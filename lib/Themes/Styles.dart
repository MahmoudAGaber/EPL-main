import 'dart:ui';

import 'package:dynamic_theme/theme_switcher_widgets.dart';
import 'package:flutter/material.dart';

import 'Colors.dart';

class Styles {

  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor:isDarkTheme?Color(0xFF0B0B0C):Color(0xFFF5F5F5),
      primarySwatch: Colors.grey,
      primaryColor: isDarkTheme ? Color(0xFF141313) : Color(0xFF77109B),

      backgroundColor: isDarkTheme ? Color(0xFF181819): Color(0xFF862aa6),

      indicatorColor: isDarkTheme ? Color(0xff0E1D36) : Color(0xffCBDCF8),
      buttonColor: isDarkTheme ? Color(0xFF181819) : Colors.white,

      hintColor: isDarkTheme ? Color(0xff280C0B) : Color(0xffEECED3),

      highlightColor: isDarkTheme ? Color(0xff372901) : Color(0xffFCE192),
      hoverColor: isDarkTheme ? Color(0xff3A3A3B) : Color(0xff4285F4),


      focusColor: isDarkTheme ? Color(0xff0B2512) : Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      cardColor: isDarkTheme ? Color(0xFF181819) : Colors.white,
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      dividerColor: isDarkTheme ? Colors.black : Colors.grey[100],
      colorScheme: ColorScheme(
          primary: Colors.grey,
          secondary: isDarkTheme?Colors.white:Colors.black,
          primaryVariant: Colors.grey,
          secondaryVariant: Colors.grey,
          surface: isDarkTheme ? Color(0xFF111111) : Colors.grey[200],
          background: isDarkTheme?Colors.grey[400] : Colors.grey[300],
          error: Colors.red,
          onPrimary: isDarkTheme ?Color(0xFF292525): Colors.grey[100],
          onBackground: isDarkTheme?Color(0xFF141313) : Colors.grey[100],
          onError: Colors.grey,
          onSecondary: Colors.grey,
          onSurface: isDarkTheme?Color(0xFF303030) : Colors.grey[100],
          brightness: isDarkTheme?Brightness.dark:Brightness.light),
      dividerTheme: DividerThemeData(
        color: isDarkTheme ? Color(0xFF0B0B0C) : Colors.grey[100],
        thickness: 1
      ),
      textTheme: TextTheme(
        headline1: TextStyle(
          color:isDarkTheme ? Colors.white : Colors.black54,
          fontSize: 14,
          fontFamily: 'Vazirmatn',
        ),
        headline2: TextStyle(
          color:isDarkTheme ? Colors.white : Colors.black,
          fontSize: 15,
          fontFamily: 'Vazirmatn',
        ),
        headline3: TextStyle(
          color:isDarkTheme ? Colors.white : Colors.black45,
          fontSize: 16,
          fontFamily: 'Vazirmatn',
        ),
        headline4: TextStyle(
        ),
        headline5: TextStyle(),
        headline6: TextStyle(
            color:isDarkTheme ? Colors.white : Colors.black54,
            fontSize: 12.5,
            fontFamily: 'Vazirmatn',
        ),
        bodyText1: TextStyle(
          color:isDarkTheme ? Colors.white : Colors.black,
          fontSize: 14,
          fontFamily: 'Vazirmatn',
        ),
        bodyText2: TextStyle(
          color:isDarkTheme ? Colors.white70 : Colors.black54,
          fontSize: 12.5,

        ),
        caption: TextStyle(
          color:isDarkTheme ? Colors.white : Colors.black45,
          fontSize: 14,
          fontFamily: 'Vazirmatn',
          decoration: TextDecoration.lineThrough
        ),
        subtitle1:TextStyle(
        color:isDarkTheme ? Colors.white : Colors.black,
        fontSize: 16,
        fontFamily: 'Vazirmatn',
      ),
        subtitle2: TextStyle(
          color:isDarkTheme ? Colors.white70 : Colors.black54,
          fontSize: 14,

      ),
      ),
      buttonTheme: Theme
          .of(context)
          .buttonTheme
          .copyWith(
          colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light()),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
      ), textSelectionTheme: TextSelectionThemeData(selectionColor: isDarkTheme ? Colors.white : Colors.black),
    );
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