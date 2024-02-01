import 'package:get/get.dart';

class Infos {
  static const String mapKey = 'AIzaSyDG2zq9-F7tw-lS1mr2i9fhoCagnZXMneo';
  String darkMapStyle = '''
[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "administrative.country",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "administrative.locality",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#181818"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#1b1b1b"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#2c2c2c"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#8a8a8a"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#373737"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#3c3c3c"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#4e4e4e"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#000000"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#3d3d3d"
      }
    ]
  }
]
''';

  final List<String> dropdownItems = ['+241', '+91', '+1', '+92'];
  final List category = [
    {
      'title': 'Grocery',
      'selectedIcon': 'assets/category-icon/grocery1.png',
      'disableIcon': 'assets/category-icon/grocery.png',
    },
    {
      'title': 'Electronics',
      'selectedIcon': 'assets/category-icon/electronics1.png',
      'disableIcon': 'assets/category-icon/electronics2.png',
    },
    {
      'title': 'Clothing Store',
      'selectedIcon': 'assets/category-icon/clothing_store1.png',
      'disableIcon': 'assets/category-icon/clothing_store2.png',
    },
    {
      'title': 'Restaurant',
      'selectedIcon': 'assets/category-icon/restaurant1.png',
      'disableIcon': 'assets/category-icon/restaurant2.png',
    },
    {
      'title': 'Cafe',
      'selectedIcon': 'assets/category-icon/cafe.png',
      'disableIcon': 'assets/category-icon/cafe2.png',
    },
    {
      'title': 'Restaurant',
      'selectedIcon': 'assets/category-icon/restaurant1.png',
      'disableIcon': 'assets/category-icon/restaurant2.png',
    },
    {
      'title': 'Cafe',
      'selectedIcon': 'assets/category-icon/cafe.png',
      'disableIcon': 'assets/category-icon/cafe2.png',
    },
    {
      'title': 'Pharmacy',
      'selectedIcon': 'assets/category-icon/medical1.png',
      'disableIcon': 'assets/category-icon/medical2.png',
    },
    {
      'title': 'Electronics',
      'selectedIcon': 'assets/category-icon/electronics1.png',
      'disableIcon': 'assets/category-icon/electronics2.png',
    },
    {
      'title': 'Clothing Store',
      'selectedIcon': 'assets/category-icon/clothing_store1.png',
      'disableIcon': 'assets/category-icon/clothing_store2.png',
    },
    {
      'title': 'Restaurant',
      'selectedIcon': 'assets/category-icon/restaurant1.png',
      'disableIcon': 'assets/category-icon/restaurant2.png',
    },
    {
      'title': 'Cafe',
      'selectedIcon': 'assets/category-icon/cafe.png',
      'disableIcon': 'assets/category-icon/cafe2.png',
    },
    {
      'title': 'Pharmacy',
      'selectedIcon': 'assets/category-icon/medical1.png',
      'disableIcon': 'assets/category-icon/medical2.png',
    },
    {
      'title': 'Electronics',
      'selectedIcon': 'assets/category-icon/electronics1.png',
      'disableIcon': 'assets/category-icon/electronics2.png',
    },
    {
      'title': 'Clothing Store',
      'selectedIcon': 'assets/category-icon/clothing_store1.png',
      'disableIcon': 'assets/category-icon/clothing_store2.png',
    },
    {
      'title': 'Restaurant',
      'selectedIcon': 'assets/category-icon/restaurant1.png',
      'disableIcon': 'assets/category-icon/restaurant2.png',
    },
    {
      'title': 'Cafe',
      'selectedIcon': 'assets/category-icon/cafe.png',
      'disableIcon': 'assets/category-icon/cafe2.png',
    },
    {
      'title': 'Pharmacy',
      'selectedIcon': 'assets/category-icon/medical1.png',
      'disableIcon': 'assets/category-icon/medical2.png',
    },
    {
      'title': 'Electronics',
      'selectedIcon': 'assets/category-icon/electronics1.png',
      'disableIcon': 'assets/category-icon/electronics2.png',
    },
    {
      'title': 'Clothing Store',
      'selectedIcon': 'assets/category-icon/clothing_store1.png',
      'disableIcon': 'assets/category-icon/clothing_store2.png',
    },
    // {
    //   'title': 'Bookstore',
    //   'icon': 'assets/category-icon/grocery.png',
    // },
    // {
    //   'title': 'Fitness Center',
    //   'icon': 'assets/category-icon/grocery.png',
    // },
    // {
    //   'title': 'Jewelry Store',
    //   'icon': 'assets/category-icon/grocery.png',
    // },
    // {
    //   'title': 'Bar',
    //   'icon': 'assets/category-icon/grocery.png',
    // },
  ];
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
  List<String> shops = [
    'Domino\'s',
    'Pizza Hut',
    'KFC',
    'McDonald\'s',
    // 'Subway',
    // 'Starbucks',
    // 'Taco Bell',
    // 'Dunkin\' Donuts',
    // 'Burger King',
    // 'Papa John\'s',
    // 'Domino\'s',
    // 'Pizza Hut',
    // 'KFC',
    // 'McDonald\'s',
    // 'Subway',
    // 'Starbucks',
    // 'Taco Bell',
    // 'Dunkin\' Donuts',
    // 'Burger King',
    // 'Papa John\'s',
  ];
  List<String> shopsLogos = [
    'assets/shop-icon/dominos.png',
    'assets/shop-icon/pizzaHut.png',
    'assets/shop-icon/kfc.png',
    'assets/shop-icon/mcdonolds.png',
  ];
  final List onboardingData = [
    {
      'title': 'seamlessIntegration'.tr,
      'description': 'first on boarding screen text'.tr,
      'image': 'assets/onboarding/1.png'
    },
    {
      'title': 'rewardsGalore'.tr,
      'description': 'second on boarding screen text'.tr,
      'image': 'assets/onboarding/2.png'
    },
    {
      'title': 'discoverNearby'.tr,
      'description': 'third on boarding screen text'.tr,
      'image': 'assets/onboarding/3.png'
    },
  ];
}
