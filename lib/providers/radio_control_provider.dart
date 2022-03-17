import 'package:alan_voice/alan_voice.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../model/channel.dart';

class RadioControlNotifier extends ChangeNotifier {
  late List<Channel> channels = [];
  late Channel selectedChannel;
  late int _idToPlay = 0;
  bool _isPlaying = false;

  late List<Channel> _favoris = [];

  List<Channel> get favoris => _favoris;
  List<Channel> addFavoris(int id) {
    _favoris.add(channels[id]);
    notifyListeners();
    return _favoris;
  }

  final AudioPlayer audioPlayer = AudioPlayer();

  int get idToPlay => _idToPlay;
  set idToPlay(int id) {
    _idToPlay = id;
    notifyListeners();
  }

  setupAlan() {
    AlanVoice.addButton(
        "e95ee1af058323d2a7f740b2a4fa4e5c2e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_RIGHT);

    AlanVoice.callbacks.add((command) => _handleCommand(command.data));
  }

  _handleCommand(Map<String, dynamic> response) {
    switch (response["command"]) {
      case "play":
        jouerMusic(selectedChannel.url);
        break;
      default:
        print("Command was ${response["command"]}");
    }
  }

  get retriveChannels async {
    // final chane = rootBundle.load("assets/channels/channel.json").toString();
    final channelJson =
        await rootBundle.loadString("assets/channels/channel.json");

    channels = ChannelList.fromJson(channelJson).radios;
    notifyListeners();
  }

  isPlaying() {
    audioPlayer.onPlayerStateChanged.listen((event) {
      // idToPlay = event.index;
      if (event == PlayerState.PLAYING) {
        _isPlaying = true;
        notifyListeners();
      } else {
        _isPlaying = false;
        notifyListeners();
      }
    });
    return _isPlaying;
  }

  void jouerMusic(String url) {
    // print(selectedChannel.name);
    audioPlayer.play(url);
    selectedChannel = channels.firstWhere((element) => element.url == url);
    // idToPlay = selectedChannel.channelId;
    notifyListeners();
  }

  void jouerNext(id) {
    if (id + 1 > channels.length) {
      jouerMusic(channels[1].url);
      notifyListeners();
    } else {}
    id++;
    jouerMusic(channels[id].url);
    notifyListeners();
  }

  void jouerPrev(id) {
    if (id < 1) {
      jouerMusic(channels[1].url);
      notifyListeners();
    } else {}
    id--;
    jouerMusic(channels[id].url);
    notifyListeners();
  }

  radioCommand(_selectedId, buttonId) {
    switch (buttonId) {
      case "play": //0 is play
        jouerMusic(channels[_selectedId].url);
        notifyListeners();
        break;

      case "pause":
        audioPlayer.pause();
        jouerMusic(channels[_selectedId].url);
        notifyListeners();
        break;

      case "stop":
        audioPlayer.stop();
        notifyListeners();
        break;
      case "next":
        //final index = _selectedId;

        if (_selectedId + 1 > channels.length) {
          jouerMusic(channels[1].url);
          notifyListeners();
        } else {
          _selectedId++;
          jouerMusic(channels[_selectedId].url);
          notifyListeners();
        }
        break;

      case "prev":
        // final index = _selectedRadio.id;
        // MyRadio newRadio;
        if (_selectedId - 1 <= 0) {
          jouerMusic(channels[1].url);
          notifyListeners();
        } else {
          _selectedId--;
          jouerMusic(channels[_selectedId].url);
          notifyListeners();
        }

        break;
      default:
        if (kDebugMode) {
          print("Command was $buttonId");
        }
        break;
    }
  }

  // Map<String, dynamic> _map = {};
  final bool _error = false;
  // String _errorMessage = '';

  // Map<String, dynamic> get map => _map;
  bool get error => _error;
  // String get errorMessage => _errorMessage;

  // void initalValues() {
  //   _error = false;
  //   _errorMessage = " ";
  //   _map = {};
  //   notifyListeners();
  // }
}
