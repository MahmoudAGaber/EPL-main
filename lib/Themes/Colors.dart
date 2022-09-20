
import 'package:arseli/Provider/ThemeProvider.dart';
import 'package:arseli/webView.dart';
import 'package:flutter/material.dart';

class CustomTextStyle extends TextTheme{
 bool isDark;
 CustomTextStyle({this.isDark});

 DarkThemeProvider darkThemeProvider = DarkThemeProvider();



   static TextStyle h1 (isDark) {
    return TextStyle(
         fontSize: 13,
         color:isDark?Colors.white:Colors.black54,
         fontWeight: FontWeight.w500,
         fontFamily: 'Vazirmatn',
        );
   }
   static TextStyle h2 = TextStyle(
    fontSize: 13.5,
    color: Colors.green,
    fontWeight: FontWeight.w500,
  );
   TextStyle h3 = TextStyle(
    fontSize: 14,
    color: Colors.green,
    fontWeight: FontWeight.w500,
  );
   TextStyle h4 = TextStyle(
    fontSize: 15,
    color: Colors.green,
    fontWeight: FontWeight.w500,
  );
   TextStyle h5 = TextStyle(
    fontSize: 16,
    color: Colors.green,
    fontWeight: FontWeight.w500,
  );
   TextStyle h6 = TextStyle(
    fontSize: 17,
    color: Colors.green,
    fontWeight: FontWeight.w500,
  );
   TextStyle h7 = TextStyle(
    fontSize: 18,
    color: Colors.green,
    fontWeight: FontWeight.w500,
  );
   TextStyle h8 = TextStyle(
    fontSize: 20,
    color: Colors.green,
    fontWeight: FontWeight.w500,
  );
}