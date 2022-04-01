import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../components/musical_colors.dart';
import 'nav_drawer.dart';

class HelpZik extends StatelessWidget {
  const HelpZik({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
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
      body: const Text("aide"),
    );
  }
}
