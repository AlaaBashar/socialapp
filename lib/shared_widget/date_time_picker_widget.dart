import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class DateTimePicker{
  ///----------------------------DATE----------------------------------------------
  static Future<String?> datePicker({context}) async {
    String? dateTime;
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.parse('1960-01-01'),
      lastDate: DateTime.parse('2040-05-03'),
    ).then((value) {
      if (value != null) {
        dateTime =dateFormat(date: value);
      }
    });

    return dateTime;
  }
  static String dateFormat({DateTime? date}){
    return DateFormat.yMMMd().format(date!);
  }
  ///----------------------------TIME----------------------------------------------
  static Future<String?> timePicker({BuildContext? context}) async {
    String? dateTime;
    await showTimePicker(
      context: context!,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value != null) {
        dateTime = timeOfDayFormat(time: value,context: context);
      }
    });
    return dateTime;
  }
  static String timeOfDayFormat({TimeOfDay? time,context}){
    final localizations = MaterialLocalizations.of(context);
    return localizations.formatTimeOfDay(time!);
  }



}


