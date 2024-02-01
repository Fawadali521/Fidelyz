import 'package:carousel_slider/carousel_slider.dart';
import 'package:fidelyz/src/widgets/swipeButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../styles.dart';

class ViewDeals extends StatefulWidget {
  const ViewDeals({Key? key}) : super(key: key);

  @override
  _ViewDealsState createState() => _ViewDealsState();
}

class _ViewDealsState extends State<ViewDeals> {
  List<String> itemImage = [
    'assets/dummy-image/1.png',
    'assets/dummy-image/1.png',
    'assets/dummy-image/1.png',
    'assets/dummy-image/1.png',
  ];

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      body: Column(
        children: [
          /// Top Slider and app bar icons
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16)),
                ),
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 247.0,
                    aspectRatio: 16 / 9,
                    viewportFraction: 2,
                    initialPage: currentPage,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 4),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.easeIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentPage = index;
                      });
                    },
                    scrollDirection: Axis.horizontal,
                  ),
                  items: itemImage.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(16),
                                  bottomLeft: Radius.circular(16)),
                              image: DecorationImage(
                                  image: AssetImage(i), fit: BoxFit.cover)),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              Positioned(
                top: 30,
                right: 20,
                left: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildTopIconsButton(Icons.arrow_back, () {
                      // HapticFeedback.lightImpact();
                      Navigator.of(context).pop();
                    }),
                    buildTopIconsButton(Icons.share_outlined, () {
                      HapticFeedback.lightImpact();
                      // Navigator.of(context).pop();
                    })
                  ],
                ),
              )
            ],
          ),

          /// Slider dots
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 08),
            child: SizedBox(
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int i = 0; i < itemImage.length; i++)
                    if (i == currentPage) ItemDots(true) else ItemDots(false)
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                /// Item name and location
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
                  child: Card(
                    color: Palette.whiteColor.withOpacity(0.08),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12)
                          .copyWith(left: 16.0),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '🍕An Extra-Large Spicy Pizza Extravaganza!',
                            style: TextStyles.titleText,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'CCA, 140, Phase 5 D.H.A, Lahore',
                            style: TextStyles.itemLocation,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                /// Item Description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0)
                      .copyWith(top: 16),
                  child: Card(
                    color: Palette.whiteColor.withOpacity(0.08),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12)
                          .copyWith(left: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${'Descriptions'.tr} 👌',
                            style: TextStyles.titleText,
                          ),
                          const SizedBox(height: 8),
                          buildRichText('🌶️',
                              'The Spice Sensation A Symphony of Heat Prepare your palate for a symphony of spices'),
                          buildRichText('🧀',
                              'Cheese Galore Melting Pools of Indulgence Our Inferno Grandiosa takes it to'),
                          buildRichText('🌿',
                              'Garnished to Perfection Fresh Herbs and Finishing Touches'),
                          buildRichText('🍽️',
                              'Experience the Inferno Grandiosa A Feast for the Senses'),
                        ],
                      ),
                    ),
                  ),
                ),

                /// Swipe button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0)
                      .copyWith(top: 30, bottom: 18),
                  child: const CustomSwipeButton(),
                ),
                const SafeArea(
                  child: SizedBox(
                    height: 25,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  InkWell buildTopIconsButton(IconData iconData, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withOpacity(0.5),
        ),
        child: Icon(
          iconData,
          color: Palette.whiteColor,
          size: 24,
        ),
      ),
    );
  }

  buildRichText(String icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: RichText(
        text: TextSpan(
          text: '$icon ',
          children: [
            TextSpan(
              text: text,
              style: TextStyles.itemLocationDec,
            ),
          ],
        ),
      ),
    );
  }
}

class ItemDots extends StatelessWidget {
  bool isActive;
  ItemDots(this.isActive, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: isActive ? 9 : 8,
        width: isActive ? 9 : 8,
        decoration: BoxDecoration(
          color: isActive ? Palette.secondaryColor : Colors.grey,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
