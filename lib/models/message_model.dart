class MessageModel{
  String? senderUid;
  String? receiverUid;
  String? message;
  String? messageUid;
  DateTime? date;

  MessageModel({
    this.senderUid,
    this.receiverUid,
    this.message,
    this.messageUid,
    this.date,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      senderUid: json['senderUid'] ?? '' ,
      receiverUid: json['receiverUid'] ?? '',
      message: json['message'] ?? '',
      messageUid: json['messageUid'] ?? '',
      date:DateTime.parse(json["date"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderUid': senderUid ?? '',
      'receiverUid': receiverUid ?? '',
      'message': message ?? '',
      'messageUid': messageUid ?? '',
      'date': date!.toIso8601String(),
    };
  }

}