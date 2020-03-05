import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:web_app/repo/ImageLoader.dart';
import 'package:web_app/repo/MyRepo.dart';

import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Injector(
      inject: [
        Inject<MyRepo>(() => MyRepo()),
        Inject<ImageLoader>(() => ImageLoader()),
      ],
      builder: (context) => MaterialApp(
        title: 'Movie Poster Classification',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        debugShowCheckedModeBanner: false,
        home: MyHomePage(title: 'Movie Poster Classification'),
      ),
    );
  }
}
