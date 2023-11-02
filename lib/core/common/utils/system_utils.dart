import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemUtils {
  static setStatusBarLight() {
    Future.delayed(const Duration(milliseconds: 100), () {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.light.copyWith(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.white, // Color for Android
          statusBarBrightness: Brightness.light, // Dark == white status bar -- for IOS.
        ),
      );
    });
  }

  static setStatusBarDark() {
    Future.delayed(const Duration(milliseconds: 100), () {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.light.copyWith(
          statusBarIconBrightness: Brightness.light,
          statusBarColor:Colors.black, // Color for Android
          statusBarBrightness: Brightness.dark, // Dark == white status bar -- for IOS.
        ),
      );
    });
  }
}
