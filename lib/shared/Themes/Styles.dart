import 'dart:ui';

import 'package:flutter/material.dart';

import 'Colors.dart';

class Styles {

  static ThemeData getTheme(bool isDark) {
    return isDark ? DarkThemeStyle : LightThemeStyle;
  }

  // static ThemeData themeData(bool isDarkTheme, BuildContext context) {
  //   return ThemeData(
  //     scaffoldBackgroundColor:isDarkTheme?Color(0xFF0B0B0C):Color(0xFFF5F5F5),
  //     primaryColor: isDarkTheme ? Color(0xFF141313) : Color(0xFF77109B),
  //
  //     indicatorColor: isDarkTheme ? Color(0xff0E1D36) : Color(0xffCBDCF8),
  //
  //     hintColor: isDarkTheme ? Color(0xff280C0B) : Color(0xffEECED3),
  //
  //     highlightColor: isDarkTheme ? Color(0xff372901) : Color(0xffFCE192),
  //     hoverColor: isDarkTheme ? Color(0xff3A3A3B) : Color(0xff4285F4),
  //
  //
  //     focusColor: isDarkTheme ? Color(0xff0B2512) : Color(0xffA8DAB5),
  //     disabledColor: Colors.grey,
  //     cardColor: isDarkTheme ? Color(0xFF181819) : Colors.white,
  //     canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
  //     brightness: isDarkTheme ? Brightness.dark : Brightness.light,
  //     dividerColor: isDarkTheme ? Colors.black : Colors.grey[100],
  //     dividerTheme: DividerThemeData(
  //       color: isDarkTheme ? Color(0xFF0B0B0C) : Colors.grey[100],
  //       thickness: 1
  //     ),
  //     textTheme: TextTheme(
  //       headline1: TextStyle(
  //         color:isDarkTheme ? Colors.white : Colors.black54,
  //         fontSize: 14,
  //         fontFamily: 'Vazirmatn',
  //       ),
  //       titleMedium: TextStyle(
  //         color:isDarkTheme ? Colors.white : Colors.black,
  //         fontSize: 15,
  //         fontFamily: 'Vazirmatn',
  //       ),
  //       headline3: TextStyle(
  //         color:isDarkTheme ? Colors.white : Colors.black45,
  //         fontSize: 16,
  //         fontFamily: 'Vazirmatn',
  //       ),
  //       headline4: TextStyle(
  //       ),
  //       headline5: TextStyle(),
  //       headline6: TextStyle(
  //           color:isDarkTheme ? Colors.white : Colors.black54,
  //           fontSize: 12.5,
  //           fontFamily: 'Vazirmatn',
  //       ),
  //       bodyMedium: TextStyle(
  //         color:isDarkTheme ? Colors.white : Colors.black,
  //         fontSize: 14,
  //         fontFamily: 'Vazirmatn',
  //       ),
  //       bodySmall: TextStyle(
  //         color:isDarkTheme ? Colors.white70 : Colors.black54,
  //         fontSize: 12.5,
  //
  //       ),
  //       caption: TextStyle(
  //         color:isDarkTheme ? Colors.white : Colors.black45,
  //         fontSize: 14,
  //         fontFamily: 'Vazirmatn',
  //         decoration: TextDecoration.lineThrough
  //       ),
  //       subtitle1:TextStyle(
  //       color:isDarkTheme ? Colors.white : Colors.black,
  //       fontSize: 16,
  //       fontFamily: 'Vazirmatn',
  //     ),
  //       bodyMedium: TextStyle(
  //         color:isDarkTheme ? Colors.white70 : Colors.black54,
  //         fontSize: 14,
  //
  //     ),
  //     ),
  //     buttonTheme: Theme
  //         .of(context)
  //         .buttonTheme
  //         .copyWith(
  //         colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light()),
  //     appBarTheme: AppBarTheme(
  //       elevation: 0.0,));
  // }
  static var LightThemeStyle = ThemeData(
      useMaterial3: true,
      //0xffffdc73
      scaffoldBackgroundColor:Color(0xFFF0F0F0),
      primaryColor:  Color(0xFF77109B),
      cardTheme: CardTheme(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          )
      ),
      dividerColor: Colors.black38,
      appBarTheme: AppBarTheme(
        elevation: 2,
        backgroundColor: Colors.white,
      ),
      iconTheme: IconThemeData(color: Colors.black),

