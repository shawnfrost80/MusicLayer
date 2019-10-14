import 'package:flutter/material.dart';
import 'package:musiclayer/ui/modal/connectedModel.dart';
import 'package:scoped_model/scoped_model.dart';

class SongListBuild extends StatefulWidget {
  ConnectedModel model;

  SongListBuild(this.model);

  @override
  _SongListBuildState createState() => _SongListBuildState();
}

class _SongListBuildState extends State<SongListBuild> {
  @override
  void initState() {
    widget.model.fetchSongs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, ConnectedModel model) {
        return ListView.builder(
            itemCount: model.songs.length,
            itemBuilder: (context, int index) {
              return Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      child: Image.asset("assets/images/dp.jpeg"),
                    ),
                    title: Text(
                      "${model.songs[index].title}",
                      style: TextStyle(
                          fontSize: 19.0,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        model.songs[index].album,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    trailing: Text(
                      "${int.parse(model.songs[index].duration) ~/ 60000}:${(int.parse(model.songs[index].duration) % 60000).toString().substring(0,2)}",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      model.selectSong(index);
                      model.playSong();
                      Navigator.pushReplacementNamed(context, '/');
                    },
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.8 / 5,
                        right: 20.0),
                    alignment: Alignment.bottomRight,
                    child: Divider(),
                  ),
                ],
              );
            });
      },
    );
  }
}
