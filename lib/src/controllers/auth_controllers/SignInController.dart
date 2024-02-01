import 'package:fidelyz/src/modals/UserModel.dart';
import 'package:fidelyz/src/modules/dashboard/Dashboard.dart';
import 'package:fidelyz/src/services/repository/AuthRepository.dart';
import 'package:fidelyz/src/services/shared_prefs/UserSharedPrefs.dart';
import 'package:fidelyz/src/utils/Utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class SignInController extends GetxController {
  final _authRepo = AuthRepository();
  final _userPrefs = UserSharedPrefs();

  TextEditingController emailOrPhoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;

  RxBool isNumber = false.obs, obscureText = true.obs;
  RxBool isLoading = false.obs;
  RxString? dropdownValue = '+241'.obs;

  @override
  void onInit() {
    super.onInit();
  }

  /// chose email or phone number for sign in
  void onTextChanged() {
    String inputText = emailOrPhoneController.text;
    if (inputText.isNotEmpty) {
      try {
        int.parse(inputText);
        isNumber(true);
      } catch (e) {
        isNumber(false);
      }
    }
  }

  /// change phone code
  void changePhoneCode(String string) {
    dropdownValue!.value = string;
  }

  /// show or hide password
  changeObscureText() {
    obscureText(!obscureText.value);
  }

  /// sign in existing user
  void signInUser(BuildContext context) async {
    isLoading(true);
    Map data = {
      if (!isNumber.value) 'email': emailOrPhoneController.text,
      if (isNumber.value) 'mobilenumber': emailOrPhoneController.text,
      'password': passwordController.text,
    };

    /// wait for api response
    await _authRepo.signInApi(data).then((value) {
      isLoading(false);
      if (value != null) {
        if (value['error'] == "INVALID_DATA") {
          // show message toast
          Utils.showToastMessage(message: value['message']);
        } else {
          /// Save user data locally
          _userPrefs.saveUser(UserModal.fromJson(value)).then((val) {
            _userPrefs.saveUserToken(value['token']).then((value) {
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade, child: const Dashboard()));
            });
          }).onError((error, stackTrace) {});

          /// show success message toast
          Utils.showToastMessage(
            message: value['message'],
            title: 'success',
          );
          emailOrPhoneController.clear();
          passwordController.clear();
        }
      }
    }).onError((error, stackTrace) {
      isLoading(false);
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

  /// dispose all the text controllers
  @override
  void dispose() {
    emailOrPhoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
