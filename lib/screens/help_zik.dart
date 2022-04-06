import 'package:accordion/accordion.dart';
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
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            )
            .make(),
        // const Text(
        //     "Dans cette section vous trouverez le support pour l'utilisation de l'application et aussi un petit mot à propos de nous."),
        Accordion(
          maxOpenSections: 1,
          // headerTextStyle: const TextStyle(
          //     color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
          leftIcon: const Icon(Icons.audiotrack, color: Colors.white),
          children: [
            AccordionSection(
              isOpen: true,
              header: const Text('Introduction',
                  style: TextStyle(color: Colors.white, fontSize: 17)),
              content: const Text(
                  'Cette application vous permet de lire les differents radios disponible dans l\'application. Dans le menu vous aurez un lien vers les radios que vous preferez, vous aurez aussi la possibilité de changer l\'apparence de l\'application '),
            ),
            AccordionSection(
              isOpen: true,
              header: const Text('Lire Radio',
                  style: TextStyle(color: Colors.white, fontSize: 17)),
              content: const Text(
                  'Choisissez la radio voulu en défilant la liste jusqu\'à ce que ce dernier soit encadré d\'une ligne bleu. puis appuyer sur la touche play pour jouer une radio. vous pouvez aussi appuyer sur l\'icon en coeur pour l\'ajouter dans vos favoris'),
            ),
            AccordionSection(
              isOpen: true,
              header: const Text('Commandes vocales',
                  style: TextStyle(color: Colors.white, fontSize: 17)),
              content: const Text(
                  "Utiliser les commandes vocales suivant pour manipuler l'application: Play , Next, Previous. Ces commandes sont aussi disponible en francais. Joue, Suivant et Précédent"),
            ),
            // AccordionSection(
            //   isOpen: true,
            //   header: const Text('A propos de nous',
            //       style: TextStyle(color: Colors.white, fontSize: 17)),
            //   content: Icon(Icons.airplay, size: 70, color: Colors.green[200]),
            // ),
          ],
        ),
        // Center(
        //   child: const Text(
        //     "Musical",
        //   ).text.xl6.bold.white.make().shimmer(
        //       primaryColor: Colors.yellow, secondaryColor: Colors.pink),
        // ),
      ]),
    );
  }
}
