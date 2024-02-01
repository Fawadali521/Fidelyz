import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/directions.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../styles.dart';

class SellerLocationDirection extends StatefulWidget {
  const SellerLocationDirection({Key? key}) : super(key: key);

  @override
  _SellerLocationDirectionState createState() =>
      _SellerLocationDirectionState();
}

class _SellerLocationDirectionState extends State<SellerLocationDirection> {
  late GoogleMapController mapController;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Completer<GoogleMapController> controllers =
      Completer<GoogleMapController>();

  LatLng? _currentLocation;
  double initialZoom = 15;
  bool _isLoading = true;

  final LatLng destinationLocation = const LatLng(37.7749, -122.4324);

  Future<void> getCurrentLocation() async {
    try {
      Position position = await _determinePosition();
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _isLoading = false;
      });

      if (_currentLocation != null) {
        mapController.animateCamera(
          CameraUpdate.newLatLngZoom(_currentLocation!, initialZoom),
        );
      }
      setState(() {});
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        toolbarHeight: 60,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 18,
            color: Colors.white,
          ),
        ),
        backgroundColor: Palette.primaryColor,
        title: const Text(
          'Seller Location Direction',
          style: TextStyles.appBarTitle,
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Palette.secondaryColor,
              ),
            )
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                    if (_currentLocation != null) {
                      mapController.moveCamera(
                        CameraUpdate.newLatLngZoom(
                            _currentLocation!, initialZoom),
                      );
                    }
                    controllers.complete(controller);
                  },
                  initialCameraPosition: CameraPosition(
                    target: _currentLocation!,
                    zoom: 14.0,
                  ),
                  markers: {
                    Marker(
                        markerId: const MarkerId('current'),
                        position: _currentLocation!),
                    Marker(
                        markerId: const MarkerId('destination'),
                        position: destinationLocation),
                  },
                ),
                if (_isLoading)
                  const Center(
                    child: CircularProgressIndicator(
                      color: Palette.secondaryColor,
                    ),
                  ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Palette.primaryColor,
        onPressed: () {
          getDirections();
        },
        child: const Icon(
          Icons.directions,
          color: Palette.whiteColor,
        ),
      ),
    );
  }

  void getDirections() async {
    final DirectionsResponse response =
        await GoogleMapsDirections(apiKey: 'YOUR_API_KEY')
            .directionsWithLocation(
      Location(
          lat: _currentLocation!.latitude, lng: _currentLocation!.longitude),
      Location(
        lat: destinationLocation.latitude,
        lng: destinationLocation.longitude,
      ),
      travelMode: TravelMode.driving,
    );

    if (response.isOkay) {
      final route = response.routes.first;
      final bounds = route.bounds;
      // final steps = route.steps;

      final LatLngBounds googleBounds = LatLngBounds(
        southwest: LatLng(bounds.southwest.lat, bounds.southwest.lng),
        northeast: LatLng(bounds.northeast.lat, bounds.northeast.lng),
      );

      mapController
          .animateCamera(CameraUpdate.newLatLngBounds(googleBounds, 100));

      // scaffoldKey.currentState
      //     ?.showSnackBar(SnackBar(content: Text('Directions Received')));
    } else {
      // scaffoldKey.currentState
      //     ?.showSnackBar(SnackBar(content: Text('Error fetching directions')));
    }
  }
}
