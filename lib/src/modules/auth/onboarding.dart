import 'package:avatar_glow/avatar_glow.dart';
import 'package:fidelyz/infos.dart';
import 'package:fidelyz/src/modules/auth/SignIn.dart';
import 'package:fidelyz/src/widgets/OnBoardingButton.dart';
import 'package:fidelyz/src/widgets/SubmitButton.dart';
import 'package:fidelyz/src/widgets/onboardingDots.dart';
import 'package:fidelyz/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentPage = 0;
  final PageController pageController = PageController(initialPage: 0);
  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  onPageChanged(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      body: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: Infos().onboardingData.length,
            onPageChanged: onPageChanged,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, bottom: 50),
                      child: Image.asset(
                        Infos().onboardingData[index]['image'],
                        fit: BoxFit.contain,
                        width: width - 60,
                        height: 250,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20, bottom: 10),
                      child: Text(
                        Infos().onboardingData[index]['title'],
                        style: TextStyles.bigHeadingWhite,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20, bottom: 15),
                      child: Text(
                        Infos().onboardingData[index]['description'],
                        textAlign: TextAlign.center,
                        style: TextStyles.textFieldHintWhite,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            bottom: height * 0.27,
            child: SizedBox(
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int i = 0; i < Infos().onboardingData.length; i++)
                    if (i == currentPage)
                      OnboardingDots(true)
                    else
                      OnboardingDots(false)
                ],
              ),
            ),
          ),
          Positioned(
            bottom: height * 0.04,
            child: SizedBox(
              width: width,
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: 20 , right: 20, bottom: 10, top: 10),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 15
                    ),
                    child: OnBoardingButton(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          if (currentPage == 0) {
                            pageController.animateToPage(1,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          }
                          if (currentPage == 1) {
                            pageController.animateToPage(2,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          }

                          if (currentPage == 2) {
                            Navigator.pushReplacement(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: const SignIn(),
                              ),
                            );
                          }
                        },
                        color: const Color(0xffFF6501),
                        title: "getStartedButton".tr),
                  ),
                  OnBoardingButton(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: const SignIn()));
                      },
                      enableBorder: true,
                      title: 'Login'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}