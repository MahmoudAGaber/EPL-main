


import 'dart:io';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Helper {


  static dynamic numberFormat(dynamic number) {
    return NumberFormat('#,##0', 'en_US').format(number);
  }

  static dynamic parseFormattedNumber(String formattedString) {
    String unformatted = formattedString.replaceAll(RegExp(r'[^\d.-]'), '');
    return num.tryParse(unformatted);
  }

  static void rateApp() async {
    const String androidUrl = 'https://play.google.com/store/apps/details?id=com.taahd.quran';
    const String iosUrl = 'https://apps.apple.com/app/6475663280';

    final Uri url = Uri.parse(Platform.isAndroid ? androidUrl : iosUrl);

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }

  }

  static launchEmail() async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'g5661133@gmail.com',
      queryParameters: {'subject': 'Contact Us'},
    );

    if (await canLaunchUrl(Uri.parse(_emailLaunchUri.toString()))) {
      await launchUrl(Uri.parse(_emailLaunchUri.toString()));
    } else {
      throw 'Could not launch email';
    }
  }

  static launchWhatsApp() async {
    const phoneNumber = '+971585060631';
    final whatsappUrl = Uri(
      scheme: 'https',
      host: 'wa.me',
      path: phoneNumber,
      queryParameters: {'text': 'السلام عليكم.'},
    );

    if (await canLaunchUrl(Uri.parse(whatsappUrl.toString()))) {
      await launchUrl(Uri.parse(whatsappUrl.toString()));
    } else {
      throw 'Could not launch WhatsApp';
    }
  }
}
