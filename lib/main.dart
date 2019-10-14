import 'package:flutter/material.dart';
import 'package:musiclayer/ui/modal/connectedModel.dart';
import 'package:musiclayer/ui/pages/home.dart';
import 'package:musiclayer/ui/pages/list.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp((MyApp()));

class MyApp extends StatelessWidget {

  ConnectedModel model = ConnectedModel();

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: model,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
        title: "MusicLayer",
        theme: ThemeData(
          primaryColor: Colors.lightBlue.shade700,
          accentColor: Colors.indigo.shade800,
        ),
        routes: {
          '/list' : (BuildContext contex) => SongList(model)
        }
      ),
    );
  }
}
