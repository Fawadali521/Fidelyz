import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../modals/UserModel.dart';
import '../../services/ToastMsg.dart';
import '../../services/repository/ProfileRepository.dart';
import '../../services/shared_prefs/UserSharedPrefs.dart';
import '../../utils/Utils.dart';
import 'ProfileController.dart';

class EditProfileController extends GetxController {
  final profileController = Get.find<ProfileController>();
  final _profileRepo = ProfileRepository();
  final _userSharedPrefs = UserSharedPrefs();
  final Rx<XFile>? selectedFile = Rx<XFile>(XFile(''));

  final Rx<XFile>? selectedCoverFile = Rx<XFile>(XFile(''));
  /// fields controllers
  final Rx<TextEditingController> firstNameController =
      TextEditingController().obs;
  final Rx<TextEditingController> lastNameController =
      TextEditingController().obs;
  final Rx<TextEditingController> phoneController = TextEditingController().obs;
  final Rx<TextEditingController> emailController = TextEditingController().obs;

  /// fields focus nodes
  final focusNodeFirstName = FocusNode().obs;
  final focusNodeLastName = FocusNode().obs;
  final focusNodePhone = FocusNode().obs;
  final focusNodeEmail = FocusNode().obs;

  RxBool isLoading = false.obs;

  XFile? get file => selectedFile?.value;

  RxString? phoneCode = '+241'.obs;

  @override
  void onInit() {
    firstNameController.value =
        TextEditingController(text: profileController.user.firstname);
    lastNameController.value =
        TextEditingController(text: profileController.user.lastname);
    phoneController.value =
        TextEditingController(text: profileController.user.mobilenumber);
    emailController.value =
        TextEditingController(text: profileController.user.email);
    super.onInit();
  }

  /// change phone code
  void changePhoneCode(String string) {
    phoneCode!.value = string;
  }

  /// pic image from gallery
  Future<void> pickImage() async {
    try {
      print('true');
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

    /// upload the picture
  //   uploadProfilePicture(
  //       selectedFile!.value, 'seller_logo', isUploadingProfile);
   }
  /// update seller details
  void updateUserProfile() async {
    isLoading(true);
    var userData = await _userSharedPrefs.getUser(); // get user id

    var data = {
      "userid": userData.id,
      "firstname": firstNameController.value.text,
      "lastname": lastNameController.value.text,
      "gender":"MALE" ,
      "dob": "1998-06-28",

    };

    /// create headers
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${userData.token}'
    };

    await _profileRepo.updateUserDetailsApi(data, headers).then((value) {
      if (value != null) {
        if (value['error'] == "INVALID_DATA") {
          isLoading(false);
          ToastMsg().sendSuccessMsg(value['message']);
        } else {
          print("hit sucessfully");
          isLoading(false);
          _userSharedPrefs
              .saveUser(
            UserModal(
              token:value['token'],
              id: value["id"],
              firstname:value["firstname"] ,
              lastname:value["lastname"] ,
             gender:value["gender"] ,
              dob:value["dob"]
            ),
          )
              .then((value) {
            profileController.getUserData();
            ToastMsg().sendSuccessMsg('Profile updated successfully');
            Get.back();
          });
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
          title: 'No internet',
        );
      }
    });
  }
  /// upload profile picture
  // void uploadProfilePicture(
  //     XFile file, String fieldName, RxBool isLoading) async {
  //   var sellerId = await _userSharedPrefs.getUser()
  //
  //   isLoading(true);
  //   var data = {'seller_id': sellerId.};
  //   File newFile = File(file.path);
  //   await _profileRepo
  //       .updateProfileOrCover(data, newFile, fieldName)
  //       .then((value) {
  //     if (value != null) {
  //       if (value["error"] == "INVALID_DATA") {
  //         isLoading(false);
  //         selectedFile!.value = XFile('');
  //         selectedCoverFile!.value = XFile('');
  //         ToastMsg().sendSuccessMsg(value['message']);
  //       } else {
  //         isLoading(false);
  //         _userSharedPrefs
  //             .saveUser(
  //           UserModal(
  //             businessname: value["businessname"],
  //             managername: value["managername"],
  //             email: value["email"],
  //             mobilenumber: value["mobilenumber"],
  //             profilepicurl: value['profilepicurl'],
  //             sellerlogo: value['sellerlogourl'],
  //           ),
  //         )
  //             .then((value) {
  //           profileController.getUserData();
  //           selectedFile!.value = XFile('');
  //           selectedCoverFile!.value = XFile('');
  //           ToastMsg().sendSuccessMsg('Profile updated successfully');
  //         });
  //       }
  //     }
  //   }).onError((error, stackTrace) {
  //     isLoading(false);
  //     if (kDebugMode) {
  //       print("Error is $error");
  //     }
  //
  //     /// Check if no internet found
  //     if (error.toString() == 'No Internet null') {
  //       Utils.showToastMessage(
  //         message: 'Make sure you have the internet connection',
  //         title: 'No internet',
  //       );
  //     }
  //   });
  // }
  /// dispose all text controllers
  @override
  void dispose() {
    super.dispose();
    firstNameController.value.dispose();
    lastNameController.value.dispose();
    phoneController.value.dispose();
    emailController.value.dispose();
  }
}
