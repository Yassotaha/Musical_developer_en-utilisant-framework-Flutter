import 'package:flutter/widgets.dart';

import 'list_view_zik.dart';

class Methode_BackEnd extends StatelessWidget {
// Une methode pour utiliser les commandes de l'API de Alan
  _handleCommand(Map<String, dynamic> response) {
    switch (response["command"]) {
      case "play":
        //_ListViewZikState.jouerMusic()
        break;
      default:
    }
  }

  final ListViewZik ani = new ListViewZik();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        // onTap:()=> ani.,
        );
  }
}
