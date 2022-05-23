import 'package:socialapp/export_feature.dart';
class PostLikes {
  String? uId;
  String? postUid;

  PostLikes({
    this.uId,
    this.postUid,
  });

  factory PostLikes.fromJson(Map<String, dynamic> json) {
    return PostLikes(
      uId: json["uId"],
      postUid: json["postUid"],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "uId": uId,
      "postUid": postUid,
    };
  }
}
