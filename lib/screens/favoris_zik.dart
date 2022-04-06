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
          toolbarHeight: 60,
        ),
        body: RefreshIndicator(
            onRefresh: () async {},
            child: Center(child: Consumer<RadioControlNotifier>(
                builder: (context, value, child) {
              // on utilise cette ligne pour faire les appeles des fonctions
              return value.favoris.isEmpty && !value.error
                  ? const Text(
                      "Vous n'avez pas encore de favoris",
                      textAlign: TextAlign.center,
                    )
                  : value.error
                      ? Text(
                          "Oops, il y a un probleme. $value.errorMessage",
                          textAlign: TextAlign.center,
                        )
                      : ListView.builder(
                          itemCount:
                              value.favoris.isEmpty ? 0 : value.favoris.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
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
                                ),
                                title: Text(value.favoris[index].name,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)
                                    // )),
                                    ),
                                subtitle: Text(value.favoris[index].genre,
                                    style: TextStyle(
                                        color: Colors.indigo.shade500,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)
                                    // )
                                    ),
                              ),
                            );
                          });
            }))));
  }
}
