import 'dart:io';
import 'package:fidelyz/src/controllers/profile/EditProfileController.dart';
import 'package:fidelyz/src/controllers/profile/ProfileController.dart';
import 'package:fidelyz/src/services/ToastMsg.dart';
import 'package:fidelyz/src/utils/Utils.dart';
import 'package:fidelyz/src/widgets/SubmitButton.dart';
import 'package:fidelyz/src/widgets/TextFieldEmail.dart';
import 'package:fidelyz/src/widgets/TextFieldNumber.dart';
import 'package:fidelyz/src/widgets/TextFields.dart';
import 'package:fidelyz/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final editController = Get.put(EditProfileController());

    final profileController = Get.find<ProfileController>();
    double profile = 100;
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      appBar: AppBar(
        backgroundColor: Palette.primaryColor,
        centerTitle: true,
        title: Text(
          'EditProfile'.tr,
          style: TextStyles.appBarTitle,
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 50),
        children: [
          /// profile image
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 20),
            child: Center(
              child: Stack(
                children: [
                  /// profile image
                  Container(
                    height: profile + 5,
                    width: profile + 5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Obx(() {
                        // Check if a file is selected
                        if (editController.selectedFile?.value != null &&
                            editController
                                .selectedFile!.value.path.isNotEmpty) {
                          return buildProfilePicture(
                              profile,
                              FileImage(File(
                                  editController.selectedFile!.value.path)));
                        }

                        // Check if the user has a profile picture URL
                        if (profileController.user.profilepicurl.toString() !=
                            'null') {
                          return buildProfilePicture(
                              profile,
                              NetworkImage(
                                  profileController.user.profilepicurl!));
                        }
                        // use default picture
                        return buildProfilePicture(profile,
                            const AssetImage("assets/image/person.jpg"));
                      }),
                    ),
                  ),

                  ///edit icon on image
                  Positioned(
                    bottom: 5,
                    right: 0,
                    child: GestureDetector(
                      onTap: () async {
                        await editController.pickImage();
                      },
                      child: CircleAvatar(
                        backgroundColor: const Color(0xffE56D1F),
                        radius: 15,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Image.asset(
                              "assets/profile/edit1.png",
                              height: 23,
                              width: 23,
                              color: Colors.white,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// Personal data
          Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20, bottom: 7, top: 30),
            child: Text(
              "UpdateYourFirstName".tr,
              style: TextStyles.textFieldHintWhite,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20,
            ),
            child: Obx(() => TextFields(
              initialText: profileController.user.firstname,
              controller: editController.firstNameController.value,
              focusNode: editController.focusNodeFirstName.value,
              onFieldSubmitted: (value) {
                Utils.changeFieldFocusNode(
                    context: context,
                    current: editController.focusNodeFirstName.value,
                    nextFocus: editController.focusNodeLastName.value);
              },
              onChanged: (value) {},
              hint: "EnterYourFirstName".tr,
            ),)
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20, bottom: 7, top: 20),
            child: Text(
              "UpdateYourLastName".tr,
              style: TextStyles.textFieldHintWhite,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Obx(() => TextFields(
              initialText: profileController.user.lastname,
              controller: editController.lastNameController.value,
              focusNode: editController.focusNodeLastName.value,
              onFieldSubmitted: (value) {
                Utils.changeFieldFocusNode(
                    context: context,
                    current: editController.focusNodeLastName.value,
                    nextFocus: editController.focusNodePhone.value);
              },
              onChanged: (value) {},
              hint: "EnterYourLastName".tr,
            ),)
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20, bottom: 7, top: 20),
            child: Text(
              "UpdateYourMobileNumber".tr,
              style: TextStyles.textFieldHintWhite,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20,
            ),
            child: Obx(
              () => TextFieldNumber(

makeReadOnly: true,
                initialText: profileController.user.mobilenumber,
                controller: editController.phoneController.value,
                focusNode: editController.focusNodePhone.value,
                onFieldSubmitted: (value) {
                  Utils.changeFieldFocusNode(
                      context: context,
                      current: editController.focusNodePhone.value,
                      nextFocus: editController.focusNodeEmail.value);
                },
                dropDownValue: editController.phoneCode!.value,
                onDropDownChanged: (string) =>
                    editController.changePhoneCode(string!),
                onChanged: (value) {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20, bottom: 7, top: 20),
            child: Text(
              "UpdateYourEmail".tr,
              style: TextStyles.textFieldHintWhite,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: TextFieldEmail(
              makeReadOnly: true,
              initialText: profileController.user.email,
              controller: editController.emailController.value,
              focusNode: editController.focusNodeEmail.value,
              onChanged: (value) {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20, top: 20, bottom: 30),
            child: Obx(
                  () => SubmitButton(
                onTap: () async {
                  editController.updateUserProfile();
                },
                title:  "UpdateProfile".tr,
                    color: Palette.secondaryColor,
                isLoading: editController.isLoading.value,
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 20.0, right: 20, top: 30),
          //   child: Obx(
          //     () => SubmitButton(
          //       onTap: ()async {
          //         editController.updateUserProfile();
          //         // ToastMsg().sendSuccessMsg('Successfully updated profile');
          //         // Get.back();
          //       },
          //       title: "UpdateProfile".tr,
          //       color: Palette.secondaryColor,
          //       isLoading: editController.isLoading.value,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Container buildProfilePicture(double profile, ImageProvider imageProvider) {
    return Container(
      height: profile,
      width: profile,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
        shape: BoxShape.circle,
      ),
    );
  }
}
