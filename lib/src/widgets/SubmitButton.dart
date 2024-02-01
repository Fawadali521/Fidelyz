import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../styles.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final Color color;
  final bool isLoading;
  final double height;
  final bool isWidget;
  final Widget? widget;

  const SubmitButton(
      {super.key,
        required this.onTap,
        required this.title,
        this.color = Palette.primaryColor,
        this.isLoading = false,
        this.isWidget = false,
        this.height = 45,
        this.widget});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      elevation: 1,
      height: height,
      color: color,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderStyles.norm2,
      ),
      child: Center(
        child: isLoading
            ? Transform.scale(
          scale: 0.5,
          child: const CircularProgressIndicator(
            color: Colors.white,
          ),
        )
            : isWidget
            ? widget
            : Text(
          title,
          style: TextStyles.buttonWhite,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
