import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:fidelyz/src/modules/dashboard/search/markers/MarkerPainterLoyalty.dart';
import 'package:fidelyz/src/modules/dashboard/search/markers/MarkerPainterOffer.dart';
import 'package:fidelyz/src/widgets/TextFieldMaps.dart';
import 'package:fidelyz/styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:fidelyz/src/modules/dashboard/search/markers/MarkerPainterLoyalty.dart';
import 'package:fidelyz/src/modules/dashboard/search/markers/MarkerPainterOffer.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();
  final List shopLocations = [
    {
      'shop-name': 'Le Palais Damine',
      'location': 'Rue andree mintsa 1.125.5, Libreville',
      'latitude': 0.4214010815803036,
      'longitude': 9.425918653376609,
      'logo': 'assets/shops/1.jpeg',
      'offer': '40% off on all items',
      'expires': 'Expires in 9 days',
      'type': 'OFFER',
    },
    {
      'shop-name': 'Restaurant mawassa',
      'location': 'CCCG+RCX, Libreville',
      'latitude': 0.4221165202308817,
      'longitude': 9.426106396322146,
      'logo': 'assets/shops/2.jpg',
      'offer': '40% off on all items',
      'expires': 'Expires in 9 days',
      'type': 'LOYALTY',
    },
    {
      'shop-name': 'Paul - Boulangerie',
      'location': 'Boulevard Quaben, Libreville',
      'latitude': 0.42316539066625436,
      'longitude': 9.428324879242671,
      'logo': 'assets/shops/3.jpeg',
      'offer': '40% off on all items',
      'expires': 'Expires in 9 days',
      'type': 'OFFER',
    },
    {
      'shop-name': 'Mbidia Koukou',
      'location': 'CC9G+36Q, Batterie Quatre, Libreville',
      'latitude': 0.41771100538313377,
      'longitude': 9.425603896885034,
      'logo': 'assets/shops/4.jpeg',
      'offer': '40% off on all items',
      'expires': 'Expires in 9 days',
      'type': 'LOYALTY',
    },
    {
      'shop-name': 'Le Phare Du Large',
      'location': 'L101, Libreville',
      'latitude': 0.41701937944969564,
      'longitude': 9.424955326476018,
      'logo': 'assets/shops/5.jpeg',
      'offer': '40% off on all items',
      'expires': 'Expires in 9 days',
      'type': 'OFFER',
    },
    {
      'shop-name': 'Bali Bar',
      'location': 'CC9G+M6G, Libreville',
      'latitude': 0.41917248505852717,
      'longitude': 9.42554754763029,
      'logo': 'assets/shops/6.jpeg',
      'offer': '40% off on all items',
      'expires': 'Expires in 9 days',
      'type': 'LOYALTY',
    },
    {
      'shop-name': 'Pharmacie Des GUEGUE',
      'location': "Route d'Ambowe, Libreville",
      'latitude': 0.4275975819948042,
      'longitude': 9.434191452862665,
      'logo': 'assets/shops/7.jpeg',
      'offer': '40% off on all items',
      'expires': 'Expires in 9 days',
      'type': 'OFFER',
    },
    {
      'shop-name': 'cecado',
      'location': 'CCHM+4WG, Libreville',
      'latitude': 0.42787164896948904,
      'longitude': 9.434814372468313,
      'logo': 'assets/shops/8.png',
      'offer': '40% off on all items',
      'expires': 'Expires in 9 days',
      'type': 'LOYALTY',
    },
  ];
  final List<Marker> _marker = <Marker>[];

  Future<ui.Image> _loadImage(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    final List<int> bytes = data.buffer.asUint8List();
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(Uint8List.fromList(bytes), (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
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

  late LatLng currentSelectLocation;
  double initialZoom = 15;
  LatLng? _currentLocation;
  late GoogleMapController _mapController;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await _determinePosition();
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        // isLoding = false;
        // isLodingNotary = false;
      });

      if (_currentLocation != null) {
        _mapController.animateCamera(
          CameraUpdate.newLatLngZoom(_currentLocation!, initialZoom),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  bool showCustomLocation = false;

  loadDate() async {
    _marker.clear();
    if (showCustomLocation) {
      for (int i = 0; i < shopLocations.length; i++) {
        final customMarker = await createCustomMarker(
          shopLocations[i]['type'],
          shopLocations[i]['logo'],
          shopLocations[i]['shop-name'],
          shopLocations[i]['offer'],
          shopLocations[i]['expires'],
        );

        _marker.add(Marker(
          markerId: MarkerId(i.toString()),
          icon: customMarker,
          position: LatLng(
            shopLocations[i]['latitude'],
            shopLocations[i]['longitude'],
          ),
          onTap: () {
            customInfoWindowController.addInfoWindow!(
              Column(
                children: [
                  Text(shopLocations[i]['shop-name']),
                  Text(shopLocations[i]['location']),
                  // Add more information as needed
                ],
              ),
              LatLng(
                shopLocations[i]['latitude'],
                shopLocations[i]['longitude'],
              ),
            );
          },
        ));
      }
    } else {
      await getCurrentLocation(); // Make sure to wait for the current location
      if (_currentLocation != null) {
        _marker.add(Marker(
          markerId: MarkerId('current_location'),
          icon: BitmapDescriptor.defaultMarker,
          position: _currentLocation!,
        ));
      }
    }

    setState(() {});
  }

  Future<BitmapDescriptor> createCustomMarker(String type, String logoPath,
      String shopName, String offerText, String expiresText) async {
    final ui.Image tagImage = await _loadImage('assets/icons/discount.png');
    final cardPath = (type == 'OFFER')
        ? 'assets/vectors/custom-markers2.png'
        : 'assets/vectors/custom-markers3.png';
    final CustomPainter painter = (type == 'OFFER')
        ? MarkerPainterOffer(
            await _loadImage(cardPath),
            await _loadImage(logoPath),
            shopName,
            offerText,
            expiresText,
            tagImage)
        : MarkerPainterLoyalty(await _loadImage(cardPath),
            await _loadImage(logoPath), shopName, offerText, expiresText);
    final ui.Image cardImage = await _loadImage(cardPath);
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(
      recorder,
      Rect.fromPoints(
        const Offset(0, 0),
        Offset(cardImage.width.toDouble(), cardImage.height.toDouble()),
      ),
    );
    print('Creating custom marker for $shopName');
    painter.paint(
      canvas,
      Size(cardImage.width.toDouble(), cardImage.height.toDouble()),
    );
    final picture = recorder.endRecording();
    final img = await picture.toImage(cardImage.width, cardImage.height);
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    customInfoWindowController = CustomInfoWindowController();
    loadDate();
  }

  void _onButtonTap() {
    setState(() {
      showCustomLocation = !showCustomLocation;
    });

    // Call loadDate after the state is updated
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      loadDate();
    });
  }

  void _onCameraMove(CameraPosition position) {
    customInfoWindowController?.onCameraMove?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop Locations on Map'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: true,
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            onTap: (position) {
              customInfoWindowController.hideInfoWindow!();
            },
            markers: Set<Marker>.of(_marker),
            initialCameraPosition: CameraPosition(
                target: LatLng(0.42787164896948904, 9.434814372468313),
                zoom: 15),
            onCameraMove: _onCameraMove,
            onMapCreated: (GoogleMapController controller) {
              print('_marker list: $_marker');

              customInfoWindowController?.googleMapController = controller;
              _mapController = controller;
              if (showCustomLocation == false) {
                getCurrentLocation(); // Show current location initially
              }
            },
          ),
          ElevatedButton(onPressed: (){
            _onButtonTap();
            print(showCustomLocation.toString());
          }, child: Text("loading data"))

        ],
      ),
    );
  }
}
