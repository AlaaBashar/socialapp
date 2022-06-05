class PostLikes {
  String? uId;
  String? postUid;
  bool? isLiked;

  PostLikes({
    this.uId,
    this.postUid,
    this.isLiked,
  });

  factory PostLikes.fromJson(Map<String, dynamic> json) {
    return PostLikes(
      uId: json["uId"],
      postUid: json["postUid"],
      isLiked: json["isLiked"],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "uId": uId,
      "postUid": postUid,
      "isLiked": isLiked = true,
    };
  }
}
