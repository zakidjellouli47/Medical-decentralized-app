import 'package:flutter/material.dart';
import 'package:med/welcome/welcome_screen_patient.dart';



class MyAppbar_Patient extends StatelessWidget {
  final String firstname;
  final String lastname;
  final String age;
  final String email;
  final String pass;
  final String role;
  final String ethereumAddress;
  const MyAppbar_Patient({super.key, required this.firstname, required this.lastname,required this.age, required this.email, required this.ethereumAddress, required this.pass, required this.role});

  @override
  Widget build(BuildContext context) {
    return SafeArea(// creating  a safe area to avoid operating system interfaces
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),// padding 15 px from the left
        child: Row(
          children:  [
            IconButton(// arrow back to the menu of the medical department
              icon:  const Icon(Icons.arrow_back, color: Colors.black54),
              onPressed: () {
                // passing this to our root
                Navigator.push(context, MaterialPageRoute(builder: (context) =>    WelcomeScreen_Patient(firstname: firstname,lastname: lastname,age: age,email: email,ethereumAddress: ethereumAddress,pass: pass,role: role,)));
              },
            ),

          ],
        ),
      ),
    );
  }
}