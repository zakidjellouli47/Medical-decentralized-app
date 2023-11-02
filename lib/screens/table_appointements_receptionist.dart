import 'dart:convert';



import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:med/screens/dashboard_receptionist.dart';
import 'package:med/screens/users_appointements.dart';









class TableApp extends StatefulWidget{
  final String firstname;
  final String lastname;
  final String age;
  final String role;
  final String email;
  final String pass;
  final String ethereumAddress;
  const TableApp({super.key, required this.firstname, required this.lastname, required this.age, required this.role, required this.email, required this.pass, required this.ethereumAddress});









  @override
  _TableAppState createState(){
    return _TableAppState();
  }
}

class _TableAppState extends State<TableApp> {






  @override
  void initState(){// init state function that loads before the build function
    loaddata();// loading the data of the table



    super.initState();
  }


  Future userAccept(String UID) async{//asynchronous function built in the future and holds string uid in parameter
    try{ // try this code
      String uri = "http://localhost/flutter-login-signup/accept_appointements.php";// holding the url of the php code that performed the accept query
      // in the uri string object
      var res = await http.post(Uri.parse(uri),body:{"UID":UID});// sending an http request to call the url and put it in res
      // parse method transforms the string uri to a valid uri
      var response = jsonDecode(res.body);// decoding the response after being encoded in the php file and get the result

      if(response["success"] == "true") {// the success msg is true then a dialog is pooped up
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Result'),
            content: const Text('Account accepted successfully'),
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
                        builder: (context) =>  TableApp(firstname: widget.firstname,lastname: widget.lastname,age: widget.age,role: widget.role,email: widget.role,pass: widget.pass,ethereumAddress: widget.ethereumAddress,)));
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




  Future userDelete(String UID) async{ // asynchronous function built in the future and holds string uid in parameter
    try{ // try this code
      String uri = "http://localhost/flutter-login-signup/delete_appointements.php";// holding the url of the php code that performed the delete query
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
                        builder: (context) =>  TableApp(firstname: widget.firstname,lastname: widget.lastname,age: widget.age,role: widget.role,email: widget.role,pass: widget.pass,ethereumAddress: widget.ethereumAddress,)));
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







  bool error = false,// declaring an error as boolean
      dataloaded = false;//  declaring data loaded as boolean
  var data;
  String dataurl = "http://localhost/flutter-login-signup/table_appointements.php"; //PHP script URL





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
        title: const Text("List of all appointements"),
        //title of app
        backgroundColor: Colors.blueAccent,//background color of app bar

        elevation: 0,// to make the ui more bright and have some blury shadows
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black54),//  going back to the home page
          onPressed: () {
            // passing this to our root
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  Dashboard_Receptionist(firstname:widget.firstname,lastname: widget.lastname,age: widget.age,role: widget.role,email: widget.email,pass: widget.pass,ethereumAddress: widget.ethereumAddress,)));
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
      List<User> namelist = List<User>.from(data["data"].map((e) { // creating a list of users called namelist and taking the mapping data
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
                    child: Text(e.email)
                )
                ),
                TableCell(child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(e.ilnessdescription)
                )
                ),
                TableCell(child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(e.date)
                )
                ),
                TableCell(child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(e.doctors)
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


                      userAccept(e.UID);

                    },
                    icon: const Icon( // <-- Icon
                      Icons.add,

                    ),
                    label: const Text('Accept'), // <-- Text
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
