import 'package:fidelyz/src/modules/auth/PhoneVerification.dart';
import 'package:fidelyz/src/modules/auth/SignIn.dart';
import 'package:fidelyz/src/widgets/PasswordField.dart';
import 'package:fidelyz/src/widgets/SocialButton.dart';
import 'package:fidelyz/src/widgets/SubmitButton.dart';
import 'package:fidelyz/src/widgets/TextFieldEmail.dart';
import 'package:fidelyz/src/widgets/TextFieldNumber.dart';
import 'package:fidelyz/src/widgets/TextFields.dart';
import 'package:fidelyz/styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import '../../controllers/auth_controllers/SignUpController.dart';
import '../../utils/Utils.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final sUpController = Get.put(SignUpController());
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
                "Let'sSignYouUp".tr,
                style: TextStyles.bigHeadingWhite,
              ),
            ),
            Form(
              key: sUpController.formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, bottom: 15),
                    child: TextFields(
                      onChanged: (value) {},
                      hint: "EnterYourFirstName".tr,
                      controller: sUpController.firstNameController,
                      focusNode: sUpController.nameFocus.value,
                      onFieldSubmitted: (value) => Utils.changeFieldFocusNode(
                          context: context,
                          current: sUpController.nameFocus.value,
                          nextFocus: sUpController.firstNameFocus.value),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, bottom: 15),
                    child: TextFields(
                      onChanged: (value) {},
                      hint: "EnterYourLastName".tr,
                      controller: sUpController.lastNameController,
                      focusNode: sUpController.firstNameFocus.value,
                      onFieldSubmitted: (value) => Utils.changeFieldFocusNode(
                          context: context,
                          current: sUpController.firstNameFocus.value,
                          nextFocus: sUpController.phoneFocus.value),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, bottom: 15),
                    child: Obx(
                      () => TextFieldNumber(
                        onChanged: (value) {},
                        controller: sUpController.phoneController,
                        focusNode: sUpController.phoneFocus.value,
                        onDropDownChanged: (String? string) {
                          return sUpController.changeDropDownValue(string!);
                        },
                        dropDownValue: sUpController.dropDownValue!.value,
                        onFieldSubmitted: (value) => Utils.changeFieldFocusNode(
                            context: context,
                            current: sUpController.phoneFocus.value,
                            nextFocus: sUpController.emailFocus.value),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, bottom: 15),
                    child: TextFieldEmail(
                      onChanged: (value) {},
                      controller: sUpController.emailController,
                      focusNode: sUpController.emailFocus.value,
                      onFieldSubmitted: (value) => Utils.changeFieldFocusNode(
                          context: context,
                          current: sUpController.emailFocus.value,
                          nextFocus: sUpController.passwordFocus.value),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, bottom: 10),
                    child: Obx(
                      () => PasswordField(
                        hint: "EnterYourPassword".tr,
                        onChanged: (value) {},
                        controller: sUpController.passwordController,
                        obscureText: sUpController.obscureText.value,
                        focusNode: sUpController.passwordFocus.value,
                        onObscureTextChange: () =>
                            sUpController.changeObscureText(),
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
                  Text("AlreadyHaveAnAccount".tr,
                      style: TextStyles().lightSmallHeadingWhite),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: const SignIn()));
                      },
                      child: Text("SIGNIN".tr,
                          style: TextStyles().smallHeadingWhite)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Obx(
                () => SubmitButton(
                  onTap: () {
                    if (sUpController.formKey.currentState!.validate()) {
                      sUpController.signUpUser(context);
                    }
                  },
                  title: "SIGNUP".tr,
                  color: Palette.secondaryColor,
                  isLoading: sUpController.isLoading.value,
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
                    text: "BySigningUpYouAcceptOur".tr,
                    style: TextStyles.smallDecWhite,
                  ),
                  TextSpan(
                      text: "TermsOfService".tr,
                      style: TextStyles.smallDecSecondary,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Navigator.push(
                          //     context,
                          //     PageTransition(
                          //         type: PageTransitionType.fade,
                          //         child: const TermsConditions()));
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
                          // Navigator.push(
                          //     context,
                          //     PageTransition(
                          //         type: PageTransitionType.fade,
                          //         child: const PrivacyPolicy()));
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
