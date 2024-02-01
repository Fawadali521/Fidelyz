import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:custom_info_window/custom_info_window.dart';
import 'package:fidelyz/infos.dart';
import 'package:fidelyz/src/controllers/search/CatergoryController.dart';
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
import 'CategoryItems.dart';
import 'SearchCategory.dart';
import 'ShopList.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  const Search({
    super.key,
  });

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
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
  final categoryController = Get.put(CategoryController());
  final DraggableScrollableController dragController =
      DraggableScrollableController();
  DraggableScrollableController categoryDragController =
      DraggableScrollableController();

  LatLng? _currentLocation;
  late GoogleMapController _mapController;
  bool _isLoading = false;
  double initialZoom = 15;
  final Completer<GoogleMapController> controllers =
      Completer<GoogleMapController>();
  Set<Marker> shopMarkers = {};
  ui.Image? cardImage;
  ui.Image? logoImage;
  bool showShops = false;
  bool showCategories = false;
  bool mostPopularShops = false;
  bool showOfferShops = false;
  Set<int> selectedCategories = {};
  int selectedCarId = 1;
  double? dragPosition;
  double? initialDragPosition;
  bool isFocus = false;
  bool heightExceeding = false;
  String categoryDragHeightExceed = '';

  animateToMyLocation() {
    if (_currentLocation != null) {
      _mapController.animateCamera(
        CameraUpdate.newLatLngZoom(_currentLocation!, initialZoom),
      );
      setState(() {});
    }
  }

  Future<ui.Image> _loadImage(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    final List<int> bytes = data.buffer.asUint8List();
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(Uint8List.fromList(bytes), (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
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
    painter.paint(
      canvas,
      Size(cardImage.width.toDouble(), cardImage.height.toDouble()),
    );
    final picture = recorder.endRecording();
    final img = await picture.toImage(cardImage.width, cardImage.height);
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }

  bool isLodingNotary = false;
  bool isLoding = false;

  TextEditingController placesController = TextEditingController();

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

  Future<void> getCurrentLocation() async {
    try {
      Position position = await _determinePosition();
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        isLoding = false;
        isLodingNotary = false;
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

  String currentLocation = '';

  locationUpdate(LatLng latLng) async {
    _currentLocation = latLng;
    List<Placemark> placemarks = await placemarkFromCoordinates(
        currentSelectLocation.latitude, currentSelectLocation.longitude);
// log(" address ==> ${placemarks.first.toString()}");
// log("show address ==> ${placemarks.first.name}, ${placemarks.first.thoroughfare}, ${placemarks.first.locality}, ${placemarks.first.subAdministrativeArea}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}, ${placemarks.first.postalCode},");
    currentLocation =
        ("${placemarks.first.name}, ${placemarks.first.thoroughfare}, ${placemarks.first.locality}, ${placemarks.first.subAdministrativeArea}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}, ${placemarks.first.postalCode}");
    setState(() {
      isLoding = false;
    });
// animateToMyLocation();
  }

  void initShopMarkers() async {
    for (var shop in Infos().shopLocations) {
      final markerIcon = await createCustomMarker(
        shop['type'], // pass the shop type
        shop['logo'],
        shop['shop-name'],
        shop['offer'],
        shop['expires'],
      );

      shopMarkers.add(
        Marker(
          icon: markerIcon,
          anchor: const Offset(0.2666, 0.9687),
          markerId: MarkerId(shop['shop-name']),
          position: LatLng(shop['latitude'], shop['longitude']),
          onTap: () {
            _mapController.animateCamera(
              CameraUpdate.newLatLngZoom(
                LatLng(shop['latitude'], shop['longitude']),
                19.0,
              ),
            );
          },
        ),
      );
    }
    setState(() {});
  }



  double maxScrollHeight = 0.98;
  double minScrollHeight = 0.12;
  double minScrollHeightt = 0.09;
  double iniScrollHeight = 0.37;
  double iniScrollHeightt = 0.24;
  double paddingBottom = 0.31;

  void animateDragOnTap(double height) {
    categoryDragController.animateTo(
      height,
      duration: const Duration(milliseconds: 350),
      curve: Curves.ease,
    );
  }

  bool isOnline = true;
  bool isListShow = false;
  List<dynamic> places = [];
  String sessionToken = DateTime.now().second.toString();

  // getSuggestion(String input) async {
  //   String baseURL =
  //       'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  //   String request =
  //       '$baseURL?input=$input&key=AIzaSyDG2zq9-F7tw-lS1mr2i9fhoCagnZXMneo&sessiontoken=$sessionToken&components=country:PK|country:IN|country:BD|country:CN';
  //
  //   try {
  //     var response = await http.get(Uri.parse(request));
  //
  //     if (response.statusCode == 200) {
  //       setState(() {
  //         places = jsonDecode(response.body)['predictions'];
  //         isListShow = places.isNotEmpty;
  //       });
  //     } else {
  //       setState(() {
  //         isListShow = false;
  //       });
  //       throw Exception("Failed to load places");
  //     }
  //   } catch (e) {
  //     print("Error: $e");
  //   }
  // }

  final FocusNode _focusNode = FocusNode();

  void _handleFocusChange() {
    if (_focusNode.hasFocus) {
      dragController.animateTo(.87,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
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
  void updateMarkers() {
// Clear existing markers
    shopMarkers.clear();

// Call initShopMarkers to generate new markers

  }

  @override
  void initState() {
    super.initState();
    // initShopMarkers();
    // getCurrentLocation();
    loadDate();
    _focusNode.addListener(_handleFocusChange);
    setState(() {
      isLoding = true;
      isLodingNotary = true;
    });

    setState(() {
      isLoding = true;
    });
//

// resetMarkers();
  }

  @override
  void dispose() {
    super.dispose();
    dragController.dispose();
    categoryDragController.dispose();
  }

  bool isSheetExpanded = true;
  bool isSheetVisible = false;
  bool sheetCollapsed = false;
  bool showCategory = false;
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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
    ));

    double padding = 10;
    const LatLng c = LatLng(0.4214010815803036, 9.425918653376609);
// LatLng(0.4192, 9.4256);
// LatLng(37.42796133580664, -122.085749655962);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final s = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          /// Google Map
          isLoding
              ? Stack(
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: s.height * 0.1,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                    ),
                  ],
                )
              : SafeArea(
                  top: false,
                  left: false,
                  right: false,
                  child:   GoogleMap(
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
                ),
          // if (isFocus && showShops)
          //   Positioned(
          //     right: 10,
          //     child: SafeArea(
          //       child: Padding(
          //         padding: const EdgeInsets.only(top: 10.0),
          //         child: InkWell(
          //           onTap: () {
          //             setState(() {
          //               showShops = !showShops;
          //             });
          //           },
          //           child: SizedBox(
          //             width: 50,
          //             height: 40,
          //             child: CircleAvatar(
          //               radius: 20,
          //               backgroundColor: Palette.secondaryColor,
          //               child: Transform.rotate(
          //                 angle: -0.75,
          //                 child: const Icon(
          //                   Icons.add,
          //                   color: Colors.white,
          //                   size: 20,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),

// /// My Location Button
// Positioned(
// right: 15,
// bottom: myLocationPositionHeight(),
// child: SafeArea(
// child: AnimatedOpacity(
// duration: const Duration(milliseconds: 100),
// opacity: isFocus ? 0 : 1,
// child: Padding(
// padding: const EdgeInsets.only(top: 10.0),
// child: InkWell(
// onTap: () {
// ///animate to markers
// _mapController.animateCamera(
// CameraUpdate.newLatLngZoom(c, 15),
// );
// animateToMyLocation();
// },
// child: const SizedBox(
// width: 50,
// height: 50,
// child: CircleAvatar(
// radius: 20,
// backgroundColor: Palette.primaryColor,
// child: ImageIcon(
// AssetImage("assets/icons/target.png"),
// color: Palette.whiteColor,
// size: 24,
// ),
// ),
// ),
// ),
// ),
// ),
// ),
// ),
// /// Reseat Location Button
// Positioned(
// left: 15,
// bottom: myLocationPositionHeight(),
// child: AnimatedOpacity(
// duration: const Duration(milliseconds: 100),
// opacity: isFocus ? 0 : 1,
// child: Padding(
// padding: const EdgeInsets.only(top: 10.0),
// child: InkWell(
// onTap: () {
//
// resetMap();
// },
// child: const SizedBox(
// width: 50,
// height: 50,
// child: CircleAvatar(
// radius: 20,
// backgroundColor: Palette.primaryColor,
// child: Icon(Icons.refresh,color: Colors.white,),
// ),
// ),
// ),
// ),
// ),
// ),

          /// Show all categories list
// if (!isFocus && showCategories)
// Positioned(
// bottom: 0,
// child: SizedBox(
// width: Get.width,
// height: 0.95 * Get.height,
// child: NotificationListener<DraggableScrollableNotification>(
// onNotification: (notification) {
// if (notification.extent > 0.5) {
// setState(() {
// categoryDragHeightExceed = 'exceed';
// });
// } else {
// setState(() {
// categoryDragHeightExceed = 'decrease';
// });
// }
// if (notification.extent < 0.1) {
// setState(() {
// categoryDragHeightExceed = 'zero';
// });
// }
// return true;
// },
// child: DraggableScrollableSheet(
// initialChildSize: 100,
// minChildSize: 100,
// maxChildSize: 1000,
// controller: categoryDragController,
// builder: (BuildContext context, scrollSheetController) {
// return AnimatedAlign(
// duration: const Duration(milliseconds: 1000),
// alignment: Alignment.bottomCenter,
// child: SearchCategory(
// scrollController: scrollSheetController,
// selectedCategories: selectedCategories,
// ),
// );
// },
// ),
// ),
// ),
// ),

// if (_isLoading)
// const Center(
// child: CircularProgressIndicator(
// color: Palette.secondaryColor,
// ),
// ),

          /// Draggable Sheet

          // Positioned(
          //
          //   child: SizedBox(
          //     width: Get.width,
          //     height: 0.95 * Get.height,
          //     child: NotificationListener<DraggableScrollableNotification>(
          //       onNotification: (notification) {
          //         return true;
          //       },
          //       child: DraggableScrollableSheet(
          //         initialChildSize: 0.13,
          //         minChildSize: 0.12,
          //         controller: dragController,
          //         builder: (BuildContext context, scrollSheetController) {
          //           return Padding(
          //             padding: EdgeInsets.only(
          //               bottom: MediaQuery.of(context).viewInsets.bottom,
          //             ),
          //             child: ShopList(
          //               scrollSheetController: scrollSheetController,
          //               selectedCategories: selectedCategories,
          //             ),
          //           );
          //         },
          //       ),
          //     ),
          //   ),
          // ),

          /// Top Blue Container

          /// top search field and Categories Buttons

          Positioned(
            top: 0,
            child: Container(
              color: sheetCollapsed ? Palette.primaryColor : Palette.whiteColor,
              child: Column(
                children: [
                  const SafeArea(bottom: false, child: SizedBox()),
                  Row(
                    children: [
                      !sheetCollapsed
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 10),
                              width: width * 0.6,
                              child: Container(
                                height: 46,
                                width: width,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 4),
                                decoration: BoxDecoration(
                                  color: heightExceeding
                                      ? Palette.whiteColor.withOpacity(0.08)
                                      : Palette.primaryColor,
                                  borderRadius: BorderRadius.circular(100),
                                  border: heightExceeding
                                      ? Border.all(
                                          color: Colors.white.withOpacity(0.09))
                                      : null,
                                ),
                                child: FocusScope(
                                  child: Focus(
                                    onFocusChange: (focus) {
                                      setState(() {
                                        isFocus = focus;
                                      });
                                    },
                                    child: TextFieldMaps(
                                      controller: placesController,
                                      hint: "SearchHere".tr,
                                      onChanged: (value) {},
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      SizedBox(
                        width: 10,
                      ),
                      sheetCollapsed
                          ? Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 10),
                                  width: width * 0.7,
                                  child: Container(
                                    height: 46,
                                    width: width,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100),
                                      border: heightExceeding
                                          ? Border.all(color: Colors.white)
                                          : null,
                                    ),
                                    child: FocusScope(
                                      child: Focus(
                                        onFocusChange: (focus) {
                                          setState(() {
                                            isFocus = focus;
                                          });
                                        },
                                        child: TextField(
                                          controller: placesController,
                                          onChanged: (value) {},
                                          style: TextStyles()
                                              .textField
                                              .copyWith(
                                                  color: Colors.white
                                                      .withOpacity(0.6)),
                                          cursorColor:
                                              Colors.white.withOpacity(0.6),
                                          decoration: InputDecoration(
                                            isDense: true,
                                            hintText: "Search here".tr,
                                            hintStyle: TextStyles()
                                                .smallHeadingLightGray
                                                .copyWith(color: Colors.black),
                                            border: InputBorder.none,
                                            prefixIcon: Image.asset(
                                              'assets/icons/search.png',
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),

// TextFieldMaps(
// controller: placesController,
// hint: "Search here".tr,
// onChanged: (value) {},
// ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () async {
// await getCurrentLocation();
// animateToMyLocation();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Palette.whiteColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Palette.primaryColor,
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(Icons.list),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 0),
                                  child: AnimatedOpacity(
                                    duration: const Duration(milliseconds: 100),
                                    opacity: isFocus ? 0 : 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 0.0),
                                      child: InkWell(
                                        onTap: () {
// setState(() {
// print("check");
// showCategory==true;
// });
// if (showCategories) {
// animateDragOnTap(minScrollHeight);
// Future.delayed(
// const Duration(milliseconds: 400), () {
// categoryDragController.reset();
// setState(() {
// showCategories = !showCategories;
// });
// });
// } else {
// animateDragOnTap(iniScrollHeight);
// Future.delayed(
// const Duration(milliseconds: 400), () {
// setState(() {
// showCategories = !showCategories;
// });
// });
// }
                                        },
                                        child: SizedBox(
                                          width: 45,
                                          height: 45,
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundColor:
                                                Palette.primaryColor,
                                            child: Icon(
                                              Icons.category,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 0),
                                  child: AnimatedOpacity(
                                    duration: const Duration(milliseconds: 100),
                                    opacity: isFocus ? 0 : 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 0.0),
                                      child: InkWell(
                                        onTap: () {
                                          ///animate to markers
                                          _mapController.animateCamera(
                                            CameraUpdate.newLatLngZoom(c, 15),
                                          );
                                          animateToMyLocation();
                                        },
                                        child: const SizedBox(
                                          width: 45,
                                          height: 45,
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundColor:
                                                Palette.primaryColor,
                                            child: ImageIcon(
                                              AssetImage(
                                                  "assets/icons/target.png"),
                                              color: Palette.whiteColor,
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),

// Positioned(
// right: 15,
// bottom: myLocationPositionHeight(),
// child: SafeArea(
// child: AnimatedOpacity(
// duration: const Duration(milliseconds: 100),
// opacity: isFocus ? 0 : 1,
// child: Padding(
// padding: const EdgeInsets.only(top: 10.0),
// child: InkWell(
// onTap: () {
// ///animate to markers
// _mapController.animateCamera(
// CameraUpdate.newLatLngZoom(c, 15),
// );
// animateToMyLocation();
// },
// child: const SizedBox(
// width: 50,
// height: 50,
// child: CircleAvatar(
// radius: 20,
// backgroundColor: Palette.primaryColor,
// child: ImageIcon(
// AssetImage("assets/icons/target.png"),
// color: Palette.whiteColor,
// size: 24,
// ),
// ),
// ),
// ),
// ),
// ),
// ),
// ),

                  /// hide and show top buttons on scroll
                  if (!heightExceeding)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: SizedBox(
                        height: 40,
                        width: width,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: [
                            /// Top 3 Buttons
                            buildTopButtonsWidget(
                              buttonName: 'Offers'.tr,
                              onTap: () {
                                _onButtonTap();
                              },

                              isSelected: showOfferShops,
                              selectedIcon: 'offer2.png',
                              index: 1, // shows the left padding
                            ),
                            buildTopButtonsWidget(
                              buttonName: "Rewards".tr,
                              onTap: () {},
                              isSelected: showCategories,
                              selectedIcon: 'category2.png',
                            ),
                            buildTopButtonsWidget(
                              buttonName: "MostPopular".tr,
                              onTap: () {
                                setState(() {
                                  mostPopularShops = !mostPopularShops;
                                });
                              },
                              isSelected: mostPopularShops,
                              selectedIcon: 'flame2.png',
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          SizedBox(
// width: Get.width,
// height: 0.95 * Get.height,
            child: NotificationListener<DraggableScrollableNotification>(
              onNotification: (DraggableScrollableNotification dSNotification) {
                if (dSNotification.extent >= 0.78) {
                  setState(() {
                    sheetCollapsed = true;
                  });
                }
// Check if the sheet is collapsed or not fully expanded
                else if (dSNotification.extent < .78) {
                  if (dSNotification.extent < .6) {
                    paddingBottom = dSNotification.extent - 0.10;
                  }
// Update the variable for not fully expanded state
                  setState(() {
                    sheetCollapsed = false;
                  });
                }
// if (notification.extent > 0.5) {
// setState(() {
// categoryDragHeightExceed = 'exceed';
//
// });
// } else {
// setState(() {
// categoryDragHeightExceed = 'decrease';
// });
// }
// if (notification.extent < 0.06) {
// setState(() {
// categoryDragHeightExceed = 'zero';
// });
// }
                return true;
              },
              child: DraggableScrollableSheet(
                initialChildSize: 0.35,
// Set the initial size to 0.4
                maxChildSize: 0.80,
// Maximum size when fully expanded
                minChildSize: 0.13,
                controller: categoryDragController,
                builder: (BuildContext context, scrollSheetController) {
                  return AnimatedAlign(
                    duration: const Duration(milliseconds: 1000),
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: width,
                      decoration: BoxDecoration(
                        color: isLodingNotary
                            ? Colors.white
                            : Palette.primaryColor,
                        borderRadius: sheetCollapsed
                            ? const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              )
                            : const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                      ),
                      child: ListView.builder(
                        controller: scrollSheetController,
                        itemCount: 1,
                        padding: const EdgeInsets.only(top: 16, bottom: 30),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              /// Top Line container
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(
                                    height: 30,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            width: 70,
                                            height: 6,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.3),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 08, left: 20, right: 20, top: 05),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Available Store".tr,
                                    style: TextStyles.categoryTextStyle(
                                        color: Palette.whiteColor),
                                  ),
                                ),
                              ),
                              isLodingNotary
                                  ? Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: GridView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          childAspectRatio:
                                              width / (height / 2),
                                        ),
                                        padding: EdgeInsets.zero,
                                        itemCount: Infos().category.length,
                                        // total number of items
                                        itemBuilder: (context, index) {
                                          return Align(
                                            alignment: Alignment.topCenter,
                                            child: SizedBox(
                                              height: 70,
                                              width: 70,
                                              child: Center(
                                                child: Stack(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    children: [
                                                      Center(
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          child: Container(
                                                            width: 150,
                                                            // Specify the width of your container
                                                            height: 150,
                                                            // Specify the height of your container
                                                            color: Colors
                                                                .white, // Specify the background color of your container
                                                          ),
                                                        ),
                                                      ),
// isOnline == true
// ? const Positioned(
// right: 6,
// child: CircleAvatar(
// backgroundColor:
// Colors.grey,
// radius: 6,
// ),
// )
// : isOnline == false
// ? const Positioned(
// right: 6,
// child:
// CircleAvatar(
// backgroundColor:
// Colors.grey,
// radius: 6,
// ),
// )
// : const SizedBox(),
                                                    ]),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : SizedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 5),
                                        child: GridView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          padding: EdgeInsets.all(padding),
                                          scrollDirection: Axis.vertical,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                            crossAxisSpacing: padding,
                                            mainAxisSpacing: 0,
                                            childAspectRatio:
                                                ((width - (padding * 7)) / 3) /
                                                    ((width - (padding * 1)) /
                                                        3),
                                          ),
                                          itemCount: Infos().category.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return CategoryItems(
                                              selectedCategories:
                                                  selectedCategories,
                                              title: Infos().category[index]
                                                  ['title'],
                                              icon: Infos().category[index]
                                                  ['selectedIcon'],
                                              index: index,
                                            );
                                          },
                                        ),
                                      ),
                                    )
                            ],
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildTopButtonsWidget({
    required String buttonName,
    required VoidCallback onTap,
    required String selectedIcon,
    required bool isSelected,
    int index = 0,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: index == 1 ? 20 : 0, right: 10),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Palette.primaryColor,
            border: isSelected
                ? Border.all(color: Palette.secondaryColor, width: 1.6)
                : null,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/search_screen/$selectedIcon'),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(buttonName,
                    style: TextStyles.categoryTextStyle(
                        color: Palette.whiteColor)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Location Button position
  double myLocationPositionHeight() {
    if (!isFocus && !showCategories && !mostPopularShops && !showOfferShops) {
      return 120.0;
    } else if (showCategories) {
      if (categoryDragHeightExceed == 'exceed') {
        return 100;
      } else if (categoryDragHeightExceed == 'decrease') {
        return 100;
      } else if (categoryDragHeightExceed == 'zero') {
        return 70;
      } else {
        return Get.width * 2 / 2;
      }
    } else {
      return 15;
    }
  }

  ///
}
