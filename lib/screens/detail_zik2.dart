//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppMusique(),
    );
  }
}

class AppMusique extends StatefulWidget {
  const AppMusique({Key? key}) : super(key: key);

  @override
  _AppMusiqueState createState() => _AppMusiqueState();
}

class _AppMusiqueState extends State<AppMusique> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Ici on cree l'interface principale de l'application
      body: Container(
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
          padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              // On va ajouter des texts pour les titres
              Text(
                "Les Beats de la Musique",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 38.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Ecoute Ta musique prefere",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
