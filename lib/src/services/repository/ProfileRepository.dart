import 'dart:io';


import '../../resources/app_urls/AppUrls.dart';
import '../NetworkApiClass.dart';
import '../shared_prefs/UserSharedPrefs.dart';

class ProfileRepository {
  final _networkApiService = NetworkApiClass();
  final _userSharedPrefs = UserSharedPrefs();

  /// update item
  Future<dynamic> updateUserDetailsApi(
      var data, Map<String, String> headers) async {
    dynamic response = await _networkApiService.patchApi(
        data, AppUrls.updateUser, headers);
    return response;
  }

  // /// update profile picture or cover photo
  // Future<dynamic> updateProfileOrCover(
  //     var data, File file, String fieldName) async {
  //   var userData = await _userSharedPrefs.getUser();
  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer ${userData.token}'
  //   };
  //
  //   dynamic response = await _networkApiService.patchMultipartFiles(
  //       data, AppUrls.addUpdateSellerProfileAndCover, headers, file, fieldName);
  //
  //   return response;
  // }
}
