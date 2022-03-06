import 'package:alan_voice/alan_voice.dart';
import 'package:audioplayers/audioplayers.dart';
//import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:alan_application_vocal_alimente/components/musical_colors.dart';
import 'package:alan_application_vocal_alimente/model/channel.dart';

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
  int _selectedDestination = 0;

  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    retrieveFavoris();
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
    final theme = Theme.of(context);
    // ignore: unused_local_variable
    final textTheme = theme.textTheme;
    return Scaffold(
      drawer: Drawer(
        child: ListView.separated(
            itemCount: favoris.isEmpty ? 0 : favoris.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemBuilder: (BuildContext context, int i) {
              return ListTile(
                title: Text(favoris[i].name),
              );
            }),
        // child: SizedBox(
        //     height: double.maxFinite,
        //     child: ListView.builder(
        //         itemCount: favoris.isEmpty ? 0 : favoris.length,
        //         itemBuilder: (BuildContext context, i) {
        //           return ListTile(
        //             title: Text(favoris[i].name),
        //           );
        //         })),
      ),
      //   child: ListView.builder(
      //       // Important: Remove any padding from the ListView.
      //       padding: EdgeInsets.zero,
      //       children: <Widget> [
      //         // const DrawerHeader(
      //         //   padding: EdgeInsets.all(2.0),
      //         //   decoration: BoxDecoration(
      //         //     color: Colors.blue,
      //         //   ),
      //         //   child: Text('Liste des Favoris'),
      //         // ),

      //         // const Padding(
      //         //   padding: EdgeInsets.all(16.0),
      //         //   child: Text(
      //         //     'Header',
      //         //     //style: textTheme.titleLarge,
      //         //   ),
      //         // ),
      //         const Divider(
      //           height: 1,
      //           thickness: 1,
      //         ),
      //         ListTile(
      //           leading: const Icon(Icons.favorite),
      //           title: const Text('Item 1'),
      //           selected: _selectedDestination == 0,
      //           onTap: () => selectDestination(0),
      //         ),
      //         ListTile(
      //           leading: const Icon(Icons.delete),
      //           title: const Text('Item 2'),
      //           selected: _selectedDestination == 1,
      //           onTap: () => selectDestination(1),
      //         ),
      //         ListTile(
      //           leading: const Icon(Icons.label),
      //           title: const Text('Item 3'),
      //           selected: _selectedDestination == 2,
      //           onTap: () => selectDestination(2),
      //         ),
      //         const Divider(
      //           height: 1,
      //           thickness: 1,
      //         ),
      //         const Padding(
      //           padding: EdgeInsets.all(16.0),
      //           child: Text(
      //             'Label',
      //           ),
      //         ),
      //         ListTile(
      //           leading: const Icon(Icons.bookmark),
      //           title: const Text('Item A'),
      //           selected: _selectedDestination == 3,
      //           onTap: () => selectDestination(3),
      //         ),
      //       ]),
      // ),
      appBar: AppBar(
        backgroundColor: MusicalColors.blueBell,

        // leading: Builder(
        //   builder: (BuildContext context) {
        //     return IconButton(
        //       icon: const Icon(Icons.menu),
        //       onPressed: () {
        //         Scaffold.of(context).openDrawer();
        //       },
        //       tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        //     );
        //   },
        // ),
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
              padding: const EdgeInsets.only(
                right: 20.0,
              ),
              onPressed: () {},
              icon: const Icon(
                Icons.refresh,
                size: 35.0,
              )),
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
        // notchMargin: 1.0,
        color: MusicalColors.purpleMountainMajesty,
        child: SizedBox(
          height: 80,
          //data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Spacer(
                flex: 5,
              ),
              IconButton(
                tooltip: 'play',
                padding: const EdgeInsets.only(bottom: 20.0),
                color: Colors.white,
                icon: Icon(
                  isPlaying
                      ? Icons.stop_circle_outlined
                      : Icons.play_circle_outline,
                  size: 50.0,
                ),
                onPressed: () {
                  if (isPlaying) {
                    audioPlayer.stop();
                  } else {
                    jouerMusic(channels[idToPlay].uri);
                    // print("id to play = $idToPlay");
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
                padding: const EdgeInsets.only(left: 10.0, bottom: 20.0),
                color: Vx.white,
                icon: Icon(
                  favoris.contains(channels[idToPlay])
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color:
                      favoris.contains(channels[idToPlay]) ? Colors.red : null,
                  size: 50.0,
                ),
                onPressed: () {
                  favoris.contains(channels[idToPlay])
                      ? favoris.remove(channels[idToPlay])
                      : favoris.add(channels[idToPlay]);
                },
              ),

              // FavoriteButton(
              //   //padding: const EdgeInsets.only(left: 10.0, bottom: 20.0),
              //   valueChanged: (_isFavorite) {
              //     favoris.add(channels[idToPlay]);
              //     print('Is Favorite $_isFavorite)');
              //   },
              // ),

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

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }

  void retrieveFavoris() {
    setState(() {
      bool _isFavorite = false;
      if (favoris.isEmpty) {
      } else {
        //favoris =
      }
    });
  }
}
