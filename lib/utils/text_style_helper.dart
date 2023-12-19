import 'package:flutter/material.dart';
import 'package:qulip/common/colors.dart';

class MyTextTheme9Normal {
  static TextStyle black() {
    return TextStyle(
      fontFamily: slashieFontFamily,
      fontSize: MyTextTheme11Normal.fontSize - 2,
      fontWeight: MyTextTheme11Normal.fontWeight,
      color: MyTextTheme11Normal.blackColor,
    );
  }

  static TextStyle green() {
    return TextStyle(
      fontFamily: slashieFontFamily,
      fontSize: MyTextTheme11Normal.fontSize - 2,
      fontWeight: MyTextTheme11Normal.fontWeight,
      color: MyTextTheme11Normal.greenColor,
    );
  }
}

class MyTextTheme9Bold {
  static TextStyle lightGrey() {
    return TextStyle(
      fontFamily: slashieFontFamily,
      fontSize: MyTextTheme11Normal.fontSize - 2,
      fontWeight: MyTextTheme11Normal.fontWeight,
      color: MyTextTheme11Normal.greyColor.withOpacity(0.5),
    );
  }
}

class MyTextTheme11Normal {
  static double fontSize = 11;
  static FontWeight fontWeight = FontWeight.normal;
  static Color blackColor = stdBlack;
  static Color greenColor = Colors.green;
  static Color greyColor = stdgrey;
  static Color redColor = Colors.red;
  static Color orangeColor = Colors.orange;
  static Color whiteColor = stdwhite;

  static TextStyle black() {
    return TextStyle(
      fontFamily: slashieFontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: blackColor,
    );
  }

  static TextStyle green() {
    return TextStyle(
      fontFamily: slashieFontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: greenColor,
    );
  }

  static TextStyle grey() {
    return TextStyle(
      fontFamily: slashieFontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: greyColor,
    );
  }

  static TextStyle red() {
    return TextStyle(
      fontFamily: slashieFontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: redColor,
    );
  }

  static TextStyle orange() {
    return TextStyle(
      fontFamily: slashieFontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: orangeColor,
    );
  }

  static TextStyle whiteStyle() {
    return TextStyle(
      fontFamily: slashieFontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: whiteColor,
    );
  }
}

class MyTextTheme11Bold {
  static double fontSize = 11;
  static FontWeight fontWeight = FontWeight.bold;
  static Color greyColor = stdgrey;
  static Color whiteColor = stdwhite;

  static TextStyle grey() {
    return TextStyle(
      fontFamily: slashieFontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: greyColor,
    );
  }

  static TextStyle whiteStyle() {
    return TextStyle(
      fontFamily: slashieFontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: whiteColor,
    );
  }
}

class MyTextTheme12Normal {
  static TextStyle grey() {
    return TextStyle(
      fontFamily: slashieFontFamily,
      fontSize: MyTextTheme14Normal.fontSize - 2,
      fontWeight: MyTextTheme14Normal.fontWeight,
      color: MyTextTheme14Normal.greyColor,
    );
  }

  static TextStyle lightGrey() {
    return TextStyle(
      fontFamily: slashieFontFamily,
      fontSize: MyTextTheme14Normal.fontSize - 2,
      fontWeight: MyTextTheme14Normal.fontWeight,
      color: MyTextTheme14Normal.greyColor.withOpacity(0.5),
    );
  }
}

class MyTextTheme12Bold {
  static TextStyle grey() {
    return TextStyle(
      fontFamily: slashieFontFamily,
      fontSize: MyTextTheme14Bold.fontSize,
      fontWeight: MyTextTheme14Bold.fontWeight,
      color: MyTextTheme14Bold.greyColor,
    );
  }

  static TextStyle black() {
    return TextStyle(
      fontFamily: slashieFontFamily,
      fontSize: MyTextTheme14Bold.fontSize,
      fontWeight: MyTextTheme14Bold.fontWeight,
      color: MyTextTheme14Bold.blackColor,
    );
  }
}

class MyTextTheme14Normal {
  static double fontSize = 14;
  static FontWeight fontWeight = FontWeight.normal;
  static Color greyColor = stdDarkGray;
  static Color blackColor = stdBlack;
  static Color whiteColor = Colors.white;

  static TextStyle black() {
    return TextStyle(
      fontFamily: slashieFontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: blackColor,
    );
  }

  static TextStyle grey() {
    return TextStyle(
      fontFamily: slashieFontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: greyColor,
    );
  }

  static TextStyle white() {
    return TextStyle(
      fontFamily: slashieFontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: whiteColor,
    );
  }
}

class MyTextTheme14Bold {
  static double fontSize = 14;
  static FontWeight fontWeight = FontWeight.bold;
  static Color greyColor = stdDarkGray;
  static Color blackColor = stdBlack;
  static Color whiteColor = stdwhite;

  static TextStyle black() {
    return TextStyle(
      fontFamily: slashieFontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: blackColor,
    );
  }

  static TextStyle grey() {
    return TextStyle(
      fontFamily: slashieFontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: greyColor,
    );
  }

  static TextStyle whiteStyle() {
    return TextStyle(
      fontFamily: slashieFontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: whiteColor,
    );
  }
}

class MyTextTheme16Bold {
  static TextStyle black() {
    return TextStyle(
      fontFamily: slashieFontFamily,
      fontSize: MyTextTheme20Bold.fontSize - 4,
      fontWeight: MyTextTheme20Bold.fontWeight,
      color: MyTextTheme20Bold.blackColor,
    );
  }

  static TextStyle grey() {
    return TextStyle(
      fontFamily: slashieFontFamily,
      fontSize: MyTextTheme20Bold.fontSize - 4,
      fontWeight: MyTextTheme20Bold.fontWeight,
      color: MyTextTheme20Bold.greyColor,
    );
  }
}

class MyTextTheme18Bold {
  static TextStyle black() {
    return TextStyle(
      fontFamily: slashieFontFamily,
      fontSize: MyTextTheme20Bold.fontSize - 2,
      fontWeight: MyTextTheme20Bold.fontWeight,
      color: MyTextTheme20Bold.blackColor,
    );
  }
}

class MyTextTheme20Bold {
  static double fontSize = 20;
  static FontWeight fontWeight = FontWeight.bold;
  static Color greyColor = stdgrey;
  static Color blackColor = stdBlack;
  static Color whiteColor = stdwhite;

  static TextStyle black() {
    return TextStyle(
      fontFamily: slashieFontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: blackColor,
    );
  }

  static TextStyle grey() {
    return TextStyle(
      fontFamily: slashieFontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: greyColor,
    );
  }

  static TextStyle whiteStyle() {
    return TextStyle(
      fontFamily: slashieFontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: whiteColor,
    );
  }
}

class MyTextStyle {
  //static TextStyle h1 = const TextStyle();
  //static TextStyle h2 = const TextStyle();
  //static TextStyle h3 = const TextStyle();
  //static TextStyle n1 = const TextStyle();
}