      indicatorColor: Color(0xFF77109B),
      textTheme: TextTheme(
        titleSmall: TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          fontFamily: 'Vazirmatn',
        ),
        titleMedium: TextStyle(
            fontSize: 15,
            color: Colors.black,
          fontFamily: 'Vazirmatn',
        ),
        titleLarge: TextStyle(
            fontSize: 17,
            color: Colors.black,
          fontFamily: 'Vazirmatn',
        ),
        bodySmall: TextStyle(
            fontSize: 13,
          color: Colors.black87,
          fontFamily: 'Vazirmatn',
        ),
        bodyMedium: TextStyle(
            fontSize: 14,
            color: Colors.black87,
          fontFamily: 'Vazirmatn',
        ),
        bodyLarge: TextStyle(
            fontSize: 16,
            color: Colors.black,
          fontFamily: 'Vazirmatn',
        ),
        labelSmall: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          fontFamily: 'Vazirmatn',
        ),
        labelMedium: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          fontFamily: 'Vazirmatn',
        ),
        labelLarge: TextStyle(
            fontSize: 20,
            color: Colors.black,
          fontFamily: 'Vazirmatn',
        ),

      ), colorScheme: ColorScheme.light(
      brightness: Brightness.light,
      primary: Colors.black,
      onPrimary: Color(0xffffdc73),
      secondary: Colors.orange,
      onSecondary: Colors.pink,
      error: Color(0xffDCDBDB),
      onError: Colors.red,
      background: Colors.white,
      onBackground: Colors.black45,

      surface: Colors.white,
      onSurface: Color(0xffF6F6F6)).copyWith(background: Colors.white)
  );
  static var DarkThemeStyle = ThemeData(
      useMaterial3: true,
      //Color(0xffF7C623),

      primaryColor: Color(0xFF77109B),
      appBarTheme: AppBarTheme(
        elevation: 2,
        backgroundColor:  Color(0xFF181819),
      ),
      dividerColor: Colors.grey,
      cardTheme: CardTheme(
          color: Color(0xFF181819),
          shape : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          )
      ),
      iconTheme: IconThemeData(color: Colors.white),
      scaffoldBackgroundColor:Color(0xFF0B0B0C),
      indicatorColor: Color(0xff0E1D36),
      hintColor: Color(0xff280C0B),
      highlightColor: Color(0xff372901) ,
      hoverColor: Color(0xff3A3A3B),

      textTheme: TextTheme(
        titleSmall: TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.w500
        ),
        titleMedium: TextStyle(
            fontSize: 17,
            color: Colors.white
        ),
        titleLarge: TextStyle(
            fontSize: 18,
            color: Colors.white
        ),
        bodySmall: TextStyle(
            fontSize: 13,
            color: Colors.white
        ),
        bodyMedium: TextStyle(
            fontSize: 15,
            color: Colors.white
        ),
        bodyLarge: TextStyle(
            fontSize: 18,
            color: Colors.white
        ),
        labelSmall: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.white
        ),
        labelMedium: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.white
        ),
        labelLarge: TextStyle(
            fontSize: 20,
            color: Colors.white
        ),

      ), colorScheme: ColorScheme.dark(
    brightness: Brightness.light,
    primary: Colors.black,
    onPrimary: Color(0xffffdc73),
    secondary: Colors.orange,
    onSecondary: Colors.pink,
    error: Colors.white10,
    onError: Colors.red,
    background:Color(0xFF181819),
    onBackground: Colors.black45,
    surface: Colors.black,
    onSurface: Color(0xFF181819),
  ).copyWith(background: Color(0xFF181819))
  );
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return isDarkTheme ? DarkThemeStyle : LightThemeStyle;
  }

}

extension CustomTextStyles on TextTheme {

  TextStyle get h1 {
    return TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get d1 {
    return TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Brightness.dark == null ? Colors.blue:Colors.white,
    );
  }
  TextStyle get d2 {
    return TextStyle(fontSize: 16.0);
  }
}