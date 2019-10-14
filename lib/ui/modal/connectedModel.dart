import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:scoped_model/scoped_model.dart';

class ConnectedModel extends Model {
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  AudioPlayer audioPlayer = AudioPlayer();
  List<SongInfo> _songList = [];
  bool play = false;
  double value = 0.0;
  Duration durationTotal = Duration(seconds: 0);
  int currentDuration = 0;
  Timer _timer;
  int index;
  bool repeat = false;
  bool shuffle = false;

  void fetchSongs() async {
    _songList = await audioQuery.getSongs();
    notifyListeners();
  }

  List<SongInfo> get songs {
    return List.from(_songList);
  }

  void changeSong({changeTO}) {
    int i;
    i = shuffle ? 3 : 1;
    if (changeTO.toString().toLowerCase() == "next" && index < songs.length-1) {
      index = (index+i)%songs.length;
    } else if (changeTO.toString().toLowerCase() == "prev" && index > 0) {
      index = (index-i).abs()%songs.length;
    } else {
      return;
    }
    if (play == true) {
      cancelTimer();
    }
    playSong();
  }

  void selectSong(i) {
    index = i;
  }

  SongInfo get selectedSong {
    return _songList[index];
  }

  void playSong() async {
    if (play == true) {
      cancelTimer();
    }
    currentDuration = 0;
    value = 0;
    play = true;
    int result = await audioPlayer.play(_songList[index].filePath, isLocal: true);
    notifyListeners();
    startTimer();
  }

  void resumeSong() async {
    await audioPlayer.resume();
    startTimer();
    play = true;
    notifyListeners();
  }

  void pauseSong() async {
    await audioPlayer.pause();
    play = false;
    _timer.cancel();
    notifyListeners();
  }

  getDuration() {
    audioPlayer.onDurationChanged.listen((d) {
      durationTotal = d;
    });
    return durationTotal;
  }

  void seekDuration() {
    audioPlayer.seek(Duration(seconds: currentDuration));
    notifyListeners();
  }

  void startTimer() {
    getDuration();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (currentDuration >= durationTotal.inSeconds) {
        if (repeat == true) {
          playSong();
          return;
        }
        currentDuration = 0;
        value = 0;
        play = false;
        _timer.cancel();
        notifyListeners();
      } else {
        currentDuration += 1;
        value = 1 / durationTotal.inSeconds * currentDuration;
        notifyListeners();
      }

    });
  }

  void cancelTimer() {
    _timer.cancel();
  }
}
