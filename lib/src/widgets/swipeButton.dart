import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:get/get.dart';

import '../../styles.dart';

class CustomSwipeButton extends StatefulWidget {
  const CustomSwipeButton({Key? key, this.activeColor = Palette.orange})
      : super(key: key);
  final Color? activeColor;

  @override
  _CustomSwipeButtonState createState() => _CustomSwipeButtonState();
}

class _CustomSwipeButtonState extends State<CustomSwipeButton> {
  late bool isSwiped;
  late bool isCompleted;

  @override
  void initState() {
    super.initState();
    isSwiped = false;
    isCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (!isSwiped)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: widget.activeColor!, width: 1),
            ),
            child: SwipeButton.expand(
              duration: const Duration(milliseconds: 200),
              thumbPadding: const EdgeInsets.all(2),
              thumb: const Icon(
                Icons.double_arrow_rounded,
                color: Colors.white,
              ),
              activeThumbColor: widget.activeColor,
              activeTrackColor: Colors.white.withOpacity(0.08),
              onSwipe: () {
                setState(() {
                  isSwiped = true;
                });

                // After swiping, wait for 2 seconds before showing the container
                Future.delayed(const Duration(seconds: 2), () {
                  setState(() {
                    isCompleted = true;
                  });
                });
                Future.delayed(const Duration(seconds: 3), () {
                  Navigator.pop(context);
                });
              },
              child: Text(
                "Save".tr,
                style: TextStyles().smallHeadingWhite,
              ),
            ),
          ),
        if (isSwiped && !isCompleted)
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Palette.secondaryColor),
              ),
            ],
          ),
        if (isCompleted)
          Container(
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Palette.green,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: Text(
                  "Completed".tr,
                  style: TextStyles.rewardCardTitle,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
