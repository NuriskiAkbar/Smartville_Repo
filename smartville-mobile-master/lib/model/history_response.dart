import 'dart:convert';

ListHistory historyFromJson(String str) => ListHistory.fromJson(json.decode(str));

String historyToJson(ListHistory data) => json.encode(data.toJson());

class ListHistory {
    ListHistory({
        required this.error,
        required this.message,
        required this.data,
    });

    bool error;
    String message;
    List<History> data;

    factory ListHistory.fromJson(Map<String, dynamic> json) => ListHistory(
        error: json["error"],
        message: json["message"],
        data: List<History>.from(json["data"].map((x) => History.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class History {
    History({
        required this.id,
        required this.userNik,
        required this.perihal,
        required this.deskripsi,
        required this.createdAt,
        required this.updatedAt,
        required this.status,
        required this.registrationToken,
    });

    int id;
    String userNik;
    String perihal;
    String deskripsi;
    DateTime createdAt;
    DateTime updatedAt;
    String status;
    String registrationToken;

    factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["Id"],
        userNik: json["UserNik"],
        perihal: json["Perihal"],
        deskripsi: json["Deskripsi"],
        createdAt: DateTime.parse(json["CreatedAt"]),
        updatedAt: DateTime.parse(json["UpdatedAt"]),
        status: json["Status"],
        registrationToken: json["Registration_token"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "UserNik": userNik,
        "Perihal": perihal,
        "Deskripsi": deskripsi,
        "CreatedAt": createdAt.toIso8601String(),
        "UpdatedAt": updatedAt.toIso8601String(),
        "Status": status,
        "Registration_token": registrationToken,
    };
}
