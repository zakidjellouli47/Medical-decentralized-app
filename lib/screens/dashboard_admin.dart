import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';



import 'package:med/screens/table.dart';
import 'package:med/screens/table_members.dart';
import 'package:med/ui/Pages/login_page.dart';
import 'package:med/welcome/welcome_screen.dart';
import 'package:uuid/uuid.dart';





class Dashboard_Admin  extends StatefulWidget {

  final String firstname;
  final String lastname;
  final String age;
  final String role;
  final String email;
  final String pass;
  final String ethereumAddress;
  const Dashboard_Admin({super.key, required this.firstname, required this.lastname, required this.age, required this.role, required this.email, required this.pass, required this.ethereumAddress});



  @override
  State<Dashboard_Admin> createState() => _Dashboard_AdminState();
}



class _Dashboard_AdminState extends State<Dashboard_Admin> {
  bool expanded = false;// to expand the menu

  static String profilePicLink = "";// first make it null

  late TextEditingController firstnameController ;

  // controller for the Last Name TextField we are going to create.
   late TextEditingController lastnameController;// late means we would initialize them lately

  late TextEditingController ageController;

  late TextEditingController roleController;

  late TextEditingController emailController;

  late TextEditingController passController;

  late TextEditingController ethereumAddressController;
  @override
  void initState() {// init state that executes the first one
    super.initState();




    firstnameController = TextEditingController();// initializing the controllers
    lastnameController = TextEditingController();
    ageController = TextEditingController();
    roleController = TextEditingController();
    emailController = TextEditingController();
    passController = TextEditingController();
    ethereumAddressController = TextEditingController();

  }







  //https://www.youtube.com/watch?v=6lmWFoWgPq4&t=599s


  void pickUploadProfilePic() async {// async referes to asynchronous programs which means wait until the required task is served
    FilePickerResult? result = // since it's an asynchronous program it's required to put the await function in order
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
          .ref(name)// image folder
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





  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:Row(
        children:[

          NavigationRail(//
            // navigation menu
              extended: expanded,
              backgroundColor: Colors.deepPurple,//
              // color of the background of the menu
              unselectedIconTheme: const IconThemeData(color: Colors.white,opacity: 1),
              //the color of the unselected items
              unselectedLabelTextStyle: const TextStyle(
                // the color of the text that belongs to the unselected items
                color: Colors.black,
              ),
              selectedIconTheme:
              const IconThemeData(color: Colors.amber),
              // the color of the selected item ,initially the home item
              destinations: [

                NavigationRailDestination(
                  // items of the navigation menu

                  icon: IconButton(
                    icon: const Icon(Icons.home), onPressed: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) =>   Dashboard_Admin(firstname:widget.firstname,lastname: widget.lastname,age: widget.age,role: widget.role,email: widget.email,pass: widget.pass,ethereumAddress: widget.ethereumAddress,)));

                  },
                  ),
                  label: const Text("Home"),
                ),
                NavigationRailDestination(

                  icon: IconButton(
                    icon: const Icon(Icons.person), onPressed: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) =>   TableMember(firstname:widget.firstname,lastname: widget.lastname,age: widget.age,role: widget.role,email: widget.email,pass: widget.pass,ethereumAddress: widget.ethereumAddress,)));

                  },
                  ),
                  label: const Text("Members"),
                ),
                NavigationRailDestination(

                  icon: IconButton(
                    icon: const Icon(Icons.request_page), onPressed: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) =>  TablePage(firstname: widget.firstname,lastname: widget.lastname,age: widget.age,role: widget.role,email: widget.email,pass: widget.pass,ethereumAddress: widget.ethereumAddress,)));

                  },
                  ),
                  label: const Text("Requests"),
                ),
                NavigationRailDestination(

                  icon: IconButton(
                    icon: const Icon(Icons.health_and_safety), onPressed: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) =>  WelcomeScreen(firstname: widget.firstname,lastname: widget.lastname,age: widget.age,role: widget.role,email: widget.email,pass: widget.pass,ethereumAddress: widget.ethereumAddress,)));

                  },
                  ),

                  label: const Text("Medical Departments"),

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
              ], selectedIndex: 0),// the index of the current item
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


                                    child: Image.asset('assets/cat1.jpg',
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

