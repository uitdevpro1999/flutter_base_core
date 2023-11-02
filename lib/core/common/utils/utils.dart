import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: library_prefixes
import 'package:get_it/get_it.dart';
import 'package:mime/mime.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

T? castOrNull<T>(dynamic x) => x is T ? x : null;

T castOrFallback<T>(dynamic x, T fallback) => x is T ? x : fallback;

class Utils {
  static void showSnackBar(BuildContext context, String? text) {
    if (Utils.isEmpty(text)) return;
    final snackBar = SnackBar(
      content: Text(text ?? ""),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  static void showErrorSnackBar(BuildContext context, String? text) {
    onWidgetDidBuild(() => showSnackBar(context, text));
  }

  static String? getMimeType(String path) {
    return lookupMimeType(path);
  }

  static bool isEmpty(Object? text) {
    if (text is String) return text.isEmpty;
    if (text is List) return text.isEmpty;
    return text == null;
  }

  static bool isEmptyArray(List? list) {
    return list == null || list.isEmpty;
  }

  static bool isInteger(num value) =>
      value is int || value == value.roundToDouble();

  static Color parseStringToColor(String? color, {Color? defaultColor}) {
    if (Utils.isEmpty(color)) {
      return defaultColor ?? Colors.black;
    } else {
      return Color(int.parse('0xff${color!.trim().substring(1)}'));
    }
  }

  static void showDialogTwoButtonAfterLayout(
      {required BuildContext context,
      required String? title,
      required Widget contentWidget,
      required List<Widget> actions}) async {
    onWidgetDidBuild(() => showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
              title: title != null ? Text(title) : null,
              content: contentWidget,
              actions: actions);
        }));
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  // static Future updateBadge(int count) async {
  //   if (await FlutterAppBadger.isAppBadgeSupported()) {
  //     FlutterAppBadger.updateBadgeCount(count);
  //   }
  // }

  static navigateNextFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static String getFileNameFromFile(File file) {
    return basename(file.path);
  }

  static String getFileName(String path) {
    return basenameWithoutExtension(path);
  }

  static String? base64Image(File? file) {
    if (file == null) return null;
    List<int> imageBytes = file.readAsBytesSync();
    return base64Encode(imageBytes);
  }

  static Future<Map<String, dynamic>> parseJson(String fileName) async {
    return jsonDecode(await rootBundle.loadString("assets/$fileName"));
  }

  static String getPhoneNumber(String? phoneNumber, String countryCode) {
    String? phone = phoneNumber?.trim();
    if (phone?.startsWith("0") == true) {
      phone = phone?.substring(1, phone.length);
    }
    phone = "$countryCode$phone";
    phone = phone.replaceAll("+", "");
    return phone;
  }

  static String getAddress(
      {String? address,
      String? ward,
      String? district,
      String? province,
      String? city,
      String? country}) {
    String result = "";
    if (!Utils.isEmpty(address)) {
      result += address!;
    }
    if (!Utils.isEmpty(ward)) {
      if (!Utils.isEmpty(result)) result += ", ";
      result += ward!;
    }
    if (!Utils.isEmpty(district)) {
      if (!Utils.isEmpty(result)) result += ", ";
      result += district!;
    }
    if (!Utils.isEmpty(city)) {
      if (!Utils.isEmpty(result)) result += ", ";
      result += city!;
    }
    if (!Utils.isEmpty(province)) {
      if (!Utils.isEmpty(result)) result += ", ";
      result += province!;
    }
    if (!Utils.isEmpty(country)) {
      if (!Utils.isEmpty(result)) result += ", ";
      result += country!;
    }
    return result;
  }

  static String getTextBreakLine(List<String?> listText) {
    String result = "";
    for (var element in listText) {
      int index = listText.indexOf(element);
      if (index == 0) {
        result += listText[0] ?? "";
      } else {
        if (!Utils.isEmpty(listText[index])) {
          if (!Utils.isEmpty(result)) result += "\n";
          result += listText[index]!;
        }
      }
    }
    return result;
  }

  static double compareTwoStrings(String? first, String? second) {
    // if both are null
    if (first == null && second == null) {
      return 1;
    }
    // as both are not null if one of them is null then return 0
    if (first == null || second == null) {
      return 0;
    }

    first =
        first.replaceAll(RegExp(r'\s+\b|\b\s'), ''); // remove all whitespace
    second =
        second.replaceAll(RegExp(r'\s+\b|\b\s'), ''); // remove all whitespace

    // if both are empty strings
    if (first.isEmpty && second.isEmpty) {
      return 1;
    }
    // if only one is empty string
    if (first.isEmpty || second.isEmpty) {
      return 0;
    }
    // identical
    if (first == second) {
      return 1;
    }
    // both are 1-letter strings
    if (first.length == 1 && second.length == 1) {
      return 0;
    }
    // if either is a 1-letter string
    if (first.length < 2 || second.length < 2) {
      return 0;
    }

    final firstBigrams = <String, int>{};
    for (var i = 0; i < first.length - 1; i++) {
      final bigram = first.substring(i, i + 2);
      final count =
          firstBigrams.containsKey(bigram) ? firstBigrams[bigram]! + 1 : 1;
      firstBigrams[bigram] = count;
    }

    var intersectionSize = 0;
    for (var i = 0; i < second.length - 1; i++) {
      final bigram = second.substring(i, i + 2);
      final count =
          firstBigrams.containsKey(bigram) ? firstBigrams[bigram]! : 0;

      if (count > 0) {
        firstBigrams[bigram] = count - 1;
        intersectionSize++;
      }
    }

    return (2.0 * intersectionSize) / (first.length + second.length - 2);
  }

