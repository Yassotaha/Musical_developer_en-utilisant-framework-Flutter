import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../components/musical_colors.dart';
import '../providers/radio_control_provider.dart';
import 'nav_drawer.dart';

class FavorisZik extends StatelessWidget {
  const FavorisZik({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const NavDrawer(),
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
        body: RefreshIndicator(
            onRefresh: () async {},
            child: Center(child: Consumer<RadioControlNotifier>(
                builder: (context, value, child) {
              // on utilise cette ligne pour faire les appeles des fonctions
              return value.favoris.isEmpty && !value.error
                  ? const CircularProgressIndicator()
                  : value.error
                      ? Text(
                          "Oops, il y a un probleme. $value.errorMessage",
                          textAlign: TextAlign.center,
                        )
                      : ListView.builder(
                          //shrinkWrap: true,
                          // padding: const EdgeInsets.all(8.0),
                          itemCount:
                              value.favoris.isEmpty ? 0 : value.favoris.length,
                          itemBuilder: (BuildContext context, int index) {
                            // return GestureDetector(
                            //     //You need to make my child interactive
                            //     onTap: () => value.jouerMusic(value.favoris[index].url),
                            //     child:
                            return Card(
                              // elevation: 0,
                              // color: Colors.purple.shade100,
                              // height: 80,

                              //padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                onTap: () {
                                  value.jouerMusic(value.favoris[index].url);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Vous écoutez maintenant ${value.favoris[index].name}'),
                                    ),
                                  );
                                },
                                leading: Image.network(
                                  value.favoris[index].imageUrl,
                                  // height: 100,
                                  // width: 100,
                                ),
                                title:
                                    // Padding(
                                    // padding: const EdgeInsets.all(8.0),
                                    // child: Center(
                                    // child:
                                    Text(value.favoris[index].name,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)
                                        // )),
                                        ),
                                subtitle:
                                    // Center(
                                    // child:
                                    Text(value.favoris[index].genre,
                                        style: TextStyle(
                                            color: Colors.indigo.shade500,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12)
                                        // )
                                        ),

                                // trailing: IconButton(
                                //   tooltip: 'play',
                                //   color: Colors.white,
                                //   icon: Icon(
                                //     value.isPlaying()
                                //         ? Icons.stop_circle_outlined
                                //         : Icons.play_circle_outline,
                                //   ),
                                //   onPressed: () {
                                //     if (value.isPlaying()) {
                                //       value.audioPlayer.stop();
                                //     } else {
                                //       value.jouerMusic(
                                //           value.favoris[value.idToPlay].url);
                                //       // print("id to play = $idToPlay");
                                //       Navigator.push(
                                //           context,
                                //           MaterialPageRoute(
                                //               builder: (context) =>
                                //                   const DetailZik()));
                                //     }
                                //   },
                                // ),
                              ),
                            );
                          });
            })))

        // children: <Widget>[
        //   Container(
        //       margin: EdgeInsets.zero,
        //       padding: EdgeInsets.zero,
        //       decoration: const BoxDecoration(
        //           image: DecorationImage(
        //               fit: BoxFit.fill,
        //               image: AssetImage('assets/images/micro.jpg'))),
        //       child: Stack(children: const <Widget>[
        //         Positioned(
        //             bottom: 12.0,
        //             left: 16.0,
        //             child: Text("Favoris",
        //                 style: TextStyle(
        //                     color: Colors.white,
        //                     fontSize: 30,
        //                     fontWeight: FontWeight.w500))),
        //       ])),
        // Consumer<RadioControlNotifier>(builder: (context, value, child) {
        //   return ListView.builder(
        //       shrinkWrap: true,
        //       padding: const EdgeInsets.all(8.0),
        //       itemCount: value.favoris.isEmpty ? 0 : value.favoris.length,
        //       itemBuilder: (BuildContext context, int index) {
        //         // return GestureDetector(
        //         //     //You need to make my child interactive
        //         //     onTap: () => value.jouerMusic(value.favoris[index].url),
        //         //     child:
        //         return Card(
        //           // elevation: 0,
        //           // color: Colors.purple.shade100,
        //           // height: 80,

        //           //padding: const EdgeInsets.all(8.0),
        //           child: ListTile(
        //             leading: Image.network(
        //               value.favoris[index].imageUrl,
        //               height: 50,
        //               width: 50,
        //             ),
        //             title: Padding(
        //               padding: const EdgeInsets.all(8.0),
        //               child: Center(
        //                   child: Text(value.favoris[index].name,
        //                       style: const TextStyle(
        //                           color: Colors.black,
        //                           fontWeight: FontWeight.bold,
        //                           fontSize: 12))),
        //             ),
        //             subtitle: Center(
        //                 child: Text(value.favoris[index].genre,
        //                     style: TextStyle(
        //                         color: Colors.indigo.shade500,
        //                         fontWeight: FontWeight.bold,
        //                         fontSize: 10))),
        //             // trailing: IconButton(
        //             //     onPressed: () {},
        //             //     icon: const Icon(
        //             //       value.isPlaying()?

        //             //       Icons.arrow_forward_sharp,
        //             //       size: 30,
        //             //     ))
        //           ),
        //         );
        //       });
        // }),
        // ],
        );
  }
}
