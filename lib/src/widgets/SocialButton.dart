import 'package:fidelyz/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SocialButton extends StatelessWidget {
  final String status;
  final VoidCallback onTap;
  const SocialButton({super.key, this.status = "GO", required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: MaterialButton(
        elevation: 0,
        onPressed: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        color: socialColor(status),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderStyles.norm3,
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  socialTitle(status),
                  style: TextStyles.buttonWhite,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Image.asset(
              socialIcon(status),
              fit: BoxFit.contain,
              height: 28,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  String socialTitle(String status) {
    if (status == "GO") {
      return "ContinueWithGoogle".tr;
    }
    if (status == "FB") {
      return "ContinueWithFacebook".tr;
    } else {
      return "ContinueWithApple".tr;
    }
  }

  Color socialColor(String status) {
    if (status == "GO") {
      return Colors.red;
    }
    if (status == "FB") {
      return Colors.blue;
    } else {
      return Colors.black;
    }
  }

  String socialIcon(String status) {
    if (status == "GO") {
      return "assets/social/google.png";
    }
    if (status == "FB") {
      return "assets/social/facebook.png";
    } else {
      return "assets/social/apple.png";
    }
  }
}
