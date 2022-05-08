import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../export_feature.dart';

class ChangeMode with ChangeNotifier, DiagnosticableTreeMixin {
  static ChangeMode watch(context) => Provider.of(context,); ///watch-function ///get variables
  static ChangeMode read(context)  => Provider.of(context,listen: false); ///read-function ///Implement functions
  bool get isDark => _isDark;
  bool _isDark = CacheHelper.getData(key: 'isDark') ?? false;
  IconData? modeIcon = CacheHelper.getData(key: 'isDark') == true ? Icons.wb_sunny : Icons.brightness_3_outlined;
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
