import 'dart:convert';

News newsFromJson(String str) => News.fromJson(json.decode(str));

String newsToJson(News data) => json.encode(data.toJson());

class News {
  News({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  List<Datum>? data;

  factory News.fromJson(Map<String, dynamic> json) => News(
        error: json["error"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.judulBerita,
    this.fotoBerita,
    this.deskripsiBerita,
    this.tanggalTerbit,
  });

  int? id;
  String? judulBerita;
  String? fotoBerita;
  String? deskripsiBerita;
  DateTime? tanggalTerbit;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["Id"],
        judulBerita: json["Judul_berita"],
        fotoBerita: json["Foto_berita"],
        deskripsiBerita: json["Deskripsi_berita"],
        tanggalTerbit: DateTime.parse(json["Tanggal_terbit"]),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Judul_berita": judulBerita,
        "Foto_berita": fotoBerita,
        "Deskripsi_berita": deskripsiBerita,
        "Tanggal_terbit": tanggalTerbit?.toIso8601String(),
      };
}
