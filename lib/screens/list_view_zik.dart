import 'package:alan_application_vocal_alimente/components/musical_colors.dart';
import 'package:alan_application_vocal_alimente/model/channel.dart';
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
  @override
  void initState() {
    super.initState();
    retriveChannels();
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
                return VxBox(child: ZStack([]))
                    .bgImage(DecorationImage(
                        image: NetworkImage(channels[index].imageUrl),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.white.withOpacity(0.3),
                            BlendMode.colorBurn)))
                    .withRounded(value: 10.0)
                    .make();
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
