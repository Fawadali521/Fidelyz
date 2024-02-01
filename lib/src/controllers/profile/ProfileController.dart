import 'dart:io';
import 'package:fidelyz/src/modals/UserModel.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../services/ToastMsg.dart';
import '../../services/shared_prefs/UserSharedPrefs.dart';

class ProfileController extends GetxController {
  final _userSharedPrefs = UserSharedPrefs();
  final Rx<XFile>? selectedFile = Rx<XFile>(XFile(''));
  XFile? get file => selectedFile?.value;

// set user modal and get user modal
  final Rx<UserModal> _userModal = UserModal().obs;

  UserModal get user => _userModal.value;

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  /// get user data from shared preferences
  getUserData() async {
    _userModal.value = await _userSharedPrefs.getUser();
  }

// pic image from gallery
  Future<void> pickImage() async {
    try {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      selectedFile?.value = image;
    } catch (e) {
      if (kDebugMode) {
        print("Error picking image: $e");
      }

      // Check the error message
      if (e.toString().contains("invalid_image")) {
        ToastMsg().sendErrorMsg(
            "There was an issue with the selected image. Please try a different image.");
      } else {
        ToastMsg().sendErrorMsg("Error picking image: $e");
      }
    }
  }
}
