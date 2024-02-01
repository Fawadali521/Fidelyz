import 'package:fidelyz/src/resources/app_urls/AppUrls.dart';
import 'package:fidelyz/src/services/NetworkApiClass.dart';

import '../shared_prefs/UserSharedPrefs.dart';

class AuthRepository {
  final _networkApiService = NetworkApiClass();
  final _userSharedPrefs = UserSharedPrefs();

  /// Sign up Api call
  Future<dynamic> signUpApi(var data) async {
    dynamic response =
        await _networkApiService.postApi(data, AppUrls.signUpApi);
    return response;
  }

  /// Sign In Api Call
  Future<dynamic> signInApi(var data) async {
    dynamic response =
        await _networkApiService.postApi(data, AppUrls.signInApi);
    return response;
  }

  /// Verify Mobile otp
  Future<dynamic> verifyOtpApi(var data) async {
    dynamic response =
        await _networkApiService.postApi(data, AppUrls.verifyOtp);
    return response;
  }

  /// send otp to mobile phone
  Future<dynamic> sendOtpApi(var data) async {
    dynamic response = await _networkApiService.postApi(data, AppUrls.sendOtp);
    return response;
  }

  /// Create new Password
  Future<dynamic> forgotPasswordApi(var data) async {
    dynamic response =
        await _networkApiService.postApi(data, AppUrls.forgotPassword);
    return response;
  }
  ///Update Password
  Future<dynamic> updatePasswordApi(var data) async {

    var user = await _userSharedPrefs.getUser();
    dynamic response = await _networkApiService.patchApi(
        data, AppUrls.updatePassword, {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${user.token}'
    });
    return response;
  }
}
