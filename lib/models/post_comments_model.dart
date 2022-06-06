
import '../export_feature.dart';

class PostCommentsModel {
  String? userUid,postUid,commentsContent,commentUid;
  DateTime? date;
  UserModel? user;

  PostCommentsModel({
    this.date,
    this.user,
    this.userUid,
    this.postUid,
    this.commentsContent,
    this.commentUid,
  });


  PostCommentsModel.fromJson(Map<String, dynamic> json) {

    userUid= json["userUid"] ?? '';
    postUid= json["postUid"] ?? '';
    commentsContent= json["commentsContent"] ?? '';
    commentUid= json["commentUid"] ?? '';
    date= DateTime.parse(json["date"]);
    user= UserModel.fromJson(json["user"]);


  }

  Map<String, dynamic> toJson() {
    return {
      "userUid": userUid ?? '',
      "postUid": postUid ?? '',
      "commentsContent": commentsContent ?? '',
      "commentUid": commentUid ?? '',
      "date": date!.toIso8601String(),
      "user": user!.toJson() ,
    };
  }
}
