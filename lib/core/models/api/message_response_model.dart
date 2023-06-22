class MessageResponseModel {
  int? status;
  String? message;
  MessageResponseModel({this.status, this.message});

  factory MessageResponseModel.fromJson(Map<String, dynamic> json) => MessageResponseModel(
        status: json["statusCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": status,
        "message": message,
      };

  @override
  String toString() => 'MessageResponseModel(statusCode: $status, message: $message)';
}
