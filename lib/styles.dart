import 'package:flutter/material.dart';

class TextStyles {
  static const bodyBlack =
      TextStyle(fontWeight: FontWeight.w400, fontSize: 5, color: Colors.black);
  static const bodyWhite =
      TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: Colors.white);
  static const TextStyle cardSubTitle = TextStyle(
    fontSize: 14,
    color: Colors.white,
    fontFamily: "Comforta",
    fontWeight: FontWeight.w400,
  );
  static const mapsSearchTextStyle = TextStyle(
    fontFamily: 'Comfortaa-Bold',
    fontWeight: FontWeight.w900,
    fontSize: 12,
    color: Colors.white,
  );
  static const paraWhite = TextStyle(
    fontFamily: 'Comfortaa',
    fontSize: 14,
    color: Colors.white,
    fontWeight: FontWeight.w400,
  );
  TextStyle textFieldHintWhite1 = TextStyle(
      fontSize: 15,
      color: Colors.white.withOpacity(0.6),
      fontFamily: "Comfortaa-Bold");
  static const contactUsTaps = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: Colors.white,
    // fontFamily: 'Comfortaa-Bold',
  );
  static const inputTextStyle = TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w500,
    // fontFamily: 'Comfortaa-Medium',
  );
  static const cardAddText = TextStyle(
    fontFamily: 'Comfortaa',
    fontSize: 12,
    color: Colors.white,
    fontWeight: FontWeight.w400,
  );
  static const actionWhiteMiniBond = TextStyle(
    fontFamily: 'Comfortaa-Bold',
    fontWeight: FontWeight.w900,
    fontSize: 12,
    color: Colors.white,
  );
  static const notificationWhiteMiniBond = TextStyle(
    fontFamily: 'Comfortaa-Bold',
    fontWeight: FontWeight.w600,
    fontSize: 10,
    color: Colors.white,
  );
  static TextStyle categoryTextStyle({Color color = Colors.grey}) {
    return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: color,
    );
  }

  static const actionSmallWhiteMiniBond = TextStyle(
      fontFamily: 'Comfortaa-Bold',
      fontWeight: FontWeight.w900,
      fontSize: 14,
      color: Colors.white);
  static const qrText = TextStyle(
      fontWeight: FontWeight.w900,
      fontSize: 22,
      color: Colors.black,
      fontFamily: 'Comfortaa-Bold');
  static const qrTextWhite = TextStyle(
      fontWeight: FontWeight.w900,
      fontSize: 22,
      color: Colors.black,
      fontFamily: 'Comfortaa-Bold');
  static const appBarTitle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 18,
    color: Colors.white,
    fontFamily: 'Comfortaa-Bold',
  );
  static const yellowTitleText = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18,
    // color: Palette.secondaryColor,
    color: Color(0xffF8EC3E),
    fontFamily: 'Comfortaa-Bold',
  );
  static const titleText = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18,
    // color: Palette.secondaryColor,
    color: Colors.white,
    fontFamily: 'Comfortaa-Bold',
  );
  static const bottomNavigationText =
      TextStyle(fontWeight: FontWeight.w900, fontFamily: 'Comfortaa-Bold');
  static const bottomNavigationText2 =
      TextStyle(fontWeight: FontWeight.w900, fontFamily: 'Comfortaa-Bold');
  static const splashLogoText = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 45,
      color: Colors.white,
      fontFamily: 'Comfortaa-Bold');
  static const smallDec =
      TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Colors.black);
  static const smallDecSecondary = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 13, color: Palette.secondaryColor);
  static const smallDecWhite =
      TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w500);
  static const qrDecBlack = TextStyle(
      fontSize: 13, color: Color(0xff0E0E0E), fontFamily: "Comfortaa-Bold");
  static const verySmallDecWhite =
      TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w500);
  static TextStyle textFieldHint = TextStyle(
      fontSize: 14,
      color: Colors.black.withOpacity(0.4),
      fontFamily: "Comfortaa-Bold");
  static TextStyle textFieldHintWhite = TextStyle(
      fontSize: 14,
      color: Colors.white.withOpacity(0.8),
      fontFamily: "Comfortaa-Bold");
  static const TextStyle badgeText = TextStyle(
      fontSize: 14, color: Colors.white, fontFamily: "Comfortaa-Bold");
  static const TextStyle rewardCardOffer = TextStyle(
      fontSize: 18,
      color: Colors.white,
      fontFamily: "Comfortaa-Bold",
      fontWeight: FontWeight.w900);
  static const TextStyle rewardCardTitle = TextStyle(
      fontSize: 16,
      color: Colors.white,
      fontFamily: "Comfortaa-Bold",
      fontWeight: FontWeight.w900);
  static const itemLocation =
      TextStyle(fontSize: 14, color: Colors.green, fontWeight: FontWeight.w500);
  static TextStyle itemLocationDec = TextStyle(
      fontSize: 14,
      color: Colors.white.withOpacity(0.4),
      fontWeight: FontWeight.w400,
      height: 1.6);

  TextStyle numberDropDown = TextStyle(
      fontSize: 14,
      color: Colors.black.withOpacity(0.9),
      fontFamily: "Comfortaa-Bold");
  TextStyle numberDropDownWhite = TextStyle(
      fontSize: 14,
      color: Colors.white.withOpacity(0.9),
      fontFamily: "Comfortaa-Bold");

  TextStyle textField = TextStyle(
      fontSize: 14,
      color: Colors.black.withOpacity(0.8),
      fontWeight: FontWeight.bold,
      fontFamily: "Comfortaa-Bold");
  TextStyle textFieldWhite = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.white.withOpacity(0.8),
      fontFamily: "Comfortaa-Bold");
  TextStyle lightSmallHeading = TextStyle(
      fontSize: 12,
      color: Colors.black.withOpacity(0.8),
      fontFamily: "Comfortaa-SemiBold");
  TextStyle lightSmallHeadingWhite = TextStyle(
    fontSize: 12,
    color: Colors.white.withOpacity(0.8),
    fontWeight: FontWeight.w900,
    fontFamily: "Comfortaa-SemiBold",
  );
  TextStyle smallHeading = const TextStyle(
    fontSize: 14,
    color: Palette.primaryColor,
    fontWeight: FontWeight.bold,
  );
  TextStyle smallHeadingWhite = const TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );
  TextStyle smallHeadingLightGray = TextStyle(
    fontSize: 16,
    color: Colors.white.withOpacity(0.6),
    fontWeight: FontWeight.w600,
  );

  static const buttonWhite = TextStyle(
      fontSize: 14,
      color: Colors.white,
      fontWeight: FontWeight.w900,
      fontFamily: "Comfortaa-Bold");
  static const bigHeading = TextStyle(
    fontSize: 25,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  static const bigHeadingWhite = TextStyle(
    fontSize: 25,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
  static const paraBigWhite2 = TextStyle(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.w900,
      fontFamily: "Comfortaa-Bold",
      height: 0);
  static const paraBigWhite = TextStyle(
    fontSize: 25,
    color: Colors.white,
    fontWeight: FontWeight.w900,
    fontFamily: "Comfortaa-Bold",
  );
  static const splashBigBoldWhiteText = TextStyle(
    fontWeight: FontWeight.w900,
    fontSize: 50,
    color: Colors.white,
    fontFamily: "Comfortaa-Bold",
  );
}

class BorderStyles {
  static const norm = BorderRadius.all(Radius.circular(7));
  static const norm2 = BorderRadius.all(Radius.circular(15));
  static const norm3 = BorderRadius.all(Radius.circular(20));
  static const cardBorderStyle = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );
}

class Palette {
  static Color whiteColorWithOpacity = Colors.white.withOpacity(0.16);
  static const Color primaryColor = darkBackgroundColor;
  static const Color secondaryColor = orange;
  static const Color darkBackgroundColor = Color(0xFF091046);
  static const Color green = Color(0xFF32CC3A);
  static const Color orange = Color(0xFFff6600);
  static const Color orangeLight = Color(0xFFffefe5);
  static const Color scaffoldBackgroundColor = Color(0xFFE8F1FA);
  static const Color redGradiant2 = Color(0xFFa40001);
  static const Color trailingIconColor = Color(0xffFAFAFA);
  static const Color whiteColor = Color(0xffffffff);
}
