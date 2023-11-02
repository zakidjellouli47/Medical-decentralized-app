import 'package:flutter/material.dart';
import 'package:med/constant.dart';
import 'package:med/welcome/gastrology_patient.dart';
import 'package:med/welcome/heart_department_patient.dart';
import 'package:med/welcome/reserve_screen_patient.dart';
import 'package:med/widget/header_logo.dart';
import 'package:med/widget/my_header.dart';
import '../screens/dashboard_patient.dart';

class WelcomeScreen_Patient extends StatelessWidget {
  final String firstname;
  final String lastname;
  final String age;
  final String role;
  final String email;
  final String pass;
  final String ethereumAddress;
  const WelcomeScreen_Patient({super.key, required this.firstname, required this.lastname, required this.age, required this.role, required this.email, required this.pass, required this.ethereumAddress});



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        backgroundColor: Colors.redAccent, //background color of app bar
        elevation: 0,// to make the ui more bright and have some blury shadows
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black54),// going back the admin home menu
          onPressed: () {
            // passing this to our root
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  Dashboard_Patient(firstname: firstname,lastname: lastname,age: age,role: role,email: email,pass: pass,ethereumAddress: ethereumAddress,)));
          },
        ),
      ),
      body: Column( // column widget
        children: [ // widgets children of the column
          MyHeader(//calling my header.dart
            height: 200,// height of the header
            imageUrl: 'assets/images/welcome.png',
            child: Column(// calling the child widget we declared in the my header class
              children: const [
                HeaderLogo(),// calling the header logo
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 20,
                    color: mTitleTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(// space between the texts
                  height: 12,
                ),
                Text(
                  'By consulting our health departments,\n you can set your appointments with the doctors you like ',
                  textAlign: TextAlign.center,// text in the center
                  style: TextStyle(
                      color: Colors.white// color of the text
                  ),
                ),
                Spacer(),// provides space between widgets

              ],
            ),
          ),
          Expanded(// fill the rest of the screen
            child: Container(
              width: double.infinity,// take the whole width
              decoration: const BoxDecoration(// decoration of the box container
                gradient: LinearGradient(// coloring the expended widget
                  colors: [mBackgroundColor, mSecondBackgroundColor],// the colors
                  begin: Alignment.topCenter,// the top center of the body will get the first color
                  end: Alignment.bottomCenter,// the bottom center of the will get the second color
                ),
              ),
              child: Column(// column
                children: [// children widgets of the column
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),//padding only from left
                    child: Row(//row

                      children: const [// children widgets of the row
                        Text(
                          'Our Health\nDepartments',
                          style: TextStyle(
                            color: mTitleTextColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(// sized box for white space
                    height: 12,
                  ),

                  Column(// column

                    children: [// children widgets of the column
                      //https://www.youtube.com/watch?v=ZFCGk8M-uBs
                      GestureDetector(// gesture detector to tap on  the route and redirect to the department
                        onTap: () {// when clicking in any place of  image , it will direct us to the medical department

                          showDialog(// welcome dialogue
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Result'),
                              content: const Text('Welcome to our Department'),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Go Back')),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                          fullscreenDialog: true,
                                          builder: (context) =>  ReserveScreen_Patient(firstname: firstname,lastname: lastname,age: age,role: role,email:email,pass: pass,ethereumAddress: ethereumAddress)));
                                    },
                                    child: const Text('ok'))
                              ],
                            ),
                          );
                        }, // Image tapped
                        child: Image.asset(// image asset of the general practice department
                          'assets/images/general_practice.png',

                          // Fixes border issues
                          width: 110.0,//size of the width
                          height: 110.0,// size of the heigh

                        ),



                      ),
                      const SizedBox(// space between the image and text
                        height: 4,
                      ),
                      const Text(// text of the image asset
                          'General'
                      )



                    ],
                  ),
                  const SizedBox(// space between the column and the row
                    height: 12,// 12 px height space
                  ),
                  Row(// row
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly, // spece between the widgets is even or equal
                    children:  [//children widgets of the column

                      GestureDetector(//gesture detector to tap on  the route and redirect to the department
                        child: Column(// column
                          children: [

                            Image.asset(
                              'assets/images/gastrology.png',// image asset of the gastrology depert



                              // Fixes border issues
                              width: 110.0,// size of width
                              height: 110.0,// size of height

                            ),
                            const SizedBox( // space between the image and text
                              height: 15,
                            ),
                            const Text( //text
                                'Gastrology'

                            ),
                          ],
                        ),


                        onTap: () {// when clicking in any place of  image , it will direct us to the medical department

                          showDialog(// welcome dialogue
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Result'),
                              content: const Text('Welcome to our Department'),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Go Back')),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                          fullscreenDialog: true,
                                          builder: (context) =>  GastroScreen_Patient(firstname: firstname,lastname: lastname,age: age,role: role,email: email,pass: pass,ethereumAddress: ethereumAddress,)));
                                    },
                                    child: const Text('ok'))
                              ],
                            ),
                          );
                        },






                      ),

                      GestureDetector(//gesture detector to tap on  the route and redirect to the department
                        child: Column(// column
                          children: [//children of the column

                            Image.asset(
                              'assets/images/specialist.png',// image asset of the cardiology depert



                              // Fixes border issues
                              width: 110.0,// size of the width
                              height: 110.0,// size of the height

                            ),
                            const SizedBox(// space between the image and text
                              height: 15,// space height of 15 px
                            ),
                            const Text(
                                'Cardiology and lung diseases'// text

                            ),
                          ],
                        ),


                        onTap: () {// when clicking in any place of  image , it will direct us to the medical department

                          showDialog(// welcome dialogue
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Result'),
                              content: const Text('Welcome to our Department'),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Go Back')),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                          fullscreenDialog: true,
                                          builder: (context) =>  HeartScreen_Patient(firstname: firstname,lastname: lastname,age: age,role: role,email: email,pass: pass,ethereumAddress: ethereumAddress,)));
                                    },
                                    child: const Text('ok'))
                              ],
                            ),
                          );
                        },






                      ),




                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
