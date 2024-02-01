import 'dart:convert';
import 'package:fidelyz/src/modules/dashboard/Notification/Notification.dart';
import 'package:fidelyz/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class QrShow extends StatefulWidget {
  const QrShow({super.key});

  @override
  State<QrShow> createState() => _QrShowState();
}

class _QrShowState extends State<QrShow> {
  var image = Image.asset(
    'assets/logo/51-cash-logo-qr.png',
  );
  var myData = {
    "company": "Fidelyz",
    "phone_number": "+918250414042",
    "name": "Shivay Kumar",
  };

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ),
    );
    double profile = 100;
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Palette.primaryColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'QR Code'.tr,
          style: TextStyles.appBarTitle,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: const Notifications()));
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Image.asset(
                      "assets/icons/notification.png",
                      height: 22,
                      width: 22,
                      color: Colors.white,
                      fit: BoxFit.contain,
                    ),
                    const Positioned(
                      right: -6,
                      top: -2,
                      child: CircleAvatar(
                        backgroundColor: Palette.orange,
                        radius: 9,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 1),
                            child: Text(
                              "2",
                              style: TextStyles.notificationWhiteMiniBond,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeLeft: true,
        removeRight: true,
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                height: 444,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 420,
                    width: 332,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Palette.whiteColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        /// back ground container
                        Container(
                          height: 200,
                          width: 191,
                          decoration: const BoxDecoration(
                              color: Palette.primaryColor,
                              shape: BoxShape.circle),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Positioned(
                                  bottom: 5,
                                  child: Image.asset(
                                      'assets/qr code/vector2.png')),
                              Positioned(
                                  bottom: 5.8,
                                  child:
                                      Image.asset('assets/qr code/vector1.png'))
                            ],
                          ),
                        ),
                        Positioned(
                          top: 6,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 7,
                              right: 7,
                              top: 40,
                            ),
                            child: Text(
                              "Shivay Kumar",
                              style: TextStyles.qrTextWhite
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 40 + 20 + 28,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Stack(
                              alignment: Alignment.center,
                              clipBehavior: Clip.none,
                              children: [
                                /// bottom 2 arrows
                                Positioned(
                                  bottom: -15,
                                  right: -14,
                                  child: Image.asset(
                                    'assets/qr code/arrow1.png',
                                    height: 21,
                                    width: 21,
                                  ),
                                ),
                                Positioned(
                                  bottom: -15,
                                  left: -14,
                                  child: Image.asset(
                                    'assets/qr code/arrow2.png',
                                    height: 21,
                                    width: 21,
                                  ),
                                ),

                                /// qr code border colors
                                Container(
                                  height: 147,
                                  width: 147,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                        color: const Color(0xff9CAFF2),
                                        width: 12),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  child: Container(
                                    height: 147,
                                    width: 77,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                          color: const Color(0xffD3DCFB),
                                          width: 12),
                                    ),
                                  ),
                                ),

                                /// qr code
                                Container(
                                  height: 138,
                                  width: 138,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white),
                                  child: PrettyQrView.data(
                                    data: jsonEncode(myData),
                                    decoration: const PrettyQrDecoration(
                                      shape: PrettyQrSmoothSymbol(
                                          color: Colors.black, roundFactor: 1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 26,
                          left: 20,
                          right: 20,
                          child: Opacity(
                            opacity: 0.9,
                            child: Text(
                              "QRCodeInfo".tr,
                              style: TextStyles.qrDecBlack
                                  .copyWith(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -35,
                child: Center(
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(100),
                    shadowColor: Palette.primaryColor.withOpacity(0.1),
                    child: Container(
                      height: 92,
                      width: 92,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: Container(
                          height: profile - 15,
                          width: profile - 15,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: AssetImage(
                                    "assets/image/FullSizeRender.png"),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 424,
              //   child: Align(
              //     alignment: Alignment.bottomCenter,
              //     child: Container(
              //       height: 370,
              //       width: 332,
              //       margin: const EdgeInsets.symmetric(horizontal: 20),
              //       decoration: BoxDecoration(
              //         color: Palette.whiteColor.withOpacity(0.9),
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //       child: Column(
              //         children: [
              //           const Padding(
              //             padding: EdgeInsets.only(
              //                 left: 7, right: 7, top: 55, bottom: 4),
              //             child: Text(
              //               "Shivay Kumar",
              //               style: TextStyles.qrTextWhite,
              //             ),
              //           ),
              //           Padding(
              //             padding: const EdgeInsets.only(top: 10),
              //             child: SizedBox(
              //               height: 157,
              //               width: 162,
              //               child: PrettyQrView.data(
              //                 data: jsonEncode(myData),
              //                 decoration: const PrettyQrDecoration(
              //                   shape: PrettyQrSmoothSymbol(
              //                       color: Colors.black, roundFactor: 1),
              //                 ),
              //               ),
              //             ),
              //           ),
              //           Padding(
              //             padding: const EdgeInsets.symmetric(horizontal: 20)
              //                 .copyWith(top: 20),
              //             child: Opacity(
              //               opacity: 0.9,
              //               child: Text(
              //                 "QRCodeInfo".tr,
              //                 style: TextStyles.qrDecBlack,
              //                 textAlign: TextAlign.center,
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // Positioned(
              //   top: -10,
              //   child: Center(
              //     child: Material(
              //       elevation: 2,
              //       borderRadius: BorderRadius.circular(100),
              //       shadowColor: Palette.primaryColor.withOpacity(0.1),
              //       child: Container(
              //         height: profile + 12,
              //         width: profile + 12,
              //         decoration: BoxDecoration(
              //           color: Colors.white.withOpacity(0.4),
              //           borderRadius: BorderRadius.circular(100),
              //         ),
              //         child: Center(
              //           child: Container(
              //             height: profile,
              //             width: profile,
              //             decoration: BoxDecoration(
              //               image: const DecorationImage(
              //                   image: AssetImage(
              //                       "assets/image/FullSizeRender.png"),
              //                   fit: BoxFit.cover),
              //               borderRadius: BorderRadius.circular(100),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
