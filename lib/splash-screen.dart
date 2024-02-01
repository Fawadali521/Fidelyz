import 'package:fidelyz/styles.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Duration initialDelay = const Duration(milliseconds: 500);
  Duration initialDelay2 = const Duration(milliseconds: 1000);
  Duration initialDelay3 = const Duration(milliseconds: 700);
  bool isLogoMoved = false;
  bool isTextMoved = false;
  @override
  void initState() {
    Future.delayed(initialDelay).then((value) {
      setState(() {
        isLogoMoved = true;
      });
    });
    Future.delayed(initialDelay2).then((value) {
      setState(() {
        isTextMoved = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double afterHeight = 100;
    double normalHeight = 220;
    // double textHeight = 135;
    double textHeight = 135 + 31;
    double padding = 15;

    if (height < 100) {
      return Scaffold(
          body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          color: Palette.primaryColor,
        ),
        child: SizedBox(
          height: height,
          width: width,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: height,
                width: width,
                decoration: const BoxDecoration(
                  color: Palette.primaryColor,
                ),
              ),
              Image.asset(
                "assets/logo/icon-220.png",
                height: normalHeight,
                width: normalHeight,
              ),
            ],
          ),
        ),
      ));
    } else {
      return Scaffold(
        body: Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(
            color: Palette.primaryColor,
          ),
          child: SizedBox(
            height: height,
            width: width,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: height,
                  width: width,
                  decoration: const BoxDecoration(
                    color: Palette.primaryColor,
                  ),
                ),
                if (isLogoMoved)
                  AnimatedPositioned(
                    duration: initialDelay2,
                    top: (height - afterHeight) / 2,
                    curve: Curves.fastEaseInToSlowEaseOut,
                    left: isTextMoved
                        ? (width - afterHeight - textHeight - padding) / 2 + afterHeight + padding
                        : (width - afterHeight - textHeight - padding) / 2,
                    child: AnimatedOpacity(
                      duration: initialDelay3,
                      opacity: isTextMoved ? 1 : 0,
                      child: SizedBox(
                        width: textHeight,
                        height: afterHeight,
                        child: const Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Fidelyz",
                                style: TextStyles.splashLogoText,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                SizedBox(
                  height: height,
                  width: width,
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                        duration: initialDelay,
                        left: isLogoMoved ? (width - afterHeight - textHeight - padding) / 2 : width / 2 - normalHeight / 2,
                        height: isLogoMoved ? afterHeight : normalHeight,
                        width: isLogoMoved ? afterHeight : normalHeight,
                        top: isLogoMoved ? (height - afterHeight) / 2 : (height - normalHeight) / 2,
                        curve: Curves.easeIn,
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              "assets/logo/icon-220.png",
                              height: normalHeight,
                              width: normalHeight,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
