import 'package:flutter/material.dart';
import 'package:musiclayer/ui/modal/connectedModel.dart';
import 'package:scoped_model/scoped_model.dart';

class PageScroll extends StatefulWidget {
  @override
  _PageScrollState createState() => _PageScrollState();
}

class _PageScrollState extends State<PageScroll> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, ConnectedModel model) {
        model.fetchSongs();
        return SizedBox(
          height: width * 2.5 / 3,
          child: PageView.builder(
              onPageChanged: (page) {
                setState(() {
                  model.index = page;
                  model.playSong();
                });
              },
              pageSnapping: true,
              controller: PageController(
                  initialPage: model.play == false ? 0 : model.index,
                  viewportFraction: 0.78),
              scrollDirection: Axis.horizontal,
              itemCount: model.songs.length,
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        image: DecorationImage(
                            image: AssetImage("assets/images/dp.jpeg"),
                            fit: BoxFit.cover),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 5.0,
                            blurRadius: 5.0,
                          ),
                        ]),
                    width: width * 2 / 3,
                    height: width * 2 / 3,
                  ),
                );
              }),
        );
      },
    );
  }
}
