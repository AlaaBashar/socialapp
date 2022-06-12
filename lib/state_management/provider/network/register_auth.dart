import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
    required String birthDay,
    required context,
    File? profileImage,

  }) async{
    String? imageUrl;

    ProgressCircleDialog.show(context);
    if (profileImage != null) {
      imageUrl = await Storage.uploadUserImage(image: profileImage)
          .catchError((onError) {
        showSnackBar(context, onError.toString());
      });
    }

    UserModel userData = UserModel(
      name: name,
      password: password,
      email: email,
      phone: phone,
      date: DateTime.now(),
      id: id,
      uid: '',
      image: imageUrl ??'',
      cover: '',
      birthDay: birthDay,
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

  bool? isVisible = true;
  IconData? modeIcon =Icons.visibility_off;
  void visibilitySuffix() {
    isVisible = !isVisible!;
    modeIcon = isVisible! ? Icons.visibility_off  :Icons.visibility ;
    notifyListeners();
  }


}
