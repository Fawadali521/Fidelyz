import 'dart:async';

import 'package:fidelyz/src/modals/UserModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import '../../modules/auth/VerifyMobileOtp.dart';
import '../../modules/dashboard/Dashboard.dart';
import '../../services/repository/AuthRepository.dart';
import '../../services/shared_prefs/UserSharedPrefs.dart';
import '../../utils/Utils.dart';

class ForgotPasswordController extends GetxController {
  final _authRepo = AuthRepository();
  final _userPrefs = UserSharedPrefs();

  final numberOrEmailController = TextEditingController();
  final pinController = TextEditingController();
  final newPasswordController = TextEditingController();

  final focusNodeEmailOrNumber = FocusNode().obs;
  final focusNodeNewPass = FocusNode().obs;
  final focusNodePin = FocusNode().obs;

  RxString? dropdownValue = '+241'.obs;




  RxBool isSendingOtp = false.obs,
      isContinue = false.obs,
      // isNumber = false.obs,
      obscureText = true.obs;

  /// show or hide password
  changeObscureText() {
    obscureText(!obscureText.value);
  }


  /// chose email or phone number for sign in
  // void onTextChanged() {
  //   String inputText = numberOrEmailController.text;
  //   if (inputText.isNotEmpty) {
  //     try {
  //       int.parse(inputText);
  //       isNumber(true);
  //     } catch (e) {
  //       isNumber(false);
  //     }
  //   }
  // }

  /// change phone code
  void changePhoneCode(String string) {
    dropdownValue!.value = string;
  }

  /// Send otp on phone
  void sendOtp(BuildContext context) async {
    isSendingOtp(true);

    Map data = {"mobilenumber": numberOrEmailController.text};
    // api call
    await _authRepo.sendOtpApi(data).then((value) {
      isSendingOtp(false);
      if (value != null) {
        if (value['error'] == "INVALID_DATA") {
          // show message toast
          Utils.showToastMessage(message: value['message']);
        } else {
          /// show success message toast
          Utils.showToastMessage(
            message: value['message'],
            title: 'success',
          );
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child: const VerifyMobileOtp()));
        }
      }
    }).onError(
      (error, stackTrace) {
        print("test auth");
        isSendingOtp(false);
        if (kDebugMode) {

          print("Error is $error");
        }

        /// Check if no internet found
        if (error.toString() == 'No Internet null') {
          Utils.showToastMessage(
            message: 'Make sure you have the internet connection',
            title: 'Network Error',
          );
        }
      },
    );
  }

  /// Create new password
  void createNewPassword(BuildContext context) async {
    isContinue(true);
    Map data = {
      "mobilenumber": numberOrEmailController.text,
      "newpassword": newPasswordController.text,
      "otp": pinController.text
    };

    _authRepo.forgotPasswordApi(data).then((value) {
      isContinue(false);
      if (value != null) {
        if (value['error'] == "INVALID_DATA") {
          // show message toast
          Utils.showToastMessage(message: value['message']);
        } else {
          /// show success message toast
          Utils.showToastMessage(
            message: value['message'],
            title: 'success',
          );

          /// Save user data locally
          _userPrefs.saveUser(UserModal.fromJson(value)).then((val) {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade, child: const Dashboard()));
          }).onError((error, stackTrace) {});
        }
      }
    }).onError((error, stackTrace) {
      isContinue(false);
      if (kDebugMode) {
        print("Error is $error");
      }

      /// Check if no internet found
      if (error.toString() == 'No Internet null') {
        Utils.showToastMessage(
          message: 'Make sure you have the internet connection',
          title: 'Network Error',
        );
      }
    });
  }


  @override
  void dispose() {
    super.dispose();
    numberOrEmailController.clear();
    numberOrEmailController.dispose();
    pinController.clear();
    pinController.dispose();
  }
}
