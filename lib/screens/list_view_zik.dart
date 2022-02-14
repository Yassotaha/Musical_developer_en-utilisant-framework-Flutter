import 'package:alan_application_vocal_alimente/components/musical_colors.dart';
import 'package:alan_application_vocal_alimente/model/channel.dart';
import 'package:alan_voice/alan_voice.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

import 'detail_zik.dart';

class ListViewZik extends StatefulWidget {
  const ListViewZik({Key? key}) : super(key: key);

  @override
  _ListViewZikState createState() => _ListViewZikState();
}

class _ListViewZikState extends State<ListViewZik> {
  List<Channel> channels = [];
  List<Channel> favoris = [];
  late Channel selectedChannel;
  late int idToPlay = 0;
  bool isPlaying = false;

  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    retriveChannels();
    setupAlan();
    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {
        // idToPlay = event.index;
        if (event == PlayerState.PLAYING) {
          isPlaying = true;
        } else {
          isPlaying = false;
        }
      });
    });
  }

  jouerMusic(String url) {
    // print(selectedChannel.name);
    setState(() {
      audioPlayer.play(url);
      selectedChannel = channels.firstWhere((element) => element.uri == url);
      // idToPlay = selectedChannel.channelId;
    });
  }

  setupAlan() {
    AlanVoice.addButton(
        "e95ee1af058323d2a7f740b2a4fa4e5c2e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_RIGHT);
    //AlanVoice.callbacks.add((command) => _handleCommand(command.data));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const Drawer(),
      appBar: AppBar(
        backgroundColor: MusicalColors.blueBell,
        title: "Musical"
            .text
            .xl4
            .bold
            .white
            .make()
            .shimmer(primaryColor: Colors.yellow, secondaryColor: Colors.pink),
        //backgroundColor: Colors.transparent,
        centerTitle: true,
        // elevation: 0.0,
        actions: <Widget>[
          // ignore: prefer_const_constructors
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.refresh,
                size: 30.0,
              ))
        ],
        toolbarHeight: 60,
      ),
      body: Stack(children: [
        VxAnimatedBox()
            // .size(context.screenWidth, context.screenHeight)
            .withGradient(
              const LinearGradient(
                colors: [
                  MusicalColors.russianCioletColor,
                  MusicalColors.lavenderBlush,
                  MusicalColors.languidLavender,
                  MusicalColors.blueBell,
                  MusicalColors.purpleMountainMajesty,
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            )
            .make(),
        ListWheelScrollView.useDelegate(
            squeeze: 0.8,
            itemExtent: 250,
            onSelectedItemChanged: (index) => {
                  audioPlayer.stop(),
                  setState(() {
                    idToPlay = index;
                    if (kDebugMode) {
                      print(index);
                    }
                  })
                },
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: channels.length,
              builder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    border: (idToPlay == index)
                        ? Border.all(
                            color: MusicalColors.russianCioletColor,
                            width: 6.0,
                          )
                        : Border.all(color: MusicalColors.lavenderBlush),
                    color: MusicalColors.lavenderBlush,
                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                (isPlaying && idToPlay == index)
                                    ? "Playing now - ${channels[index].name.toUpperCase()} - $index"
                                    : channels[index].name.toUpperCase(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle:
                                  Text(channels[index].genre.toLowerCase()),
                            ),
                            Container(
                              height: 150.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(channels[index].imageUrl),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ))
      ]),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5.0,
        color: MusicalColors.purpleMountainMajesty,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Row(
            children: <Widget>[
              const Spacer(),
              IconButton(
                tooltip: 'Open navigation menu',
                icon: const Icon(
                  Icons.menu,
                  size: 40.0,
                ),
                onPressed: () {},
              ),
              const Spacer(
                flex: 3,
              ),
              IconButton(
                tooltip: 'play',
                icon: Icon(
                  isPlaying
                      ? Icons.stop_circle_outlined
                      : Icons.play_circle_outline,
                  size: 40.0,
                ),
                onPressed: () {
                  if (isPlaying) {
                    audioPlayer.stop();
                  } else {
                    jouerMusic(channels[idToPlay].uri);
                    print("id to play = $idToPlay");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailZik(
                                idToPlay, audioPlayer, channels, isPlaying)));
                  }
                },
              ),
              const Spacer(
                flex: 3,
              ),
              IconButton(
                tooltip: 'Favorite',
                icon: const Icon(
                  Icons.favorite_outline,
                  size: 40.0,
                ),
                onPressed: () {},
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  retriveChannels() async {
    // final chane = rootBundle.load("assets/channels/channel.json").toString();
    final channelJson =
        await rootBundle.loadString("assets/channels/channel.json");
    channels = ChannelList.fromJson(channelJson).radios;
    setState(() {});
  }
}
