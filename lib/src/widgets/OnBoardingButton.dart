import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../styles.dart';

class OnBoardingButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final Color color;
  final bool enableBorder;
  const OnBoardingButton({
    Key? key,
    required this.onTap,
    required this.title,
    this.color = Palette.primaryColor,
    this.enableBorder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      elevation: 1,
      height: 45,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(08),
        side: enableBorder
            ? const BorderSide(color: Colors.white, width: 1)
            : BorderSide.none,
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyles.buttonWhite,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
