import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:med/Utils/connector.dart';
import 'package:med/screens/dashboard_patient.dart';
import 'package:med/screens/view_prescription.dart';
import 'package:med/ui/pages/login_page.dart';
import 'package:web3dart/credentials.dart';

class PatientHomePage extends StatefulWidget {
  final String firstname;//  declaring the string variables
  final String lastname;
  final String age;
  final String role;
  final String email;
  final String pass;
  final String ethereumAddress;
   const PatientHomePage({super.key, required this.firstname, required this.lastname,required this.age, required this.email, required this.ethereumAddress, required this.role, required this.pass});

  @override
  State<PatientHomePage> createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  TextEditingController doctorAddress = TextEditingController();// create the text controller

  bool showLoading = true;// create a bool variable and set it to true
  List<List<String>> prescriptions = [];// create a list of string lists of prescriptions
  void setAuthorization() async {// create the void asynchronous function
    if (doctorAddress.text.length < 40) { // if the  public address is less than 40 characters then return a message

      Fluttertoast.showToast(msg: "Please check your public address");
      return; // return nothing
    }
    bool isAuthorized = await Connector.addAuthorization(// call the function add authorization and store it in bool
      // value isAuthorized
        EthereumAddress.fromHex(doctorAddress.text),// the public address of the doctor
        Connector.address,// the address of the patient
        Connector.key);// the private key
    if (!isAuthorized) {// if the function is authorized isn't verified meaning the function failed
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Result'),
          content: const Text('Doctot is restricted to send you medical records'),
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
                      builder: (context) =>  PatientHomePage(firstname:widget.firstname,lastname: widget.lastname,age: widget.age,email: widget.email,ethereumAddress: widget.ethereumAddress,role: widget.role,pass: widget.role,)));
                },
                child: const Text('ok'))
          ],
        ),
      );
    } else { // else if the function is successful
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Result'),
          content: const Text('Doctor is now authorized to send you medical records'),
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
                      builder: (context) =>  PatientHomePage(firstname:widget.firstname,lastname: widget.lastname,age: widget.age,email: widget.email,ethereumAddress: widget.ethereumAddress,role: widget.role,pass: widget.pass,)));
                },
                child: const Text('ok'))
          ],
        ),
      );
      doctorAddress.clear();// clear the text controller
    }
  }

  void getPrescriptions() async {
    setState(() {
      showLoading = true;// show the loading dialogue waiting the records to pop up
    });
    List<dynamic> result = await Connector.getPresc(Connector.address);// create a dynamic list result and get
    // the prescriptions from the connector class
    for (var element in result) {// allocating the dynamic list
      prescriptions.add(element.split('#'));
      // adding the elemens which are the prescriptions and split the elements index by #
      //The purpose of the toString() method is to provide a literal representation of whatever object it is called on,
      // or to convert an object to a string
    }
    prescriptions = prescriptions.reversed.toList();
    //https://api.flutter.dev/flutter/dart-core/List/reversed.html
    setState(() {
      showLoading = false;// when the records are being printed stops the loading
    });
  }



  _showPickerAuthorization() {
    //https://api.flutter.dev/flutter/material/showModalBottomSheet.html
    //building a modal similar to the dialog menu but that prevents you from interacting with the rest of the application
    showModalBottomSheet(
        isScrollControlled: true,// to set the bottom sheet to full height
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),// to set the border of the top with 25 px circular
        context: context,
        builder: (BuildContext bc) {
          return SingleChildScrollView(// used to scroll and display all the screen when the container of the child is too wide
            // to be displayed in the app
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,// for the mobile ui to avoid being obscured by the keyboardInput,
              child: Column(
                mainAxisSize: MainAxisSize.min,// it takes the minimum place it can get
                children: <Widget>[
                  const Text(
                    "Authorize Doctor",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  CupertinoFormSection(children: [
                    CupertinoFormRow(
                      //padding: EdgeInsets.only(left: 0),
                      child: CupertinoTextFormFieldRow(
                        controller: doctorAddress,
                        // obscureText: true,
                        placeholder: "Enter Doctor's Public Address",
                        // prefix: "Email".text.make(),
                        padding: const EdgeInsets.only(left: 3.0),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Address can't be empty";
                          }
                          return null;
                        },
                        prefix: Text(
                          'Address  | ',

                        ),
                      ),
                    ),
                    InkWell(
                        onTap: () async {
                          setAuthorization();
                          Navigator.pop(context);
                          doctorAddress.clear();
                        },
                        child: const SizedBox(
                            height: 50,
                            child: Center(
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            )))
                  ])
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    //https://api.flutter.dev/flutter/widgets/State/initState.html
    getPrescriptions();// call the function initially
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(// scaffold that gives the app screen
      appBar: AppBar(

        backgroundColor: Colors.grey, //background color of app bar
elevation: 100,// to make the ui more bright and have some blury shadows

        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () {
            // passing this to our root
            Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard_Patient(firstname:widget.firstname,lastname: widget.lastname,age: widget.age,email: widget.email,ethereumAddress: widget.ethereumAddress,role: widget.role,pass: widget.pass,)));
          },
        ),
      ),


      floatingActionButton: Center(// famous button which is used in mobile apps,
        //  in addition it's a circular icon button that hovers over content to promote a primary action in the application

        child: InkWell( // it's close to the gestureDetector , and both provide many common features like onTap, onLongPress etc. The main difference is GestureDetector provides more controls like dragging etc.
          // on the other hand it doesn't include ripple effect tap, which InkWell does.
          onTap: () => _showPickerAuthorization(),
          //calling the function when the inkwell button is clicked
          child: Container(
            width: (MediaQuery.of(context).size.width / 3), //the width of the button is 1/3 of all the width of the app
            height: 55,// the height of the button
            decoration: BoxDecoration(// box of the button
              color: Colors.black,// the color of
              borderRadius: BorderRadius.circular(60),// circular with 60 value
              boxShadow: [
                BoxShadow(// shadow of the button
                  color: Colors.grey.withOpacity(0.5),// the color of the shadow
                  blurRadius: 15,// shadow radius
                  offset: const Offset(0, 5), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),// padding from in all but only works from buttom and top
              child: Row(// row
                mainAxisAlignment: MainAxisAlignment.center,// put the widgets in the center of the row
                children: const [
                  Icon(
                    FontAwesomeIcons.userDoctor,// doctor icon
                    color: Colors.white,
                    size: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),// padding from all
                    child: VerticalDivider(// it's a vertical slider that splits between two or more widgets
                      color: Colors.white,
                      thickness: 1,
                    ),
                  ),
                  Text(
                    'Authorize Doctor',// button text
                    style: TextStyle(
                      // fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white), // color of the text white
                  ),
                ],
              ),
            ),
          ),


        ),
      ),



      backgroundColor: Colors.white,// background is white


      body: SafeArea(// to set dimension and avoid widget appearing in the margin of the app(OS Interface)
        child: SingleChildScrollView(// single child view to avoid render flex problems
          child: Column(// column

            children: [
              Container(// container of a box patient medical information
                width: MediaQuery.of(context).size.width,// take the whole width
                height: MediaQuery.of(context).size.height / 8,// the height of the app / 8
                padding: const EdgeInsets.all(8),// padding from in all but only works from buttom and top
                decoration: const BoxDecoration(
                  color: Colors.black,// color of the box
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    bottomLeft: Radius.circular(50),// circular only in the borders
                    topRight: Radius.circular(0),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,// cross in the center
                  mainAxisAlignment: MainAxisAlignment.center,// main in the center
                  children: const [
                    Icon(
                      CupertinoIcons.person_circle, // patient icon
                      color: Colors.white,
                      size: 40,
                    ),
                    VerticalDivider(// it's a vertical slider that splits between two or more widgets
                      color: Colors.white,
                       thickness: 1,
                    ),
                    Text(
                        'Patient Medical Information',// text
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),

                  ],
                ),
              ),
              Padding(// padding
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),// padding of the widgets
                child: Row(// row
                  mainAxisAlignment: MainAxisAlignment.center,// main axis in the center
                  children: [// children of the widget row
                    Container(// container of the address box
                      width: MediaQuery.of(context).size.width * 0.7,// width of container is by 5
                      padding: const EdgeInsets.all(16),// padding
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,// color of the box
                        borderRadius: BorderRadius.circular(20),// circular with 20 value
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),// the color of the shadow
                            blurRadius: 7,// radius of the shadow
                            offset: const Offset(
                                0, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Center(// address text in the center
                        child: Text(
                          Connector.address.toString(),//since the address is of type ethereum toString function is needed to represent
                          // the address as a string
                          style: TextStyle(
                              fontSize:
                              (MediaQuery.of(context).size.width * 0.02),//width of the text box
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      ),
                    ),
                    const SizedBox(// sized bow with a width 10 px between the address bow and login page bow
                      width: 10,
                    ),
                    InkWell(// on pressed widget
                      onTap: () {
                        // redirect to the login page when pressing

                        Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) =>   LoginPage()));

                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.2,// width of container is the whole width * 0.2
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,// the color of the shadow
                          borderRadius: BorderRadius.circular(20),// circular with 60 value
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 7,// radius of the shadow
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "Login Page",
                            style: TextStyle(
                                fontSize:
                                (MediaQuery.of(context).size.width * 0.02),// size of the text
                                // fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center( // center
                child: Container( // container
                  width: MediaQuery.of(context).size.width,// the size of the container is the width
                  height: 50,// the height of the container
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,// main axis in the center
                    children: const [
                      Icon(
                        FontAwesomeIcons.notesMedical,// medical note icon
                        color: Colors.black,
                        size: 25,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),// padding
                        child: VerticalDivider(// it's a vertical slider that splits between two or more widgets
                          color: Colors.black,
                          thickness: 1,
                        ),
                      ),
                      Text(
                        'Medical Records',// text
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              (showLoading == false && prescriptions.isNotEmpty) //if the condtion is true
              //then =
                  ? ListView.builder(//lists of  prescriptions that contain a list of records
                itemCount: prescriptions.length,// the length of the prescriptions records
                shrinkWrap: true,// used when there is one of the widgets that belong to a list is a list itself
                // so the size won't be a problem.
                itemBuilder: (BuildContext context,  index) {// the list builder
                  return InkWell(// on pressed widget
                    onTap: () async { // press the on tap to view the prescription
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewPrescription(
                                  index: index + 1,// increment  the index in the itemBuilder from 0 to the prescription length
                                  record: prescriptions[index],//take the record from the prescription index
                                lastname:widget.lastname,firstname: widget.firstname,age: widget.age,email:widget.email,ethereumAddress: widget.ethereumAddress,role: widget.role,pass: widget.pass,)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Container(// container

                          padding: const EdgeInsets.all(16),// padding from all
                          decoration: BoxDecoration(
                            color: Colors.white,// color of the box white
                            borderRadius: BorderRadius.circular(15),// border radius with  15 circular
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),// color of the shadow
                                blurRadius: 7,// radius of the box
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(// row
                            children: [// children of the row
                              Padding(// padding
                                padding:
                                const EdgeInsets.only(right: 8.0),// padding from the right only
                                child: ClipRRect(// clip r rect to have your own shape
                                  borderRadius: BorderRadius.circular(5),//border radius with  15 circular
                                  child: Container(// container of the index
                                    color: Colors.black,
                                    child: Text(
                                      "  ${index+1}  ",// number of the index starting from 1 since arrays are 0 indexed
                                      style: const TextStyle(
                                        color: Colors.white,// white text
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const VerticalDivider(// it's a vertical slider that splits between two or more widgets
                                thickness: 10,
                              ),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,// cross at the start
                                children: [// children of column
                                  Row(

                                    children: [
                                      const Icon(
                                        FontAwesomeIcons.clock,// clock icon
                                        size: 15,
                                        // color: Colors.grey,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        prescriptions[index][0],// calling the first prescription
                                        // style:
                                        //     Theme.of(context).textTheme.caption,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        FontAwesomeIcons.userDoctor,// doctor icon
                                        size: 15,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      // size of the sized box
                                        // height: 30,
                                        Text(
                                          prescriptions[index][1],// the second index of the prescription

                                          selectionColor: Colors.green,// color is green
                                        ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          )),
                    ),
                  );
                },
              )
                 //else if
              : showLoading == true // if the show loading is true then show a the loading indicator

                  ? const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 40.0),// padding in the top with 40 px
                  child: CupertinoActivityIndicator(
                    radius: 20,// radius of the loading
                  ),
                ),
              )
              //else if the show loading == false then show
                  : const Padding(
                padding: EdgeInsets.only(top: 32.0, left: 16.0),//padding in the top with 32 px top and left 16 px
                child: Text(
                  "No Medical Records!",// show no medical records text
                  style: TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
