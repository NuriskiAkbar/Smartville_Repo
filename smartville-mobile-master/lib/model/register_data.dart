import 'dart:io';

class RegisterData {
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
  File? imageProfile;

  RegisterData({
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
    this.imageProfile,
  });
}
