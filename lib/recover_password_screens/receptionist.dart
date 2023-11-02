import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:med/ui/Pages/login_page.dart';






class RecoverPassword_r extends StatefulWidget {


  final String firstname;
  final String lastname;
  final String UID;
  final String role;

  final String pass;

  const RecoverPassword_r({super.key,required this.firstname, required this.lastname,  required this.role, required this.pass, required this.UID});



  @override
  State<RecoverPassword_r> createState() => _RecoverPassword_rState();
}
class _RecoverPassword_rState extends State<RecoverPassword_r> {
  final GlobalKey<FormState> _formKey = GlobalKey<
      FormState>(); // create the form key to validate a form


  late TextEditingController _passController = TextEditingController();


// create string variables


  Future updaterecord(UID) async {
    //asynchronous function built in the future and holds string uid in parameter to update

    var url = "http://localhost/flutter-login-signup/update_pass.php"; //holding the url of the php code that performed the accept query
    // in the uri string object
    var res = await http.post(Uri.parse(url), body: {
      'UID': UID,

      'pass': _passController.text,

    }); // sending an http request to call the url and put it in res
    // parse method transforms the string uri to a valid uri
    if (res.statusCode ==
        200) { // the status code =200 means the http request is ok and successful

      var update = jsonDecode(res
          .body); ////decode the json code of data we took from the php code and hold it in the update obj

      if (kDebugMode) {
        showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                title: const Text('Result'),
                content: const Text('Updated successfully'),
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
                            builder: (context) =>
                                RecoverPassword_r(
                                  firstname: widget.firstname,
                                  lastname: widget.lastname,
                                  pass: widget.pass,
                                  role: widget.role,
                                  UID: widget.UID,)));
                      },
                      child: const Text('ok'))
                ],
              ),
        ); // running in debug mode
        print(update); //print the result
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
                    Text(
                      "Reset your password now,Mr. ${widget.lastname} ${widget
                          .firstname}",
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Please enter your Password to reset it",
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
                          controller: _passController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: "Password",
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
                                  if (_formKey.currentState!
                                      .validate()) { // when pressing the update button the formkey will validate the current state
                                    // and return a message if the textfield is empty
                                    setState(() {});


                                    if (kDebugMode) {
                                      print(widget.UID);
                                    }
                                    updaterecord(widget.UID);
                                  }
                                }
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