

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:flutter/material.dart';
import 'package:med/Utils/connector.dart';







import 'package:med/screens/table_appointements_doctor.dart';
import 'package:med/screens/table_patients_doctors.dart';







import 'package:med/ui/Pages/login_page.dart';
import 'package:uuid/uuid.dart';


import 'package:web3dart/credentials.dart';

import 'medical_records.dart';




class Dashboard_Doctor extends StatefulWidget {
  final String firstname;
  final String lastname;
  final String age;
  final String email;
  final String role;
  final String pass;
  final String ethereumAddress;
  const Dashboard_Doctor({super.key, required this.firstname, required this.lastname,required this.age, required this.email, required this.ethereumAddress, required this.pass, required this.role});


  @override
  State<Dashboard_Doctor> createState() => _Dashboard_DoctorState();
}

class _Dashboard_DoctorState extends State<Dashboard_Doctor> {
  bool adding = false;
  final _formKey = GlobalKey<FormState>();
  bool expanded = false;
  static String profilePicLink = "";


  TextEditingController date = TextEditingController();
  TextEditingController doctors = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController ilnessdescription = TextEditingController();


  TextEditingController address = TextEditingController();
  TextEditingController privateKey = TextEditingController();




  void pickUploadProfilePic() async {// async referes to asynchronous programs which means wait until the required task is server
    FilePickerResult? result = // sicne it's an asynchronous program it's required to put the await function in order
    //to wait for the uploading operation to be done
    await FilePicker.platform.pickFiles();//taking the file from the platfrom device by using the function pickFiles() and
    // save it in the result value of FilePickerResult

//https://stackoverflow.com/questions/47124945/how-to-read-bytes-of-a-local-image-file-in-dart-flutter
    if (result != null) {
      Uint8List? file = result.files.first.bytes;//In dart Uint8List is equal to byte[],transforming the file(image)
      //to bytes by using the function files.first.bytes
      //https://pub.dev/packages/file_picker


      String fileID = const Uuid().v4();// the package Uuid generates a random id for the file
//v4  This version of UUID is generated randomly. Although the random UUID uses random bytes, four bits are used to indicate version 4, while two to three bits are used to indicate the variant.
// These can be created using a random or pseudo-random number generator.

      String name = "Mr. ${widget.lastname} ${widget.firstname}";
      UploadTask task = FirebaseStorage.instance//the uploadtask function used to indicate that a task is being uploaded
      //FirebaseStorage.instance is the database service that supports uploading files , it returns
      // an instance
          .ref(name)// image folderge folder
          .child(fileID)// file Uuid
          .putData(file!);// put the file uploaded in the referenced location

      task.snapshotEvents.listen((event) {//we want to take the task which is the file from the firestore
        // and save it in the placeholder by using the snapshotevent function by listening to the event
        // we have


        event.ref
            .getDownloadURL()// loading the image file from the firestore and holding it in th value by using the ref.getDownloadURL.then
            .then((value)  async { // then is a call back function used to take the file from the url and store it in the value



          setState(() {// setting the current state into newer state
            profilePicLink = value;//holding the image value in the "profilepiclink"

          });
        }


        );





      });
    }


  }

