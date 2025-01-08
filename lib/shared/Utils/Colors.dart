
import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xffffdc73);
  static const Color secondColor = Color(0xFFBCBCBC);
  static const Color secondgreyColor = Color(0xFFF6F6F6);
  static const Color textBlack = Color(0xff404254);
  static const Color subTextBlack = Color(0xff9da4bc);
  static const Color textColor1 =Color(0xFF717171);
  static const Color textColor2 =Color(0xFF6D6D6D);
  static const Color quranBackground =Color(0xFFF9F7F8);
  static const Color borderColor =Color(0xffDCDBDB);
  static const Color line = Color(0xff6B7580);
  static const Color settingsText =Color(0xFF6D6D6D);
  static const Color settingsContainer =Color(0xffE9E9E9);

  static var textBody = TextStyle(
    fontSize: 16,
    color: Colors.black
  );
  static var textButton = TextStyle(
      fontSize: 17,
      color: Colors.black
  );

  static var LightThemeStyle = ThemeData(
    primaryColor: Color(0xffffdc73),
    colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: Colors.grey,
        onPrimary: Colors.blue,
        secondary: Colors.orange,
        onSecondary: Colors.pink,
        error: Colors.red,
        onError: Colors.red,
        background: Color(0xFFF0F0F0),
        onBackground: Colors.black45,
        surface: Color(0xFFFFFFFF),
        onSurface: Colors.black),
    textTheme: TextTheme(
      titleSmall: TextStyle(
          fontSize: 15,
          color: Colors.black,
        fontWeight: FontWeight.w500
      ),
      titleMedium: TextStyle(
          fontSize: 17,
          color: Colors.black
      ),
      titleLarge: TextStyle(
          fontSize: 18,
          color: Colors.black
      ),
      bodySmall: TextStyle(
          fontSize: 13,
          color: Colors.black
      ),
      bodyMedium: TextStyle(
          fontSize: 15,
          color: Colors.black
      ),
      bodyLarge: TextStyle(
          fontSize: 18,
          color: Colors.black
      ),
      labelSmall: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Colors.black
      ),
        labelMedium: TextStyle(
        fontSize: 15,
            fontWeight: FontWeight.w500,
        color: Colors.black
    ),
      labelLarge: TextStyle(
          fontSize: 20,
          color: Colors.black
      ),

    )
  );

  static var DarkThemeStyle = ThemeData(
      primaryColor: Color(0xffffdc73),
      colorScheme: ColorScheme.dark(
          brightness: Brightness.light,
          primary: Colors.grey,
          onPrimary: Colors.blue,
          secondary: Colors.orange,
          onSecondary: Colors.pink,
          error: Colors.red,
          onError: Colors.red,
          background: Color(0xFFF0F0F0),
          onBackground: Colors.black45,
          surface: Color(0xFFFFFFFF),
          onSurface: Colors.black),
      textTheme: TextTheme(
        titleSmall: TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.w500
        ),
        titleMedium: TextStyle(
            fontSize: 17,
            color: Colors.black
        ),
        titleLarge: TextStyle(
            fontSize: 18,
            color: Colors.black
        ),
        bodySmall: TextStyle(
            fontSize: 13,
            color: Colors.black
        ),
        bodyMedium: TextStyle(
            fontSize: 15,
            color: Colors.black
        ),
        bodyLarge: TextStyle(
            fontSize: 18,
            color: Colors.black
        ),
        labelSmall: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.black
        ),
        labelMedium: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black
        ),
        labelLarge: TextStyle(
            fontSize: 20,
            color: Colors.black
        ),

      )
  );

}