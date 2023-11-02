import 'dart:convert';





import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:http/http.dart' as http;

import 'login_page.dart';









class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {


  
  
  
  
  
  
  




  // our form key
  final _formKey = GlobalKey<FormState>(); // create the key to validate the forms
  // editing Controller
  final firstNameEditingController = TextEditingController(); // creating the text controllers
  final lastNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final roleEditingController = TextEditingController();
  final ageEditingController = TextEditingController();
  final ethereumaddressController = TextEditingController();

  _showPicker() {// show picker to show a dialogue to choose the role
    showModalBottomSheet(  //building a modal similar to the dialog menu but that prevents you from interacting with the rest of the application
        context: context,//
        shape: const RoundedRectangleBorder(// to set the border of the top with 5 px circular
            borderRadius: BorderRadius.vertical(top: Radius.circular(5.0))),
        builder: (BuildContext bc) {// the modal builder
          return SafeArea(// safe area to avoid os interface
            child: Wrap(// to wrap the list tiles in the safe area
              children: [ // children of the wrap
                const Padding(// padding the roles
                  padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
                  child: Text(
                    "Roles",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),


   // creating the list tiles
                ListTile(
                    leading:  const Icon(
                      FontAwesomeIcons.user,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'admin',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      roleEditingController.text = "admin"; // assign the controller with the list tile name
                      setState(() {});
                      Navigator.pop(context);
                    }),
                ListTile(
                    leading: const Icon(
                      FontAwesomeIcons.user,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'doctor',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      roleEditingController.text = "doctor";
                      setState(() {});
                      Navigator.pop(context);
                    }),
                ListTile(
                    leading: const Icon(
                      FontAwesomeIcons.user,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'receptionist',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      roleEditingController.text = "receptionist";
                      setState(() {});
                      Navigator.pop(context);
                    }),
                ListTile(
                    leading: const Icon(
                      FontAwesomeIcons.user,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'director',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      roleEditingController.text = "director";
                      setState(() {});
                      Navigator.pop(context);// hide the modal
                    }),
                ListTile(
                    leading: const Icon(
                      FontAwesomeIcons.user,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'patient',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      roleEditingController.text = "patient";
                      setState(() {});
                      Navigator.pop(context);
                    }),
              ],
            ),
          );
        });
  }




  @override
  Widget build(BuildContext context) {// the builder of ui

    Future userRegistration() async{ // the future function registration

      if(_formKey.currentState!.validate()) { // to validate the function
        // Getting value from Controller


        // SERVER API URL
        var url = "http://localhost/flutter-login-signup/registration.php"; // taking the file containing the back end to register

        // Store all data with Param Name.
        var data = {
          'firstname': firstNameEditingController.text,
          // storing the values in the controller in each data
          'lastname': lastNameEditingController.text,
          'age': ageEditingController.text,
          'role': roleEditingController.text,
          'email': emailEditingController.text,
          'pass': passwordEditingController.text,
          'ethereumAddress': ethereumaddressController.text
        };

        // Starting Web API Call.
        var response = await http.post(Uri.parse(url), body: json.encode(
            data)); // wait until the http request is being made
        //parse means converting the uri into string since http.post takes a string and encode
        // the data into json and hold it in the body

        // Getting Server response into variable.
        var message = jsonDecode(response
            .body); // holding the response after being decoded from json in message var


        if (message['registrationStatus'] ==
            true) { // if registration is successful shows the dialogue
          showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  title: const Text('Result'),
                  content: const Text(
                      'Your account request is now pending for approval. Please wait for confirmation. Thank you'),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) => const RegistrationScreen()));
                        },
                        child: const Text('Go Back'))
                  ],
                ),
          );
        }
      }

    }



    //first name field
    final firstNameField = TextFormField( // setting the text fields
        controller: firstNameEditingController,// taking the controller
        keyboardType: TextInputType.name,
        validator: (value) {// validate the names
          if (value!.isEmpty) {
            return ("First Name cannot be Empty");
          }

          return null;// return nothing
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          hintText: "First Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //second name field
    final secondNameField = TextFormField(
        controller: lastNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Second Name cannot be Empty");
          }
          return null;
        },
        onSaved: (value) {
          lastNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          hintText: "Second Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //email field
    final emailField = TextFormField(

        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }

          return null;
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //password field
    final passwordField = TextFormField(
        controller: passwordEditingController,
        obscureText: true,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Password is required for login");
          }

          return null;
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));



    final roleField = TextFormField(
        controller: roleEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Role cannot be Empty");
          }
          return null;
        },
        onSaved: (value) {
          roleEditingController.text = value!;// save the value in the console when written
        },
        textInputAction: TextInputAction.next,
        onTap: _showPicker,// show the picker when typing
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.add_box_rounded),
          hintText: "Role",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),

        ),
      readOnly: true,// it means you can't write in the text field
    );
    final ageField = TextFormField(
        controller: ageEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Age cannot be Empty");
          }
          return null;
        },
        onSaved: (value) {
          ageEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.accessibility),
          hintText: "Age",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final ethereumAddressField = TextFormField(
        controller: ethereumaddressController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("EthereumAddress cannot be Empty");
          }
          return null;
        },
        onSaved: (value) {
          ethereumaddressController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.add_box_rounded),
          hintText: "Ethereum Address",
          border: OutlineInputBorder(// outline borders
            borderRadius: BorderRadius.circular(10),// circular border with 10 px
          ),
        ));
    //signup button
    final signUpButton = Material( // the button sign up
      elevation: 5,// blury effects
      borderRadius: BorderRadius.circular(30),// border circular with 30
      color: Colors.blueAccent,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),// padding from all with different pixels
          minWidth: MediaQuery.of(context).size.width,// take the whole width
          onPressed: () {

             userRegistration();// calling the function when pressed

          },
          child: const Text(
            "Register",
            textAlign: TextAlign.center,// text in the center
            style: TextStyle(
                fontSize: 18, color: Colors.white54, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(// create the app screen
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,// blury effects
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.lightBlue),
          onPressed: () {
            // passing this to our root
            Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
          },
        ),
      ),
      body: Center(// put the body in the center
        child: SingleChildScrollView(// to avoid the render flex problems
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),// padding the contents of the container like  text fields
              child: Form(// creating the form
                key: _formKey,// the form key that validates the form
                child: Column(// colum,
                  children: [// children of the column
                    SizedBox( // sized box for the  hospital image
                        height: 90,
                        child: Image.asset(
                          "assets/images/h.png",
                          fit: BoxFit.contain,
                        )),
                    const SizedBox(height: 20),
                    firstNameField,// calling the text fields
                    const SizedBox(height: 10),// space between ever text field
                    secondNameField,
                    const SizedBox(height: 10),
                    emailField,
                    const SizedBox(height: 10),
                    passwordField,

                    const SizedBox(height: 10),
                    roleField,
                    const SizedBox(height: 10),
                    ageField,
                    const SizedBox(height: 10),
                    ethereumAddressField,
                    const SizedBox(height: 10),
                    signUpButton,
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


}