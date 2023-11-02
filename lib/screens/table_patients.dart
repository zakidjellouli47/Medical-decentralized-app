import 'dart:convert';




import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:med/screens/dashboard_receptionist.dart';


import 'package:med/screens/users.dart';






class TablePatient extends StatefulWidget{

  final String firstname;
  final String lastname;
  final String age;
  final String email;
  final String role;
  final String pass;
  final String ethereumAddress;

  const TablePatient({super.key, required this.firstname, required this.lastname, required this.age, required this.email, required this.role, required this.pass, required this.ethereumAddress});










  @override
  _TablePatientState createState(){
    return _TablePatientState();
  }
}

class _TablePatientState extends State<TablePatient> {


  bool error = false,// declaring an error as boolean
      dataloaded = false;//  declaring data loaded as boolean
  var data;
  String dataurl = "http://localhost/flutter-login-signup/table_patient.php"; //PHP script URL
  // do not use http://localhost/ for your local
  // machine, Android emulation do not recognize localhost
  // insted use your local ip address or your live URL
  // hit "ipconfig" on Windows or
  // "ip a" on Linux to get IP Address

  @override
  void initState(){// init state function that loads before the build function
    loaddata();// loading the data of the table








    //calling loading of data
    super.initState();
  }




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



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("List of all the  patients "),
        //title of app
        backgroundColor: Colors.blueAccent,//background color of app bar

        elevation: 0,// to make the ui more bright and have some blury shadows
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black54),//  going back to the home page
          onPressed: () {
            // passing this to our root
            Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard_Receptionist(firstname: widget.firstname,lastname: widget.lastname,age: widget.age,email: widget.email,ethereumAddress: widget.ethereumAddress,pass: widget.pass,role: widget.role,)));
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
      List<User> namelist = List<User>.from(data["data"].map((e) {// creating a list of users called namelist and taking the mapping data

        return User.fromJson(e);// returning the user object that was mapped
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
                ),

                ),







              ]
          );
        }).toList(),// since it was a list of mapping we should convert it to a list for avoiding a type error


      );
    }
  }
}
