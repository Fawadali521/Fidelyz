import 'dart:async';

import 'package:fidelyz/src/modules/auth/AddNewPassword.dart';
import 'package:fidelyz/src/services/ToastMsg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pinput/pinput.dart';

import '../../../styles.dart';
import '../../controllers/auth_controllers/ForgotPasswordController.dart';
import '../../widgets/SubmitButton.dart';

class VerifyMobileOtp extends StatefulWidget {
  const VerifyMobileOtp({Key? key}) : super(key: key);

  @override
  State<VerifyMobileOtp> createState() => _VerifyMobileOtpState();
}

class _VerifyMobileOtpState extends State<VerifyMobileOtp> {
  final controller = Get.find<ForgotPasswordController>();
  late Timer timer;
  int _minutes = 4;
  int _seconds = 60;
  @override
  void initState() {
    super.initState();
    startOtpCountDown();
  }

  /// OTP timer
  void startOtpCountDown() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_minutes > 0 || _seconds > 0) {
          if (_seconds == 0) {
            _minutes--;
            _seconds = 59;
          } else {
            _seconds--;
          }
        } else {
          resendOtp();
        }
      });
    });
  }

  void resendOtp() {
    debugPrint('Resending OTP...');
    controller.sendOtp(context);
    // Reset the countdown
    setState(() {
      _minutes = 4;
      _seconds = 60;
      startOtpCountDown();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    const focusedBorderColor = Palette.primaryColor;
    final fillColor = Colors.white.withOpacity(0.15);
    const borderColor = Colors.white;
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyles.bigHeadingWhite,
      decoration: BoxDecoration(
        borderRadius: BorderStyles.norm2,
        border: Border.all(color: borderColor),
      ),
    );

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.deepPurple,
      statusBarBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      body: Stack(
        children: [
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.only(bottom: height * 0.1),
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 60.0, bottom: 30, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/logo/icon-010.png",
                        fit: BoxFit.contain,
                        width: width * 0.5,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 10, top: 0),
                  child: Text(
                    "Let'sVerifyYourOTP".tr,
                    style: TextStyles.bigHeadingWhite,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 4),
                  child: Column(
                    children: [
                      Text(
                        '${"We sent you a six-digit OTP code to"} ${controller.numberOrEmailController.text} ${'PleaseEnterOTPtoConfirmVerification'.tr}',
                        style: TextStyles().lightSmallHeadingWhite,
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 20),
                        child: SizedBox(
                          width: width - 40,
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: Pinput(
                              length: 6,
                              controller: controller.pinController,
                              focusNode: controller.focusNodePin.value,
                              androidSmsAutofillMethod:
                                  AndroidSmsAutofillMethod.smsUserConsentApi,
                              listenForMultipleSmsOnAndroid: true,
                              defaultPinTheme: defaultPinTheme,
                              hapticFeedbackType:
                                  HapticFeedbackType.lightImpact,
                              onChanged: (value) {},
                              cursor: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 9),
                                    width: 22,
                                    height: 1,
                                    color: focusedBorderColor,
                                  ),
                                ],
                              ),
                              focusedPinTheme: defaultPinTheme.copyWith(
                                decoration:
                                    defaultPinTheme.decoration!.copyWith(
                                  borderRadius: BorderStyles.norm,
                                  border: Border.all(color: focusedBorderColor),
                                ),
                              ),
                              submittedPinTheme: defaultPinTheme.copyWith(
                                decoration:
                                    defaultPinTheme.decoration!.copyWith(
                                  color: fillColor,
                                  borderRadius: BorderStyles.norm,
                                  border: Border.all(color: focusedBorderColor),
                                ),
                              ),
                              errorPinTheme: defaultPinTheme.copyBorderWith(
                                border: Border.all(color: Colors.redAccent),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0)
                            .copyWith(top: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Resend OTP in',
                              style: TextStyles().lightSmallHeadingWhite,
                            ),
                            const Spacer(),
                            Text(
                              '$_minutes:${_seconds.toString().padLeft(2, '0')} s',
                              style: TextStyles()
                                  .lightSmallHeadingWhite
                                  .copyWith(fontSize: 12),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.timer_outlined,
                              color: Colors.white,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Obx(
                          () => SubmitButton(
                            color: Palette.secondaryColor,
                            title: "Verify".tr,
                            isLoading: controller.isContinue.value,
                            onTap: () async {
                              if (controller.pinController.text.isNotEmpty) {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.fade,
                                        child: const AddNewPassword()));
                              } else {
                                ToastMsg().sendErrorMsg('OTP is required');
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 06),
              child: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.1),
                radius: 20,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
