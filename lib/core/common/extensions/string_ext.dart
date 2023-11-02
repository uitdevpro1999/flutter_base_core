import '../utils/utils.dart';

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(" ").map((str) => toCapitalized()).join(" ");

  String toFormatKtaNumber() =>
      (!contains(" ") && length >= 10) ? ("${substring(0, 3)} ${substring(3, 6)} ${substring(6)}") : this;

  String? getFlagFromCountryCode() => toUpperCase()
      .replaceAllMapped(RegExp(r'[A-Z]'), (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));

  String? toEmoji() => startsWith("U+") == true ? String.fromCharCode(int.parse("0x${replaceAll("U+", "")}")) : this;

  String toWalletAddressMinimal() {
    return "${substring(0, 5)}...${substring(length - 4)}";
  }

  String toPhoneNumberMinimal() {
    String characterHide = '';
    for (var i = 0; i < length - 6; i++) {
      characterHide += '*';
    }
    return "${substring(0, 3)}$characterHide${substring(length - 3)}";
  }

  String convertVNtoText() {
    String newText = this;
    newText = newText.replaceAll(RegExp(r'[à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ]'), 'a');
    newText = newText.replaceAll(RegExp(r'[è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ]'), 'e');
    newText = newText.replaceAll(RegExp(r'[ì|í|ị|ỉ|ĩ]'), 'i');
    newText = newText.replaceAll(RegExp(r'[ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ]'), 'o');
    newText = newText.replaceAll(RegExp(r'[ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ]'), 'u');
    newText = newText.replaceAll(RegExp(r'[ỳ|ý|ỵ|ỷ|ỹ]'), 'y');
    newText = newText.replaceAll(RegExp(r'[đ]'), 'd');

    newText = newText.replaceAll(RegExp(r'[À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ]'), 'A');
    newText = newText.replaceAll(RegExp(r'[È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ]'), 'E');
    newText = newText.replaceAll(RegExp(r'[Ì|Í|Ị|Ỉ|Ĩ]'), 'I');
    newText = newText.replaceAll(RegExp(r'[Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ]'), 'O');
    newText = newText.replaceAll(RegExp(r'[Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ]'), 'U');
    newText = newText.replaceAll(RegExp(r'[Ỳ|Ý|Ỵ|Ỷ|Ỹ]'), 'Y');
    newText = newText.replaceAll(RegExp(r'[Đ]'), 'D');
    return newText;
  }

  String? toFormatPhoneNumber() {
    if (Utils.isEmpty(this)) return null;
    return length >= 10 ? ("${substring(0, 3)} ${substring(3, 6)} ${substring(6)}") : this;
  }

  bool isPhoneNoValid() {
    if (isEmpty) return false;
    final regExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
    return regExp.hasMatch(this);
  }
}
