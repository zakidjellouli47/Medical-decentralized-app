


import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:intl/intl.dart';

import 'package:med/screens/dashboard_patient.dart';




class Dashboard_Patient_Appointements extends StatefulWidget {

  final String firstname;
  final String lastname;
  final String age;
  final String email;
  final String role;
  final String pass;
  final String ethereumAddress;
  const Dashboard_Patient_Appointements({super.key, required this.firstname, required this.lastname,required this.age, required this.email,required this.ethereumAddress, required this.role, required this.pass});

  @override
  State<Dashboard_Patient_Appointements> createState() => _Dashboard_Patient_AppointementsState();
}

class _Dashboard_Patient_AppointementsState extends State<Dashboard_Patient_Appointements> {



  final _formKey = GlobalKey<FormState>();//Key used in the form state
  // controllers for the  TextField we are going to create.
TextEditingController date = TextEditingController();
  TextEditingController doctors = TextEditingController();
 TextEditingController firstname =TextEditingController() ;
  TextEditingController lastname = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController ethereumAddress = TextEditingController();
  TextEditingController ilnessdescription = TextEditingController();

  TextEditingController address = TextEditingController();
  TextEditingController privateKey = TextEditingController();

  @override
  void initState(){//init state function that loads before the build function
    super.initState();
    firstname =TextEditingController(text: widget.firstname);// get the values of the controllers to avoid repeating writing them
    lastname = TextEditingController(text: widget.lastname);
    age = TextEditingController(text: widget.age);
    email = TextEditingController(text: widget.email);
    ethereumAddress = TextEditingController(text: widget.ethereumAddress);
  }









