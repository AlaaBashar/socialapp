import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../../export_feature.dart';

class RegisterProvider with ChangeNotifier, DiagnosticableTreeMixin {
  static RegisterProvider watch(context) => Provider.of(context,); ///watch-function ///get variables
  static RegisterProvider read(context)  => Provider.of(context,listen: false); ///read-function ///Implement functions


  void onRegisterPro({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String id,
    required context,
  }) async{
    ProgressCircleDialog.show(context);
    UserModel userData = UserModel(
      name: name,
      password: password,
      email: email,
      phone: phone,
      date: DateTime.now(),
      id: id,
      uid: '',
    );

    UserModel? response = await Auth.signUpByEmailAndPass(
        userModel: userData, email: email, password: password)
        .catchError((onError) {
      showSnackBar(context, onError.toString());
    });
    ProgressCircleDialog.dismiss(context);
    if(response == null) {
      return;
    }

    openNewPage(context , const HomeScreen() , popPreviousPages: true);
    notifyListeners();

  }
}
