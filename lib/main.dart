// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

//import 'package:alan_application_vocal_alimente/components/musical_colors.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/list_view_zik.dart';

void main() {
  // SystemChrome.setSystemUIOverlayStyle(
  //     SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Musical',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: GoogleFonts.aBeeZee().fontFamily,
        ),
        home: ListViewZik(),
      );
}
