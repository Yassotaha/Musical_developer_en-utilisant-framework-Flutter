import 'package:alan_application_vocal_alimente/components/musical_colors.dart';
import 'package:alan_application_vocal_alimente/model/channel.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

class ListViewZik extends StatefulWidget {
  const ListViewZik({Key? key}) : super(key: key);

  @override
  _ListViewZikState createState() => _ListViewZikState();
}

class _ListViewZikState extends State<ListViewZik> {
  List<Channel> channels = [];
  late Channel selectedChannel;
  bool isPlaying = false;

  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    retriveChannels();
    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
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
          IconButton(onPressed: () {}, icon: Icon(Icons.refresh))
        ],
        toolbarHeight: 60,
      ),
      body: Stack(children: [
        VxAnimatedBox()
            // .size(context.screenWidth, context.screenHeight)
            .withGradient(
              LinearGradient(
                colors: [
                  MusicalColors.mPurpleColor,
                  MusicalColors.mPurpleLColor,
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            )
            .make(),
        // AppBar(
        //   title: "Musical".text.xl4.bold.white.make().shimmer(
        //       primaryColor: Colors.yellow, secondaryColor: Colors.pink),
        //   backgroundColor: Colors.transparent,
        //   centerTitle: true,
        //   elevation: 0.0,
        //   actions: <Widget>[
        //     // ignore: prefer_const_constructors
        //     IconButton(onPressed: () {}, icon: Icon(Icons.refresh))
        //   ],
        // ).h(100).p16(),
        ListWheelScrollView.useDelegate(
            itemExtent: 250,
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: channels.length,
              builder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade200,
                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(isPlaying
                                  ? "Playing now - ${channels[index].name.toUpperCase()}"
                                  : channels[index].name.toUpperCase()),
                              subtitle:
                                  Text(channels[index].genre.toLowerCase()),
                            ),
                            Container(
                              height: 150.0,
                              decoration: BoxDecoration(
                                // color: Colors.red.shade200,

                                image: DecorationImage(
                                  image: NetworkImage(channels[index].imageUrl),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              child: GestureDetector(
                                onDoubleTap: () {
                                  jouerMusic(channels[index].uri);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CupertinoButton(
                              // ignore: prefer_const_constructors
                              child: Icon(
                                CupertinoIcons.heart,
                                size: 50,
                                color: Colors.white,
                              ),
                              onPressed: () {}),
                          // ignore: prefer_const_constructors
                          // Divider(
                          //   height: 2.0,
                          //   color: Colors.white,
                          // ),
                          CupertinoButton(
                              // ignore: prefer_const_constructors
                              child: Icon(
                                isPlaying
                                    ? CupertinoIcons.stop_circle
                                    : CupertinoIcons.play_circle,
                                size: 50,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                if (isPlaying) {
                                  audioPlayer.stop();
                                } else {
                                  jouerMusic(channels[index].uri);
                                }
                              }),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ))
      ]),
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
