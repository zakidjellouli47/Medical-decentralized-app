import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:med/ui/hospital_needs.dart';
import 'package:provider/provider.dart';




import 'Pages/splash_screen.dart';

import 'firebase_options.dart';


Future<void> main() async {// the main class which is a future class since it's
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);// initialize the firebase
//https://firebase.flutter.dev/docs/overview/
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  runApp(
    ChangeNotifierProvider(
      create: (context) => HospitalNeeds(),
      child: const MyApp(),
    ),



  );// to run the app
}

class MyApp extends StatelessWidget {
   const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {// the builder function


    return MaterialApp(// return the material app tha contains all the widgets
      debugShowCheckedModeBanner: false,// to avoid the mobile interface in the screen
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(// to use some fonts
          Theme.of(context).textTheme,
        ),
      ),
      home: const Splash2(),//the home page (the first page that appears)

    );

}}

