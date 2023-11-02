import 'dart:async';

import 'package:flutter/material.dart';
import 'package:med/ui/Pages/login_page.dart';

class Splash2 extends StatefulWidget {
  const Splash2({Key? key}) : super(key: key);

  @override
  State<Splash2> createState() => _Splash2State();
}

class _Splash2State extends State<Splash2> { // create the splash screen that pops up first in the app
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 10),// after 10 seconds duration of the splash screen move to the login page
        () => Navigator.of(context)
            .pushReplacement(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) =>  const LoginPage())));

  }

  @override
  Widget build(BuildContext context) {// builder function to build the ui
    return Scaffold(// scaffold that creates the app screen
      body: Center(// body is in the center
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,// put the column in the center of centers
          children: [
            // children of the columns
            Container(// container
              width: 250,// width of the container
              height: 250,// height of the container
              decoration: BoxDecoration(
                color: Colors.red.shade50,// the color of the shadow
                borderRadius: BorderRadius.circular(500),// circular with 60 value
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 50,// radius of the shadow
                    offset: const Offset(
                        0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(// padding of the image
                padding: const EdgeInsets.all(8.0),// padding the image from 16 px in all from the container
                child: ClipRRect(// clip rect to have your own shape of the image
                  borderRadius: BorderRadius.circular(500),//  boreder of the image
                  child: Image.asset(
                    'assets/Icons/medical.jpg',// our splash image
                    fit: BoxFit.cover,// cover the image in the box
                  ),
                ),
              ),
            ),
            const SizedBox(// white space
              height: 20,
            ),
            const Text( // text
              "Smart Hospital Management System",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox( //text
              height: 10,
            ),
            const Text(
              "Manage Your Medical Records",
            ),
          ],
        ),
      ),
    );
  }
}
