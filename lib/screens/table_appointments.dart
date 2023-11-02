import 'dart:convert';




import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:med/screens/dashboard_patient.dart';





import 'package:med/screens/users_appointements.dart';






class TableApp_patient extends StatefulWidget{
  final String firstname;
  final String lastname;
  final String age;
  final String role;
  final String email;
  final String pass;
  final String ethereumAddress;

  const TableApp_patient({super.key, required this.firstname, required this.lastname,required this.age, required this.email, required this.ethereumAddress, required this.role, required this.pass});









  @override
  _TableApp_patientState createState(){
    return _TableApp_patientState();
  }
}

class _TableApp_patientState extends State<TableApp_patient> {


  bool error = false, // declaring an error as boolean
      dataloaded = false; //  declaring data loaded as boolean
  var data;
  String dataurl = "http://localhost/flutter-login-signup/table_appointements.php"; //PHP script URL

  @override
  void initState() {
    loaddata();


    //calling loading of data
    super.initState();
  }


  void loaddata() {
    // function to load data into a table of records
    Future.delayed(const Duration(
        milliseconds: 1000), () async { // we use Future.delayed becuase there is
      // async function inside it.zero duration represents zero time duration
      var res = await http.post(Uri.parse(
          dataurl)); // sending an http request to call the url and put it in res
      // parse method transforms the string uri to a valid uri
      if (res.statusCode ==
          200) { // the status code =200 means the http request is ok and successful
        setState(() { // set the state into the newer state
          data = json.decode(res
              .body); //decode the json code of data we took from the php code
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
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("List of all the  appointements "), //title of app
        //title of app
        backgroundColor: Colors.redAccent, //background color of app bar
        elevation: 0, // to make the ui more bright and have some blury shadows
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black54),
          //  going back to the home page
          onPressed: () {
            // passing this to our root
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                Dashboard_Patient(firstname: widget.firstname,
                  lastname: widget.lastname,
                  age: widget.age,
                  email: widget.email,
                  ethereumAddress: widget.ethereumAddress,
                  role: widget.role,
                  pass: widget.pass,)));
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


// widget datalist(){





//}




  Widget datalist(){
    if(data["error"]){
      return Text(data["errmsg"]);
      //print error message from server if there is any error
    }else{
      //https://docs.flutter.dev/cookbook/networking/background-parsing
      List<User> namelist = List<User>.from(data["data"].map((e){  // creating a list of users called namelist and taking the mapping data
        return User.fromJson(e);// returning the user object that was mapped
      })
      ); //parsing data list to model

      return Table( //if data is loaded then show table
          border: TableBorder.all(width:2, color:Colors.blueAccent),

          children: namelist.map((e){

            return TableRow( //return table row in every loop
                children: [

                  TableCell(child: Padding(
                      padding: const EdgeInsets.all(5),

                      child:Text(e.UID)
                  )
                  ),
                  //table cells inside table row
                  TableCell(child: Padding(
                      padding: const EdgeInsets.all(5),

                      child:Text(e.firstname)
                  )
                  ),
                  TableCell(child: Padding(
                      padding: const EdgeInsets.all(5),
                      child:Text(e.lastname)
                  )
                  ),
                  TableCell(child: Padding(
                      padding: const EdgeInsets.all(5),
                      child:Text(e.age)
                  )
                  ),
                  TableCell(child: Padding(
                      padding: const EdgeInsets.all(5),
                      child:Text(e.ilnessdescription)
                  )
                  ),
                  TableCell(child: Padding(
                      padding: const EdgeInsets.all(5),
                      child:Text(e.date)
                  )
                  ),
                  TableCell(child: Padding(
                      padding: const EdgeInsets.all(5),
                      child:Text(e.doctors)
                  )
                  ),






                ]
            );
          }).toList()// since it was a list of mapping we should convert it to a list for avoiding a type error


      );

    }
  }
}