  _showPicker() { // show picker function to display a form pick when pressing the book button
    showModalBottomSheet(//https://api.flutter.dev/flutter/material/showModalBottomSheet.html
      //building a modal similar to the dialog menu but that prevents you from interacting with the rest of the application
        context: context,// it takes two parameters
        shape: const RoundedRectangleBorder(// make the modal rounded
            borderRadius: BorderRadius.vertical(top:Radius.circular(30.0))),// to set the border of the top with 25 px circular
        builder: (BuildContext bc) {// the second parameter builder context
          return SafeArea(// creating  a safe area to avoid operating system interfaces
            child: Wrap(// wrapping the list of doctors
              children: [
                const Padding(// padding
                  padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
                  child: Text(
                    "Doctors and Specialities",// text of the modal
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),



                ListTile(// a list that contains a leading and title
                    leading: const Icon(// icon
                      FontAwesomeIcons.userDoctor,// of doctor
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Doctor Djellouli Zakaria(Generalist)',// title of the list tile
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {// press to choose
                      doctors.text = "Doctor Djellouli Zakaria(General)";
                      setState(() {});
                      Navigator.pop(context);// dismiss the modal after choosing the list tile
                    }),
                ListTile(
                    leading: const Icon(
                      FontAwesomeIcons.userDoctor,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Doctor Bakhti karim(Gastrology)',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      doctors.text = "Doctor Bakhti karim(Gastrology)";
                      setState(() {});
                      Navigator.pop(context);
                    }),
                ListTile(
                    leading: const Icon(
                      FontAwesomeIcons.userDoctor,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Doctor Boutaleb Ahmed(Gastrology)',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      doctors.text = "Doctor Boutaleb Ahmed(Gastrology)";
                      setState(() {});
                      Navigator.pop(context);
                    })
              ],
            ),
          );
        });
  }


  @override
  Widget build(BuildContext context) {// build function

    Future userRegistrationBooking() async{//asynchronous function built in the future





      // SERVER API URL
      var url = "http://localhost/flutter-login-signup/booking.php";// holding the url of the php code that performed the booking query
      // in the uri string object

      // Store all data with Param Name.
      var data = {'firstname':firstname.text,
        'lastname':lastname.text ,
        'age': age.text,
        'email': email.text,
        'ilnessdescription' :ilnessdescription.text,
        'date' :date.text,
        'doctors' : doctors.text,
        'ethereumAddress' : ethereumAddress.text
      };

      // Starting Web API Call.
      var response = await http.post(Uri.parse(url), body: json.encode(data));// sending an http request to call the url and put it in response
      // parse method transforms the string uri to a valid uri

      // Getting Server response into variable message
      var message = jsonDecode(response.body);



      if (message['registrationStatus'] == true) { // if the message registrationStatus = true then
        showDialog(// show dialogue
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Result'),
            content: const Text('Your account request is now pending for approval. Please wait for confirmation. Thank you'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard_Patient_Appointements(firstname:widget.firstname,lastname: widget.lastname,age: widget.age,email: widget.email,ethereumAddress: widget.ethereumAddress,role: widget.role,pass: widget.pass,)));
                  },
                  child: const Text('Go Back'))
            ],
          ),
        );
      }

    }


    return Scaffold(// scaffold widget that gives the app screen properties such as app bar
      appBar: AppBar(// app bar
        backgroundColor: Colors.redAccent, //background color of app bar
        elevation: 0,// to make the ui more bright and have some blury shadows
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black54),//  going back to the home page
          onPressed: () {
            // passing this to our root
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  Dashboard_Patient(firstname:widget.firstname,lastname: widget.lastname,age: widget.age,role: widget.role,email: widget.email,pass: widget.pass,ethereumAddress: widget.ethereumAddress,)));
          },
        ),
      ),
      body:Row(// row
        children:[ // children of row

          Expanded(// fill the rest of the screen ,exapand the widget
            child:Padding(
              padding: const EdgeInsets.all(15),// padding  the expanded widget
              child: SingleChildScrollView( // make the row and column scroball
                child:Column(// column
                  children: [// children of column




                    Center( // center

                      child: Text( // text in the center
                        "Patient Mr. ${widget.lastname} ${widget.firstname}",// print the msg with the name of the patient

                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,


                        ),


                      ),

                    ),
                    Container(// container

                      width: MediaQuery.of(context).size.width / 1.8,// width of the screen / 1.8
                      height: MediaQuery.of(context).size.height /1.2,// width of the screen / 1.8
                      color: Colors.lightBlue[600],
                      alignment: Alignment.center,
                      child: Padding(// padding the widgets
                        padding: const EdgeInsets.only(top: 65.0, right: 30.0, left: 70.0),
                        child: Align(
                          alignment: Alignment.center,// align the widgets in the center
                          child: Column(// column
                            children: [// children of column



                              const SizedBox(height: 14.0,),//14 px height white boxes space

                              Container(// container of a text
                                padding: const EdgeInsets.only(// padding from the top and bottom only
                                    top: 15.0,

                                ),
                                child: const Text(
                                  "Your health is important for us",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 5.0,),// 5 px height white space


                              Container(// container of the text
                                padding: const EdgeInsets.only(// padding from the top and bottom only
                                    top: 15.0,

                                ),
                                child: const Text(
                                  "you can book appointements and choose the doctors you desire ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Center(// image     asset in the center
                                child: Image.asset('assets/images/book.png',
                                  height: 400,
                                  width: 400,
                                ),
                              ),
                              Center( // text button in the center
                                child: TextButton(
                                  style: TextButton.styleFrom(



                                    padding: const EdgeInsets.symmetric(horizontal: 40,vertical:12 ),// padding the button with 40 px hor and 12 vert
                                    backgroundColor: Colors.deepPurple,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),//15 px ciruclar border
                                    ),
                                  ),
                                  onPressed: ()  {// show the modal when pressed
                                    // Validate returns true if the form is valid, or false otherwise.
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(

                                            title: const Text('Appointment'),

                                            content: Form(// form
                                              key: _formKey,//the key of the form to validate


                                              child: Column(// column

                                                children: [// children of column


                                                  CupertinoFormRow(// text field called cupertino
                                                    //padding: EdgeInsets.only(left: 0),
                                                    child: CupertinoTextFormFieldRow(
                                                      style: GoogleFonts.poppins(),
                                                      controller: firstname,
                                                      placeholder: "Enter your first name",
                                                      prefix: const Text(
                                                        "first name      ",

                                                      ),
                                                      keyboardType: TextInputType.emailAddress,
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return "first name can't be empty";
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                  CupertinoFormRow(
                                                    //padding: EdgeInsets.only(left: 0),
                                                    child: CupertinoTextFormFieldRow(
                                                      style: GoogleFonts.poppins(),
                                                      controller: lastname,
                                                      placeholder: "Enter your last name",
                                                      prefix: const Text(
                                                        "last name      ",

                                                      ),
                                                      padding: const EdgeInsets.only(left: 0),
                                                      keyboardType: TextInputType.emailAddress,
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return "last name can't be empty";
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                  CupertinoFormRow(
                                                    //padding: EdgeInsets.only(left: 0),
                                                    child: CupertinoTextFormFieldRow(
                                                      style: GoogleFonts.poppins(),
                                                      controller: age,
                                                      placeholder: "Enter  your age",
                                                      prefix: const Text(
                                                        "age      ",

                                                      ),
                                                      keyboardType: TextInputType.emailAddress,
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return "age can't be empty";
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                  CupertinoFormRow(
                                                    //padding: EdgeInsets.only(left: 0),
                                                    child: CupertinoTextFormFieldRow(
                                                      style: GoogleFonts.poppins(),
                                                      controller:email ,
                                                      placeholder: "Enter your email",
                                                      prefix: const Text(
                                                        "email      ",

                                                      ),

                                                      keyboardType: TextInputType.emailAddress,
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return "email can't be empty";
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                  CupertinoFormRow(
                                                    //padding: EdgeInsets.only(left: 0),
                                                    child: CupertinoTextFormFieldRow(
                                                      style: GoogleFonts.poppins(),
                                                      controller: ilnessdescription,
                                                      placeholder: "Enter your illness description",
                                                      prefix: const Text(
                                                        "illness description      ",

                                                      ),
                                                      keyboardType: TextInputType.text,
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return "illness description can't be empty";
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),

                                                  CupertinoFormRow(
                                                    //padding: EdgeInsets.only(left: 0),
                                                    child: CupertinoTextFormFieldRow(
                                                      style: GoogleFonts.poppins(),
                                                      controller: date,

                                                      placeholder: "Enter your Date",

                                                      prefix: const Text(
                                                        "Date      ",

                                                      ),
                                                      onTap: () async {
                                                        DateTime? pickeddate = await showDatePicker(
                                                            context: context,
                                                            initialDate: DateTime.now(),
                                                            firstDate:DateTime(2000),
                                                            lastDate:DateTime(2025));
                                                        if(pickeddate != null){
                                                          setState((){
                                                            date.text = DateFormat('yyyy-MM-dd').format(pickeddate);
                                                          });

                                                        }
                                                      },
                                                      keyboardType: TextInputType.text,
                                                      validator: (value) {// validator to validate that the textfield has a value
                                                        if (value!.isEmpty) {
                                                          return "date can't be empty";
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                  CupertinoFormRow(
                                                    //padding: EdgeInsets.only(left: 0),
                                                    child: CupertinoTextFormFieldRow(
                                                      style: GoogleFonts.poppins(),
                                                      controller: doctors,
                                                      placeholder: "Enter your doctor",
                                                      prefix: const Text(
                                                        "doctor      ",

                                                      ),
                                                      onTap: _showPicker,
                                                      keyboardType: TextInputType.text,
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return "Doctors can't be empty";
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                  CupertinoFormRow(
                                                    //padding: EdgeInsets.only(left: 0),
                                                    child: CupertinoTextFormFieldRow(
                                                      style: GoogleFonts.poppins(),
                                                      controller: ethereumAddress,
                                                      placeholder: "Enter your ethereumAddress",
                                                      prefix: const Text(
                                                        "ethereumAddress      ",

                                                      ),
                                                      keyboardType: TextInputType.text,
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return "ethereumAddress can't be empty";
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),




                                                  TextButton(
                                                      onPressed: (){

                                                        if (firstname.text.isEmpty || lastname.text.isEmpty || age.text.isEmpty || email.text.isEmpty || ilnessdescription.text.isEmpty || date.text.isEmpty || doctors.text.isEmpty) {
                                                          showDialog(
                                                            context: context,
                                                            builder: (context) =>
                                                                AlertDialog(
                                                                  title: const Text('Text fields can t be empty'),

                                                                  actions: [
                                                                    ElevatedButton(
                                                                        onPressed: () {
                                                                          Navigator.push(context,
                                                                              MaterialPageRoute(builder: (context) =>  Dashboard_Patient_Appointements(firstname:widget.firstname,lastname: widget.lastname,age: widget.age,email: widget.email,ethereumAddress: widget.ethereumAddress,role: widget.role,pass: widget.pass,)));
                                                                        },
                                                                        child: const Text('Go Back'))
                                                                  ],
                                                                ),
                                                          );
                                                        }
                                                        else {
                                                          userRegistrationBooking();// calling the function to book
                                                        }

                                                      },


                                                      child: const Text('Book your appointment')
                                                  ),

                                                ],

                                              ),
                                            )
                                        );

                                      },
                                    );




                                  },



                                      child: const Text(
                                        'Book an appointement now',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.red,
                                        ),
                                      ),


                                ),
                              ),






                            ],
                          ),
                        ),
                      ),
                    ),







                  ],


                ),




              ),
            ),
          ),
        ],

      ),


    );
  }
}
