import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../Utils/dimensions.dart';

import '../../helper/responsive_helper.dart';

void showCustomSnackBar(String message, {bool isError = true, Duration? duration}) {
  ScaffoldMessenger.of(Get.context!).clearSnackBars();
  final width = MediaQuery.of(Get.context!).size.width;
  ScaffoldMessenger.of(Get.context!)..hideCurrentSnackBar()..showSnackBar(SnackBar(key: UniqueKey(), content: Text(message),
      margin: ResponsiveHelper.isDesktop(Get.context!) ?  EdgeInsets.only(
        right: width * 0.75, bottom: Dimensions.paddingSizeLarge, left: Dimensions.paddingSizeExtraSmall,
      ) : null,
      duration: duration ?? const Duration(milliseconds: 4000),
      behavior: ResponsiveHelper.isDesktop(Get.context!) ? SnackBarBehavior.floating : SnackBarBehavior.fixed ,
      dismissDirection: DismissDirection.down,
      backgroundColor: isError ? Colors.red : Colors.green,
      )
  );
}
