import 'package:flutter/material.dart';
import '../../styles.dart';

class DialogBoxWidget extends StatelessWidget {
  const DialogBoxWidget({
    Key? key,
    required this.asset,
    required this.text,
    required this.cancelButtonText,
    required this.confirmButtonText,
    required this.onConfirm,
    required this.onCancel,
    this.assetHeight = 100,
    this.assetWidth = 75,
  }) : super(key: key);

  final String asset;
  final String text;
  final String cancelButtonText;
  final String confirmButtonText;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;
  final double assetWidth;
  final double assetHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          asset,
          width: assetWidth,
          height: assetHeight,
          fit: BoxFit.fill,
        ),
        const SizedBox(height: 16),
        Text(
          text,
          style: TextStyles().smallHeadingWhite.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: MaterialButton(
                onPressed: onCancel,
                elevation: 1,
                height: 40,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Colors.white)),
                child: Text(
                  cancelButtonText,
                  style: TextStyles().smallHeadingWhite.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: FittedBox(
                fit: BoxFit.contain,
                child: MaterialButton(
                  onPressed: onConfirm,
                  elevation: 1,
                  height: 40,
                  color: const Color(0xffE56D1F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    confirmButtonText,
                    style: TextStyles().smallHeadingWhite.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
