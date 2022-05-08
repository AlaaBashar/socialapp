class UserModel{
  String? id, uid, name, password, email , phone;
  bool? isBlocked ;
  DateTime? date;

  UserModel({
    this.id,
    this.uid,
    this.name,
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
      name: json["name"],
      phone: json["phone"],
      email: json["email"],
      date: DateTime.parse(json["date"]),
      isBlocked: json["isBlocked"] ?? false,
      password: json["password"],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "uid": uid,
      "name": name,
      "phone": phone,
      "isBlocked": isBlocked ?? false,
      "email": email,
      "date": date!.toIso8601String(),
      "password": '',
    };
  }








}