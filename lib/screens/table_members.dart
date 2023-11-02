import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:med/screens/dashboard_admin.dart';



import 'package:med/screens/users.dart';






class TableMember extends StatefulWidget{
  final String firstname;
  final String lastname;
  final String age;
  final String role;
  final String email;
  final String pass;
  final String ethereumAddress;
  const TableMember({super.key, required this.firstname, required this.lastname, required this.age, required this.role, required this.email, required this.pass, required this.ethereumAddress});









  @override
  _TableMemberState createState(){
    return _TableMemberState();
  }
}

class _TableMemberState extends State<TableMember> {


  final _formKey = GlobalKey<FormState>();//Key used in the form state



 late TextEditingController _firstnameController = TextEditingController();

  // controller for the Last Name TextField we are going to create.
late TextEditingController _lastnameController = TextEditingController();
  // controller for the Last Name TextField we are going to create.

 late TextEditingController _ageController = TextEditingController();
   late TextEditingController _roleController = TextEditingController();
  late TextEditingController _emailController = TextEditingController();
   late TextEditingController _passController = TextEditingController();
  late TextEditingController _ethereumAddressNameController = TextEditingController();

  @override
  void initState(){// init state function that loads before the build function
    loaddata();// loading the data of the table

    super.initState();
  }






  Future userDelete(String UID) async{ // asynchronous function built in the future and holds string uid in parameter
    try{ // try this code
      String uri = "http://localhost/flutter-login-signup/delete_members.php";// holding the url of the php code that performed the delete query
      // in the uri string object
      var res = await http.post(Uri.parse(uri),body:{"UID":UID});// sending an http request to call the url and put it in res
      // parse method transforms the string uri to a valid uri
      var response = jsonDecode(res.body); // decoding the response after being encoded in the php file and get the result

      if(response["success"] == "true") {// the success msg is true then a dialog is pooped up
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Result'),
            content: const Text('Rejection successful'),
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
                        builder: (context) =>  TableMember(firstname: widget.firstname,lastname: widget.lastname,age: widget.age,role: widget.role,email: widget.role,pass: widget.pass,ethereumAddress: widget.ethereumAddress,)));
                  },
                  child: const Text('ok'))
            ],
          ),
        );
      }
      else
      {
        if (kDebugMode) {
          print("record not deleted");// the record won't be deleted if the success msg is false meaning the operation was failed
        }
      }
    }
    catch(e){// catching the exceptions and print them

      if (kDebugMode) {// Flutter application is running in debug mode
        print(e);// print the exception if it's true
      }
    }

  }



  Future updaterecord(UID) async {//asynchronous function built in the future and holds string uid in parameter to update

    var url = "http://localhost/flutter-login-signup/update_records.php";//holding the url of the php code that performed the accept query
    // in the uri string object
      var res = await http.post(Uri.parse(url), body: {
      'UID' :UID,
       'firstname' :_firstnameController.text,// the body that contains the data
        'lastname' :_lastnameController.text,
        'age' :_ageController.text,
        'role' :_roleController.text,
        'email' :_emailController.text,
        'pass' :_passController.text,
        'ethereumAddress' :_ethereumAddressNameController.text,
      });// sending an http request to call the url and put it in res
    // parse method transforms the string uri to a valid uri
      if(res.statusCode == 200){// the status code =200 means the http request is ok and successful

        var update = jsonDecode(res.body);////decode the json code of data we took from the php code and hold it in the update obj

        if (kDebugMode) {// running in debug mode
          print(update);//print the result
        }

      }

  }




  bool error = false,// declaring an error as boolean
      dataloaded = false;//  declaring data loaded as boolean
  var data;
  String dataurl = "http://localhost/flutter-login-signup/table_members.php"; //PHP script URL





  void loaddata() {// function to load data into a table of records
    Future.delayed(const Duration(milliseconds:1000), () async { // we use Future.delayed becuase there is
      // async function inside it.zero duration represents zero time duration
      var res = await http.post(Uri.parse(dataurl));// sending an http request to call the url and put it in res
      // parse method transforms the string uri to a valid uri
      if (res.statusCode == 200) {// the status code =200 means the http request is ok and successful
        setState(() {// set the state into the newer state
          data = json.decode(res.body);//decode the json code of data we took from the php code
          dataloaded = true;
          // we set dataloaded to true,
          // so that we can build a list only
          // on data load
        });
      } else {
        //there is error
        setState(() {
          error = true;
        });
      }
    });
    // we use Future.delayed becuase there is
    // async function inside it.
  }

