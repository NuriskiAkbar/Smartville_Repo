import 'package:flutter/material.dart';
import 'package:smartville/model/pendataan_domisili_response.dart';
import 'package:smartville/network/remote_data_source.dart';

class PendataanDomisiliProvider with ChangeNotifier {
  Future<PendataanDomisili> submitPendataanDomisili({
    required String token,
    required String nikPemohon,
    required String namaPemohon,
    required String tglLahir,
    required String asalDomisili,
    required String tujuanDomisili,
    required String registerToken,
  }) async {
    PendataanDomisili pendataanDomisili =
        await RemoteDataSource.pendataanDomisili(token, nikPemohon, namaPemohon,
            tglLahir, asalDomisili, tujuanDomisili,registerToken);
    notifyListeners();
    return pendataanDomisili;
  }
}
