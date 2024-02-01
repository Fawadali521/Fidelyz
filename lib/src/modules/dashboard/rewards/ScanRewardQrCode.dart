import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../../../../styles.dart';

class ScanRewardQrCode extends StatelessWidget {
  const ScanRewardQrCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var myData = {
      "company": "Fidelyz",
      "phone_number": "+918250414042",
      "name": "Shivay Kumar",
    };
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 60,
        scrolledUnderElevation: 0,
        backgroundColor: Palette.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white, size: 20),
        title: Text(
          'Reward\'s QR Code'.tr,
          style: TextStyles.appBarTitle.copyWith(fontWeight: FontWeight.w400),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: Get.width,
            padding: const EdgeInsets.all(18),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Palette.whiteColor.withOpacity(0.08),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/shop-icon/mcdonolds.png',
                  height: 47,
                  width: 47,
                ),
                const SizedBox(height: 12),
                Text(
                  'McDonold\'s',
                  style: TextStyles()
                      .smallHeadingWhite
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/qr code/reward_qr.png',
                      width: 176,
                      height: 234,
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                      top: 70,
                      bottom: 42,
                      child: Container(
                        width: 120,
                        height: 100,
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        child: PrettyQrView.data(
                          data: jsonEncode(myData),
                          decoration: const PrettyQrDecoration(
                            shape: PrettyQrSmoothSymbol(
                                color: Colors.black, roundFactor: 1),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  'Flash this QR code to get exclusive loyalty rewards!',
                  style: TextStyles.qrDecBlack.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
              ],
            ),
          )
        ],
      ),
    );
  }
}