Future editUsers(UID) async{//asynchronous function built in the future and holds string uid in parameter to update records
showDialog(context: context,
    // showing the records in a dialog menu

    builder: (context){
    return AlertDialog(
      content: Form(// form of the records to get updated
        key: _formKey,// key that creates the form fields and confirm them and validate them

        child: Column(
          mainAxisSize: MainAxisSize.min,
  children: [



    CupertinoFormRow(//   CupertinoFormRow are some kind of  cool text fields taken from the import 'package:flutter/cupertino.dart';

      //padding: EdgeInsets.only(left: 0),
      child: CupertinoTextFormFieldRow(
        style: GoogleFonts.poppins(),
        controller: _firstnameController,
        placeholder: "Enter your first name",
        prefix: const Text(
          "first name      ",

        ),
        padding: const EdgeInsets.only(left: 0),
        keyboardType: TextInputType.text,
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
        controller: _lastnameController,
        placeholder: "Enter your last name",
        prefix: const Text(
          "last name",

        ),
        padding: const EdgeInsets.only(left: 0),
        keyboardType: TextInputType.text,
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
        controller: _ageController,
        placeholder: "Enter your age",
        prefix: const Text(
          "age    ",

        ),
        padding: const EdgeInsets.only(left: 0),
        keyboardType: TextInputType.text,
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
        controller: _roleController,
        placeholder: "Enter your role",
        prefix: const Text(
          "role      ",

        ),
        padding: const EdgeInsets.only(left: 0),
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value!.isEmpty) {
            return "role can't be empty";
          }
          return null;
        },
      ),
    ),
    CupertinoFormRow(
      //padding: EdgeInsets.only(left: 0),
      child: CupertinoTextFormFieldRow(
        style: GoogleFonts.poppins(),
        controller: _emailController,
        placeholder: "Enter your Email",
        prefix: const Text(
          "email     ",

        ),
        padding: const EdgeInsets.only(left: 0),
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
        controller: _passController,
        placeholder: "Enter your password",
        obscureText: true,
        prefix: const Text(
          "password      ",


        ),
        padding: const EdgeInsets.only(left: 0),
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value!.isEmpty) {
            return "password can't be empty";
          }
          return null;
        },
      ),
    ),
    CupertinoFormRow(
      //padding: EdgeInsets.only(left: 0),
      child: CupertinoTextFormFieldRow(
        style: GoogleFonts.poppins(),
        controller: _ethereumAddressNameController,
        placeholder: "Enter your Ethereum Address",
        prefix: Text(
          "Address      ",
          style: Theme.of(context).textTheme.caption,
        ),
        padding: const EdgeInsets.only(left: 0),
        keyboardType: TextInputType.text,
        validator: (value) {// validators that belong to the form state will test if the value isn't empty
          if (value!.isEmpty) {
            return "Address can't be empty";
          }
          return null;
        },
      ),
    ),

    ElevatedButton(

        onPressed: () {
          if (_formKey.currentState!.validate()) {// when pressing the update button the formkey will validate the current state
            // and return a message if the textfield is empty
            setState(() {});


            if (kDebugMode) {
              print(_firstnameController.text);
            }
            if (kDebugMode) {
              print(_lastnameController.text);
            }
            if (kDebugMode) {
              print(_ageController.text);
            }
            if (kDebugMode) {
              print(_roleController.text);
            }
            if (kDebugMode) {
              print(_emailController.text);
            }
            if (kDebugMode) {
              print(_passController.text);
            }
            if (kDebugMode) {
              print(_ethereumAddressNameController.text);
            }
            if (kDebugMode) {
              print(UID);
            }
            updaterecord(UID);
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
                                builder: (context) =>  TableMember(firstname: widget.firstname,lastname: widget.lastname,age: widget.age,role: widget.role,email: widget.role,pass: widget.pass,ethereumAddress: widget.ethereumAddress,)));
                          },
                          child: const Text('ok'))
                    ],
                  ),
            );


          }}
          , child: const Text('Update'),// update button

    )







  ],




        ),


      ),



    );


    }



);
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("List of all the  hospital members"),
        //title of app
        backgroundColor: Colors.blueAccent,//background color of app bar

        elevation: 0,// to make the ui more bright and have some blury shadows
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black54),//  going back to the home page
          onPressed: () {
            // passing this to our root
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  Dashboard_Admin(firstname:widget.firstname,lastname: widget.lastname,age: widget.age,role: widget.role,email: widget.email,pass: widget.pass,ethereumAddress: widget.ethereumAddress,)));
          },
        ),


        //background color of app bar
      ),

      body: Container(
        padding: const EdgeInsets.all(15),
        //check if data is loaded, if loaded then show datalist on child
        child: dataloaded ? datalist() :
        const Center( //if data is not loaded then show progress
            child: CircularProgressIndicator()
        ),
      ),

    );
  }

  Widget datalist() {
    if (data["error"]) {
      return Text(data["errmsg"]);
      //print error message from server if there is any error
    } else {
      //https://docs.flutter.dev/cookbook/networking/background-parsing
      List<User> namelist = List<User>.from(data["data"].map((i) { // creating a list of users called namelist and taking the mapping data
        return User.fromJson(i);// returning the user object that was mapped
      })
      ); //prasing data list to model

      return Table( //if data is loaded then show table
        border: TableBorder.all(width: 2, color: Colors.blueAccent),

        children: namelist.map((e) {
          return TableRow( //return table row in every loop
              children: [

                TableCell(child: Padding(
                    padding: const EdgeInsets.all(5),

                    child: Text(e.UID)
                )
                ),
                //table cells inside table row
                TableCell(child: Padding(
                    padding: const EdgeInsets.all(5),

                    child: Text(e.firstname)
                )
                ),
                TableCell(child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(e.lastname)
                )
                ),
                TableCell(child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(e.age)
                )
                ),
                TableCell(child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(e.role)
                )
                ),
                TableCell(child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(e.email)
                )
                ),
                TableCell(child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(e.pass)
                )
                ),
                TableCell(child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(e.ethereumAddress)
                )
                ),
                TableCell(child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      userDelete(e.UID);
                    },
                    icon: const Icon( // <-- Icon
                      Icons.delete,

                    ),
                    label: const Text('Delete'), // <-- Text
                  ),
                ),
                ),
                TableCell(child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: ElevatedButton.icon(
                    onPressed: () {

                      editUsers(e.UID);


                    },
                    icon: const Icon( // <-- Icon
                      Icons.add,

                    ),
                    label: const Text('Edit'), // <-- Text
                  ),
                ),
                ),


              ]
          );
        }).toList(),// since it was a list of mapping we should convert it to a list for avoiding a type error


      );
    }
  }
}
