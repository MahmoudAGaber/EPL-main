

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DatePicker{

  static Future<void> selectDate (BuildContext context,TextEditingController dateText) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.green, // Change primary color
            colorScheme: ColorScheme.light(
                primary: Theme.of(context).primaryColor,
                surface: Colors.white,
                surfaceTint: Colors.white),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
        dateText.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  static int calculateMonthsBetween(String fromDate, String toDate) {
    DateTime startDate = DateFormat('yyyy-MM-dd').parse(fromDate);
    DateTime endDate = DateFormat('yyyy-MM-dd').parse(toDate);

    if (startDate.isAfter(endDate)) {
      throw ArgumentError('The start date must be before the end date.');
    }

    int months = (endDate.year - startDate.year) * 12 + endDate.month - startDate.month;

    // if (endDate.day < startDate.day) {
    //   months--;
    // }

    return months;
  }
}