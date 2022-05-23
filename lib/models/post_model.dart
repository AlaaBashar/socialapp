import '../export_feature.dart';

class PostModel {
  String? userUid, postUid, postImage, postContent;
  DateTime? date;
  UserModel? user;
  List<PostLikes>? likes= <PostLikes>[];

  PostModel({
    this.date,
    this.user,
    this.userUid,
    this.postUid,
    this.postImage,
    this.postContent,
    this.likes,

  });


  PostModel.fromJson(Map<String, dynamic> json) {

        userUid= json["userUid"] ?? '';
        postUid= json["postUid"] ?? '';
        postImage=json["postImage"] ?? '';
        postContent= json["postContent"] ?? '';
        date= DateTime.parse(json["date"]);
        user= UserModel.fromJson(json["user"]);
        likes = [];
        List likesList = json['likes'] ?? [] ;
        likes = likesList.map((e) => PostLikes.fromJson(e)).toList();

  }

  Map<String, dynamic> toJson() {
    return {
      "userUid": userUid ?? '',
      "postUid": postUid ?? '',
      "postImage": postImage ?? '',
      "postContent": postContent ?? '',
      "date": date!.toIso8601String(),
      "user": user!.toJson() ,
      "likes" : [],
    };
  }
}
