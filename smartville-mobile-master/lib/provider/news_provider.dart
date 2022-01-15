import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smartville/model/news_response.dart';

import '../network/remote_data_source.dart';

class NewsProvider extends ChangeNotifier {
  Future<List<Datum>> listNews() async {
    return await RemoteDataSource.newsList();
  }
}
