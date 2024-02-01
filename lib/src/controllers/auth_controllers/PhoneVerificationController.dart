import 'package:fidelyz/src/modals/UserModel.dart';
import 'package:fidelyz/src/services/repository/AuthRepository.dart';
import 'package:fidelyz/src/services/shared_prefs/UserSharedPrefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import '../../modules/dashboard/Dashboard.dart';
import '../../utils/Utils.dart';
import 'SignUpController.dart';

class PhoneVerificationController extends GetxController {
  final _authRepo = AuthRepository();
  final _signUpPrefs = UserSharedPrefs();
  final pinControllerPhone = TextEditingController();
  RxString? enterOtp;
  RxBool isLoading = false.obs;
  final signUpController = Get.find<SignUpController>();

  void verifyOtp(BuildContext context) async {
    isLoading(true);
    var phone = signUpController.phoneController.text;
    Map data = {"mobilenumber": phone, "otp": pinControllerPhone.text};

    /// wait for api response
    await _authRepo.verifyOtpApi(data).then((value) {
      isLoading(false);
      if (value != null) {
        if (value['error'] == "INVALID_DATA") {
          // show message toast
          Utils.showToastMessage(message: value['message']);
        } else {
          /// Save user data locally
          _signUpPrefs.saveUser(UserModal.fromJson(value)).then((val) {
            _signUpPrefs.saveUserToken(value['token']).then((value) {
              Navigator.push(
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
}
