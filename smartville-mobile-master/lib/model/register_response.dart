import 'dart:convert';

Register registerFromJson(String str) => Register.fromJson(json.decode(str));

String registerToJson(Register data) => json.encode(data.toJson());

class Register {
  Register({
    required this.error,
    required this.message,
    required this.data,
  });

  bool error;
  String message;
  Data data;

  factory Register.fromJson(Map<String, dynamic> json) => Register(
        error: json["error"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.nik,
    required this.nama,
    required this.email,
    required this.password,
    required this.tglLahir,
    required this.tempatLahir,
    required this.alamat,
    required this.dusun,
    required this.rt,
    required this.rw,
    required this.jenisKelamin,
    required this.noHp,
    required this.role,
    required this.profilePic,
    required this.token,
  });

  int id;
  String nik;
  String nama;
  String email;
  String password;
  DateTime tglLahir;
  String tempatLahir;
  String alamat;
  String dusun;
  int rt;
  int rw;
  bool jenisKelamin;
  String noHp;
  String role;
  String profilePic;
  String token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        "Tgl_lahir": tglLahir.toIso8601String(),
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
