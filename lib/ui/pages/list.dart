import 'package:flutter/material.dart';
import 'package:musiclayer/ui/modal/connectedModel.dart';
import 'package:musiclayer/ui/widget/songListBuilder.dart';

class SongList extends StatefulWidget {

  ConnectedModel model;
  SongList(this.model);

  @override
  _SongListState createState() => _SongListState();
}

class _SongListState extends State<SongList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Songs",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SongListBuild(widget.model),
    );
  }
}
