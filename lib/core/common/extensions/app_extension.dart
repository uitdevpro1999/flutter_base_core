import 'package:flutter/cupertino.dart';

extension Stringx on String? {
  bool isNullOrEmpty() {
    if (this != null && this!.isNotEmpty) {
      return false;
    }
    return true;
  }
}

extension doublex on double {
  SizedBox get wB => SizedBox(
        width: this,
      );
  SizedBox get hB => SizedBox(
        height: this,
      );
  BorderRadius get borderRadius =>
      BorderRadius.all(Radius.circular(toDouble()));
  BorderRadius get topBorderRadius =>
      BorderRadius.vertical(top: Radius.circular(toDouble()));
  BorderRadius get bottomBorderRadius =>
      BorderRadius.vertical(bottom: Radius.circular(toDouble()));
  BorderRadius get leftBorderRadius =>
      BorderRadius.horizontal(left: Radius.circular(toDouble()));
  BorderRadius get rightBorderRadius =>
      BorderRadius.horizontal(right: Radius.circular(toDouble()));
  EdgeInsets get allInset => EdgeInsets.all(toDouble());
  EdgeInsets get leftInset => EdgeInsets.only(left: toDouble());
  EdgeInsets get rightInset => EdgeInsets.only(right: toDouble());
  EdgeInsets get topInset => EdgeInsets.only(top: toDouble());
  EdgeInsets get bottomInset => EdgeInsets.only(bottom: toDouble());
  EdgeInsets get horizontalInset =>
      EdgeInsets.symmetric(horizontal: toDouble());
  EdgeInsets get verticalInset => EdgeInsets.symmetric(vertical: toDouble());
}

extension intx on int {
  SizedBox get wB => SizedBox(
        width: toDouble(),
      );
  SizedBox get hB => SizedBox(
        height: toDouble(),
      );
  BorderRadius get borderRadius =>
      BorderRadius.all(Radius.circular(toDouble()));
  BorderRadius get topBorderRadius =>
      BorderRadius.vertical(top: Radius.circular(toDouble()));
  BorderRadius get bottomBorderRadius =>
      BorderRadius.vertical(bottom: Radius.circular(toDouble()));
  BorderRadius get leftBorderRadius =>
      BorderRadius.horizontal(left: Radius.circular(toDouble()));
  BorderRadius get rightBorderRadius =>
      BorderRadius.horizontal(right: Radius.circular(toDouble()));
  EdgeInsets get allInset => EdgeInsets.all(toDouble());
  EdgeInsets get leftInset => EdgeInsets.only(left: toDouble());
  EdgeInsets get rightInset => EdgeInsets.only(right: toDouble());
  EdgeInsets get topInset => EdgeInsets.only(top: toDouble());
  EdgeInsets get bottomInset => EdgeInsets.only(bottom: toDouble());
  EdgeInsets get horizontalInset =>
      EdgeInsets.symmetric(horizontal: toDouble());
  EdgeInsets get verticalInset => EdgeInsets.symmetric(vertical: toDouble());
}

extension Datex on DateTime {
  DateTime copyWith({int? hour, int? minute}) {
    return DateTime(
      year,
      month,
      day,
      hour ?? this.hour,
      minute ?? this.minute,
    );
  }
}
