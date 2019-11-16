import 'package:flutter/material.dart';

final ThemeData themeData = new ThemeData(
    fontFamily: 'ProductSans',
    brightness: Brightness.light,
    primarySwatch: MaterialColor(AppColors.green[500].value, AppColors.green),
    primaryColor: AppColors.green[500],
    primaryColorBrightness: Brightness.light,
    accentColor: AppColors.green[500],
    accentColorBrightness: Brightness.light,
    dividerColor: AppColors.gray[100],
    backgroundColor: AppColors.gray[20],
    textTheme: TextTheme(
        title: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
        display1: TextStyle(fontSize: 30.0),
        display2: TextStyle(fontSize: 25.0),
        display3: TextStyle(fontSize: 23.0),
        display4: TextStyle(fontSize: 21.0),
        body1: TextStyle(fontSize: 19.0),
        subhead: TextStyle(fontSize: 16.0),
        caption: TextStyle(fontSize: 17.0, color: AppColors.gray[100])));

final double avatarSize = 45;
final double iconSize = 40;
final double heightButton = 40;
final int numberPage = 5;

final BorderRadius avatarBorderRadius =
    BorderRadius.all(Radius.circular(avatarSize));

final BorderRadius buttonBorderRadius = BorderRadius.all(Radius.circular(8));

final double logoSize = 100;
final BorderRadius logoBorderRadius =
    BorderRadius.all(Radius.circular(logoSize));
final paddingSection = EdgeInsets.all(10);
final Color negativeMoneyColor = AppColors.red[100];
final Color positiveMoneyColor = AppColors.blue[100];

final List<double> stopsColorLoginScreen = [0.15, 1];
final List<Color> gradientColorLoginScreen = [
  Color(0xFFA1EF67),
  Color(0xFF009689)
];

class Layout {
  Layout._();

  static final double m1 = 5.0;
  static final double m2 = 7.0;
  static final double m4 = 11.0;
  static final double m5 = 15.0;
  static final double p1 = 5.0;
  static final double p2 = 7.0;
  static final EdgeInsets mr1 = EdgeInsets.only(right: m1);
  static final EdgeInsets mr2 = EdgeInsets.only(right: m2);
  static final EdgeInsets mb2 = EdgeInsets.only(bottom: m2);
  static final EdgeInsets mt1 = EdgeInsets.only(top: m1);
  static final EdgeInsets mb4 = EdgeInsets.only(bottom: m4);
  static final EdgeInsets mb5 = EdgeInsets.only(bottom: m5);
  static final EdgeInsets pt1 = EdgeInsets.only(top: p1);
  static final EdgeInsets pt2 = EdgeInsets.only(top: p2);
}

class AppColors {
  AppColors._(); // this basically makes it so you can instantiate this class

  static const Map<int, Color> green = const <int, Color>{
    50: const Color(0xFFf2f8ef),
    100: const Color(0xFFdfedd8),
    200: const Color(0xFFc9e2be),
    300: const Color(0xFFb3d6a4),
    400: const Color(0xFFa3cd91),
    500: const Color(0xFF93c47d),
    600: const Color(0xFF8bbe75),
    700: const Color(0xFF80b66a),
    800: const Color(0xFF76af60),
    900: const Color(0xFF64a24d)
  };

  static const Map<int, Color> gray = const <int, Color>{
    20: const Color(0xFFFAFAFA),
    50: const Color(0xFFBDBDBD),
    100: const Color(0xFF6E6E6E)
  };

  static const Map<int, Color> red = const <int, Color>{
    50: const Color(0xFFFA5858),
    100: const Color(0xFFFE2E2E)
  };
  static const Map<int, Color> blue = const <int, Color>{
    50: const Color(0xFF2E64FE),
    100: const Color(0xFF0040FF),
    200: const Color(0xFF013ADF)
  };
}
