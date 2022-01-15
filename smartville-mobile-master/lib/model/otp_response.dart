import 'dart:convert';

OtpResponse otpResponseFromJson(String str) =>
    OtpResponse.fromJson(json.decode(str));

String otpResponseToJson(OtpResponse data) => json.encode(data.toJson());

class OtpResponse {
  OtpResponse({
    required this.error,
    required this.message,
    required this.data,
  });

  bool error;
  String message;
  Data? data;

  factory OtpResponse.fromJson(Map<String, dynamic> json) => OtpResponse(
        error: json["error"],
        message: json["message"],
        data: json["data"] != "" ? Data.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    required this.email,
    required this.otp,
  });

  String email;
  String otp;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        email: json["email"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "otp": otp,
      };
}
