import 'dart:convert';




import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:med/screens/dashboard_doctor.dart';




import 'package:med/screens/users_appointements.dart';






class TableApp_D extends StatefulWidget{
  final String firstname;
  final String lastname;
  final String age;
  final String role;
  final String email;
  final String pass;
  final String ethereumAddress;
   const TableApp_D({super.key, required this.firstname, required this.lastname, required this.age, required this.role, required this.email, required this.pass, required this.ethereumAddress});









  @override
  _TableApp_DState createState(){
    return _TableApp_DState();
  }
}

class _TableApp_DState extends State<TableApp_D> {

  bool visible = false;




  TextEditingController firstnameController = TextEditingController();

  // controller for the Last Name TextField we are going to create.
  TextEditingController lastnameController = TextEditingController();
  // controller for the Last Name TextField we are going to create.

  TextEditingController ageController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController ilnessdescriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController doctorsController = TextEditingController();










  bool error = false,
      dataloaded = false;
  var data;
  String dataurl = "http://localhost/flutter-login-signup/table_appointements.php"; //PHP script URL
  // do not use http://localhost/ for your local
  // machine, Android emulation do not recognize localhost
  // insted use your local ip address or your live URL
  // hit "ipconfig" on Windows or
  // "ip a" on Linux to get IP Address

  @override
  void initState() {
    loaddata();

    firstnameController = TextEditingController();
    lastnameController = TextEditingController();
    ageController = TextEditingController();

    emailController = TextEditingController();
    ilnessdescriptionController = TextEditingController();
    dateController = TextEditingController();
    doctorsController = TextEditingController();







    //calling loading of data
    super.initState();
  }




  void loaddata() {
    Future.delayed(Duration.zero, () async {
      var res = await http.post(Uri.parse(dataurl));
      if (res.statusCode == 200) {
        setState(() {
          data = json.decode(res.body);
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
        title: const Text("List of all the  appointements "),
        //title of app
        backgroundColor: Colors.blueAccent,

        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () {
            // passing this to our root
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  Dashboard_Doctor(firstname:widget.firstname,lastname: widget.lastname,age: widget.age,email: widget.email,role: widget.role,pass: widget.pass,ethereumAddress: widget.ethereumAddress,)));
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
      List<User> namelist = List<User>.from(data["data"].map((i) {
        return User.fromJson(i);
      })
      ); //prasing data list to model

      return Table( //if data is loaded then show table
        border: TableBorder.all(width: 2, color: Colors.blueAccent),

        children: namelist.map((user) {
          return TableRow( //return table row in every loop
              children: [

                TableCell(child: Padding(
                    padding: const EdgeInsets.all(5),

                    child: Text(user.UID)
                )
                ),
                //table cells inside table row
                TableCell(child: Padding(
                    padding: const EdgeInsets.all(5),

                    child: Text(user.firstname)
                )
                ),
                TableCell(child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(user.lastname)
                )
                ),
                TableCell(child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(user.age)
                )
                ),

                TableCell(child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(user.email)
                )
                ),
                TableCell(child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(user.ilnessdescription)
                )
                ),
                TableCell(child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(user.date)
                )
                ),
                TableCell(child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(user.doctors)
                )
                ),




              ]
          );
        }).toList(),


      );
    }
  }
}
