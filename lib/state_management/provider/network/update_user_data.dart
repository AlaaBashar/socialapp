import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../export_feature.dart';

class EditUserDate with ChangeNotifier, DiagnosticableTreeMixin {
  ///watch-function ///get variables
  static EditUserDate watch(context) => Provider.of(context,);
  ///read-function ///Implement functions
  static EditUserDate read(context) => Provider.of(context, listen: false);

  void onEdit({
    context,
    String? name,
    String? phone,
    String? bio,
    String? id,
    String? birthDay,
    File? profileImage,
    File? coverImage,
  }) async {
    String? imageUrl;
    String? coverUrl;

    ProgressLinearDialog.show(context, title: 'Editing in progress');

    if (profileImage != null) {
      imageUrl = await Storage.uploadUserImage(image: profileImage)
          .catchError((onError) {
        showSnackBar(context, onError.toString());
      });
    }
    if (coverImage != null) {
      coverUrl = await Storage.uploadUserImage(image: coverImage)
          .catchError((onError) {
        showSnackBar(context, onError.toString());
      });
    }

    UserModel userModel = UserModel();
    userModel
      ..name = name
      ..phone = phone
      ..email = Auth.currentUser!.email
      ..bio = bio
      ..id = id
      ..birthDay = birthDay
      ..date = DateTime.now()
      ..image = imageUrl ?? Auth.currentUser!.image
      ..cover = coverUrl ?? Auth.currentUser!.cover;

    await Api.editUserProfile(model: userModel, docId: Auth.currentUser!.uid,context: context)
        .catchError((onError) {
      showSnackBar(context, onError.toString());
      ProgressLinearDialog.dismiss(context);
    });

    ProgressLinearDialog.dismiss(context);

    Navigator.pop(context, true);

    notifyListeners();
  }
}
