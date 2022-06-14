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
      debugPrint(e.toString());
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

  static Future<List<UserModel>?> getAllUser() async {
    List<UserModel> userList = [];
    if (userList.isEmpty) {
      await db.collection(CollectionsFireStoreKeys.USERS).get().then((value) => {
                if(value.docs.isNotEmpty){
                  value.docs.forEach((element) {
                    if (element.data()['uid'] != Auth.currentUser!.uid) {
                      userList.add(UserModel.fromJson(element.data()));
                    }
                  })
                }
              });
             }

    return userList;
  }


  static Future<dynamic> editUserProfile({UserModel? model,String? docId,BuildContext? context}) async {
    List<PostModel>? post = LoginProvider.read(context).postList;
    List<PostCommentsModel>? commentsList = <PostCommentsModel>[];
     post!.forEach((element) {
       // if(element.userUid == model!.uid){
       //   element.user == model;
       //
       // }
       commentsList.addAll(element.comments!.toList()) ;
    });

    try{
    model!.uid = docId;
    CollectionReference doc = db.collection(CollectionsFireStoreKeys.USERS);
    await doc.doc(model.uid).update(model.toJson());

    CollectionReference docs = db.collection(CollectionsFireStoreKeys.POSTS);
    await docs.where('userUid',isEqualTo: Auth.currentUser!.uid).get().then((value) => {
      value.docs.forEach((element) {
        element.reference.update({
          'user': model.toJson(),
        });
      })
    });

    CollectionReference comments = db.collection(CollectionsFireStoreKeys.POSTS);
    commentsList.forEach((element) async{
      await comments.doc(element.postUid).update({'comments': FieldValue.delete()});
    });
     commentsList.forEach((element) async{
       PostCommentsModel? postCommentsModel;
       if(element.userUid == Auth.currentUser!.uid) {
         debugPrint('${element.postUid}');
         element.user = model;
         postCommentsModel = element;
         await comments.doc(element.postUid).update({'comments': FieldValue.arrayUnion([postCommentsModel.toJson()])});
       }
       else{
         postCommentsModel = element;
         await comments.doc(element.postUid).update({'comments': FieldValue.arrayUnion([postCommentsModel.toJson()])});

       }
     });


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

  static Future<void> setComments(PostCommentsModel postComments,String? postUid) async {
    DocumentReference doc = db.collection(CollectionsFireStoreKeys.POSTS).doc(postUid);
    DocumentReference generateId = db.collection(CollectionsFireStoreKeys.POSTS).doc();
    postComments.commentUid =generateId.id;
    await doc.update({
      'comments': FieldValue.arrayUnion([postComments.toJson()])
    });
  }

  static Future<void> removeComments(PostCommentsModel postComments,String? postUid) async {
    await db.collection(CollectionsFireStoreKeys.POSTS).doc(postUid).update({
      'comments': FieldValue.arrayRemove([postComments.toJson()])
    });
  }

  static Future<void> updateComments(String? postUid,List<PostCommentsModel>? commentList) async {
    await db.collection(CollectionsFireStoreKeys.POSTS).doc(postUid).update({
      'comments': FieldValue.delete()});

    commentList!.forEach((element) async{
      PostCommentsModel? postCommentsModel = element;
      await db.collection(CollectionsFireStoreKeys.POSTS).doc(postUid).update({
        'comments': FieldValue.arrayUnion([postCommentsModel.toJson()])
      });
    });

  }



}
