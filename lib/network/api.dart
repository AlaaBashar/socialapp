import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialapp/export_feature.dart';

class Api {
  static FirebaseFirestore db = FirebaseFirestore.instance;

  static Future<UserModel?> insertNewUser({
    required UserModel userApp,
  }) async {
    try {
      await db
          .collection(CollectionsKey.USERS)
          .doc(userApp.uid)
          .set(userApp.toJson());

      await Auth.updateUserInPref(userApp);

      return userApp;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<UserModel?> getUserFromUid(String uid) async {
    DocumentSnapshot documentSnapshot =
        await db.collection(CollectionsKey.USERS).doc(uid).get();

    if (documentSnapshot.data() != null) {
      Map<String, dynamic>? map =
          documentSnapshot.data() as Map<String, dynamic>?;
      UserModel userApp = UserModel.fromJson(map!);

      Auth.updateUserInPref(userApp);
      Auth.currentUser = userApp;
      return userApp;
    }
    return null;
  }
}
