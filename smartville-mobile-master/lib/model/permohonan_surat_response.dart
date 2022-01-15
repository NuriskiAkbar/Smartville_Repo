// To parse this JSON data, do
//
//     final permohonanSurat = permohonanSuratFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PermohonanSurat permohonanSuratFromJson(String str) =>
    PermohonanSurat.fromJson(json.decode(str));

String permohonanSuratToJson(PermohonanSurat data) =>
    json.encode(data.toJson());

class PermohonanSurat {
  PermohonanSurat({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  Data? data;

  factory PermohonanSurat.fromJson(Map<String, dynamic> json) =>
      PermohonanSurat(
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
    required this.nikPemohon,
    required this.namaPemohon,
    required this.alamatPemohon,
    required this.noHp,
    required this.jenisSurat,
  });

  int id;
  String userNik;
  String nikPemohon;
  String namaPemohon;
  String alamatPemohon;
  String noHp;
  String jenisSurat;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["Id"],
        userNik: json["UserNik"],
        nikPemohon: json["Nik_pemohon"],
        namaPemohon: json["Nama_pemohon"],
        alamatPemohon: json["Alamat_pemohon"],
        noHp: json["No_hp"],
        jenisSurat: json["Jenis_surat"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "UserNik": userNik,
        "Nik_pemohon": nikPemohon,
        "Nama_pemohon": namaPemohon,
        "Alamat_pemohon": alamatPemohon,
        "No_hp": noHp,
        "Jenis_surat": jenisSurat,
      };
}
