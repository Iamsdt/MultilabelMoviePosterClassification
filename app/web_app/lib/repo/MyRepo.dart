import 'dart:convert';

import 'package:dio/dio.dart';

import 'RestService.dart';

class MyRepo {
  RestService _service;
  Labels _labels;

  MyRepo() {
    _service = RestService(Dio());
  }

  void getMovies(image) async {
    if (_service == null) {
      _service = RestService(Dio());
    }
    image = base64Encode(image);
    image = image + "==";
    _labels = await _service.getLabels(image);
    print(_labels.label);
    print(_labels.label[0]);
  }

  Labels get labels => _labels;
}
