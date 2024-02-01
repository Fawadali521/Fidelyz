import 'package:avatar_glow/avatar_glow.dart';
import 'package:fidelyz/src/modules/dashboard/store/SellerLocationDirection.dart';
import 'package:fidelyz/src/modules/dashboard/store/UnlockOffer.dart';
import 'package:fidelyz/styles.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import '../rewards/Animated_Digits.dart';
import '../rewards/LoyaltyCards.dart';
import '../rewards/RotatingCoin.dart';
import 'ViewDeals.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class Store extends StatefulWidget {
  const Store({super.key});

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  offers(index) {
    return Padding(
      padding: EdgeInsets.only(left: (index == 0) ? 15 : 0, right: 15),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          /// Image
          Container(
            width: 250,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white.withOpacity(0.2),
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
              /// Animated points
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedPoints(endPoints: 450),
                ],
              ),
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
                  const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: RotatingCoin()),
                ],
              ),

              /// deals title and description
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                            width: 32,
                            height: 32,
                            child: Image.asset('assets/image/offersIcon.png')),
                        const SizedBox(width: 8.0),
                        Text(
                          "ExclusiveDeals".tr.toUpperCase(),
                          style: TextStyles.yellowTitleText,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      child: Opacity(
                        opacity: 0.6,
                        child: Text(
                          "GetThrillingOffers".tr,
                          style: TextStyles.paraWhite,
                          // textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// Exclusive Deals
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

              /// Loyalty program
              Padding(
                padding: const EdgeInsets.only(
                    top: 35, left: 20, right: 20, bottom: 30),
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
                            '500 ${'Points'.tr}',
                            style: TextStyles.rewardCardTitle.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    LoyaltyOptions(
                      points: "600",
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
                var url = Uri.parse("tel:03435382022");
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
                          )),
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
}

// class DottedLine extends StatelessWidget {
//   final double height;
//   final double width;
//   final double gap;
//   final Color color;
//
//   DottedLine({
//     super.key,
//     required this.height,
//     required this.width,
//     required this.gap,
//     this.color = Colors.black, // Default color is set to black
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       size: Size(width, height),
//       painter: DottedLinePainter(gap: gap, color: color),
//     );
//   }
// }
//
// class DottedLinePainter extends CustomPainter {
//   final double gap;
//   final Color color;
//
//   DottedLinePainter({required this.gap, required this.color});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = color
//       ..strokeWidth = 1.0
//       ..strokeCap = StrokeCap.round;
//
//     double startY = 0;
//
//     while (startY < size.height) {
//       canvas.drawCircle(Offset(size.width / 2, startY), size.width / 2, paint);
//       startY += size.width + gap;
//     }
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }

// class LoyaltyOptions extends StatefulWidget {
//   final String points;
//   final String title;
//   final String imagePath;
//   final bool available;
//
//   const LoyaltyOptions({
//     super.key,
//     required this.points,
//     required this.title,
//     required this.imagePath,
//     required this.available,
//   });
//
//   @override
//   State<LoyaltyOptions> createState() => _LoyaltyOptionsState();
// }

// class _LoyaltyOptionsState extends State<LoyaltyOptions> {
//   bool isSwiped = false;
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//
//     return Stack(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(bottom: 30),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               // Points Container
//               if (!widget.available)
//                 InkWell(
//                   onTap: () {
//                     ToastMsg().sendErrorMsg("You don't have enough points");
//                   },
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(15),
//                     child: ColorFiltered(
//                       colorFilter: const ColorFilter.mode(
//                           Colors.grey, BlendMode.saturation),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.2),
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.only(
//                               left: 12, right: 12, top: 7, bottom: 5),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Text(
//                                 widget.points,
//                                 style: TextStyles
//                                     .qrTextWhite, // Your TextStyle here
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 5),
//                                 child: Image.asset(
//                                   "assets/icons/coin.png",
//                                   height: 22,
//                                   width: 22,
//                                   fit: BoxFit.contain,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               if (widget.available)
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         left: 12, right: 12, top: 7, bottom: 5),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           widget.points,
//                           style: TextStyles.qrTextWhite, // Your TextStyle here
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 5),
//                           child: Image.asset(
//                             "assets/icons/coin.png",
//                             height: 22,
//                             width: 22,
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//               // Dotted Line with Glow
//               Padding(
//                 padding: const EdgeInsets.only(top: 7),
//                 child: Stack(
//                   clipBehavior: Clip.none,
//                   alignment: Alignment.bottomCenter,
//                   children: [
//                     DottedLine(
//                       height: 30,
//                       width: 2,
//                       gap: 2,
//                       color: Palette.secondaryColor, // Your color here
//                     ),
//                     const Positioned(
//                       bottom: -32,
//                       child: AvatarGlow(
//                         glowColor: Palette.secondaryColor, // Your color here
//                         endRadius: 25.0,
//                         duration: Duration(milliseconds: 1000),
//                         repeat: true,
//                         showTwoGlows: true,
//                         child: CircleAvatar(
//                           backgroundColor:
//                               Palette.secondaryColor, // Your color here
//                           radius: 5,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               // Image with Title
//               Padding(
//                 padding: const EdgeInsets.only(top: 25),
//                 child: SizedBox(
//                   height: width / 2.5 + 50,
//                   child: ListView.builder(
//                     itemCount: 10,
//                     shrinkWrap: true,
//                     scrollDirection: Axis.horizontal,
//                     itemBuilder: (BuildContext context, int index) {
//                       return Padding(
//                         padding: EdgeInsets.only(
//                             right: 15, left: index == 0 ? 15 : 0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(bottom: 10),
//                               child: Stack(
//                                 alignment: Alignment.center,
//                                 children: [
//                                   InkWell(
//                                     onTap: () {
//                                       Navigator.push(
//                                           context,
//                                           PageTransition(
//                                               type: PageTransitionType.fade,
//                                               child: const ItemDetails()));
//                                       // showCustomBottomSheet(context);
//                                     },
//                                     child: Container(
//                                       width: width / 2.5,
//                                       height: width / 2.5,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(15),
//                                         color: Colors.white.withOpacity(0.2),
//                                         border: Border.all(
//                                             color: Colors.yellow, width: 1),
//                                         image: DecorationImage(
//                                           image: AssetImage(widget.imagePath),
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   if (!widget.available)
//                                     InkWell(
//                                       onTap: () {
//                                         ToastMsg().sendErrorMsg(
//                                             "You don't have enough points");
//                                       },
//                                       child: Container(
//                                         width: width / 2.5,
//                                         height: width / 2.5,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(15),
//                                           color: Colors.black.withOpacity(0.7),
//                                           border: Border.all(
//                                               color:
//                                                   Colors.black.withOpacity(0.7),
//                                               width: 1),
//                                         ),
//                                         child: Center(
//                                           child: Icon(
//                                             Icons.lock_outline_rounded,
//                                             color:
//                                                 Colors.white.withOpacity(0.7),
//                                             size: 40,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               width: width / 2.5,
//                               child: Text(
//                                 widget.title,
//                                 style: TextStyles
//                                     .rewardCardOffer, // Your TextStyle here
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Positioned(
//           bottom: 25,
//           child: SizedBox(
//             width: width,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   width: width - 40,
//                   height: 1,
//                   color: Colors.white.withOpacity(0.05),
//                 ),
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   }
//
//   void showCustomBottomSheet(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(15.0),
//           topRight: Radius.circular(15.0),
//         ),
//       ),
//       backgroundColor: Colors.black,
//       builder: (BuildContext bc) {
//         return Stack(
//           clipBehavior: Clip.none,
//           children: [
//             ListView(
//               padding: const EdgeInsets.only(
//                   left: 20, right: 20, top: 40, bottom: 40),
//               shrinkWrap: true,
//               children: <Widget>[
//                 Container(
//                   width: width - 40,
//                   height: 150, // adjust height as required
//                   decoration: const BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(15)),
//                     image: DecorationImage(
//                       image: AssetImage('assets/dummy-image/1.png'),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 15),
//
//                 // Text
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(right: 10),
//                       child: Container(
//                         height: 30,
//                         width: 30,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(50),
//                           color: Colors.white,
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(4),
//                           child: Image.asset(
//                             'assets/shop-icon/1.png',
//                             width: 10,
//                             height: 10,
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const Text(
//                       'Pizza Hut',
//                       style: TextStyles.rewardCardOffer,
//                     ),
//                     Spacer(),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.2),
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.only(
//                                 left: 12, right: 12, top: 7, bottom: 5),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Text(
//                                   widget.points,
//                                   style: TextStyles
//                                       .qrTextWhite, // Your TextStyle here
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 5),
//                                   child: Image.asset(
//                                     "assets/icons/coin.png",
//                                     height: 22,
//                                     width: 22,
//                                     fit: BoxFit.contain,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 15),
//
//                 // Description with opacity 0.8
//                 const Opacity(
//                   opacity: 0.8,
//                   child: Text(
//                     "Unlock delicious rewards with Pizza Hut's Loyalty Program! Exchange just 200 loyalty points and savor 6 succulent chicken wings. Dive into flavor, because loyalty tastes better here.",
//                     style: TextStyles.paraWhite,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//
//                 // Swipe Button
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 30,
//                     vertical: 8,
//                   ),
//                   child: RewardSwipeButton(),
//                 ),
//               ],
//             ),
//             Positioned(
//               top: 15,
//               child: SizedBox(
//                 width: width,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       height: 7,
//                       width: 50,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(50),
//                         color: Colors.white.withOpacity(0.2),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class RewardSwipeButton extends StatefulWidget {
//   @override
//   _RewardSwipeButtonState createState() => _RewardSwipeButtonState();
// }
//
// class _RewardSwipeButtonState extends State<RewardSwipeButton> {
//   late bool isSwiped;
//   late bool isCompleted;
//
//   @override
//   void initState() {
//     super.initState();
//     isSwiped = false;
//     isCompleted = false;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         if (!isSwiped)
//           SwipeButton.expand(
//             duration: const Duration(milliseconds: 200),
//             thumb: const Icon(
//               Icons.double_arrow_rounded,
//               color: Colors.white,
//             ),
//             activeThumbColor: Palette.secondaryColor,
//             activeTrackColor: Colors.white.withOpacity(0.2),
//             onSwipe: () {
//               setState(() {
//                 isSwiped = true;
//               });
//
//               // After swiping, wait for 2 seconds before showing the container
//               Future.delayed(const Duration(seconds: 2), () {
//                 setState(() {
//                   isCompleted = true;
//                 });
//               });
//               Future.delayed(const Duration(seconds: 3), () {
//                 Navigator.pop(context);
//               });
//             },
//             child: Text(
//               "Swipe to get Rewards",
//               style: TextStyles().smallHeadingWhite,
//             ),
//           ),
//         if (isSwiped && !isCompleted)
//           const Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CircularProgressIndicator(
//                 valueColor:
//                     AlwaysStoppedAnimation<Color>(Palette.secondaryColor),
//               ),
//             ],
//           ),
//         if (isCompleted)
//           Container(
//             height: 45,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(30),
//               color: Palette.green,
//             ),
//             child: const Center(
//               child: Padding(
//                 padding: EdgeInsets.only(
//                   left: 15,
//                   right: 15,
//                 ),
//                 child: Text(
//                   "Completed",
//                   style: TextStyles.rewardCardTitle,
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }

// class DashedLineHorizontal extends StatelessWidget {
//   final double height;
//   final double width;
//   final double gap;
//   final Color color;
//
//   DashedLineHorizontal({
//     Key? key,
//     required this.height,
//     required this.width,
//     required this.gap,
//     this.color = Colors.black, // Default color is set to black
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       size: Size(width, height),
//       painter: DashedLinePainterHorizontal(gap: gap, color: color),
//     );
//   }
// }
//
// class DashedLinePainterHorizontal extends CustomPainter {
//   final double gap;
//   final Color color;
//
//   DashedLinePainterHorizontal({required this.gap, required this.color});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = color
//       ..strokeWidth = 1.0;
//
//     double startX = 0;
//
//     while (startX < size.width) {
//       canvas.drawRRect(
//         RRect.fromRectAndRadius(
//           Rect.fromPoints(
//             Offset(startX, 0),
//             Offset(startX + size.height, size.height),
//           ),
//           Radius.circular(size.height / 2),
//         ),
//         paint,
//       );
//       startX += size.height + gap;
//     }
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }
