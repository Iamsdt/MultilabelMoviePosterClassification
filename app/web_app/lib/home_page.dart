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
                    onIdle: () => handleIdle(),
                    onWaiting: () => handleOnWaiting(),
                    onData: (state) => handleOnData(state),
                    onError: (error) => handleOnError(error));
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
    final reactiveModel = Injector.getAsReactive<ImageLoader>();
    reactiveModel.setState((store) => store.pickImages());
  }

  //send image for analysis
  void sendRequest(image) {
    final reactiveModel = Injector.getAsReactive<MyRepo>();
    reactiveModel.setState((store) => store.getMovies(image));
  }

  /// Handle network request
  Widget handleIdle() {
    return Text("Hey I am idle");
  }

  Widget handleOnWaiting() {
    return Text("Hey I am waiting");
  }

  Widget handleOnData(state) {
    return Text("Hey I have data");
  }

  Widget handleOnError(error) {
    return Text("Hey I got an error");
  }
}
