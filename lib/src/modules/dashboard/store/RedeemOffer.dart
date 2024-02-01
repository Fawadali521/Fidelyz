import 'package:fidelyz/src/widgets/swipeButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../styles.dart';

class RedeemOffer extends StatelessWidget {
  const RedeemOffer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          topLeft: Radius.circular(24),
        ),
        color: Palette.primaryColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 6,
            margin: const EdgeInsets.only(top: 16, bottom: 14),
            decoration: BoxDecoration(
              color: Palette.whiteColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Do you want to redeem".tr,
              style: TextStyles.rewardCardTitle.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            height: 140,
            width: Get.width,
            padding: const EdgeInsets.all(18),
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ).copyWith(top: 16, bottom: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [
                  Color(0xff5762D5),
                  Color.fromRGBO(87, 98, 213, 0.78),
                ],
              ),
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '6 Chicken',
                      style: TextStyles.rewardCardOffer.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Wings',
                      style: TextStyles.rewardCardOffer.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Expiration : 31/12',
                      style: TextStyles.rewardCardOffer.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                Positioned(
                  bottom: 4,
                  right: 2,
                  child: Image.asset(
                    'assets/image/chicken-plate.png',
                    height: 94,
                    width: 164,
                    fit: BoxFit.fill,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomSwipeButton(
              activeColor: Color(0xffE56D1F),
            ),
          ),
          const SizedBox(height: 10),
          const SafeArea(
            child: SizedBox(
              height: 18,
            ),
          ),
        ],
      ),
    );
  }
}
