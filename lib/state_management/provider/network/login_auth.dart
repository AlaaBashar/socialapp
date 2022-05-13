import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../export_feature.dart';

class LoginProvider with ChangeNotifier, DiagnosticableTreeMixin {
  static LoginProvider watch(context) => Provider.of(context,); ///watch-function ///get variables
  static LoginProvider read(context)  => Provider.of(context,listen: false); ///read-function ///Implement functions

  void onLoginPro(
      {required String email,
      required String password,
      required context}) async {
    ProgressCircleDialog.show(context);
    UserModel? userApp = await Auth.loginByEmailAndPass(
      email: email,
      password: password,
    ).catchError((onError) {
      showSnackBar(context, onError.toString());
      ProgressCircleDialog.dismiss(context);
    });

    ProgressCircleDialog.dismiss(context);

    if (userApp == null) return;

    if (userApp.isBlocked!) {
      showSnackBar(context, 'Please contact technical support to activate your account');
      await Auth.logout();
      openNewPage(context, const LoginScreen(), popPreviousPages: true);
      return;
    }
    await Auth.updateUserInPref(userApp);
    openNewPage(context, const HomeScreen(), popPreviousPages: true);
    notifyListeners();
  }

  bool? isVisible = true;
  IconData? modeIcon =Icons.visibility_off;
  void visibilitySuffix() {
    isVisible = !isVisible!;
    modeIcon = isVisible! ? Icons.visibility_off  :Icons.visibility ;
    notifyListeners();
  }
}
