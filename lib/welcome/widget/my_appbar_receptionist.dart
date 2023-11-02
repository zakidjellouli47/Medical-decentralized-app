import 'package:flutter/material.dart';



import '../welcome_screen_receptionist.dart';

class MyAppbar_rece extends StatelessWidget {
  final String firstname;
  final String lastname;
  final String age;
  final String role;
  final String email;
  final String pass;
  final String ethereumAddress;
  const MyAppbar_rece({super.key, required this.firstname, required this.lastname, required this.age, required this.role, required this.email, required this.pass, required this.ethereumAddress});


  @override
  Widget build(BuildContext context) {
    return SafeArea(// creating  a safe area to avoid operating system interfaces
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),// padding 15 px from the left
        child: Row(// row
          children:  [
            IconButton(// arrow back to the menu of the medical department
              icon:  const Icon(Icons.arrow_back, color: Colors.black54),
              onPressed: () {
                // passing this to our root
                Navigator.push(context, MaterialPageRoute(builder: (context) =>    WelcomeScreen_Rece(firstname: firstname,lastname: lastname,age: age,role: role,email: email,pass: pass,ethereumAddress: ethereumAddress,)));
              },
            ),

          ],
        ),
      ),
    );
  }
}