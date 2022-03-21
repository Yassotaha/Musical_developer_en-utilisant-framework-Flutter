import 'package:alan_voice/alan_voice.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../model/channel.dart';

class RadioControlNotifier extends ChangeNotifier {
  late List<Channel> channels = [];
  late Channel selectedChannel;
  late Channel _chaineChoisi;
  late int _idToPlay = 0;
  bool _isPlaying = false;

  late List<Channel> _favoris = [];

  List<Channel> get favoris => _favoris;
  var _ctxt;

  get ctxt => _ctxt;

  set ctxt(newCtxt) {
    _ctxt = newCtxt;
    notifyListeners();
  }

  List<Channel> addFavoris(int id) {
    _favoris.add(channels[id]);
    notifyListeners();
    return _favoris;
  }

  final AudioPlayer audioPlayer = AudioPlayer();
  Channel get chaineChoisi => _chaineChoisi;

  set chaineChoisi(Channel cc) {
    _chaineChoisi = cc;
    notifyListeners();
  }

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

  navigation(ctxt) {
    Navigator.pushNamed(ctxt, '/second');
  }

  _handleCommand(Map<String, dynamic> response) {
    switch (response["command"]) {
      case "play": // dans le cas l'utilisateur est anglophone
        jouerMusic(chaineChoisi.url);
        navigation(ctxt);
        break;
      case "Jouer":
        jouerMusic(
            chaineChoisi.url); // dans le cas l'utilisateur est francophone
        break;
      case "stop": // dans le cas l'utilisateur veut arrete la musique
        audioPlayer.stop();
        break;
      case "next": // On veut jour le prochain channel
        playNext(chaineChoisi.id);

        break;
      case "prev": // On veut jour le channel precedente
        playPrev(chaineChoisi.id);
        //navigation(ctxt);
        break;
      default:
        print("Command was ${response["command"]}");
        break;
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
    idToPlay = id;
    jouerMusic(channels[id].url);
    //navigation(ctxt);
    notifyListeners();
  }

  late Channel newChannel;
  void playNext(ch) {
    if (ch + 1 > channels.length) {
      newChannel = channels.firstWhere((element) => element.id == 1);
      channels.remove(newChannel);
      channels.insert(0, newChannel);
      ch++;
    } else {
      newChannel = channels.firstWhere((element) => element.id == ch + 1);
      channels.remove(newChannel);
      channels.insert(0, newChannel);
    }

    notifyListeners();
    jouerMusic(newChannel.url);
  }

  void playPrev(ch) {
    if (ch - 1 <= 0) {
      newChannel = channels.firstWhere((element) => element.id == 1);
      channels.remove(newChannel);
      channels.insert(0, newChannel);
    } else {
      newChannel = channels.firstWhere((element) => element.id == ch - 1);
      channels.remove(newChannel);
      channels.insert(0, newChannel);
    }
    ch--;
    notifyListeners();
    jouerMusic(newChannel.url);
  }

  void jouerPrev(id) {
    if (id < 1) {
      jouerMusic(channels[1].url);
      notifyListeners();
    } else {}
    id--;
    idToPlay = id;
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
