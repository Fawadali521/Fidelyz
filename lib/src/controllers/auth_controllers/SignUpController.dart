import 'package:fidelyz/src/modules/auth/PhoneVerification.dart';
import 'package:fidelyz/src/services/repository/AuthRepository.dart';
import 'package:fidelyz/src/services/shared_prefs/UserSharedPrefs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import '../../utils/Utils.dart';

class SignUpController extends GetxController {
  final _authRepo = AuthRepository();
  final _userPrefs = UserSharedPrefs();

  final formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final nameFocus = FocusNode().obs;
  final firstNameFocus = FocusNode().obs;
  final phoneFocus = FocusNode().obs;
  final emailFocus = FocusNode().obs;
  final passwordFocus = FocusNode().obs;

  RxString? dropDownValue = '+241'.obs;
  RxBool obscureText = true.obs, isLoading = false.obs;

  /// change phone number code
  changeDropDownValue(String string) {
    dropDownValue!.value = string;
  }

  /// show or hide password
  changeObscureText() {
    obscureText(!obscureText.value);
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  /// sign up new user
  void signUpUser(BuildContext context) async {
    isLoading(true);
    Map data = {
      'firstname': firstNameController.text,
      'lastname': lastNameController.text,
      'countrycode': dropDownValue!.value,
      'mobilenumber': phoneController.text,
      'email': emailController.text,
      'password': passwordController.text,
    };

    /// wait for server response
    await _authRepo.signUpApi(data).then((value) {
      isLoading(false);
      if (value != null) {
        if (value['error'] == "INVALID_DATA") {
          // show message toast
          Utils.showToastMessage(message: value['message']);
        } else if (value['message'] == 'mobile otp sent') {
          Navigator.pushReplacement(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child: const PhoneVerification()));
          // ------------------------------------------show toast message

          /// show success message toast
          Utils.showToastMessage(
            message: value['message'],
            title: 'success',
          );
        }
      }
      if (kDebugMode) {
        print(value);
      }
    }).onError((error, stackTrace) {
      isLoading(false);
      if (kDebugMode) {
        print(error.toString());
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

  /// dispose all text controllers
  @override
  void dispose() {
    lastNameController.clear();
    firstNameController.clear();
    phoneController.clear();
    emailController.clear();
    passwordController.clear();
    lastNameController.dispose();
    firstNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
