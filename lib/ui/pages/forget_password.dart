

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:med/recover_password_screens/admin.dart';

import 'package:med/ui/Pages/login_page.dart';

import '../../recover_password_screens/director.dart';
import '../../recover_password_screens/doctor.dart';
import '../../recover_password_screens/receptionist.dart';





class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});



  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}
class _ForgetPasswordState extends State<ForgetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<
      FormState>(); // create the form key to validate a form
  TextEditingController user_name = TextEditingController(); // create the text controllers
 TextEditingController private_key = TextEditingController();




  late String UID ,pass, role, firstname, lastname; // create string variables




  void loginProcess() async {
    // create the login process function

    if (_formKey.currentState!.validate()) { // if the form is validated


      final response = await http.post(
          Uri.parse("http://localhost/flutter-login-signup/login_private_key.php"),
          body: {

            "private_key": private_key.text
          }); // create a final response variable and store  in it the wait for the
      // http request to call the code in the wamp server of the login and the body of data which is the email and the password

      var dataUser = json.decode(response.body); // store the decoded json which is the response in the data user

      if (dataUser.length < 1) {
        // if data user is empty or 0 this means there is no objects in the data
        setState(() {
          showDialog( // show an error dialogue saying invalid login
            context: context,
            builder: (context) =>
                AlertDialog(
                  title: const Text('Result'),
                  content: const Text('Invalid login details'),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Go Back')),

                  ],
                ),
          );
        });
      }  else{ // if the data isn't empty or false which means dataUser.length > 1
    setState(() {
    //take the email from the data user and since it's an array is zero indexed we put 0 inside the dateuser
    pass = dataUser[0]["pass"];
    role = dataUser[0]["role"];
    firstname = dataUser[0]["firstname"];

    lastname = dataUser[0]["lastname"];
UID = dataUser[0]["UID"];

    });

   // if the user is a patient then move to the patient home page
    if (role == "patient") {
    showDialog(
    context: context,
    builder: (context) =>
    AlertDialog(
    title: const Text('Result'),
    content: const Text('Login successful'),
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
    builder: (context) => RecoverPassword(firstname:firstname,lastname: lastname,role: role,pass: pass, UID: UID,)));
    },
    child: const Text('ok'))
    ],
    ),
    );
    }

    if (role == "receptionist") {
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: const Text('Result'),
              content: const Text('Login successful'),
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
                          builder: (context) => RecoverPassword_r(firstname:firstname,lastname: lastname,role: role,pass: pass, UID: UID,)));
                    },
                    child: const Text('ok'))
              ],
            ),
      );
    }

    if (role == "doctor") {
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: const Text('Result'),
              content: const Text('Login successful'),
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
                          builder: (context) => RecoverPassword_d(firstname:firstname,lastname: lastname,role: role,pass: pass, UID: UID,)));
                    },
                    child: const Text('ok'))
              ],
            ),
      );
    }
    if (role == "director") {
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: const Text('Result'),
              content: const Text('Login successful'),
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
                          builder: (context) => RecoverPassword_dir(firstname:firstname,lastname: lastname,role: role,pass: pass, UID: UID,)));
                    },
                    child: const Text('ok'))
              ],
            ),
      );
    }
    }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black38,
          onPressed: () {
            // passing this to our root
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 60, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: Image.asset("assets/pass.jpg"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Recover your password now",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Please enter the private key associated with your meta mask account and we will send you a link to it with instructions for restoring your account.",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: private_key,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: "Private key",
                            labelStyle: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 60,
                          alignment: Alignment.centerLeft,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.3, 1],
                              colors: [
                                Color(0xFFF58524),
                                Color(0XFFF92B7F),
                              ],
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: SizedBox.expand(
                            child: MaterialButton(
                              child: const Text(
                                "Submit",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              onPressed: () {

                                loginProcess();

                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}