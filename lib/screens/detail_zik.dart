import 'package:alan_application_vocal_alimente/providers/radio_control_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../components/musical_colors.dart';

class DetailZik extends StatelessWidget {
  const DetailZik({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RadioControlNotifier>(builder: (context, value, child) {
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
                        value.channels[value.idToPlay].genre
                            .toUpperCase(), // recuepere le genre de chaque radio
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
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
                              image: NetworkImage(value.channels[value.idToPlay]
                                  .imageUrl), // recuepere les images de chaque radio
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 18.0,
                    ),
                    Center(
                      child: Text(
                        value.channels[value.idToPlay].name
                            .toUpperCase(), // recuepere les noms de chaque radio
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
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
                                  value.jouerPrev(value.idToPlay);
                                },
                                icon: const Icon(
                                  Icons
                                      .skip_previous, // Button pour une radio precedente
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  value.isPlaying()
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  size: 40.0,
                                ),
                                iconSize: 62.0,
                                color: Colors.blue[800],
                                onPressed: () {
                                  // Ici sont les functionalites pour le button jouer ou Play
                                  if (value.isPlaying()) {
                                    value.audioPlayer.stop();
                                  } else {
                                    //playBtn = Icons.play_arrow;
                                    value.jouerMusic(
                                        value.channels[value.idToPlay].url);

                                    //isPlaying = true;
                                  }
                                },
                              ),
                              IconButton(
                                iconSize: 45.0,
                                color: Colors.blue,
                                onPressed: () {
                                  value.jouerNext(value.idToPlay);
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
    });
  }
}
