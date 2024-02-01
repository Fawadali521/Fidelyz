import 'package:fidelyz/src/modules/dashboard/profile/ProfileScreen.dart';
import 'package:fidelyz/src/modules/dashboard/qr/QrShow.dart';
import 'package:fidelyz/src/modules/dashboard/rewards/Rewards.dart';
import 'package:fidelyz/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'my-cards/MyCards.dart';
import 'search/Searchs.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentIndex = 2;
  late final PageController? pageController;
  @override
  void initState() {
    pageController = PageController(
      initialPage: currentIndex,
    );
    super.initState();
  }

  @override
  void dispose() {
    pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: Palette.scaffoldBackgroundColor,
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (page) {
          setState(() {
            currentIndex = page;
          });
        },
        children: const [
          MyCards(),
          Rewards(),
          Search(),
          QrShow(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 1,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 11.0,
        unselectedFontSize: 10.0,
        backgroundColor: Palette.primaryColor,
        enableFeedback: false,
        iconSize: 24,
        selectedItemColor: Palette.secondaryColor,
        selectedLabelStyle: TextStyles.bottomNavigationText,
        unselectedLabelStyle: TextStyles.bottomNavigationText2,
        unselectedItemColor: Colors.grey[300],
        currentIndex: currentIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (value) {
          currentIndex = value;
          pageController?.jumpToPage(
            value,
            // curve: Curves.decelerate,
            // duration: const Duration(milliseconds: 300),
          );

          setState(() {});
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const ImageIcon(
              AssetImage("assets/icons/loyalty-card.png"),
              size: 20,
            ),
            label: 'MyCards'.tr,
          ),
          BottomNavigationBarItem(
            icon: const ImageIcon(AssetImage("assets/icons/gift-box.png"),
                size: 20),
            label: 'Rewards'.tr,
          ),
          BottomNavigationBarItem(
            icon: const ImageIcon(AssetImage("assets/icons/searching.png"),
                size: 20),
            label: 'Search'.tr,
          ),
          BottomNavigationBarItem(
            icon: const ImageIcon(AssetImage("assets/icons/qr-code.png"),
                size: 20),
            label: 'QR Code'.tr,
          ),
          BottomNavigationBarItem(
            icon:
                const ImageIcon(AssetImage("assets/icons/user.png"), size: 20),
            label: 'Profile'.tr,
          ),
        ],
      ),
    );
  }
}
