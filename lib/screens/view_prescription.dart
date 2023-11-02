import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class ViewPrescription extends StatelessWidget {
  final String firstname;
  final String lastname;
  final String age;
  final String role;
  final String pass;
  final String email;
  final String ethereumAddress;

  final int index;// index of the prescription
  final List<String> record;// string list of the records
  const ViewPrescription({
    Key? key,
    required this.index,
    required this.record,
    required this.lastname,
    required this.firstname,
    required this.age, required this.email, required this.ethereumAddress, required this.role, required this.pass,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(// scaffold that gives the app screen
        backgroundColor: Colors.white,// white background
        body: SafeArea(// to set dimension and avoid widget appearing in the margin of the app(OS Interface)
            child: SingleChildScrollView(// single child view to avoid render flex problems
              child: Padding(
                padding: const EdgeInsets.all(16.0),// padding from all
                child: Column(

                    children: [
                      Row(// row
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,// space between the record and icon button
                        children: [// children of the row


                            Text(
                              "Record #$index",// take the index of the record
                              style: const TextStyle(// size of the record
                                  fontSize: 70, fontWeight: FontWeight.bold),
                            ),

                          IconButton(
                            onPressed: () => Navigator.pop(context),// return back to the previous page when pressed
                            icon: const Icon(CupertinoIcons.chevron_back),// icon is chevron back
                            iconSize: 40,// size of the icon
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,// main   axis at the start
                        children: [
                          const Icon(
                            FontAwesomeIcons.clock,// icon clock
                            size: 15,
                            color: Colors.grey,
                          ),
                          const SizedBox(// space between the clock and record
                            width: 10,
                          ),
                          Text(
                            record[0],// take the first record(time)

                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,// main   axis at the start
                        children: [
                          const Icon(
                            FontAwesomeIcons.userDoctor,// icon doctor
                            size: 15,
                            color: Colors.grey,
                          ),
                          const SizedBox(// space between the doctor and record
                            width: 10,
                          ),

                             Text(
                              record[1],// take the second record(address)

                            ),

                        ],
                      ),
                      const Divider( // divider to divide between the rows
                        thickness: 2,// thick with 2
                      ),
                      Center( // center
                        child: Container(
                          width: 200,// width of the note container
                          height: 50,// height of the note container

                          child: Row(

                            children: const [ // children of the row
                              Icon(
                                FontAwesomeIcons.noteSticky,// note icon
                                color: Colors.black,
                                size: 25,
                              ),
                              Padding(
                                padding: EdgeInsets.all(15.0),// padding from all
                                child: VerticalDivider(// it's a vertical slider that splits between two or more widgets
                                  color: Colors.black,
                                  thickness: 1,
                                ),
                              ),
                              Text(
                                'Notes', // text note
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),

                        Center(// put it in the center
                          child: Text(
                            record[2],// take the record 2 note
                            textAlign: TextAlign.justify,
                          ),
                        ),


                      const Divider( // divider to divide between the rows
                        thickness: 2,// thick with 2
                      ),
                      Center(
                        child: Container(
                          width: 200,// width of the medicine container
                          height: 50,// height of the medicine container

                          child: Row(// row

                            children: const [// children of the row
                              Icon(
                                FontAwesomeIcons.tablets,// tablets icon
                                color: Colors.black,
                                size: 25,
                              ),
                              Padding(
                                padding: EdgeInsets.all(15.0),// padding from all
                                child: VerticalDivider(// it's a vertical slider that splits between two or more widgets
                                  color: Colors.black,
                                  thickness: 1,
                                ),
                              ),
                              Text(
                                'Medicines',// text medicines
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),

                Center(// put it in the center
                          child: Text(
                            record[3],// take the record 3 medicines
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      const Divider( // divider to divide between the rows
                        thickness: 2,// thick with 2
                      ),
                      Center(
                        child: Container(
                          width: 200,// width of the advice container
                          height: 50,// height of the advice container

                          child: Row(

                            children: const [// children of row
                              Icon(
                                FontAwesomeIcons.message,// message icon
                                color: Colors.black,
                                size: 25,
                              ),
                              Padding(
                                padding: EdgeInsets.all(15.0),// padding from all
                                child: VerticalDivider(// it's a vertical slider that splits between two or more widgets
                                  color: Colors.black,
                                  thickness: 1,
                                ),
                              ),
                              Text(
                                'Advice',// text advice
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),

                        Center(// put it in the center
                          child: Text(
                            record[4],// take the record 4 advice
                            textAlign: TextAlign.justify,
                          ),
                        ),


                      const Divider( // divider to divide between the rows
                        thickness: 2,// thick with 2
                      ),
                      Center(
                        child: Container(
                          width: 200,// width of the health history container
                          height: 50,// height of the health history container

                          child: Row(
                            children: const [// children of the row
                              Icon(
                                FontAwesomeIcons.heartCircleCheck,// icon of the hearth circle
                                color: Colors.black,
                                size: 25,
                              ),
                              Padding(
                                padding: EdgeInsets.all(15.0),// padding from all
                                child: VerticalDivider(// it's a vertical slider that splits between two or more widgets
                                  color: Colors.black,
                                  thickness: 1,
                                ),
                              ),
                              Text(
                                'Health history',// text health history
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),

                        Center(// put it in the center
                          child: Text(
                            record[5],// take the record 5 health history
                            textAlign: TextAlign.justify,
                          ),
                        ),




                    ]),
              ),




            ),
        ),
    );
  }
}
