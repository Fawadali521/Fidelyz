import 'package:fidelyz/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../widgets/TextFields.dart';

class LoyaltyCard extends StatefulWidget {
  final String title;
  final String points;
  final Color color;
  final int index;

  const LoyaltyCard({
    super.key,
    required this.title,
    required this.points,
    required this.color,
    required this.index,
  });

  @override
  State<LoyaltyCard> createState() => _LoyaltyCardState();
}

class _LoyaltyCardState extends State<LoyaltyCard> {




  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 150,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        clipBehavior: Clip.antiAlias,
        children: [
          /// designs on the card
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              child: Image.asset(
                'assets/vectors/artwork.png',
                color: Colors.black.withOpacity(0.8),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 75,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              child: Image.asset(
                'assets/vectors/artwork2.png',
                width: 60,
                color: Colors.black.withOpacity(0.8),
              ),
            ),
          ),
          Positioned(
            top: 2,
            left: 2,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              child: Image.asset(
                'assets/vectors/artwork3.png',
                width: 38,
                color: Colors.black.withOpacity(0.8),
              ),
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.only(left: 16, right: 16, top: 15, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 17,
                        // backgroundColor: Palette.cardPurpleColor,
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.white12,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Image.asset('assets/shop-icon/cardimg.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                     Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        widget.title,
                        style: TextStyles.cardSubTitle,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Total Points',
                      style: TextStyles.cardSubTitle.copyWith(fontSize: 12),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/icons/coin.png",
                                height: 16,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Text(
                                  widget.points,
                                  style: TextStyles.cardSubTitle
                                      .copyWith(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Card creation date',
                          style: TextStyles.cardSubTitle.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Text(
                            '20/10/2013',
                            style:
                            TextStyles.cardSubTitle.copyWith(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Visited',
                            style: TextStyles.cardSubTitle.copyWith(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: Text(
                              '223',
                              style: TextStyles.cardSubTitle
                                  .copyWith(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
    // final width = MediaQuery.of(context).size.width;
    // return Container(
    //
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(9),
    //
    //     color: widget.color,
    //     boxShadow: [
    //       BoxShadow(
    //         color: Colors.black.withOpacity(0.1),
    //         blurRadius: 10,
    //       ),
    //     ],
    //   ),
    //   padding: const EdgeInsets.all(15),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.only(right: 10),
    //                 child: Container(
    //                   height: 30,
    //                   width: 30,
    //                   decoration: BoxDecoration(
    //                     border: Border.all(color: Colors.white,width: 4),
    //                     borderRadius: BorderRadius.circular(50),
    //                     color: Colors.white,
    //                   ),
    //                   child: Image.asset(
    //                     'assets/shop-icon/cardimg.png',
    //                     width: 15,
    //                     height: 15,
    //                     fit: BoxFit.contain,
    //                   ),
    //                 ),
    //               ),
    //               Text(
    //                 widget.title,
    //                 style: TextStyles.inputTextStyle.copyWith(fontWeight: FontWeight.w600,fontSize: 13),
    //               ),
    //             ],
    //           ),
    //           Row(
    //             children: [
    //               Text(
    //                 ' Totals Points',
    //                 style: TextStyles.cardSubTitle.copyWith(fontSize: 13,),
    //               ),
    //               SizedBox(width: 12,),
    //               Container(
    //
    //                 width: 60,
    //                 decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.circular(12),
    //                   color:Colors.white.withOpacity(0.3),
    //
    //                 ),
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(4),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                     children: [
    //                       Image.asset(
    //                         'assets/icons/star.png',
    //                         width: 17,
    //                         height: 17,
    //                       ),
    //
    //                       Text(
    //                         widget.points,
    //                         style: TextStyles.rewardCardTitle.copyWith(fontSize: 12),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //
    //             ],
    //           ),
    //
    //
    //         ],
    //       ),
    //       // TextFieldsSearch(
    //       //   controller: searchController,
    //       //   onChanged: filterCard,
    //       //   hint: 'search',),
    //       Stack(
    //         children: [
    //           Image.asset(
    //             color:Colors.black.withOpacity(0.4),
    //             width:width,
    //
    //             'assets/icons/Subtract.png',  // Replace with your image asset path
    //             fit: BoxFit.cover,
    //             height: 40,// You may adjust the BoxFit as needed
    //           ),
    //
    //           Positioned(
    //             top: 0,bottom: 0,
    //             right: 0,
    //             left: 0,
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 // Column(
    //                 //   crossAxisAlignment: CrossAxisAlignment.start,
    //                 //   children: [
    //                 //     Text(
    //                 //       'CardCreationDate'.tr,
    //                 //       style: TextStyles.rewardCardTitle.copyWith(
    //                 //           fontWeight: FontWeight.w800, fontSize: 14),
    //                 //     ),
    //                 //     const SizedBox(height: 4),
    //                 //     Text(
    //                 //       '19/09/23'.tr,
    //                 //       style: TextStyles.rewardCardTitle.copyWith(
    //                 //           fontWeight: FontWeight.w600, fontSize: 14),
    //                 //     ),
    //                 //   ],
    //                 // ),
    //
    //                 Text(
    //                   'Visited'.tr,
    //                   style: TextStyles.rewardCardTitle
    //                       .copyWith(fontWeight: FontWeight.w800,fontSize: 12),
    //                 ),
    //                 const SizedBox(height: 4),
    //                 Text(
    //                   '222',
    //                   style: TextStyles.textFieldHintWhite
    //                       .copyWith(fontWeight: FontWeight.w800,fontSize: 12),
    //                 )
    //               ],
    //             ),
    //           )
    //         ],
    //       )
    //     ],
    //   ),
    // );


  }
}
