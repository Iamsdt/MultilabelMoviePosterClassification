import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:web_app/repo/ImageLoader.dart';
import 'package:web_app/repo/MyRepo.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //show intro dialogs
            Container(),
            // show info container
            Container(),
            //pick image
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
              height: 32.0,
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
    return Container();
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
        margin: EdgeInsets.all(8.0),
        padding:
            EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
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
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: widgetList,
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
        height: 350,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(
                width: 3, color: Colors.green, style: BorderStyle.solid)),
        child: Center(
          child: error != null
              ? Text(error.toString())
              : Text("Click to pick image"),
        ),
      ),
    );
  }

  Widget showImage(state) {
    if (state.bytesData != null) {
      print("Bytes I got data");
      byteData = state.bytesData;

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
                height: 350.0,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            height: 32.0,
          ),
          FractionallySizedBox(
            widthFactor: 0.2,
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
                  print(byteData);
                  sendRequest(byteData);
                }),
          )
        ],
      );
    } else {
      print("Bytes data is null");
      return showEmptyContainer(null);
    }
  }
}
