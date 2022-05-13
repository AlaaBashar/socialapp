import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../../../export_feature.dart';

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
      image: 'https://img.freepik.com/free-photo/attractive-surprised-curly-haired-woman-keeps-lips-rounded-points-thumb-away-makes-her-choice-shopping-dressed-casual-hoodie-poses-yellow-wall-shows-logo-promo-deal-copy-space_273609-49702.jpg?t=st=1652078518~exp=1652079118~hmac=1cf3a4e4a7f62207ae5c73eff64987a03176b87a33bd0255b495d450480bca03&w=1380',
      bio: 'write your bio ...',
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
