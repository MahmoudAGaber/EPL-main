import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Views/custom/custom_snackbar.dart';



class NetworkInfo {
  final Connectivity connectivity;
  NetworkInfo(this.connectivity);

  Future<bool> get isConnected async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  static void checkConnectivity(BuildContext context) {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {

      if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {

      } else {
        bool isNotConnected = result == ConnectivityResult.none;
        isNotConnected ? const SizedBox() : showCustomSnackBar(isNotConnected ? 'no_connection'.tr : 'connected'.tr,isError: isNotConnected);

      }
    });
  }
}
