import 'package:alan_application_vocal_alimente/model/channel.dart';
import 'package:alan_application_vocal_alimente/providers/radio_control_provider.dart';

//import 'package:favorite_button/favorite_button.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:alan_application_vocal_alimente/components/musical_colors.dart';

import 'detail_zik.dart';

class ListViewZik extends StatelessWidget {
  const ListViewZik({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // RadioControlNotifier radioNotifier =
    //     Provider.of<RadioControlNotifier>(context);
    /// Define the app routes

    context.read<RadioControlNotifier>().retriveChannels;
    context.read<RadioControlNotifier>().setupAlan();
    final theme = Theme.of(context);
    // ignore: unused_local_variable
    final textTheme = theme.textTheme;
    return Scaffold(
      drawer: const AppDrawer(),
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
        RefreshIndicator(
            onRefresh: () async {},
            child: Center(child: Consumer<RadioControlNotifier>(
                builder: (context, value, child) {
              // on utilise cette ligne pour faire les appeles des fonctions
              return value.channels.isEmpty && !value.error
                  ? const CircularProgressIndicator()
                  : value.error
                      ? Text(
                          "Oops, something went wrong. $value.errorMessage",
                          textAlign: TextAlign.center,
                        )
                      : ListWheelScrollView.useDelegate(
                          squeeze: 0.8,
                          itemExtent: 250,
                          onSelectedItemChanged: (index) => {
                                // value.getIdToPlay,
                                value.idToPlay = index,
                                value.audioPlayer.stop(),
                                value.chaineChoisi = value.channels[index],
                                value.ctxt = context,
                              },
                          childDelegate: ListWheelChildBuilderDelegate(
                            // childCount: channels.length,
                            childCount: value.channels.length,
                            builder: (context, index) {
                              //return Text("value.channels.length");
                              return Container(
                                decoration: BoxDecoration(
                                  border: (value.idToPlay == index)
                                      ? Border.all(
                                          color:
                                              MusicalColors.russianCioletColor,
                                          width: 6.0,
                                        )
                                      : Border.all(
                                          color: MusicalColors.lavenderBlush),
                                  color: MusicalColors.lavenderBlush,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30.0)),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          ListTile(
                                            title: Text(
                                              (value.isPlaying() &&
                                                      value.idToPlay == index)
                                                  ? "Playing now - ${value.channels[index].name.toUpperCase()} - $index"
                                                  : value.channels[index].name
                                                      .toUpperCase(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            subtitle: Text(value
                                                .channels[index].genre
                                                .toLowerCase()),
                                          ),
                                          Container(
                                            height: 150.0,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(value
                                                    .channels[index].imageUrl),
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
                          ));
            })))
      ]),
      bottomNavigationBar: BottomAppBar(
        // notchMargin: 1.0,
        color: MusicalColors.purpleMountainMajesty,
        child: SizedBox(
            height: 80,
            //data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
            child: Consumer<RadioControlNotifier>(
                builder: (context, value, child) {
              return Row(
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
                      value.isPlaying()
                          ? Icons.stop_circle_outlined
                          : Icons.play_circle_outline,
                      size: 50.0,
                    ),
                    onPressed: () {
                      if (value.isPlaying()) {
                        value.audioPlayer.stop();
                      } else {
                        value.jouerMusic(value.channels[value.idToPlay].url);
                        // print("id to play = $idToPlay");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailZik()));
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
                      value.favoris.isEmpty
                          ? Icons.favorite
                          : value.favoris
                                  .contains(value.channels[value.idToPlay])
                              ? Icons.favorite
                              : Icons.favorite_border,
                      color: value.favoris.isEmpty
                          ? null
                          : value.favoris
                                  .contains(value.channels[value.idToPlay])
                              ? Colors.red
                              : null,
                      size: 50.0,
                    ),
                    onPressed: () {
                      value.favoris.isEmpty
                          ? value.addFavoris(value.idToPlay)
                          : value.favoris
                                  .contains(value.channels[value.idToPlay])
                              ? value.favoris
                                  .remove(value.channels[value.idToPlay])
                              : value.addFavoris(value.idToPlay);
                    },
                  ),
                  const Spacer(),
                ],
              );
            })),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          createHeader(),
          createDrawerItem(),
        ],
      ),
    );
  }
}

Widget createHeader() {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage('assets/images/micro.jpg'))),
      child: Stack(children: const <Widget>[
        Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Text("Favoris",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w500))),
      ]));
}

Widget createDrawerItem() {
  return Consumer<RadioControlNotifier>(builder: (context, value, child) {
    return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8.0),
        itemCount: value.favoris.isEmpty ? 0 : value.favoris.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              //You need to make my child interactive
              onTap: () => value.jouerMusic(value.favoris[index].url),
              child: Card(
                elevation: 0,
                color: Colors.purple.shade100,
                // height: 80,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.network(
                      value.favoris[index].imageUrl,
                      height: 50,
                      width: 50,
                    ),
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(value.favoris[index].name,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12))),
                    ),
                    subtitle: Center(
                        child: Text(value.favoris[index].genre,
                            style: TextStyle(
                                color: Colors.indigo.shade500,
                                fontWeight: FontWeight.bold,
                                fontSize: 10))),
                    // trailing: IconButton(
                    //     onPressed: () {},
                    //     icon: const Icon(
                    //       value.isPlaying()?

                    //       Icons.arrow_forward_sharp,
                    //       size: 30,
                    //     ))
                  ),
                ),
              ));
        });
  });
}
