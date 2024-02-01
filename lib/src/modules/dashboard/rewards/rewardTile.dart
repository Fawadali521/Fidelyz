import 'package:fidelyz/src/modules/dashboard/rewards/ScanRewardQrCode.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../styles.dart';
import 'RewardDetails.dart';

class RewardTile extends StatelessWidget {
  final Color color;
  final String imageSrc;
  const RewardTile({super.key, required this.color, required this.imageSrc});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child: const ScanRewardQrCode()));
        },

        /// Full Box
        child: SizedBox(
          width: width - 40,
          height: 125,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // shadow box
              Container(
                width: width - 45,
                height: 113,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              // data box
              Positioned(
                child: Center(
                  child: Container(
                    width: width - 60,
                    height: 125,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 15, top: 15, bottom: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width / 2,
                            child: Text(
                              "Get 20% off on your next order",
                              style: TextStyles.rewardCardOffer
                                  .copyWith(fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: SizedBox(
                              width: width,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 12,
                                    child: Image.asset(
                                        'assets/shop-icon/mcdonolds.png'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      "McDonald's",
                                      style: TextStyles.rewardCardTitle
                                          .copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              ///Image
              Positioned(
                left: 227,
                top: 12,
                bottom: 12,
                child: Container(
                  width: 90,
                  height: 90,
                  clipBehavior: Clip.none,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    shape: BoxShape.circle,
                    border: Border.all(color: Palette.whiteColor, width: 2),
                    image: DecorationImage(
                        image: AssetImage(
                          imageSrc,
                        ),
                        fit: BoxFit.fill),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
