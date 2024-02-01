import 'package:fidelyz/src/controllers/auth_controllers/ForgotPasswordController.dart';
import 'package:fidelyz/src/widgets/PasswordField.dart';
import 'package:fidelyz/src/widgets/SubmitButton.dart';
import 'package:fidelyz/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddNewPassword extends StatelessWidget {
  const AddNewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgotPasswordController>();
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
                    "Let'sCreateNewPassword".tr,
                    style: TextStyles.bigHeadingWhite,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 20, top: 0),
                  child: Text(
                    'WeWillCreateNewPasswordForYou'.tr,
                    style: TextStyles().lightSmallHeadingWhite,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 20,
                    right: 20,
                  ),
                  child: Obx(
                    () => PasswordField(
                      controller: controller.newPasswordController,
                      focusNode: controller.focusNodeNewPass.value,
                      obscureText: controller.obscureText.value,
                      onChanged: (value) {},
                      hint: "EnterNewPassword".tr,
                      onObscureTextChange: () => controller.changeObscureText(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: Obx(
                    () => SubmitButton(
                      color: Palette.secondaryColor,
                      title: "CONTINUE".tr,
                      isLoading: controller.isContinue.value,
                      onTap: () async {
                        controller.createNewPassword(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 6),
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
