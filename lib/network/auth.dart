import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../export_feature.dart';

class Auth {
  Auth._();

  static UserModel? currentUser;

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<UserModel?> signUpByEmailAndPass(
      {required UserModel userModel,
      required String? email,
      required String? password}) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email!, password: password!);

      userModel.uid = userCredential.user!.uid;
      return await Api.insertNewUser(
        userApp: userModel,
      );
    } on FirebaseAuthException catch (e) {
      //handle auth error
      if (e.code == "email-already-in-use") {
        print(e.toString());
        return Future.error('The email is already in use, please use another email again');
      } else if (e.code == "invalid-email") {
        print(e.toString());
        return Future.error('Incorrect email');
      } else if (e.code == "weak-password") {
        print(e.toString());
        return Future.error(
            "The password is weak, the password must be at least 6 characters");
      } else {
        print(e.toString());
        return Future.error('Unknown Error Please try again later');
      }
    } on PlatformException catch (e) {
      print('test');
      print(e.toString());
      return Future.error(e.toString());
    }
  }

  static Future<UserModel?> loginByEmailAndPass(
      {String? email, String? password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email ?? '', password: password ?? '');

      return await Api.getUserFromUid(userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        return Future.error('There is no record for this email');
      }

      if (e.code == "invalid-email") {
        return Future.error('Badly formatted email address');
      } else {
        return Future.error('The email or password is incorrect');
      }
    }
  }

  static Future forgotPassword(String email) async {
    print('======== $email');
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        return Future.error('There is no record for this email');
      }
      if (e.code == "invalid-email") {
        return Future.error('Badly formatted email address');
      }
    }
  }

  static Future<UserModel?> getUserFromPref() async {
    String jsonUser;
    try {
      jsonUser = CacheHelper.getData(key: 'User_Cache') ;
    } catch (e) {
      debugPrint('****** ${e.toString()}');
      return null;
    }
    Map<String, dynamic> userMap = json.decode(jsonUser);
    return UserModel.fromJson(userMap);
  }

  static Future updateUserInPref(UserModel? user) async {
    Map userMap;
    userMap = user!.toJson();
    String userJson = json.encode(userMap);
    currentUser = user;

    ///Fcm.subscribeToTopic(currentUser!.uid!);
    CacheHelper.saveData(key: 'User_Cache', value: userJson);
  }

  static Future removeUserFromPref() async {
     CacheHelper.removeData(key: 'User_Cache');
  }

  static Future logout() async {
    await _auth.signOut();
    removeUserFromPref();
    currentUser = null;
  }
}
