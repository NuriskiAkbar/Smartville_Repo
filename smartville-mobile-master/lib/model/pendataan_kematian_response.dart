import 'dart:convert';

PendataanKematian pendataanKematianFromJson(String str) =>
    PendataanKematian.fromJson(json.decode(str));

String pendataanKematianToJson(PendataanKematian data) =>
    json.encode(data.toJson());

class PendataanKematian {
  PendataanKematian({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  DataPendataanKematian? data;

  factory PendataanKematian.fromJson(Map<String, dynamic> json) =>
      PendataanKematian(
        error: json['error'],
        message: json['message'],
        data: DataPendataanKematian.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataPendataanKematian {
  DataPendataanKematian({
    required this.id,
    required this.userNik,
    required this.nik,
    required this.nama,
    required this.jenisKelamin,
    required this.usia,
    required this.tglWafat,
    required this.alamat,
  });

  int id;
  String userNik;
  String nik;
  String nama;
  bool jenisKelamin;
  int usia;
  DateTime tglWafat;
  String alamat;

  factory DataPendataanKematian.fromJson(Map<String, dynamic> json) =>
      DataPendataanKematian(
          id: json['Id'],
          userNik: json['UserNik'],
          nik: json['Nik'],
          nama: json['Nama'],
          jenisKelamin: json['Jenis_kelamin'],
          usia: json['Usia'],
          tglWafat:  DateTime.parse(json['Tgl_wafat']),
          alamat: json['Alamat']);

  Map<String, dynamic> toJson() => {
        "Id": id,
        "UserNik": userNik,
        "Nik": nik,
        "Nama": nama,
        "Jenis_kelamin": jenisKelamin,
        "Usia": usia,
        "Tgl_wafat": tglWafat.toIso8601String(),
        "Alamat": alamat,
      };
}
