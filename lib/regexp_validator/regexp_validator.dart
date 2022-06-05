import 'package:flutter/services.dart';

class RegExpValidator {

  ///Clear leading whitespace
  static FilteringTextInputFormatter beginWhitespace = FilteringTextInputFormatter.deny(RegExp(r'^[\s]+'));
  ///Clear trailing whitespace:
  static FilteringTextInputFormatter endWhitespace = FilteringTextInputFormatter.deny(RegExp(r'[\s]+$'));
  ///Clear all whitespace:
  static FilteringTextInputFormatter clearWhitespace = FilteringTextInputFormatter.deny(RegExp('\\s+'));
  ///Insert English language only
  static FilteringTextInputFormatter insertEnglish =FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9\u0020-\u007E-\u0024-\u00A9]'));
  ///

  static bool isValidEmail({required String? email}) {
    String? emailRex = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    return RegExp(emailRex).hasMatch(email!);
  }

  static bool isValidPhone({required String? phone}) {
    String? phoneRex = '^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}\$';
    return RegExp(phoneRex).hasMatch(phone!);
  }

  static bool passwordStrength({required String? password}) {
    String? phoneRex ='(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[^A-Za-z0-9])(?=.{8,})';
    return RegExp(phoneRex).hasMatch(password!);
  }
}
