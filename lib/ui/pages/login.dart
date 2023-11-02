
import 'package:flutter/material.dart';
import 'package:med/screens/dashboard_director.dart';
import 'package:med/screens/dashboard_doctor.dart';
import 'package:med/screens/dashboard_patient.dart';
import 'package:med/screens/dashboard_receptionist.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:med/ui/pages/forget_password.dart';
import 'package:med/ui/pages/usermodel.dart';
import '../../screens/dashboard_admin.dart';




class LoginPageLeft extends StatefulWidget {
  const LoginPageLeft({super.key});



  @override
  State<LoginPageLeft> createState() => _LoginPageLeftState();
}

class _LoginPageLeftState extends State<LoginPageLeft> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();// create the form key to validate a form
  TextEditingController emailin =  TextEditingController();// create the text controllers
  TextEditingController passin =  TextEditingController();

  bool _isHidePassword = true;// create a bool variable hide password and set it to true


  late String email, pass, role,firstname,lastname,age,ethereumAddress;// create string variables


  void _togglePassword() {// a function to change the state of the password
    setState(() {
      _isHidePassword = !_isHidePassword;// toggle the password
    });
  }

  void loginProcess() async {// create the login process function

    if(_formKey.currentState!.validate()){ // if the form is validated


      final response = await http.post(Uri.parse("http://localhost/flutter-login-signup/login_user.php"), body: {
        "email" : emailin.text,
        "pass" : passin.text
      }); // create a final response variable and store  in it the wait for the
      // http request to call the code in the wamp server of the login and the body of data which is the email and the password

      var dataUser = json.decode(response.body);// store the decoded json which is the response in the data user

      if(dataUser.length < 1){
        // if data user is empty or 0 this means there is no objects in the data
        setState(() {
          showDialog(// show an error dialogue saying invalid login
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
      }else{ // if the data isn't empty or false which means dataUser.length > 1
        setState(() {
          email = dataUser[0]["email"];//take the email from the data user and since it's an array is zero indexed we put 0 inside the dateuser
          pass = dataUser[0]["pass"];
         role = dataUser[0]["role"];
         age = dataUser[0]["age"];
          firstname = dataUser[0]["firstname"];
          lastname = dataUser[0]["lastname"];
          ethereumAddress = dataUser[0]["ethereumAddress"];

        });

        // move the page according to user status
        if(role == "admin"){
          // use navigator push replacement so that user can not go back to login page
          // if the use is an admin then move to the admin home page
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
                              builder: (context) =>  Dashboard_Admin(firstname:firstname, lastname: lastname,age: age,role: role,email: email,pass: pass,ethereumAddress: ethereumAddress,)));
                        },
                        child: const Text('ok'))
                  ],
                ),
          );
        }else  // if the user is a patient then move to the patient home page
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
                                builder: (context) => Dashboard_Patient(firstname:firstname,lastname: lastname,age: age,email:email,ethereumAddress: ethereumAddress,role: role,pass: pass,)));
                          },
                          child: const Text('ok'))
                    ],
                  ),
            );
          }
          else // if the user is a director then move to the director home page
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
                                builder: (context) =>  Dashboard_Director(firstname:firstname,lastname: lastname,)));
                          },
                          child: const Text('ok'))
                    ],
                  ),
            );
          }

          else
          if (role == "doctor") {
            // if the user is a doctor then move to the doctor home page
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
                                builder: (context) =>  Dashboard_Doctor(firstname: firstname,lastname:lastname,age: age,email: email,role: role,pass: pass,ethereumAddress: ethereumAddress,)));
                          },
                          child: const Text('ok'))
                    ],
                  ),
            );
          }

          else
          if (role == "receptionist") {
            // if the user is a receptionist then move to the receptionist home page
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
                                builder: (context) =>  Dashboard_Receptionist(firstname:firstname, lastname: lastname,age: age,role: role,email: email,pass: pass,ethereumAddress: ethereumAddress,)));
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
  Widget build(BuildContext context) {// the builder function of the login left side
    return Expanded(// to expand the rest of the screen
        child: Center( // put it in the center
          child: Padding(
            padding:  const EdgeInsets.fromLTRB(60, 40,120,120),
    child: Form(// the login form
      key: _formKey,// the key to validate the form
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,// the main axis is in the center (horizental column)
              crossAxisAlignment: CrossAxisAlignment.start,// the cross axis is in the start(vertical column)
              children: [

                const Text("Login", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),),// the login text
                const SizedBox(height: 10),// sized box for white spaces
                const Text("Note: if you don't have a metamask account ,please create a new one because you may need it in sharing private information", style: TextStyle(fontSize: 12),),
                    // note text
                const SizedBox(height: 8),// sized box for white spaces

                TextFormField(// text form field
                  controller: emailin,// take the controller
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(// decorate the textfield
                    label: Text("email"),// text
                    hintText: "Please write your email address",


                  ),
                  validator: (value) {// validator for checking that the value isn't empty
                    if (value == null || value.isEmpty) {
                      return 'Please Enter User Name';
                    }
                    return null;
                  },

                ),
                const SizedBox(height:8),//  white space
                TextFormField(// decorate the textfield
                  controller: passin,// take the controller
                  obscureText: _isHidePassword,// the password is hidden
                  decoration:  InputDecoration(// decorate the textfield
                    label: const Text("password"),
                    hintText: "Please write your password",
                    suffixIcon:  GestureDetector(// gesture detector to make a pressed a button
                      onTap: () {
                        _togglePassword();// when pressed call the toggle password fucntion
                      },
                      child: Icon(// create icon to change according the pass state
                        _isHidePassword
                            ? // if the password is hidden then the icon is visibility_off
                        Icons.visibility_off
                            :// else  if the password isn't hidden then the icon is visibility
                         Icons.visibility,
                        color: _isHidePassword ?// the color of the icon is grey if the password is hidden
                         Colors.grey
                            : // the color of the icon is blue if the password is shown
                        Colors.blue,
                      ),
                    ),

                  ),

                  validator: (value) {// validator for checking that the value isn't empty
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Password';
                    }
                    return null;
                  },

                ),
                const SizedBox(height: 20),// white space
                Align(
                  alignment: Alignment.topRight,
                  child: MaterialButton(child: const Text("Forget password?"), onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  ForgetPassword()));

                  },),
                ),
                const SizedBox(height: 18),

                TextButton(// text button
                  style: TextButton.styleFrom(

                     padding: const EdgeInsets.symmetric(horizontal: 80,vertical:8 ),// padding from the vertical and horizontal positions only
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),// circular border with 15
                    ),
                  ),
                  onPressed: ()  {
                    // Validate returns true if the form is valid, or false otherwise.
                    loginProcess();// calling the login function

                  },
                  child: const Padding( // padding the text with only  top and left and bottom
                    padding: EdgeInsets.only(
                      top: 15.0,
                      bottom: 15.0,
                      left:15.0,
                    ),


                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12), // white space




                  MaterialButton(child: const Text("Don't have account yet ,Register now"), onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => const RegistrationScreen()));
                    },
                  ),


              ],
            ),
    ),
          ),
        ));
  }
}

