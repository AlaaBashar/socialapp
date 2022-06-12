class UserModel{
  String? id, uid, name, password, email, phone, image,cover, bio,birthDay;
  bool? isBlocked ;
  DateTime? date;

  UserModel({
    this.id,
    this.uid,
    this.image,
    this.cover,
    this.bio,
    this.name,
    this.birthDay,
    this.email,
    this.password,
    this.phone,
    this.isBlocked,
    this.date
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      uid: json["uid"],
      image: json["image"],
      cover: json["cover"],
      bio: json["bio"],
      name: json["name"],
      birthDay: json["birthDay"] ?? '',
      phone: json["phone"],
      email: json["email"],
      date: DateTime.parse(json["date"]),
      isBlocked: json["isBlocked"] ?? false,
      password: json["password"],

    );
  }

  
  Map<String, dynamic> toJson() {
    return {
      "id":id,
      "uid":uid,
      "cover":cover,
      "name":name,
      "birthDay":birthDay,
      "image":image,
      "bio": bio,
      "phone": phone,
      "isBlocked": isBlocked ?? false,
      "email": email,
      "date": date!.toIso8601String(),
      "password": '',
    };
  }








}