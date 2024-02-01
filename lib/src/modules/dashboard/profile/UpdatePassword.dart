import 'package:fidelyz/src/widgets/PasswordField.dart';
import 'package:fidelyz/src/widgets/SubmitButton.dart';
import 'package:fidelyz/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import '../../../controllers/auth_controllers/UpdatePasswordController.dart';
import '../../../utils/Utils.dart';
import '../../auth/SendMobileOtp.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdatePasswordController());
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      appBar: AppBar(
        backgroundColor: Palette.primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 20,
            color: Colors.white,
          ),
        ),
        title: Text(
          'UpdatePassword'.tr,
          style: TextStyles.appBarTitle,
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20, bottom: 10, top: 20),
            child: Obx(
                  () => PasswordField(
                controller: controller.oldPasswordController,
                hint: "Enter current password",
                focusNode: controller.focusNodeOldPassword.value,
                onChanged: (value) {},
                obscureText: controller.oldPassObscure.value,
                onSubmit: (value) => Utils.changeFieldFocusNode(
                    context: context,
                    current: controller.focusNodeOldPassword.value,
                    nextFocus: controller.focusNodeNewPassword.value),
                onObscureTextChange: () {
                  controller.oldPassObscure(!controller.oldPassObscure.value);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20, bottom: 10, top: 15),
            child:Obx(
                  () => PasswordField(
                controller: controller.newPasswordController,
                hint: "Enter New password",
                focusNode: controller.focusNodeNewPassword.value,
                obscureText: controller.newPassObscure.value,
                onChanged: (value) {},
                onObscureTextChange: () {
                  controller.newPassObscure(!controller.newPassObscure.value);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
            child: Obx(
                  () => SubmitButton(
                color: Palette.secondaryColor,
                onTap: () async {
                  controller.updatePassword();
                },
                isLoading: controller.isLoading.value,
                title: "Update Password",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
