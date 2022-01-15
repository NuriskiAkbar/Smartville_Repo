import 'dart:convert';


PendataanKelahiran pendataanKelahiranFromJson(String str) =>
    PendataanKelahiran.fromJson(json.decode(str));

String pendataanKelahiranToJson(PendataanKelahiran data) =>
    json.encode(data.toJson());

class PendataanKelahiran {
  PendataanKelahiran({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  DataPendataanKelahiran? data;

  factory PendataanKelahiran.fromJson(Map<String, dynamic> json) =>
      PendataanKelahiran(
        error: json['error'],
        message: json['message'],
        data: DataPendataanKelahiran.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataPendataanKelahiran {
  DataPendataanKelahiran({
    required this.id,
    required this.userNik,
    required this.namaBayi,
    required this.jenisKelamin,
    required this.namaAyah,
    required this.namaIbu,
    required this.anakKe,
    required this.tglKelahiran,
    required this.alamatKelahiran,
  });

  int id;
  String userNik;
  String namaBayi;
  bool jenisKelamin;
  String namaAyah;
  String namaIbu;
  int anakKe;
  DateTime tglKelahiran;
  String alamatKelahiran;

  factory DataPendataanKelahiran.fromJson(Map<String, dynamic> json) =>
      DataPendataanKelahiran(
          id: json['Id'],
          userNik: json['UserNik'],
          namaBayi: json['Nama_bayi'],
          jenisKelamin: json['Jenis_kelamin'],
          namaAyah: json['Nama_ayah'],
          namaIbu: json['Nama_ibu'],
          anakKe: json['Anak_ke'],
          tglKelahiran: DateTime.parse(json["Tanggal_kelahiran"]),
          alamatKelahiran: json['Alamat_kelahiran']);

  Map<String, dynamic> toJson() => {
        'Id': id,
        'UserNik': userNik,
        'Nama_bayi': namaBayi,
        'Jenis_kelamin': jenisKelamin,
        'Nama_ayah': namaAyah,
        'Nama_ibu': namaIbu,
        'Anak_ke': anakKe,
        'Tanggal_kelahiran': tglKelahiran.toIso8601String(),
        'Alamat_kelahiran': alamatKelahiran,
      };
}
