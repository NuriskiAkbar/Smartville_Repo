import 'dart:convert';

PendataanDomisili pendataanDomisiliFromJson(String str) =>
    PendataanDomisili.fromJson(json.decode(str));

String pendataanDomisiliToJson(PendataanDomisili data) =>
    json.encode(data.toJson());

class PendataanDomisili {
  PendataanDomisili({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  DataPendataanDomisili? data;

  factory PendataanDomisili.fromJson(Map<String, dynamic> json) =>
      PendataanDomisili(
        error: json['error'],
        message: json['message'],
        data: DataPendataanDomisili.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'error': error,
        'message': message,
        'data': data?.toJson(),
      };
}

class DataPendataanDomisili {
  DataPendataanDomisili({
    required this.id,
    required this.userNik,
    required this.nikPemohon,
    required this.namaPemohon,
    required this.tglLahir,
    required this.asalDomisili,
    required this.tujuanDomisili,
  });

  int id;
  String userNik;
  String nikPemohon;
  String namaPemohon;
  DateTime tglLahir;
  String asalDomisili;
  String tujuanDomisili;

  factory DataPendataanDomisili.fromJson(Map<String, dynamic> json) =>
      DataPendataanDomisili(
          id: json['Id'],
          userNik: json['UserNik'],
          nikPemohon: json['Nik_pemohon'],
          namaPemohon: json['Nama_pemohon'],
          tglLahir: DateTime.parse(json['Tgl_lahir']),
          asalDomisili: json['Asal_domisili'],
          tujuanDomisili: json['Tujuan_domisili']);

  Map<String, dynamic> toJson() => {
        'Id': id,
        'UserNik': userNik,
        'Nik_pemohon': nikPemohon,
        'Nama_pemohon': namaPemohon,
        'Tgl_lahir': tglLahir.toIso8601String(),
        'Asal_domisili': asalDomisili,
        'Tujuan_domisili': tujuanDomisili,
      };
}
