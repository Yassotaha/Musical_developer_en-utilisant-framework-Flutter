// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

//import 'package:alan_application_vocal_alimente/components/musical_colors.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'providers/radio_control_provider.dart';
import 'screens/contact_zik.dart';
import 'screens/detail_zik.dart';
import 'screens/favoris_zik.dart';
import 'screens/help_zik.dart';
import 'screens/list_view_zik.dart';

// void main() {
//   // SystemChrome.setSystemUIOverlayStyle(
//   //     SystemUiOverlayStyle(statusBarColor: Colors.transparent));
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Musical',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         fontFamily: GoogleFonts.aBeeZee().fontFamily,
//       ),
//       home: ChangeNotifierProvider(
//           create: (context) => RadioControlNotifier(),
//           builder: ((context, child) {
//             return ListViewZik();
//           })),
//       // initialRoute: '/',
//       // routes: {
//       //   '/': ((context) => ListViewZik()),
//       // },
//     );
//   }
// }

void main() {
  // SystemChrome.setSystemUIOverlayStyle(
  //     SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => RadioControlNotifier()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Musical',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              fontFamily: GoogleFonts.aBeeZee().fontFamily,
            ),
            darkTheme: ThemeData.dark(),
            themeMode: currentMode,
            initialRoute: '/',
            routes: {
              '/': ((context) => ListViewZik()),
              '/second': ((context) => DetailZik()),
              '/favoris': ((context) => FavorisZik()),
              '/contact': ((context) => ContactZik()),
              '/aide': ((context) => HelpZik()),
            },
          );
        });
  }
}
