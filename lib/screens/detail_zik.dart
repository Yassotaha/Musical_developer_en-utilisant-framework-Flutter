import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../components/musical_colors.dart';
import '../model/channel.dart';

class DetailZik extends StatefulWidget {
  final int id;
  final AudioPlayer audioPlayer;
  final List<Channel> channels;
  final bool isPlaying;
  //const DetailZik({Key? key, this.idPlay}) : super(key: key);
  const DetailZik(this.id, this.audioPlayer, this.channels, this.isPlaying,
      {Key? key})
      : super(key: key);

  @override
  _DetailZikState createState() =>
      // ignore: no_logic_in_create_state
      _DetailZikState(id, audioPlayer, channels, isPlaying);
}

class _DetailZikState extends State<DetailZik> {
  int idPlay;
  AudioPlayer audioPlayer;
  List<Channel> channels;
  bool isPlaying;
  _DetailZikState(this.idPlay, this.audioPlayer, this.channels, this.isPlaying);
  int cle = 0;
  // Quelque Variables
  //bool playing = true; // aucune radio
  IconData playBtn = Icons.play_arrow;
  //List<Channel> channels = [];
  // late int idPlay;

  @override
  void initState() {
    super.initState();

    //retriveChannels();
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

  // retriveId(int id) {
  //   setState(() {
  //     idPlay = id;
  //   });
  // }

  // get idPlay => null;

  // Ici pour declarer les variable qu'on va utiliser pour notre music player
  //AudioPlayer _player;
  //AudioPlayer cache;

  // retriveChannels() async {
  //   // final chane = rootBundle.load("assets/channels/channel.json").toString();
  //   final channelJson =
  //       await rootBundle.loadString("assets/channels/channel.json");
  //   channels = ChannelList.fromJson(channelJson).radios;
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MusicalColors.blueBell,
          title: "Musical".text.xl4.bold.white.make().shimmer(
              primaryColor: Colors.yellow, secondaryColor: Colors.pink),
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

        // Ici on cree l'interface principale de l'application
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
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue[800]!,
                    Colors.blue[200]!,
                  ]),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 48.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // On va ajouter des texts pour les titres
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(
                      channels[cle]
                          .genre
                          .toUpperCase(), // recuepere le genre de chaque radio
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 38.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Text(
                      "Ecoute Ta radio préférée",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 24.0,
                  ),

                  //Let's add the music cover
                  Center(
                    child: Container(
                      width: 280.0,
                      height: 280.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          image: DecorationImage(
                            image: NetworkImage(channels[cle]
                                .imageUrl), // recuepere les images de chaque radio
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 18.0,
                  ),
                  Center(
                    child: Text(
                      channels[cle]
                          .name
                          .toUpperCase(), // recuepere les noms de chaque radio
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),

                  Expanded(
                      child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // on commence par ajouter le controlleur
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              iconSize: 45.0,
                              color: Colors.blue,
                              onPressed: () {
                                if (idPlay > 0) {
                                  cle = idPlay - 1;
                                }

                                audioPlayer.play(channels[cle].url);
                              },
                              icon: const Icon(
                                Icons
                                    .skip_previous, // Button pour une radio precedente
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                size: 40.0,
                              ),
                              iconSize: 62.0,
                              color: Colors.blue[800],
                              onPressed: () {
                                // Ici sont les functionalites pour le button jouer ou Play
                                if (isPlaying) {
                                  //playBtn = Icons.pause;
                                  audioPlayer.stop();
                                  //isPlaying = false;
                                } else {
                                  //playBtn = Icons.play_arrow;

                                  audioPlayer.play(channels[cle].url);

                                  //isPlaying = true;
                                }
                              },
                            ),
                            IconButton(
                              iconSize: 45.0,
                              color: Colors.blue,
                              onPressed: () {
                                if (idPlay < 49) {
                                  cle = idPlay + 1;
                                }
                                audioPlayer.play(channels[cle].url);
                              },
                              icon: const Icon(
                                Icons
                                    .skip_next, // Button pour une radio suivante
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ))
                ],
              ),
            ),
          ),
        ]));
  }
}
