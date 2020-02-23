import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String imgData;
  var _bytesData;

  startWebFilePicker() async {
    html.InputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = false;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      final file = files[0];
      final reader = new html.FileReader();

      reader.onLoadEnd.listen((e) {
        _handleResult(reader.result);
      });
      reader.readAsDataUrl(file);
    });
  }

  void _handleResult(Object result) {
    setState(() {
      _bytesData = Base64Decoder().convert(result.toString().split(",").last);
      imgData = base64Encode(_bytesData);
    });
  }

  Future<http.Response> postRequest(imgData) async {
    var url = 'https://rocky-beyond-88001.herokuapp.com/analysis/';
    print(url);

    print("Send request");

    print(imgData);

    var response = http.post(url, body: imgData + "==");
    print(response.toString());
    response.catchError(() {
      print("Error detected");
    });

    var data = await response;

    print("${data.statusCode}");
    print("${data.body}");
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            _bytesData != null
                ? Image.memory(
                    _bytesData,
                    height: 100.0,
                  )
                : Text("Image is loading"),
            RaisedButton(onPressed: () {
              var res = postRequest(imgData);
              res.catchError(() {
                print("Error");
              });
            })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: startWebFilePicker,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
