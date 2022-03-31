import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../export_feature.dart';

class Counter with ChangeNotifier, DiagnosticableTreeMixin {
  int? count = CacheHelper.getData(key: 'counter') ?? 0;
  static Counter watch(context) => Provider.of(context,); ///watch-function ///get variables
  static Counter read(context)  => Provider.of(context,listen: false); ///read-function ///Implement functions
  void increment() {
    count = count! + 1;
    CacheHelper.saveData(key: 'counter', value: count).then((value) {
      debugPrint('Is cached :');
    });
    notifyListeners();
  }

  void decrement() {
    count = count! - 1;
    CacheHelper.saveData(key: 'counter', value: count).then((value) {
      debugPrint('Is cached :');
    });
    notifyListeners();
  }

  bool get isDark => _isDark;

  bool _isDark = CacheHelper.getData(key: 'isDark') ?? false;

  IconData? modeIcon = CacheHelper.getData(key: 'isDark') == true
      ? Icons.wb_sunny
      : Icons.brightness_3_outlined;

  void changeAppMode() {
    _isDark = !_isDark;
    modeIcon = _isDark ? Icons.wb_sunny : Icons.brightness_3_outlined;
     CacheHelper.saveData(key: 'isDark', value: _isDark).then((value) {
      debugPrint(value.toString());
      debugPrint('Is cached');
      debugPrint(_isDark.toString());
    });
    notifyListeners();

  }
}
