import 'dart:html' as html;
import 'dart:convert';

import 'package:states_rebuilder/states_rebuilder.dart';

class ImageLoader {
  var _bytesData;

  Future<dynamic> pickImages() async {
    html.InputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = false;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      final file = files[0];
      final reader = new html.FileReader();

      reader.onLoadEnd.listen((e) {
        var result = reader.result;
        _bytesData = Base64Decoder().convert(result.toString().split(",").last);
        final reactiveModel = Injector.getAsReactive<ImageLoader>();
        reactiveModel.setState((store) => store._bytesData = _bytesData);
        return _bytesData;
      });

      reader.readAsDataUrl(file);
    });
  }

  void requestPickImage() async {
    var data = await pickImages();
    _bytesData = data;
  }

  get bytesData => _bytesData;
}
