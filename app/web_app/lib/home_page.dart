import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_app/repo/Button.dart';
import 'package:web_app/repo/ImageLoader.dart';
import 'package:web_app/repo/MyRepo.dart';
import 'dart:html' as html;
import 'package:web_app/utils/hover.dart' as hover;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool showSubmitButton = false;

  var byteData;

  List<Color> colors = [
    Colors.lightBlue,
    Colors.deepOrange,
    Colors.amber,
    Colors.green
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: Text(
          widget.title,
          style: TextStyle(
              fontSize: 24.0, fontWeight: FontWeight.bold, letterSpacing: 1.0),
        ),
        actions: <Widget>[
          Container(
            child: IconButton(
                icon: Icon(Icons.info),
                iconSize: 30.0,
                onPressed: () {
                  //todo handel on pressed
                }),
            padding: EdgeInsets.only(right: 16.0),
          )
        ],
      ),
      body: Container(
        decoration: new BoxDecoration(
          color: const Color(0xff7c94b6),
          image: new DecorationImage(
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.2), BlendMode.dstATop),
            image: new NetworkImage(
              'https://ak0.picdn.net/shutterstock/videos/16143640/thumb/1.jpg',
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text(
                        "Multilabel Image classification by using Movies Poster.",
                        style: TextStyle(fontSize: 26.0, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      "Goal: Generate Movies Genere from Movies poster",
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: new InkWell(
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 20.0,
                                bottom: 20.0,
                                right: 16.0,
                                left: 16.0),
                            child: new Text('Show in Github',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    decoration: TextDecoration.underline,
                                    color: Colors.blue)),
                          ),
                          onTap: () {
                            var url =
                                "https://github.com/Iamsdt/MultilabelMoviePosterClassification";
                            html.window.open(url, "Github link");
                          }),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 0.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    StateBuilder(
                      models: [
                        Injector.getAsReactive<ImageLoader>(),
                      ],
                      builder: (ctx, model) {
                        return model.whenConnectionState(
                            onIdle: () => showEmptyContainer(null),
                            onWaiting: () => showEmptyContainer(null),
                            onData: (state) => showImage(state),
                            onError: (error) => showEmptyContainer(error));
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      child: MaterialButton(
                          padding: EdgeInsets.all(10.0),
                          color: Colors.cyan,
                          child: Text(
                            "Analysis",
                            style: TextStyle(
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          onPressed: () {
                            if (byteData != null) {
                              sendRequest(byteData);
                            }
                          }),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Card(
                      child: Container(
                        width: (MediaQuery.of(context).size.width / 2) - 10,
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 32.0, bottom: 32.0, right: 16.0, left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Mutlilable Image Classification',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25.0,
                                      color: Colors.blue)),
                              SizedBox(
                                height: 15.0,
                              ),
                              Text('Datasets: Movie_Poster_Dataset',
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.black)),
                              SizedBox(
                                height: 15.0,
                              ),
                              Text('Framework: Tensorflow 2.1',
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.black)),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text('Train model converted into tf lite',
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.black)),
                              SizedBox(
                                height: 15.0,
                              ),
                              Text(
                                  """Total params: 27,660,664\nTrainable params: 27,659,672\nNon-trainable params: 992""",
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.black)),
                              SizedBox(
                                height: 15.0,
                              ),
                              Text("Accuracy: 90%",
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    StateBuilder(
                      models: [
                        Injector.getAsReactive<MyRepo>(),
                      ],
                      builder: (ctx, model) {
                        return model.whenConnectionState(
                            onIdle: () => handleIdle(),
                            onWaiting: () => handleOnWaiting(),
                            onData: (state) => handleOnData(state),
                            onError: (error) => handleOnError(error));
                      },
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //pick image
  void pickImage() {
    final reactiveModel = Injector.get<ImageLoader>();
    reactiveModel.requestPickImage();
  }

  //send image for analysis
  void sendRequest(image) {
    final reactiveModel = Injector.getAsReactive<MyRepo>();
    reactiveModel.setState((store) => store.getMovies(image));
  }

  /// Handle network request
  Widget handleIdle() {
    return Container(
      width: 300.0,
    );
  }

  Widget handleOnWaiting() {
    return CircularProgressIndicator(
      strokeWidth: 2.0,
    );
  }

  Widget handleOnData(state) {
    var data = state as MyRepo;

    var list = data.labels.label;

    print(list);

    List<Widget> widgetList = new List<Widget>();
    for (var i = 0; i < list.length; i++) {
      widgetList.add(Container(
        margin: EdgeInsets.only(left: 8.0, right: 8.0),
        padding:
            EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0, bottom: 4.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(
                width: 3, color: colors[i], style: BorderStyle.solid)),
        child: Text(
          list[i],
          style: TextStyle(fontSize: 25.0, color: colors[i]),
        ),
      ));
    }
    return Column(
      children: <Widget>[
        Text(
          "Movie Genes",
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: widgetList,
        ),
      ],
    );
  }

  Widget handleOnError(error) {
    print(error);
    return Text("Hey I got an error");
  }

  Widget showEmptyContainer(var error) {
    return InkWell(
      onTap: () {
        pickImage();
      },
      child: Container(
        padding: EdgeInsets.only(),
        width: 300,
        height: 320,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(
                width: 3, color: Colors.green, style: BorderStyle.solid)),
        child: Center(
          child: error != null
              ? Text(error.toString())
              : Text(
                  "Click to pick image",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
        ),
      ),
    );
  }

  Widget showImage(state) {
    if (state.bytesData != null) {
      print("Bytes I got data");
      byteData = state.bytesData;

      var button = Injector.getAsReactive<ButtonState>();
      button.setState((store) => store.data = true);
      print("Button state saved");

      return Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                    width: 3, color: Colors.green, style: BorderStyle.solid)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.memory(
                state.bytesData,
                width: 300.0,
                height: 320.0,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      );
    } else {
      print("Bytes data is null");
      return showEmptyContainer(null);
    }
  }
}