  void moveToHome() async {// function to login using the public and private ethereum key
    bool result;// declaring bool result
    if (_formKey.currentState!.validate()) {// key validator of the form

      try {
        result = await Connector.logInPatient(address.text, privateKey.text);// verify connection using the connector that check the public and private keys
        if (!result) {// if the result is false then a dialogue menu will pop up saying Wrong information
          showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  title: const Text('Result'),
                  content: const Text('Wrong information'),
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
                              builder: (context) =>  Dashboard_Doctor(firstname:widget.firstname,lastname: widget.lastname,age: widget.age,email: widget.email,ethereumAddress: widget.ethereumAddress,role: widget.pass,pass: widget.pass,)));
                        },
                        child: const Text('ok'))
                  ],
                ),
          );

        } else {
          Connector.address = EthereumAddress.fromHex(address.text);// taking the value of the public address
          Connector.key = privateKey.text;//taking the value of the private address
          showDialog(//if the result is true then a dialogue menu will pop up saying Login successful
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
                              builder: (context) =>  const DoctorHomePage()));
                        },
                        child: const Text('ok'))
                  ],
                ),
          );
        }
      } catch (e) {// catch the connection error
        // print("here");
        if (kDebugMode) {// run as debug mode
          print(e);// printing the error in the console
        }
        Fluttertoast.showToast(
            msg: "Oops! Something went wrong. Try Again...$e");// printing the error message
        // print('Error creating user: $e');

      }


    }
  }











  @override
  Widget build(BuildContext context) {







    return Scaffold(
      body:Row(
        children:[

          NavigationRail(
              extended: expanded,
              backgroundColor: Colors.cyan.shade400,
              unselectedIconTheme: const IconThemeData(color: Colors.white,opacity: 1),
              unselectedLabelTextStyle: const TextStyle(
                color: Colors.white,
              ),
              selectedIconTheme:
              IconThemeData(color: Colors.cyan.shade800),
              destinations:[

                NavigationRailDestination(

                  icon: IconButton(
                    icon: const Icon(Icons.home), onPressed: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) =>  Dashboard_Doctor(firstname: widget.firstname,lastname: widget.lastname,age: widget.age,role: widget.role,email: widget.email,pass: widget.pass,ethereumAddress: widget.ethereumAddress,)));

                  },
                  ),
                  label: const Text("Home"),
                ),
                NavigationRailDestination(

                  icon: IconButton(
                    icon: const Icon(Icons.bar_chart), onPressed: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) =>  TableApp_D(firstname: widget.firstname,lastname: widget.lastname,age: widget.age,email: widget.email,role: widget.role,pass: widget.pass,ethereumAddress: widget.ethereumAddress,)));

                  },
                  ),

                  label: const Text("Appointements"),

                ),

                NavigationRailDestination(
                  icon: IconButton(
                    icon: const Icon(Icons.person), onPressed: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => TablePatient_doc(firstname: widget.firstname,lastname: widget.lastname,age: widget.age,ethereumAddress: widget.ethereumAddress,email: widget.email,pass: widget.pass,role: widget.role,)));

                  },
                  ),
                  label: const Text("Patients"),





                ),
                NavigationRailDestination(

                  icon: IconButton(
                    icon: const Icon(Icons.work), onPressed: () {


                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            
                          title: const Text('Address'),
                        
                          content: Form(
                            key: _formKey,


                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [


                              CupertinoFormRow(
                                //padding: EdgeInsets.only(left: 0),
                                child: CupertinoTextFormFieldRow(
                                  style: GoogleFonts.poppins(),
                                  controller: address,
                                  placeholder: "Enter your Etherium Address",
                                  prefix: const Text(
                                    "Address      ",

                                  ),
                                  padding: const EdgeInsets.only(left: 0),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Address can't be empty";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              CupertinoFormRow(
                                //padding: EdgeInsets.only(left: 0),
                                child: CupertinoTextFormFieldRow(
                                  style: GoogleFonts.poppins(),
                                  controller: privateKey,
                                  placeholder: "Enter your private key",
                                  prefix: const Text(
                                    "Key      ",

                                  ),
                                  padding: const EdgeInsets.only(left: 0),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Key can't be empty";
                                    }
                                    return null;
                                  },
                                ),
                              ),



                            TextButton(
                              onPressed: () => moveToHome(),



                              child: const Text('Connect'),
                            ),

                            ],

                          ),
                          )
                        );

                      },
                    );

                  },
                  ),

                  label: const Text("Prescriptions"),

                ),

                NavigationRailDestination(
                  icon: IconButton(
                    icon: const Icon(Icons.exit_to_app_outlined), onPressed: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => const LoginPage()));

                  },
                  ),
                  label: const Text("Sign out"),





                ),


              ], selectedIndex: 0),
          Expanded(
            child:Padding(
              padding: const EdgeInsets.all(15),// padding  the icon menu from all left up right bottom
              child: SingleChildScrollView( // make the row and column scroball
                child:Column(
                  children: [
                    Row(

                      children: [
                        IconButton(onPressed: ()  {

                          setState(() {

                            expanded = !expanded;// when pressing the icon menu , the menu get expanded(displayed or saved)
                          });
                        }, icon:const Icon(Icons.menu)
                        ),
                        GestureDetector(// detecting the gesture
                          onTap: () {
                            pickUploadProfilePic();// when clicking the upload function is called
                          },
                          child: Container(// the container of the file(picture)
                            margin: const EdgeInsets.only(top: 70, bottom: 20,left: 525),
                            height: 150,
                            width: 150,

                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),// the border of the picture after uploading it
                                color:Colors.black45
                            ),
                            child: Center(
                              child: profilePicLink == "" ? const Icon(// if the profile pic is empty then show an icon of person
                                Icons.person,
                                color: Colors.indigo,
                                size: 120,
                              ) : ClipRRect( // clip rect allows to you control the image and make it rounded

                                // else if the profile pic isn't empty then wrapp it with
                                // a clip rect and put the link of the uploaded pic in the image.network widget

                                borderRadius: BorderRadius.circular(30),

                                child: Image.network(profilePicLink),
                              ),

                            ),

                          ),

                        ),


                      ],
                    ),





                    Center(

                      child: Text(
                        "Welcome to your Home Menu , Mr. ${widget.lastname} ${widget.firstname}",

                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,


                        ),


                      ),

                    ),







                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.6,


                      child: Image.asset('assets/doctor.jpg',
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
