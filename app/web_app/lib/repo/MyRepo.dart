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
    _labels = await _service.getLabels(image);
  }

  Labels get labels => _labels;
}
