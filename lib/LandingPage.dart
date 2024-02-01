import 'package:fidelyz/splash-screen.dart';
import 'package:fidelyz/src/modals/UserModel.dart';
import 'package:fidelyz/src/modules/auth/SignIn.dart';
import 'package:fidelyz/src/modules/auth/onboarding.dart';
import 'package:fidelyz/src/modules/dashboard/Dashboard.dart';
import 'package:fidelyz/src/services/shared_prefs/UserSharedPrefs.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Duration splashDelay = const Duration(milliseconds: 3000);

  /// check if user exist
  void checkIfUserExist() async {
    final userPrefs = UserSharedPrefs();
    UserModal userModel = await userPrefs.getUser();
    String? userToken = await userPrefs.getUserToken();
    if (userToken != null && userToken.isNotEmpty) {
      if (userModel.token != null && userModel.id != null) {
        Future.delayed(splashDelay).then((value) {
          Navigator.pushReplacement(
              context,
              PageTransition(
                  type: PageTransitionType.fade, child: const Dashboard()));
        });
      } else {
        Future.delayed(splashDelay).then((value) {
          Navigator.pushReplacement(
              context,
              PageTransition(
                  type: PageTransitionType.fade, child: const SignIn()));
        });
      }
    } else {
      Future.delayed(splashDelay).then((value) {
        Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.fade, child: const Onboarding()));
      });
    }
  }

  @override
  void initState() {
    checkIfUserExist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