  static String convertVNtoText(String str) {
    str = str.replaceAll(RegExp(r'[à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ]'), 'a');

    str = str.replaceAll(RegExp(r'[è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ]'), 'e');
    str = str.replaceAll(RegExp(r'[ì|í|ị|ỉ|ĩ]'), 'i');
    str = str.replaceAll(RegExp(r'[ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ]'), 'o');
    str = str.replaceAll(RegExp(r'[ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ]'), 'u');
    str = str.replaceAll(RegExp(r'[ỳ|ý|ỵ|ỷ|ỹ]'), 'y');
    str = str.replaceAll(RegExp(r'[đ]'), 'd');

    str = str.replaceAll(RegExp(r'[À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ]'), 'A');
    str = str.replaceAll(RegExp(r'[È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ]'), 'E');
    str = str.replaceAll(RegExp(r'[Ì|Í|Ị|Ỉ|Ĩ]'), 'I');
    str = str.replaceAll(RegExp(r'[Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ]'), 'O');
    str = str.replaceAll(RegExp(r'[Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ]'), 'U');
    str = str.replaceAll(RegExp(r'[Ỳ|Ý|Ỵ|Ỷ|Ỹ]'), 'Y');
    str = str.replaceAll(RegExp(r'[Đ]'), 'D');
    return str;
  }

  static String getRandString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  static String formatNikText(String text) {
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(
            ' '); // Replace this with anything you want to put after each 4 numbers
      }
    }

    var string = buffer.toString();
    return string;
  }

  static String getPhoneNumberNonPrefix(
      String phoneNumber, String countryCode) {
    if (countryCode.startsWith("+")) {
      countryCode = countryCode.substring(1);
    }
    return phoneNumber.substring(countryCode.length);
  }

  static String getCountryCode(
      String phoneNumber, List<String> listNationalityCode) {
    if (phoneNumber.startsWith("+")) {
      phoneNumber = phoneNumber.substring(1);
    }
    String threeFirstChars = "";
    String twoFirstChars = "";
    String oneFirstChars = "";
    if (phoneNumber.length > 3) {
      threeFirstChars = phoneNumber.substring(0, 3);
      twoFirstChars = phoneNumber.substring(0, 2);
      oneFirstChars = phoneNumber.substring(0, 1);
    } else if (phoneNumber.length > 2) {
      twoFirstChars = phoneNumber.substring(0, 2);
      oneFirstChars = phoneNumber.substring(0, 1);
    } else if (phoneNumber.length > 1) {
      oneFirstChars = phoneNumber.substring(0, 1);
    }
    String code = "";
    if (!Utils.isEmpty(threeFirstChars)) {
      try {
        code = listNationalityCode.firstWhere(
            (element) => element.substring(1).startsWith(threeFirstChars));
        // ignore: empty_catches
      } catch (e) {}
      if (!Utils.isEmpty(code)) {
        return code;
      }
    }
    if (!Utils.isEmpty(twoFirstChars)) {
      try {
        code = listNationalityCode.firstWhere(
            (element) => element.substring(1).startsWith(twoFirstChars));
        // ignore: empty_catches
      } catch (e) {}
      if (!Utils.isEmpty(code)) {
        return code;
      }
    }
    if (!Utils.isEmpty(oneFirstChars)) {
      try {
        code = listNationalityCode.firstWhere(
            (element) => element.substring(1).startsWith(oneFirstChars));
        // ignore: empty_catches
      } catch (e) {}
      if (!Utils.isEmpty(code)) {
        return code;
      }
    }
    return code;
  }

  static String formatedTimeCountDown(
      {required int timeInSecond, bool coutHour = false}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor() % 60;
    int hour = (timeInSecond / 60 / 60).floor();
    String hours = hour.toString().length <= 1 ? "0$hour" : "$hour";
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return coutHour ? "$hours:$minute:$second" : "$minute:$second";
  }

  static Size preSize(
    String text,
    TextStyle style, {
    double maxWidth = double.infinity,
  }) {
    var textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: ui.TextDirection.ltr,
      textScaleFactor: WidgetsBinding.instance.window.textScaleFactor,
    )..layout(
        maxWidth: maxWidth,
      );
    return textPainter.size;
  }
}
