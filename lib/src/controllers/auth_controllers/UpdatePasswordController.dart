
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../services/ToastMsg.dart';
import '../../services/repository/AuthRepository.dart';

class UpdatePasswordController extends GetxController {
  final _authRepo = AuthRepository();

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  final focusNodeNumber = FocusNode().obs;
  final focusNodeOldPassword = FocusNode().obs;
  final focusNodeNewPassword = FocusNode().obs;

  RxBool isLoading = false.obs,
      oldPassObscure = true.obs,
      newPassObscure = true.obs;

  void updatePassword() async {
    isLoading(true);
    var data = {
      "oldpassword": oldPasswordController.text.trim(),
      "newpassword": newPasswordController.text.trim(),
    };

    await _authRepo.updatePasswordApi(data).then((value) {
      isLoading(false);

      if (value != null) {
        if (value['error'] == "INVALID_DATA") {
          ToastMsg().sendErrorMsg(value['message']);
        } else {
          /// Save user data locally
          if (kDebugMode) print(value);
          ToastMsg().sendSuccessMsg('Password updated successfully');
          clearTextFields();
        }
      }
    }).onError((error, stackTrace) {
      isLoading(false);
      if (kDebugMode) {
        print("Error is $error");
      }

      /// Check if no internet found
      if (error.toString() == 'No Internet null') {
        ToastMsg().sendErrorMsg('Make sure you have the internet connection');
      }
    });
  }

  void clearTextFields() {
    oldPasswordController.clear();
    newPasswordController.clear();
  }

  /// dispose all the text controllers
  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }
}
