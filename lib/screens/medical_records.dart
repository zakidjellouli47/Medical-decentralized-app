import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med/Utils/connector.dart';
import 'package:med/ui/Pages/login_page.dart';
import 'package:web3dart/web3dart.dart';

class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({Key? key}) : super(key: key);

  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  TextEditingController feeController = TextEditingController(); // creating the text controllers
  TextEditingController patientAddress = TextEditingController();
  TextEditingController notes = TextEditingController();
  TextEditingController health_history = TextEditingController();
  TextEditingController medicines = TextEditingController();
  TextEditingController advice = TextEditingController();


  bool isAuthorized = false;// create a bool variable isAuthorized and set it to fase
  bool showLoading = false;// create a bool variable showLoading and set it to fase

  void checkAuthorization() async {// create the void asynchronous function checkAuthorization to check if the doctor
    // is authorized or not
    if (patientAddress.text.length < 40) { // if the  public address is less than 40 characters then return a message
      Fluttertoast.showToast(msg: "Wrong address");
      return;// return nothing void
    }
    setState(() {
      showLoading = true; // if the address is verified then show the loading dialogue waiting for the response
    });
    isAuthorized = await Connector.isAuthorized(Connector.address, EthereumAddress.fromHex(patientAddress.text));
    // call the is authorized function to check if the patient has authorized the doctor to send a presc using the patient
    // address and store it in the bool value is authorized
    if (!isAuthorized) {
      Fluttertoast.showToast(
          msg: "You are not authorized to give prescription.");
    }
    setState(() {
      showLoading = false;// hide the loading dialogue  after the response
    });
  }

  void updateFee(String newAmount) async {//  create the void asynchronous function updateFee to update the fee if needed
    if (newAmount.isEmpty) {// if the amount is empty then return a message
      Fluttertoast.showToast(msg: "Amount cannot be empty");
      return;// return nothing void
    }
    setState(() {
      showLoading = true;// if the newAmoun is verified then show the loading dialogue waiting for the response
    });
    feeController.text = await Connector.updateDoctorFee(
        Connector.address, Connector.key, newAmount);
    // call the updateDoctorFee function to update the fee and store it in the feeController.text
    setState(() {
      showLoading = false;
    });// hide the loading dialogue  after the response
  }

  void getFee() async {// create the void asynchronous function getFee to get  the new fee
    feeController.text = await Connector.getFee(Connector.address);// get the new fee by calling the function get fee and store it
    // in the fee controller.text
    setState(() {});// set the state to the newest
  }

  void sendPrescription() async {// create the void  asynchronous send Prescription function to send the prescription
    setState(() {
      showLoading = true;// show the loading dialogue when the prescription is sent
    });
    String timestamp = DateTime.now().toString();// the time of creating the prescription is held
    // in the string value timestamp
    String prescription =
        "$timestamp#${Connector.address}#${notes.text}#${medicines.text}#${advice.text}#${health_history.text}";
    //hold the values from time stamp to the health history in the prescription list
    await Connector.setPresc(Connector.address, EthereumAddress.fromHex(patientAddress.text), Connector.key, prescription);
    // call the set prescription function in connector and store the prescription list in the function
    setState(() {
      showLoading = false;// after the prescription is sent , hide the loading dialogue
      isAuthorized = false;// set the is authorized value to false meaning the doctor is longer authorized until the patient
      // gives him the authorization again
    });
  }

  @override
  void initState() {
    getFee();// call the get fee function in order to print the fee initially
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(// scaffold that gives the app screen
      backgroundColor: Colors.greenAccent,//background color
      body: SafeArea(// to set dimension and avoid widget appearing in the margin of the app(OS Interface)
        child: SingleChildScrollView(// single child view to avoid render flex problem
          child: Column(
            children: [
              Container(// children of column
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
                      FontAwesomeIcons.userDoctor,// doctor icon
                      color: Colors.white,
                      size: 40,
                    ),
                    VerticalDivider(// it's a vertical slider that splits between two or more widgets
                      color: Colors.white,
                       thickness: 5,
                    ),
                    Text(
                      'Doctor Panel',// text
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,// main axis in the center
                  children: [// children of the widget row
                    Container(// container of the address box
                      width: MediaQuery.of(context).size.width * 0.6,// width of container is 0.6 of all
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
                          color: Colors.red.shade50,// the color of box
                          borderRadius: BorderRadius.circular(20),// circular with 20 value
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),// the color of shadow
                              blurRadius: 7,// radius of the shadow
                              offset: const Offset(
                                  0, 5), // changes position of shadow
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
              showLoading == false // if the dialogue loading is hidden(false)

                  ? // then
               Padding(
                padding: const EdgeInsets.all(16.0),// padding the container from all
                child: Container(
                  padding: const EdgeInsets.only(bottom: 16, top: 8),// padding the widgets inside the container in the bottom and top
                  decoration: BoxDecoration(
                    color: Colors.white,// the color of the box
                    borderRadius: BorderRadius.circular(50),// circular with 50 value
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.9),// the color of shadow
                        blurRadius: 7,// radius of the shadow
                        offset: const Offset(
                            0
                            , 5), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(// column
                    children: [// children of the column
                      Center(// put it in the center
                        child: Container(// Sized box of the widgets
                          width: 200,
                          height: 50,

                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceAround,// space between the icon and text
                            children: const [// children of the row
                              Icon(
                                FontAwesomeIcons.ethereum,// ethereum icon
                                color: Colors.black,
                                size: 25,
                              ),
                              VerticalDivider(// it's a vertical slider that splits between two or more widgets
                                color: Colors.black,
                                thickness: 1,
                              ),
                              Text(
                                'Update Fee', //text update fee
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),// padding the form from all
                        child: CupertinoFormSection(// cupertino form
                          children: [
                            CupertinoFormRow( // row of the cupertino form
                              child: CupertinoTextFormFieldRow( // text field of cupertino row
                                controller: feeController,// controller is the fee controller
                                placeholder: "Change Fee",// place holder

                                validator: (value) {// validotor to validate that the value written isn't empty
                                  if (value!.isEmpty) {
                                    return "Fee cannot be empty.";
                                  }
                                  return null;// return nothing
                                },
                                enableSuggestions: true,// suggestion in the mobile keyboard
                                prefix: const Text(// the text
                                  'Fee (In Wei)  | ',

                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(// put the button in the center
                        child: GestureDetector(//gesture detector to tap update button and update the fee
                          onTap: () => updateFee(feeController.text),// call the update fee function and the value amount
                          // which was stored in fee controller will be the parameter of update fee fucntion
                          child: Container(// container of the button
                              width: 100,// width of the container
                              height: 40,// height of the container
                              decoration: BoxDecoration(
                                color: Colors.black,// the color of box
                                borderRadius: BorderRadius.circular(50),// circular with 50
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),// color of the shadow
                                    blurRadius: 7,// radius of the shadow
                                    offset: const Offset(0,
                                        3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: const Center(//  text in the center
                                child: Text(
                                  'Update',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              )
                  : const Center( // in the center
                child: Padding(
                  padding: EdgeInsets.only(top: 180),// the circular indicator is being padded by 50 px top
                  child: null,// hide all the children
                ),
              ),
              showLoading == false
              // if the dialogue loading is hidden(false)
                  ?

              Padding(
                padding: const EdgeInsets.all(16.0),// padding the container from all
                child: Container(
                  padding: const EdgeInsets.only(bottom: 16, top: 8),// padding the widgets inside the container in the bottom and top
                  decoration: BoxDecoration(
                    color: Colors.white,// the color of the box
                    borderRadius: BorderRadius.circular(50),// circular with 50 value
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.9),// the color of shadow
                        blurRadius: 7,// radius of the shadow
                        offset: const Offset(
                            0
                            , 5), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(// column
                    children: [// children of the column
                      Center(// fill the widgets in the center
                        child: Container(//
                           width: 250,// width of the container
                          height: 50,// height of the container
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceAround,// space between the icon and text
                            children: const [
                              Icon(
                                FontAwesomeIcons.prescriptionBottle,// icon of prescription
                                color: Colors.black,
                                size: 25,
                              ),

                                VerticalDivider(// it's a vertical slider that splits between two or more widgets
                                  color: Colors.black,
                                  thickness: 1,
                                ),

                              Text(
                                'Give Prescription',// text
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),// padding the form from all
                        child: CupertinoFormSection( // cupertino form
                          children: [
                            CupertinoFormRow(// row of the cupertino form
                              child: CupertinoTextFormFieldRow( // text field of the cupertino form
                                controller: patientAddress,// controller holds the patient address
                                placeholder: "Patient Address",// place holder

                                validator: (value) {// validotor to validate that the value written isn't empty
                                  if (value!.isEmpty) {
                                    return "Address cannot be empty.";
                                  }
                                  return null;
                                },
                                prefix: const Text(// text
                                  'Address  | ',

                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: GestureDetector(//gesture detector to tap checking the authorization
                          onTap: () => checkAuthorization(),// call the check authorization function
                          child: Container(// container of the button
                              width: 200,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.black,// the color of box
                                borderRadius: BorderRadius.circular(50),// circular with 50
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),// color of the shadow
                                    blurRadius: 7,// radius of the shadow
                                    offset: const Offset(0,
                                        3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: const Center(// put it in the center
                                child: Text(
                                  'Check Authorization',// text button
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              )),
                        ),
                      ),
                      isAuthorized // if the condition is true
                      // which means the doctor is authorized to send a prescription
                          ? Padding(
                        padding: const EdgeInsets.all(16.0),// padding the column from all with 16 px
                        child: Column(// column
                          children: [// children of the column
                            CupertinoFormSection(//  cupertino form
                              children: [ // children of the cupertino form
                                CupertinoFormRow(// cupertino row
                                  child: CupertinoTextFormFieldRow( // cupertino text field
                                    controller: notes,// controller notes


                                    validator: (value) {// validator to validate that the value written isn't empty
                                      if (value!.isEmpty) {
                                        return "Notes cannot be empty.";
                                      }
                                      return null;
                                    },
                                    prefix: const Text(// text
                                      'Notes  | ',

                                    ),

                                  ),
                                ),

                                CupertinoFormRow(
                                  child: CupertinoTextFormFieldRow(
                                    controller: medicines,

                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Medicines cannot be empty.";
                                      }
                                      return null;
                                    },
                                    prefix: const Text(
                                      'Medicines  | ',

                                    ),

                                  ),
                                ),
                                CupertinoFormRow(
                                  child: CupertinoTextFormFieldRow(
                                    controller: advice,
                                    // placeholder: "Advice Address",

                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Advice cannot be empty.";
                                      }
                                      return null;
                                    },
                                    prefix: const Text(
                                      'Advice  | ',

                                    ),


                                  ),
                                ),
                                CupertinoFormRow(
                                  child: CupertinoTextFormFieldRow(
                                    controller: health_history,
                                    // placeholder: "Vitals",

                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Health history  cannot be empty.";
                                      }
                                      return null;
                                    },
                                    prefix: const Text(
                                      'Health history  | ',

                                    ),

                                  ),
                                ),
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 16, bottom: 16), // padding the gesture detector from the top and bottom
                              child: Center(// put it in th center
                                child: GestureDetector(//gesture detector to tap checking the authorization
                                  onTap: () => sendPrescription(),//calling the send prescription when pressed
                                  child: Container(// container of the button
                                      width: 100,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.black,// the color of box
                                        borderRadius: BorderRadius.circular(50),// circular with 50
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),// color of the shadow
                                            blurRadius: 7,// radius of the shadow
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: const Center(// put the button in the center
                                        child: Text(
                                          'Send',// text
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                          : const SizedBox(),// else if it's not authorized then a sized box which is a white space is being present
                    ],
                  ),
                ),
              )
                  : const Center(// else if the show dialogue is true then a circular indicator with a 20 radius wiil pop up
                  child: CupertinoActivityIndicator(
                    radius: 20,
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
