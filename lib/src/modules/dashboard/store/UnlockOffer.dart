import 'package:fidelyz/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnlockOffer extends StatelessWidget {
  const UnlockOffer({Key? key}) : super(key: key);

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
              '${"To redeem the offer, you need to earn".tr} 500 ${"points".tr}.',
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
                color: const Color(0xffF7B32B),
                borderRadius: BorderRadius.circular(12)),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '12 Chicken',
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
          const SafeArea(
            child: SizedBox(
              height: 16,
            ),
          ),
        ],
      ),
    );
  }
}
