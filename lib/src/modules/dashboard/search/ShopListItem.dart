import 'package:fidelyz/src/modules/dashboard/store/store.dart';
import 'package:fidelyz/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class ShopListItem extends StatelessWidget {
  final String? shopName;
  final String? offer;
  final String? expires;
  final String? logo;
  const ShopListItem(
      {super.key, this.shopName, this.offer, this.expires, this.logo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade, child: const Store()));
        },
        child: Container(
          height: 187,
          width: 335,
          alignment: Alignment.bottomCenter,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(image: AssetImage(logo!), fit: BoxFit.cover),
          ),
          child: Container(
            width: Get.width,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: AssetImage(
                  'assets/image/seller_bc.png',
                ),
                fit: BoxFit.fill,
              ),
              gradient: LinearGradient(
                colors: [
                  Colors.brown.withOpacity(0.7),
                  Colors.brown.withOpacity(0.12),
                  Colors.brown.withOpacity(0.19)
                  // Color.fromRGBO(221, 221, 221, 0.58),
                  // Color.fromRGBO(255, 255, 255, 0),
                ],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        shopName ?? "McDonald's",
                        style: TextStyles.paraBigWhite2,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      offer ?? "20% off on all items",
                      style: TextStyles.smallDecWhite,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(
                      CupertinoIcons.calendar_today,
                      color: Palette.whiteColor,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      expires ?? "Expires in 9 days",
                      style: TextStyles.bodyWhite,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
    //   Padding(
    //   padding: const EdgeInsets.only(bottom: 15),
    //   child: InkWell(
    //     onTap: () {
    //       Navigator.push(
    //           context,
    //           PageTransition(
    //               type: PageTransitionType.fade, child: const Store()));
    //     },
    //     child: SizedBox(
    //       width: width - padding * 2,
    //       height: cirleRadious * 2 + padding * 2,
    //       child: Padding(
    //         padding: EdgeInsets.only(left: padding, right: padding),
    //         child: Stack(
    //           children: [
    //             Positioned(
    //               right: 0,
    //               child: Container(
    //                 width: width - padding * 2 - cirleRadious,
    //                 height: cirleRadious * 2 + padding * 2,
    //                 decoration: BoxDecoration(
    //                   color: Palette.blueShallowLight2,
    //                   borderRadius: BorderRadius.circular(10),
    //                   boxShadow: [
    //                     BoxShadow(
    //                       color: Colors.black.withOpacity(0.1),
    //                       blurRadius: 10,
    //                       spreadRadius: 3,
    //                     ),
    //                   ],
    //                 ),
    //                 child: Padding(
    //                   padding: EdgeInsets.only(
    //                       left: cirleRadious + padding,
    //                       right: padding,
    //                       top: padding,
    //                       bottom: padding),
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.start,
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: [
    //                           SizedBox(
    //                             width: width - 40 - 30 - 90 - 15 - 50,
    //                             child: Row(
    //                               children: [
    //                                 Flexible(
    //                                   child: Text(
    //                                     shopName ?? "McDonald's",
    //                                     style: TextStyles.paraBigWhite2,
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                       Padding(
    //                         padding: const EdgeInsets.only(top: 3),
    //                         child: Text(
    //                           offer ?? "Get 20% off on your next order",
    //                           style: TextStyles.smallDecWhite,
    //                         ),
    //                       ),
    //                       const Spacer(),
    //                       Padding(
    //                         padding: const EdgeInsets.only(top: 5),
    //                         child: Text(
    //                           expires ?? "Get 20% off on your next order",
    //                           style: TextStyles.bodyWhite,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             Positioned(
    //               left: 0,
    //               top: ((cirleRadious * 2 + padding * 2) - (cirleRadious * 2)) /
    //                   2,
    //               child: CircleAvatar(
    //                 radius: cirleRadious,
    //                 backgroundColor: Palette.secondaryColor,
    //                 child: Center(
    //                   child: CircleAvatar(
    //                     radius: cirleRadious - 2,
    //                     backgroundColor: Colors.white.withOpacity(0.5),
    //                     child: Center(
    //                       child: CircleAvatar(
    //                           backgroundColor: Colors.white.withOpacity(0.5),
    //                           radius: cirleRadious - 4,
    //                           child: Padding(
    //                             padding: const EdgeInsets.all(2.0),
    //                             child: ClipRRect(
    //                               child: Container(
    //                                   width: cirleRadious * 2 + 10,
    //                                   height: cirleRadious * 2 + 10,
    //                                   decoration: BoxDecoration(
    //                                     borderRadius: BorderRadius.circular(50),
    //                                     image: DecorationImage(
    //                                       image: AssetImage(
    //                                         logo ?? "assets/images/mcd.png",
    //                                       ),
    //                                       fit: BoxFit.cover,
    //                                     ),
    //                                   )),
    //                             ),
    //                           )),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
