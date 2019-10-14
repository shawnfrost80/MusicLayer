import 'package:flutter/material.dart';import 'package:musiclayer/ui/modal/connectedModel.dart';import 'package:musiclayer/ui/widget/customClipper.dart';import 'package:musiclayer/ui/widget/pageView.dart';import 'package:scoped_model/scoped_model.dart';import 'package:seekbar/seekbar.dart';class Home extends StatefulWidget {  @override  _HomeState createState() => _HomeState();}class _HomeState extends State<Home> {  @override  void initState() {    super.initState();    setState(() {});  }  @override  Widget build(BuildContext context) {    final width = MediaQuery.of(context).size.width;    final height = MediaQuery.of(context).size.height;    return Scaffold(      appBar: AppBar(        leading: Container(),        centerTitle: true,        elevation: 0.0,        title: Container(          alignment: Alignment.bottomCenter,          child: Text(            "Now Playing",            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23.0),          ),        ),        actions: <Widget>[          Padding(            padding: const EdgeInsets.only(top: 20.0),            child: ScopedModelDescendant(              builder:                  (BuildContext context, Widget child, ConnectedModel model) {                return IconButton(                  icon: Icon(Icons.list),                  onPressed: () {                    Navigator.pushNamed(context, '/list');                  },                );              },            ),          )        ],//        backgroundColor: Colors.transparent,      ),      body: Stack(        children: <Widget>[          ClipPath(            clipper: CustomPathClipper(),            child: Container(              width: width,              height: height / 3,//              color: Theme.of(context).primaryColor,              decoration: BoxDecoration(                gradient: LinearGradient(                    begin: Alignment.topCenter,                    end: Alignment.bottomCenter,                    colors: [                      Theme.of(context).primaryColor,                      Colors.blue.shade800                    ]),              ),            ),          ),          Container(            padding: EdgeInsets.all(10.0),            child: ScopedModelDescendant(              builder:                  (BuildContext context, Widget child, ConnectedModel model) {                return Column(                  mainAxisAlignment: MainAxisAlignment.spaceAround,                  children: <Widget>[                    PageScroll(),                    ListTile(                      leading: IconButton(                        icon: Icon(                          Icons.share,                          color: Theme.of(context).accentColor,                        ),                        onPressed: () {                          setState(() {                            bottomSheet();                          });                        },                      ),                      title: Center(                        child: Text(                          model.index == null                              ? "No Song Selected!!"                              : model.selectedSong.title,                          style: TextStyle(                              fontSize: 20.0,                              color: Theme.of(context).accentColor,                              fontWeight: FontWeight.bold),                        ),                      ),                      subtitle: Center(                        child: Padding(                          padding: const EdgeInsets.only(top: 8.0),                          child: Text(                            model.index == null                                ? "None"                                : model.selectedSong.album,                            style: TextStyle(                              fontSize: 16.0,                              color: Colors.grey,                            ),                          ),                        ),                      ),                      trailing: IconButton(                        icon: Icon(                          Icons.more_vert,                          color: Theme.of(context).accentColor,                        ),                        onPressed: () {},                      ),                    ),                    Wrap(                      children: <Widget>[                        Padding(                          padding: const EdgeInsets.only(right: 5.0),                          child: Text(                            model.index == null                                ? "0:00"                                : "${(model.currentDuration / 60).toString().substring(0, 1).padLeft(2, '0')}:${(model.currentDuration % 60).toString().padLeft(2, '0')}",                            style: TextStyle(                              fontSize: 16.0,                              fontWeight: FontWeight.w500,                              color: Theme.of(context).accentColor,                            ),                          ),                        ),                        Container(                          width: MediaQuery.of(context).size.width * 6.8 / 10,                          child: SeekBar(                            value: model.value,                            progressWidth: 5.0,                            thumbRadius: 12.0,                            barColor: Theme.of(context).primaryColor,                            thumbColor: Colors.indigoAccent,                            progressColor: Theme.of(context).accentColor,                            onStartTrackingTouch: () {                              print("Started tracking");                              model.cancelTimer();                            },                            onProgressChanged: (value) {                              setState(() {                                model.value = value;                                model.currentDuration = (model.value *                                        model.getDuration().inSeconds)                                    .toInt();                              });                              print("Value: $value");                            },                            onStopTrackingTouch: () {                              print("Stopped");                              model.currentDuration =                                  (model.value * model.getDuration().inSeconds)                                      .toInt();                              model.seekDuration();                              if (model.play == true) {                                model.startTimer();                              } else {                                setState(() {});                              }                            },                          ),                        ),                        Padding(                          padding: const EdgeInsets.only(left: 5.0),                          child: Text(                            model.index == null                                ? "0:00"                                : "${model.durationTotal.inMinutes.toString().padLeft(2, '0')}:${(model.durationTotal.inSeconds % 60).toString().padLeft(2, '0')}",                            style: TextStyle(                              fontSize: 16.0,                              fontWeight: FontWeight.w500,                              color: Theme.of(context).accentColor,                            ),                          ),                        )                      ],                    ),                    Row(                      mainAxisAlignment: MainAxisAlignment.spaceAround,                      children: <Widget>[                        IconButton(                          icon: Icon(                            model.shuffle ? Icons.cancel : Icons.shuffle,                            size: 30.0,                            color: Theme.of(context).accentColor,                          ),                          onPressed: () {                            setState(() {                              model.shuffle = !model.shuffle;                            });                          },                        ),                        IconButton(                          icon: Icon(                            Icons.skip_previous,                            size: 35.0,                            color: Theme.of(context).accentColor,                          ),                          onPressed: () {                            model.changeSong(changeTO: "Prev");                          },                        ),                        IconButton(                          iconSize: 60.0,                          icon: CircleAvatar(                            radius: 60.0,                            child: Icon(                              model.play ? Icons.pause : Icons.play_arrow,                              size: 30.0,                              color: Colors.white,                            ),                            backgroundColor: Theme.of(context).primaryColor,                          ),                          onPressed: () {                            if (model.play == true) {                              model.pauseSong();                            } else {                              model.resumeSong();                            }                          },                        ),                        IconButton(                          icon: Icon(                            Icons.skip_next,                            size: 35.0,                            color: Theme.of(context).accentColor,                          ),                          onPressed: () {                            model.changeSong(changeTO: "next");                          },                        ),                        IconButton(                          icon: Icon(                            model.repeat ? Icons.repeat_one : Icons.repeat,                            size: 30.0,                            color: Theme.of(context).accentColor,                          ),                          onPressed: () {                            setState(() {                              model.repeat = !model.repeat;                            });                          },                        ),                      ],                    ),                  ],                );              },            ),          )        ],      ),    );  }  bottomSheet() {    return showModalBottomSheet(        context: context,        builder: (BuildContext context) {          return Container(              padding: EdgeInsets.all(20.0),              child: Wrap(                children: <Widget>[                  GestureDetector(                    child: Column(                      children: <Widget>[                        Image.asset(                          "assets/images/gmail_icon.png",                          height: 50.0,                          width: 50.0,                        ),                        Text("Gmail")                      ],                    ),                    onTap: () {},                  ),                  Padding(                    padding: EdgeInsets.all(10.0),                  ),                  GestureDetector(                    child: Column(                      children: <Widget>[                        Image.asset(                          "assets/images/watsapp_icon.png",                          height: 50.0,                          width: 50.0,                        ),                        Text("Watsapp")                      ],                    ),                  ),                ],              ));        });  }}