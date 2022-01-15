import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.error,
    required this.message,
    required this.data,
  });

  bool error;
  String message;
  UserData? data;

  factory User.fromJson(Map<String, dynamic> json) => User(
        error: json["error"],
        message: json["message"],
        data: json["data"] != "" ? UserData.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": data?.toJson(),
      };
}

class UserData {
  UserData({
    this.id,
    this.nik,
    this.nama,
    this.email,
    this.password,
    this.tglLahir,
    this.tempatLahir,
    this.alamat,
    this.dusun,
    this.rt,
    this.rw,
    this.jenisKelamin,
    this.noHp,
    this.role,
    this.profilePic,
    this.token,
  });

  int? id;
  String? nik;
  String? nama;
  String? email;
  String? password;
  DateTime? tglLahir;
  String? tempatLahir;
  String? alamat;
  String? dusun;
  int? rt;
  int? rw;
  bool? jenisKelamin;
  String? noHp;
  String? role;
  String? profilePic;
  String? token;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["Id"],
        nik: json["Nik"],
        nama: json["Nama"],
        email: json["Email"],
        password: json["Password"],
        tglLahir: DateTime.parse(json["Tgl_lahir"]),
        tempatLahir: json["Tempat_lahir"],
        alamat: json["Alamat"],
        dusun: json["Dusun"],
        rt: json["Rt"],
        rw: json["Rw"],
        jenisKelamin: json["Jenis_kelamin"],
        noHp: json["No_hp"],
        role: json["Role"],
        profilePic: json["Profile_pic"],
        token: json["Token"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Nik": nik,
        "Nama": nama,
        "Email": email,
        "Password": password,
        "Tgl_lahir": tglLahir?.toIso8601String(),
        "Tempat_lahir": tempatLahir,
        "Alamat": alamat,
        "Dusun": dusun,
        "Rt": rt,
        "Rw": rw,
        "Jenis_kelamin": jenisKelamin,
        "No_hp": noHp,
        "Role": role,
        "Profile_pic": profilePic,
        "Token": token,
      };
}
