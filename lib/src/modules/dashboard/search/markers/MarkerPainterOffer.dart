import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:fidelyz/styles.dart';
import 'package:flutter/material.dart';

class MarkerPainterOffer extends CustomPainter {
  final ui.Image cardImage;
  final ui.Image logoImage;
  final String shopNameText;
  final String offerText;
  final String expiresText;
  final ui.Image tagImage;

  MarkerPainterOffer(this.cardImage, this.logoImage, this.shopNameText,
      this.offerText, this.expiresText, this.tagImage);

  @override
  void paint(Canvas canvas, Size size) {
    const double cardWidth = 392.0;
    const double cardHeight = 383.0;

    const double logoSize = 95.0;

    const Offset logoOffset = Offset(
      (cardWidth - logoSize) * 0.195,
      cardHeight * 0.075,
    );

    // Drawing the card image
    canvas.drawImageRect(
      cardImage,
      Rect.fromLTWH(
          0, 0, cardImage.width.toDouble(), cardImage.height.toDouble()),
      const Rect.fromLTWH(0, 0, cardWidth, cardHeight),
      Paint(),
    );

    // Increase circleRadius
    const double circleRadius = logoSize * 0.6;
    const Offset circleOffset = Offset(
      cardWidth * 0.2675,
      cardHeight * 0.196,
    );
    canvas.drawCircle(circleOffset, circleRadius,
        Paint()..color = const Color(0xFFff6600).withOpacity(0.3));

    // Drawing the logo on top of the circle
    final logoRect = Rect.fromCenter(
      center:
          Offset(logoOffset.dx + logoSize / 2, logoOffset.dy + logoSize / 2),
      width: logoSize,
      height: logoSize,
    );
    final clipOval = Path()..addOval(logoRect);
    canvas.saveLayer(logoRect, Paint());
    canvas.clipPath(clipOval);

    // Proportionally scale the logo
    final double scaleFactor = logoSize /
        math.min(logoImage.width.toDouble(), logoImage.height.toDouble());
    final scaledLogoWidth = logoImage.width * scaleFactor;
    final scaledLogoHeight = logoImage.height * scaleFactor;

    canvas.drawImageRect(
      logoImage,
      Rect.fromLTWH(
          0, 0, logoImage.width.toDouble(), logoImage.height.toDouble()),
      Rect.fromCenter(
          center: logoRect.center,
          width: scaledLogoWidth,
          height: scaledLogoHeight),
      Paint(),
    );
    canvas.restore();

    // Drawing the texts
    _drawText(
        canvas,
        shopNameText,
        const Offset(cardWidth * 0.125, cardHeight * 0.355),
        30,
        FontWeight.w500,
        Colors.black87);
    _drawText(
        canvas,
        offerText,
        const Offset(cardWidth * 0.095, cardHeight * 0.48),
        35,
        FontWeight.bold,
        Palette.secondaryColor);
    _drawText(
        canvas,
        expiresText,
        const Offset(cardWidth * 0.1, cardHeight * 0.73),
        30,
        FontWeight.normal,
        Colors.black);
// Drawing the price-tag image
    const double tagImageSize =
        60.0; // Define the desired size for the tag image
    const Offset tagImageOffset = Offset(
      cardWidth *
          0.88, // Adjust these values to position the image where you want it
      cardHeight * 0.75,
    );

    final tagImageRect = Rect.fromCenter(
      center: tagImageOffset,
      width: tagImageSize,
      height: tagImageSize,
    );

    canvas.drawImageRect(
      tagImage,
      Rect.fromLTWH(0, 0, tagImage.width.toDouble(),
          tagImage.height.toDouble()), // Source rectangle
      tagImageRect, // Destination rectangle
      Paint(),
    );
  }

  void _drawText(Canvas canvas, String text, Offset offset, double fontSize,
      FontWeight fontWeight, Color color) {
    const double cardWidth = 382.0;
    final textSpan = TextSpan(
      text: text,
      style:
          TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(maxWidth: cardWidth * 0.885);
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
