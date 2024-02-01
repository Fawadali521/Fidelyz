import 'package:avatar_glow/avatar_glow.dart';
import 'package:fidelyz/src/modules/dashboard/store/ViewDeals.dart';
import 'package:fidelyz/styles.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import '../store/SellerLocationDirection.dart';
import '../store/UnlockOffer.dart';
import 'Animated_Digits.dart';
import 'LoyaltyCards.dart';
import 'RotatingCoin.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class RewardDetails extends StatefulWidget {
  const RewardDetails({super.key});

  @override
  State<RewardDetails> createState() => _RewardDetailsState();
}

class _RewardDetailsState extends State<RewardDetails> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    /// AppBar
    PreferredSizeWidget appBarWidget = AppBar(
      toolbarHeight: 78,
      backgroundColor: Palette.primaryColor,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Image.asset(
                  'assets/shop-icon/1.png',
                  width: 10,
                  height: 10,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const Text(
            'Pizza Hut',
            style: TextStyles.rewardCardOffer,
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 40),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Opacity(
                opacity: 0.9,
                child: Text(
                  'Subscribed'.tr,
                  style: TextStyles.actionWhiteMiniBond,
                ),
              ),
              Positioned(
                top: -5,
                right: -22,
                child: Image.asset(
                  "assets/icons/tick-mark.png",
                  height: 18,
                  width: 18,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        )
      ],
    );
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      appBar: appBarWidget,
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(top: 10, bottom: 30),
            children: [
              /// Points
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedPoints(endPoints: 450),
                  ],
                ),
              ),

              /// rotating coin
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: 0.8,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        "MyPoints".tr,
                        style: TextStyles.paraBigWhite,
                      ),
                    ),
                  ),
                  const RotatingCoin(),
                ],
              ),

              /// Exciting Offers
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 45, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                            width: 32,
                            height: 32,
                            child: Image.asset('assets/image/offersIcon.png')),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "ExclusiveDeals".tr.toUpperCase(),
                            style: TextStyles.yellowTitleText,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      child: Opacity(
                        opacity: 0.8,
                        child: Text(
                          "GetThrillingOffers".tr,
                          style: TextStyles.paraWhite,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 180,
                      child: ListView.builder(
                        itemCount: 10,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: const ViewDeals()));
                            },
                            child: offers(index),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              /// Loyalty program
              Padding(
                padding: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    /// data container
                    Positioned(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        child: Container(
                          width: width,
                          decoration: BoxDecoration(
                            color: Palette.green,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Stack(
                            // clipBehavior: Clip.none,
                            children: [
                              /// light grey sticker on top left
                              Positioned(
                                left: -5,
                                top: -15,
                                child: Container(
                                  width: 91,
                                  height: 91,
                                  clipBehavior: Clip.none,
                                  child: Transform.rotate(
                                    angle: 0.3,
                                    child: Image.asset(
                                      'assets/image/img_2.png',
                                      height: 150,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: -15,
                                bottom: -35,
                                child: Container(
                                  width: 91,
                                  height: 91,
                                  clipBehavior: Clip.none,
                                  child: Transform.rotate(
                                    angle: 2.8,
                                    child: Image.asset(
                                      'assets/image/img_2.png',
                                      height: 150,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, bottom: 15, left: 15, right: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: width / 1.5,
                                      child: Text(
                                        "OurLoyaltyPrograms".tr,
                                        style: TextStyles.titleText,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 20),
                                      child: Text(
                                        "LoyaltyProgramInfo".tr,
                                        style: TextStyles.paraWhite,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    ///Image
                    Positioned(
                      right: -5,
                      top: -25,
                      child: Container(
                        width: 91,
                        height: 91,
                        clipBehavior: Clip.none,
                        child: Image.asset(
                          'assets/image/img_3.png',
                          height: 150,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// 200 points container
              Padding(
                padding: const EdgeInsets.only(bottom: 30, left: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: AvatarGlow(
                              endRadius: 22,
                              child: Image.asset(
                                'assets/icons/coin.png',
                                width: 22,
                                height: 22,
                              ),
                            ),
                          ),
                          Text(
                            '200 ${'Points'.tr}',
                            style: TextStyles.rewardCardTitle.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const LoyaltyOptions(
                      points: "300",
                      title: "6 Chicken Wings",
                      imagePath: "assets/dummy-image/1.png",
                      available: true,
                    ),
                  ],
                ),
              ),

              /// Not available / locked
              Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: AvatarGlow(
                              endRadius: 22,
                              child: Image.asset(
                                'assets/icons/coin.png',
                                width: 22,
                                height: 22,
                              ),
                            ),
                          ),
                          Text(
                            '200 ${'Points'.tr}',
                            style: TextStyles.rewardCardTitle.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    LoyaltyOptions(
                      points: "300",
                      title: "6 Chicken Wings",
                      imagePath: "assets/dummy-image/1.png",
                      available: false,
                      onLockOfferTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => const UnlockOffer());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            right: -1,
            top: 10,
            child: InkWell(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
              onTap: () async {
                var url = Uri.parse("tel:+923435382022");
                if (await url_launcher.canLaunchUrl(url)) {
                  await url_launcher.launchUrl(url);
                } else {
                  Fluttertoast.showToast(msg: 'Something went wrong!');
                }
              },
              child: Container(
                width: 110,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Palette.green,
                        child: Image.asset(
                          "assets/icons/telephone.png",
                          height: 18,
                          width: 18,
                          fit: BoxFit.contain,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text("CallNow".tr, style: TextStyles.paraWhite),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: -1,
            top: 10,
            child: InkWell(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SellerLocationDirection()));
              },
              child: Container(
                width: 100,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Locate".tr, style: TextStyles.paraWhite),
                    Padding(
                      padding: const EdgeInsets.only(left: 7),
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Palette.secondaryColor,
                        child: Image.asset(
                          "assets/icons/pin.png",
                          height: 18,
                          width: 18,
                          fit: BoxFit.contain,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Exciting offers
  offers(index) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 15),
      child: Stack(
        children: [
          /// Image
          Container(
            width: 250,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white.withOpacity(0.2),
              // border: Border.all(color: Colors.yellow, width: 1),
              image: const DecorationImage(
                image: AssetImage("assets/image/pizza.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: 250,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.black.withOpacity(0.8),
                  Colors.transparent,
                  Colors.black.withOpacity(0.8),
                ],
              ),
            ),
          ),

          /// Text on the image
          const Positioned(
            bottom: 0,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                width: 250,
                height: 180,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Get 50% off on all orders above \$100",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Offers exclusive to our store",
                      style: TextStyle(
                        color: Color(0xff6FE44E),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
