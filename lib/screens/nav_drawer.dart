import 'package:alan_application_vocal_alimente/components/musical_colors.dart';
import 'package:alan_application_vocal_alimente/screens/favoris_zik.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'contact_zik.dart';
import 'help_zik.dart';
import 'list_view_zik.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/micro.jpg'))),
              child: Stack(children: const <Widget>[
                Positioned(
                    bottom: 12.0,
                    left: 16.0,
                    child: Text("Menu",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w500))),
              ])),
          ListTile(
            title: const Text("Accueil"),
            tileColor: MusicalColors.blueBell,
            leading: IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const ListViewZik()));
              },
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const ListViewZik()));
            },
          ),
          // const Divider(
          //   color: Colors.grey,
          // ),
          ListTile(
            title: const Text("Favoris"),
            tileColor: MusicalColors.languidLavender,
            leading: IconButton(
              icon: const Icon(Icons.favorite_outline_sharp),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const FavorisZik()));
              },
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const FavorisZik()));
            },
          ),
          // const Divider(
          //   color: Colors.grey,
          // ),

          ListTile(
            title: const Text("Contact"),
            tileColor: MusicalColors.blueBell,
            leading: IconButton(
              icon: const Icon(Icons.contact_page_rounded),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const ContactZik()));
              },
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const ContactZik()));
            },
          ),
          // const Divider(
          //   color: Colors.grey,
          // ),

          ListTile(
            title: const Text("Aide"),
            tileColor: MusicalColors.languidLavender,
            leading: IconButton(
              icon: const Icon(Icons.help_center),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const HelpZik()));
              },
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const HelpZik()));
            },
          ),
          // const Padding(
          //   //color: Colors.grey,
          // ),

          ListTile(
            title: const Text("Apparence"),
            tileColor: MusicalColors.lavenderBlush,
            leading: IconButton(
              icon: Icon(MyApp.themeNotifier.value == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode),
              onPressed: () {
                MyApp.themeNotifier.value =
                    MyApp.themeNotifier.value == ThemeMode.light
                        ? ThemeMode.dark
                        : ThemeMode.light;
              },
            ),
          ),
        ],
      ),
    );
  }
}
