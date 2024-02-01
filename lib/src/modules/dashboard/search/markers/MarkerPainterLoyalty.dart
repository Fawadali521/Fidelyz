import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class MarkerPainterLoyalty extends CustomPainter {
  final ui.Image cardImage;
  final ui.Image logoImage;
  final String shopNameText;
  final String offerText;
  final String expiresText;

  MarkerPainterLoyalty(this.cardImage, this.logoImage, this.shopNameText,
      this.offerText, this.expiresText);

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
        // expiresText,
        'Visit Store & Claim Loyalty Points',
        const Offset(cardWidth * 0.125, cardHeight * 0.455),
        25,
        FontWeight.normal,
        Colors.black);
    //draw Container with  secondaryColor bg color , border radius 10, cenetr a text "Claim Now" with white color bold text
    // Draw Container for "Claim Now" button
    void _drawText2(Canvas canvas, String text, Offset offset, double fontSize,
        FontWeight fontWeight, Color color) {
      const double cardWidth = 382.0;
      final textSpan = TextSpan(
        text: text,
        style:
            TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.center, // Align the text to the center
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(maxWidth: cardWidth * 0.885);
      textPainter.paint(canvas, offset);
    }

    const double buttonWidth = cardWidth * 0.8;
    const double buttonHeight = 70.0;
    final buttonRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: const Offset(cardWidth * 0.5, cardHeight * 0.735),
        width: buttonWidth,
        height: buttonHeight,
      ),
      const Radius.circular(10.0),
    );
    canvas.drawRRect(
      buttonRect,
      Paint()
        ..color = Colors.green // Assuming you have this color defined
        ..style = PaintingStyle.fill,
    );

    // Draw "Claim Now" text on the button
    _drawText2(
      canvas,
      "Claim Now!",
      const Offset(
        cardWidth * 0.5 - buttonWidth * 0.37,
        cardHeight * 0.735 - buttonHeight * 0.35,
      ),
      40,
      FontWeight.bold,
      Colors.white,
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
