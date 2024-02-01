import 'package:fidelyz/src/modules/auth/SendMobileOtp.dart';
import 'package:fidelyz/src/modules/auth/SignUp.dart';
import 'package:fidelyz/src/utils/Utils.dart';
import 'package:fidelyz/src/widgets/PasswordField.dart';
import 'package:fidelyz/src/widgets/SocialButton.dart';
import 'package:fidelyz/src/widgets/SubmitButton.dart';
import 'package:fidelyz/src/widgets/TextFieldNumberOrEmail.dart';
import 'package:fidelyz/styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import '../../controllers/auth_controllers/SignInController.dart';
import '../dashboard/PrivacyPolicy/PrivacyPolicy.dart';
import '../dashboard/profile/PrivacyPolicy.dart';
import '../dashboard/profile/TermsAndConditions.dart';
import '../dashboard/termandcondition/TermAndCondition.dart';
import 'AddNewPassword.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final signInController = Get.put(SignInController());
    final bool isIos = Theme.of(context).platform == TargetPlatform.iOS;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.deepPurple,
      statusBarBrightness: Brightness.dark,
    ));
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
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
                  left: 20, right: 20, bottom: 20, top: 0),
              child: Text(
                "LetsSignYouIn".tr,
                // style: TextStyles.bigHeading,
                style: TextStyles.bigHeadingWhite,
              ),
            ),
            Form(
              key: signInController.formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, bottom: 15),
                    child: Obx(
                      () => TextFieldNumberOrEmail(
                        onChanged: (value) {
                          signInController.emailOrPhoneController
                              .addListener(signInController.onTextChanged);
                        },
                        controller: signInController.emailOrPhoneController,
                        focusNode: signInController.emailFocusNode.value,
                        phoneCode: signInController.dropdownValue!.value,
                        isNumber: signInController.isNumber.value,
                        onPhoneCodeChange: (string) =>
                            signInController.changePhoneCode(string!),
                        onFieldSubmitted: (value) => Utils.changeFieldFocusNode(
                            context: context,
                            current: signInController.emailFocusNode.value,
                            nextFocus:
                                signInController.passwordFocusNode.value),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, bottom: 10),
                    child: Obx(
                      () => PasswordField(
                        hint: "EnterYourPassword".tr,
                        onChanged: (value) {},
                        controller: signInController.passwordController,
                        focusNode: signInController.passwordFocusNode.value,
                        obscureText: signInController.obscureText.value,
                        onObscureTextChange: () =>
                            signInController.changeObscureText(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: const SendMobileOtp()));
                    },
                    child: Text("ForgotPassword".tr,
                        style: TextStyles().lightSmallHeadingWhite),
                  ),
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
                  color: Palette.secondaryColor,
                  onTap: () {
                    if (signInController.formKey.currentState!.validate()) {
                      signInController.signInUser(context);
                    }
                  },
                  title: "SIGNIN".tr,
                  isLoading: signInController.isLoading.value,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20, bottom: 15, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: (width - 40) / 2 - 30,
                    height: 1,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderStyles.norm,
                    ),
                  ),
                  Text(
                    "OR".tr,
                    style: TextStyles.textFieldHintWhite,
                  ),
                  Container(
                    width: (width - 40) / 2 - 30,
                    height: 1,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderStyles.norm,
                    ),
                  ),
                ],
              ),
            ),
            if (isIos)
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
                child: SocialButton(
                  onTap: () {},
                  status: "AP",
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20, bottom: 30),
                child: SocialButton(
                  onTap: () {},
                  status: "GO",
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 30,
                left: 15,
                right: 20,
              ),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: 'BySigningIn,YouAcceptOur'.tr,
                    style: TextStyles.smallDecWhite,
                  ),
                  TextSpan(
                      text: 'TermsOfService'.tr,
                      style: TextStyles.smallDecSecondary,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: const TermsAndConditions()));
                        }),
                  TextSpan(
                    text: 'And'.tr,
                    style: TextStyles.smallDecWhite,
                  ),
                  TextSpan(
                      text: 'PrivacyPolicy'.tr,
                      style: TextStyles.smallDecSecondary,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child:  const PrivacyPolicy()));
                        }),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
