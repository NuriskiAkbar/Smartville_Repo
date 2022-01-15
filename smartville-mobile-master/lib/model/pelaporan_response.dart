import 'package:meta/meta.dart';
import 'dart:convert';

Pelaporan pelaporanFromJson(String str) => Pelaporan.fromJson(json.decode(str));

String pelaporanToJson(Pelaporan data) => json.encode(data.toJson());

class Pelaporan {
  Pelaporan({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  DataPelaporan? data;

  factory Pelaporan.fromJson(Map<String, dynamic> json) => Pelaporan(
        error: json["error"],
        message: json["message"],
        data:
            json["data"] != null ? DataPelaporan.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataPelaporan {
  DataPelaporan({
    required this.id,
    required this.userNik,
    required this.namaPelapor,
    required this.deskripsi,
    required this.jenisLaporan,
    required this.tglLaporan,
    required this.noHp,
    required this.alamat,
    required this.fotoKejadian,
  });

  int id;
  String userNik;
  String namaPelapor;
  String deskripsi;
  String jenisLaporan;
  DateTime tglLaporan;
  String noHp;
  String alamat;
  String fotoKejadian;

  factory DataPelaporan.fromJson(Map<String, dynamic> json) => DataPelaporan(
        id: json["Id"],
        userNik: json["UserNik"],
        namaPelapor: json["Nama_pelapor"],
        deskripsi: json["Deskripsi"],
        jenisLaporan: json["Jenis_laporan"],
        tglLaporan: DateTime.parse(json["Tgl_laporan"]),
        noHp: json["No_hp"],
        alamat: json["Alamat"],
        fotoKejadian: json["Foto_kejadian"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "UserNik": userNik,
        "Nama_pelapor": namaPelapor,
        "Deskripsi": deskripsi,
        "Jenis_laporan": jenisLaporan,
        "Tgl_laporan": tglLaporan.toIso8601String(),
        "No_hp": noHp,
        "Alamat": alamat,
        "Foto_kejadian": fotoKejadian,
      };
}
