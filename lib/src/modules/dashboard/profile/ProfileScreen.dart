import 'dart:io';
import 'package:fidelyz/LandingPage.dart';
import 'package:fidelyz/src/controllers/profile/ProfileController.dart';
import 'package:fidelyz/src/modules/dashboard/FAQs/FAQs.dart';
import 'package:fidelyz/src/modules/dashboard/Notification/Notification.dart';
import 'package:fidelyz/src/modules/dashboard/PrivacyPolicy/PrivacyPolicy.dart';
import 'package:fidelyz/src/modules/dashboard/contact-us/ContactUs.dart';
import 'package:fidelyz/src/modules/dashboard/profile/EditProfile.dart';
import 'package:fidelyz/src/modules/dashboard/profile/UpdatePassword.dart';
import 'package:fidelyz/src/modules/dashboard/profile/test.dart';
import 'package:fidelyz/src/modules/dashboard/store/SavedDeals.dart';
import 'package:fidelyz/src/modules/dashboard/store/store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../styles.dart';
import '../../../services/shared_prefs/UserSharedPrefs.dart';
import '../rewards/Rewards.dart';
import '../termandcondition/TermAndCondition.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());
    double profile = 95;
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      appBar: AppBar(
        backgroundColor: Palette.primaryColor,
        toolbarHeight: 60,
        title: Text('Profile'.tr, style: TextStyles.appBarTitle),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: const Notifications()));
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Image.asset(
                      "assets/icons/notification.png",
                      height: 22,
                      width: 22,
                      color: Colors.white,
                      fit: BoxFit.contain,
                    ),
                    const Positioned(
                      right: -6,
                      top: -2,
                      child: CircleAvatar(
                        backgroundColor: Palette.orange,
                        radius: 9,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 1),
                            child: Text(
                              "2",
                              style: TextStyles.notificationWhiteMiniBond,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: ListView(
        padding:
        const EdgeInsets.symmetric(horizontal: 15).copyWith(bottom: 40),
        children: [
          /// Profile Pic
          Padding(
            padding: const EdgeInsets.only(top: 1),
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
                        if (profileController.selectedFile?.value != null &&
                            profileController
                                .selectedFile!.value.path.isNotEmpty) {
                          return buildProfilePicture(
                              profile,
                              FileImage(File(
                                  profileController.selectedFile!.value.path)));
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
                        await profileController.pickImage();
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
          //name text
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Obx(
                    () => Text(
                  '${profileController.user.firstname} ${profileController.user.lastname}',
                  style: TextStyles.titleText,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// Tiles card
          ListTileWidget(
            title: 'EditProfile'.tr,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const EditProfile(),
              ));
            },
            iconSrc: 'assets/profile/edit.png',
          ),

          ListTileWidget(
            title: 'UpdatePassword'.tr,
            onTap: () {
              Navigator.of(context).push(
                PageTransition(
                  type: PageTransitionType.fade,
                  child: const UpdatePassword(),
                ),
              );
            },
            iconSrc: 'assets/profile/lock.png',
          ),
          ListTileWidget(
            title: 'SaveDeals'.tr,
            onTap: () {
              Navigator.of(context).push(
                PageTransition(
                  type: PageTransitionType.fade,
                  child: const SavedDeals(),
                ),
              );
            },
            isIcon: true,
            iconSrc: 'assets/profile/loyalty.png',
          ),
          ListTileWidget(
            title: 'Rewards'.tr,
            onTap: () {
              Navigator.of(context).push(
                PageTransition(
                  type: PageTransitionType.fade,
                  child: const   Rewards(),
                ),
              );
            },
            iconSrc: 'assets/profile/edit2.png',
          ),
          ListTileWidget(
            title: 'Reward History'.tr,
            onTap: () {
              // Navigator.of(context).push(
              //   PageTransition(
              //     type: PageTransitionType.fade,
              //     child: const SavedDeals(),
              //   ),
              // );
            },
            isIcon: true,
            iconSrc: 'assets/profile/loyalty.png',
          ),
          ListTileWidget(
            title: 'ContactUs'.tr,
            onTap: () {
              Navigator.of(context).push(
                PageTransition(
                  type: PageTransitionType.fade,
                  child: const ContactUs(),
                ),
              );
            },
            iconSrc: 'assets/profile/call.png',
          ),
          ListTileWidget(
            title: 'Terms&Conditions'.tr,
            onTap: () {
              Navigator.of(context).push(
                PageTransition(
                  type: PageTransitionType.fade,
                  child: const TermsAndConditions(),
                ),
              );
            },
            iconSrc: 'assets/profile/edit2.png',
          ),

          ListTileWidget(
            title: 'FAQS'.tr,
            onTap: () {
              Navigator.of(context).push(
                PageTransition(
                  type: PageTransitionType.fade,
                  child: const FAQs(),
                ),
              );
            },
            iconSrc: 'assets/profile/edit2.png',
          ),
          ListTileWidget(
            title: 'PrivacyPolicy'.tr.replaceAll('.', ''),
            onTap: () {
              Navigator.of(context).push(
                PageTransition(
                  type: PageTransitionType.fade,
                  child:  MapScreen(),
                ),
              );
            },
            iconSrc: 'assets/profile/lock.png',
          ),

          ListTileWidget(
            title: 'LogOut'.tr,
            onTap: () async {
              final userPrefs = UserSharedPrefs();
              bool isUserClear = await userPrefs.removeUser();
              if (isUserClear) {
                if (!context.mounted) return;
                Navigator.of(context).pushReplacement(
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: const LandingPage(),
                  ),
                );
              }
            },
            iconSrc: 'assets/profile/logout.png',
          ),
          ListTileWidget(
            title: 'DeleteAccount'.tr,
            onTap: () {
              Navigator.of(context).push(
                PageTransition(
                  type: PageTransitionType.fade,
                  child: const Notifications(),
                ),
              );
            },
            iconSrc: 'assets/profile/delete.png',
          ),
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

class ListTileWidget extends StatelessWidget {
  final String title;
  final Function onTap;
  final String iconSrc;
  final bool isIcon;
  const ListTileWidget({
    super.key,
    required this.title,
    required this.onTap,
    required this.iconSrc,
    this.isIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Palette.whiteColor.withOpacity(0.08),
      elevation: 0,
      shape: BorderStyles.cardBorderStyle,
      child: ListTile(
        onTap: () => onTap(),
        contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        leading: CircleAvatar(
          backgroundColor: const Color(0xffE56D1F),
          radius: 16,
          child: isIcon
              ? const Icon(
            Icons.favorite,
            color: Colors.white,
            size: 19,
          )
              : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              iconSrc,
              color: Colors.white,
              width: 20,
              height: 20,
            ),
          ),
        ),
        title: Text(
          title,
          style: TextStyles().smallHeadingWhite,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Palette.trailingIconColor.withOpacity(0.6),
          size: 18,
        ),
      ),
    );
  }
}
