import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowToastSnackBar {
  static Future<bool?> displayToast({
    required String? message,
    bool isError = false,
    bool isSuccess = false,
  }) {
    return Fluttertoast.showToast(
        msg: message!,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        textColor: Colors.white,
        backgroundColor: isError
            ? Colors.red[800]
            : isSuccess
            ? Colors.green[800]
            : null,
        fontSize: 14.0);

  }

  static void showSnackBars(BuildContext context,
      {String? message,
        bool isError = false,
        bool isSuccess = false,
        Duration? duration,
        SnackBarAction? snackBarAction}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message!,
      ),
      duration: duration ?? const Duration(seconds: 3),
      action: snackBarAction,
      backgroundColor: isError
          ? Colors.red[800]
          : isSuccess
          ? Colors.green[800]
          : null,
    ));
  }
}
