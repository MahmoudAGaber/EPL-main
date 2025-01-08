

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';



final localeProvider = StateNotifierProvider<LocaleNotifier, Locale?>((ref) {
  return LocaleNotifier();
});

class LocaleNotifier extends StateNotifier<Locale?> {
  LocaleNotifier() : super(null) {
    _initializeLocale();
  }

  Future<void> _initializeLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? langCode = prefs.getString('lang');
    if (langCode != null) {
      Locale locale = langCode.toLocale(separator: '|');
      state = locale;
    } else {
      var deviceLocale = WidgetsBinding.instance.window.locale;
      if(Lang.supportLocal.contains(deviceLocale)){
        state =  deviceLocale;
      }else{
        state =  Locale("ar", "AR");
      }
      prefs.setString('lang', state!.toStringWithSeparator(separator: '|'));

    }
  }

  Future<Locale?> setDeviceLocale(BuildContext context) async {
    state = context.deviceLocale;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('lang', state!.toStringWithSeparator(separator: '|'));
    return state;
  }

  Future<void> setLocale(Locale locale) async {
    state = locale;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('lang', locale.toStringWithSeparator(separator: '|'));
  }


}


class Lang {
  String key;
  String name;

  Lang(this.key, this.name);

  static List<Lang> getLangdata() {
    return <Lang>[
      Lang("ar", "عربي"),
      Lang("en", "English"),
    ];
  }

  static List<Locale> supportLocal = [
    Locale("ar", "AR"), // Arabic (UAE)
    Locale("en", "US"), // English (United States)
    Locale("fr", "FR"), // French (France)
    Locale("de", "DE"), // German (Germany)
    Locale("ru", "RU"), // Russian (Russia)
    Locale("es", "ES"), // Spanish (Spain)
    Locale("it", "IT"), // Italian (Italy)
    Locale("tr", "TR"), // Turkish (Turkey)
    Locale("ur", "PK"), // Urdu (Pakistan)
    Locale("zh", "CN"), // Chinese (China)
    Locale("am", "ET"), // Amharic (Ethiopia)
    Locale("az", "AZ"), // Azerbaijani (Azerbaijan)
    Locale("be", "BY"), // Belarusian (Belarus)
    Locale("bg", "BG"), // Bulgarian (Bulgaria)
    Locale("bn", "BD"), // Bengali (Bangladesh)
    Locale("cs", "CZ"), // Czech (Czech Republic)
    Locale("da", "DK"), // Danish (Denmark)
    Locale("el", "GR"), // Greek (Greece)
    Locale("es", "MX"), // Spanish (Mexico)
    Locale("et", "EE"), // Estonian (Estonia)
    Locale("fa", "IR"), // Persian (Iran)
    Locale("fi", "FI"), // Finnish (Finland)
    Locale("he", "IL"), // Hebrew (Israel)
    Locale("hi", "IN"), // Hindi (India)
    Locale("hr", "HR"), // Croatian (Croatia)
    Locale("hu", "HU"), // Hungarian (Hungary)
    Locale("id", "ID"), // Indonesian (Indonesia)
    Locale("is", "IS"), // Icelandic (Iceland)
    Locale("ja", "JP"), // Japanese (Japan)
    Locale("ka", "GE"), // Georgian (Georgia)
    Locale("kk", "KZ"), // Kazakh (Kazakhstan)
    Locale("km", "KH"), // Khmer (Cambodia)
    Locale("ko", "KR"), // Korean (South Korea)
    Locale("lt", "LT"), // Lithuanian (Lithuania)
    Locale("lv", "LV"), // Latvian (Latvia)
    Locale("mk", "MK"), // Macedonian (North Macedonia)
    Locale("ml", "IN"), // Malayalam (India)
    Locale("mn", "MN"), // Mongolian (Mongolia)
    Locale("ms", "MY"), // Malay (Malaysia)
    Locale("nb", "NO"), // Norwegian Bokmål (Norway)
    Locale("nl", "NL"), // Dutch (Netherlands)
    Locale("no", "NO"), // Norwegian (Norway)
    Locale("pl", "PL"), // Polish (Poland)
    Locale("pt", "PT"), // Portuguese (Portugal)
    Locale("ro", "RO"), // Romanian (Romania)
    Locale("si", "LK"), // Sinhala (Sri Lanka)
    Locale("sk", "SK"), // Slovak (Slovakia)
    Locale("sl", "SI"), // Slovenian (Slovenia)
    Locale("sq", "AL"), // Albanian (Albania)
    Locale("sr", "RS"), // Serbian (Serbia)
    Locale("sv", "SE"), // Swedish (Sweden)
    Locale("ta", "IN"), // Tamil (India)
    Locale("te", "IN"), // Telugu (India)
    Locale("th", "TH"), // Thai (Thailand)
    Locale("uk", "UA"), // Ukrainian (Ukraine)
    Locale("vi", "VN"), // Vietnamese (Vietnam)
    Locale("zh", "TW"), // Chinese (Taiwan)
    Locale("af", "ZA"), // Afrikaans (South Africa)
  ];
}