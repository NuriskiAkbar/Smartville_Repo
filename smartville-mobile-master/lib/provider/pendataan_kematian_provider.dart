import 'package:flutter/material.dart';
import 'package:smartville/network/remote_data_source.dart';
import 'package:smartville/model/pendataan_kematian_response.dart';

class PendataanKematianProvider with ChangeNotifier {
  Future<PendataanKematian> submitPendataanKematian({
    required String token,
    required String nik,
    required String nama,
    required bool jenisKelamin,
    required int usia,
    required String tglWafat,
    required String alamat,
    required String registerToken,
  }) async {
    PendataanKematian pendataanKematian =
        await RemoteDataSource.pendataanKematian(
            token, nik, nama, jenisKelamin, usia, tglWafat, alamat,registerToken);
    notifyListeners();
    return pendataanKematian;
  }
}
