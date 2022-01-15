// To parse this JSON data, do
//
//     final requestSupport = requestSupportFromJson(jsonString);

import 'dart:convert';

RequestSupport requestSupportFromJson(String str) => RequestSupport.fromJson(json.decode(str));

String requestSupportToJson(RequestSupport data) => json.encode(data.toJson());

class RequestSupport {
  RequestSupport({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  Data? data;

  factory RequestSupport.fromJson(Map<String, dynamic> json) => RequestSupport(
    error: json["error"],
    message: json["message"],
    data: json["data"] != null ? Data.fromJson(json["data"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    required this.id,
    required this.userNik,
    required this.namaBantuan,
    required this.jenisBantuan,
    required this.jumlahDana,
    required this.alokasiDana,
    required this.danaTerealisasi,
    required this.sisaDanaBantuan,
  });

  int id;
  String userNik;
  String namaBantuan;
  String jenisBantuan;
  int jumlahDana;
  int alokasiDana;
  int danaTerealisasi;
  int sisaDanaBantuan;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["Id"],
    userNik: json["UserNik"],
    namaBantuan: json["Nama_bantuan"],
    jenisBantuan: json["Jenis_bantuan"],
    jumlahDana: json["Jumlah_dana"],
    alokasiDana: json["Alokasi_dana"],
    danaTerealisasi: json["Dana_terealisasi"],
    sisaDanaBantuan: json["Sisa_dana_bantuan"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "UserNik": userNik,
    "Nama_bantuan": namaBantuan,
    "Jenis_bantuan": jenisBantuan,
    "Jumlah_dana": jumlahDana,
    "Alokasi_dana": alokasiDana,
    "Dana_terealisasi": danaTerealisasi,
    "Sisa_dana_bantuan": sisaDanaBantuan,
  };
}
