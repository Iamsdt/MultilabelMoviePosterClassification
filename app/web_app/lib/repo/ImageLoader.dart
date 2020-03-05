import 'dart:html' as html;
import 'dart:convert';
import 'package:http/http.dart' as http;

class ImageLoader {
  var _bytesData;

  void pickImages() async {
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
      });
      reader.readAsDataUrl(file);
    });
  }

  get bytesData => _bytesData;
}
