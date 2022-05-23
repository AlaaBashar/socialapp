import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
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

  static Future<dynamic> setPost({required PostModel postModel,}) async {
    try {
      DocumentReference doc = db.collection(CollectionsFireStoreKeys.POSTS).doc();
      postModel.postUid = doc.id;
      await doc.set(postModel.toJson());
    } catch (e) {
      debugPrint(e.toString());
      return Future.error(e.toString());
    }
  }

  static Future<List<PostModel>> getPosts() async {
    List<PostModel>? postsList = [];
    QuerySnapshot querySnapshot = await db.collection(CollectionsFireStoreKeys.POSTS).get();
    postsList = querySnapshot.docs.map((e) {return PostModel.fromJson(e.data() as Map<String, dynamic>);}).toList();
    if (postsList.isNotEmpty) {postsList.sort((a, b) => b.date!.compareTo(a.date!));}
    return postsList;
  }

  // static Future<dynamic> setPostLike({required PostLikes postLikes,required String? postUid }) async {
  //   try {
  //     DocumentReference doc =  db
  //         .collection(CollectionsFireStoreKeys.POSTS)
  //         .doc(postUid)
  //         .collection(CollectionsFireStoreKeys.LIKES)
  //         .doc(Auth.currentUser!.uid);
  //     postLikes.postUid = postUid;
  //     await doc.set(postLikes.toJson());
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     return Future.error(e.toString());
  //   }
  // }

  // static Future<List<PostLikes>?> getPostLike() async {
  //   try {
  //     List<PostLikes> postsLikesList = [];
  //     QuerySnapshot querySnapshot;
  //     querySnapshot= await db
  //         .collectionGroup(CollectionsFireStoreKeys.LIKES)
  //         .where('uId', isEqualTo: Auth.currentUser!.uid)
  //         .get();
  //     postsLikesList = querySnapshot.docs.map((e) => PostLikes.fromJson(e.data() as Map<String, dynamic>)).toList();
  //     return postsLikesList;
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     return Future.error(e.toString());
  //   }
  // }


  static Future<void> setPostLike(PostLikes postLikes,String? postUid) async {
     await db.collection(CollectionsFireStoreKeys.POSTS).doc(postUid).update({
       'likes': FieldValue.arrayUnion([postLikes.toJson()])
     });
  }
  static Future<void> removePostLike(PostLikes postLikes,String? postUid) async {
    await db.collection(CollectionsFireStoreKeys.POSTS).doc(postUid).update({
      'likes': FieldValue.arrayRemove([postLikes.toJson()])
    });
  }


}
