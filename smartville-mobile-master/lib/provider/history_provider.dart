import 'package:flutter/material.dart';

import '../network/remote_data_source.dart';

class HistoryProvider extends ChangeNotifier {
  Future<dynamic> getListHistory(String token) async {
    return await RemoteDataSource.getHistory(token);
  }
}
