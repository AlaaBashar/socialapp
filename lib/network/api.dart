import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/export_feature.dart';

class Api {
  static FirebaseFirestore db = FirebaseFirestore.instance;

  static Future<UserModel?> insertNewUser({
    required UserModel userApp,
  }) async {
    try {
      await db
          .collection(CollectionsFireStoreKeys.USERS)
          .doc(userApp.uid)
          .set(userApp.toJson());
      await Auth.updateUserInPref(userApp);

      return userApp;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<UserModel?> getUserFromUid({String? uid}) async {
    DocumentSnapshot documentSnapshot =
        await db.collection(CollectionsFireStoreKeys.USERS).doc(uid).get();

    if (documentSnapshot.data() != null) {
      Map<String, dynamic>? map = documentSnapshot.data() as Map<String, dynamic>?;
      UserModel userApp = UserModel.fromJson(map!);

      Auth.updateUserInPref(userApp);
      Auth.currentUser = userApp;
      return userApp;
    }
    return null;
  }

  static Future<dynamic> editUserProfile({UserModel? model,String? docId}) async {
    try{
    model!.uid = docId;
    CollectionReference doc = db.collection(CollectionsFireStoreKeys.USERS);
    await doc.doc(model.uid).update(model.toJson());
    }catch(onError){
     return Future.error(onError.toString());
    }
  }

  static Future<List<PostModel>> getPosts() async {
    List<PostModel> postsList = [];
    QuerySnapshot querySnapshot = await db.collection(CollectionsFireStoreKeys.POSTS).get();
    postsList = querySnapshot.docs.map((e) => PostModel.fromJson(e.data() as Map<String, dynamic>)).toList();
    if (postsList.isNotEmpty) {
      postsList.sort((a, b) => b.date!.compareTo(a.date!));
    }

    return postsList;
  }



  static Future<dynamic> uploadPost({required PostModel postModel,}) async {
    try {
      DocumentReference doc = db.collection(CollectionsFireStoreKeys.POSTS).doc();
      postModel.postUid = doc.id;
      await doc.set(postModel.toJson());
    } catch (e) {
      debugPrint(e.toString());
      return Future.error(e.toString());
    }
  }



}
