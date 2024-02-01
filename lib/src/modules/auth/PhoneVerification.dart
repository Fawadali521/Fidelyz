import 'package:fidelyz/src/controllers/auth_controllers/PhoneVerificationController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../styles.dart';
import '../../widgets/SubmitButton.dart';

class PhoneVerification extends StatefulWidget {
  const PhoneVerification({super.key});

  @override
  State<PhoneVerification> createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PhoneVerificationController());
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
                    "Let'sNowVerifyYourPhoneNumber".tr,
                    style: TextStyles.bigHeadingWhite,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    children: [
                      Text(
                        "EnterYourSixDigitOTP".tr,
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
                              controller: controller.pinControllerPhone,
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
                        padding: const EdgeInsets.only(top: 20),
                        child: Obx(
                          () => SubmitButton(
                            color: Palette.secondaryColor,
                            title: "VERIFY&CONTINUE".tr,
                            isLoading: controller.isLoading.value,
                            onTap: () async {
                              controller.verifyOtp(context);
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
        ],
      ),
    );
  }
}
