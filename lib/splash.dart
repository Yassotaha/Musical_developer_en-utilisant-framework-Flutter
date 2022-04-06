import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'components/musical_colors.dart';
import 'screens/list_view_zik.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    gotoHome();
  }

  gotoHome() async {
    await Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const ListViewZik()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        (Center(
          child: const Text(
            "Musical",
          ).text.xl6.bold.white.make().shimmer(
              primaryColor: Colors.yellow, secondaryColor: Colors.pink),
        )),
      ]),
    );
  }
}
