
import 'package:flutter/material.dart';

class Styles {

  static ThemeData getTheme(bool isDark) {
    return isDark ? DarkThemeStyle : LightThemeStyle;
  }

  static var LightThemeStyle = ThemeData(
      useMaterial3: true,
    //0xffffdc73
      scaffoldBackgroundColor:Color(0xFFF0F0F0),
      primaryColor: Color(0xffffdc73),
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

      primaryColor: Color(0xffffdc73),
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