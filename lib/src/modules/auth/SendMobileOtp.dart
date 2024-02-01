import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import '../../../styles.dart';
import '../../controllers/auth_controllers/ForgotPasswordController.dart';
import '../../widgets/SubmitButton.dart';
import '../../widgets/TextFieldNumberOrEmail.dart';
import 'SignUp.dart';

class SendMobileOtp extends StatelessWidget {
  const SendMobileOtp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgotPasswordController());
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
                      top: 70.0, bottom: 30, left: 20, right: 20),
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
                    "Let'sRecoverYourPassword".tr,
                    style: TextStyles.bigHeadingWhite,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 20, top: 0),
                  child: Text(
                    "ForgotPasswordInfoText".tr,
                    style: TextStyles().lightSmallHeadingWhite,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 20.0, right: 20, bottom: 15),
                  child: Obx(
                        () => TextFieldNumberOrEmail(
                      controller: controller.numberOrEmailController,
                      focusNode: controller.focusNodeEmailOrNumber.value,
                      isNumber: true,
                      phoneCode: controller.dropdownValue!.value,
                      onChanged: (value) {
                      },
                      onPhoneCodeChange: (string) =>
                          controller.changePhoneCode(string!),
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Don'tHaveAnAccount".tr,
                          style: TextStyles().lightSmallHeadingWhite),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: const SignUp()));
                          },
                          child: Text("SIGNUP".tr,
                              style: TextStyles().smallHeadingWhite)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Obx(
                        () => SubmitButton(
                      onTap: () async {
                        controller.sendOtp(context);
                      },
                      color: Palette.secondaryColor,
                      isLoading: controller.isSendingOtp.value,
                      title: "SENDOTP".tr,
                    ),
                  ),
                ),

              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 15,top: 06),
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
