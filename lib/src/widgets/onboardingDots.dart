import 'package:fidelyz/styles.dart';
import 'package:flutter/material.dart';

class OnboardingDots extends StatelessWidget {
  bool isActive;
  OnboardingDots(this.isActive, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.circle,
            size: 10,
            color: isActive ? Palette.secondaryColor : Colors.grey,
          ),
          Visibility(
            visible: isActive,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeIn,
              child: const Icon(
                Icons.circle_outlined,
                size: 20,
                color: Palette.secondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
