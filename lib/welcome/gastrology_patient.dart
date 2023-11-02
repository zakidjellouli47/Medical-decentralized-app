import 'package:flutter/material.dart';
import 'package:med/constant.dart';
import 'package:med/model/choose_model.dart';
import 'package:med/welcome/widget/choose_date.dart';
import 'package:med/welcome/widget/choose_time_group.dart';
import 'package:med/welcome/widget/my_appbar_patient.dart';
import 'package:med/welcome/widget/user_info_gastro.dart';


import 'package:med/widget/my_header.dart';

class GastroScreen_Patient extends StatelessWidget {
  final String firstname;// declare all the string values
  final String lastname;
  final String age;
  final String role;
  final String email;
  final String pass;
  final String ethereumAddress;
  const GastroScreen_Patient({super.key, required this.firstname, required this.lastname, required this.age, required this.role, required this.email, required this.pass, required this.ethereumAddress});
// create the contractor

  @override
  Widget build(BuildContext context) {// build function to build our class
    return Scaffold(// scaffold that gives the app screen
      body: Column(// body of the app is a column
        children: [// children of the column
          MyHeader(// calling my header class
            height: 240,// the height of the header
            imageUrl: 'assets/images/avatar_head.png',// the image of container
            child: Column(// calling the child widget of the header
              children: [
                MyAppbar_Patient(firstname: firstname,lastname: lastname,age: age,role: role,email: role,pass: pass,ethereumAddress: ethereumAddress),
                const SizedBox(// space between the appbar and userinfo
                  height: 10,// space with 10 px height
                ),
                const UserInfo_Gastro (),// calling the userinfo class in order to get the doctor information
              ],
            ),
          ),
          Expanded(//fill the rest of the screen
            child: Container(//
              padding: const EdgeInsets.only(left: 30.0),//padding the whole container widgets from 30 px
              width: double.infinity,// take the whole width
              decoration: const BoxDecoration(
                gradient: LinearGradient(// coloring the expended widget
                  colors: [mBackgroundColor, mSecondBackgroundColor],// the colors
                  begin: Alignment.topCenter,// the top center of the body will get the first color
                  end: Alignment.bottomCenter,// the bottom center of the will get the second color
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,// align the slots in the start
                children: [// children of the column
                  const ChooseSlot(),// calling the class ChooseSlot()
                  const SizedBox(// space between the choose slots and the ChooseTimeGroup
                    height: 15,// space with 15 px height
                  ),
                  ChooseTimeGroup(//calling the class ChooseTimeGroup()
                    title: 'Morning',// the title of the first time
                    list: [// list of models that describe time

                      ChooseModel('11.00 AM'),
                      ChooseModel('11.30 AM'),
                      ChooseModel('12.00 AM'),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ChooseTimeGroup(
                    title: 'Afternoon',
                    list: [
                      ChooseModel('02.00 PM', ),
                      ChooseModel('02.30 PM', ),
                      ChooseModel('03.00 PM', ),
                      ChooseModel('03.30 PM',),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ChooseTimeGroup(
                    title: 'Evening',
                    list: [
                      ChooseModel('06.00 PM', ),
                      ChooseModel('06.30 PM', ),
                      ChooseModel('07.00 PM',),
                      ChooseModel('07.30 PM', ),
                      ChooseModel('08.00 PM', ),
                      ChooseModel('08.30 PM', ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChooseSlot extends StatelessWidget {
  const ChooseSlot({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){// build function of the choose slot class
    return Column(//column
      crossAxisAlignment: CrossAxisAlignment.start,//// align the text in the start
      children: [// children of the column
        const Text(
          'you can choose appointments based on the doctor working time',
          style: TextStyle(
            color: mTitleTextColor,// color of the :jjtext
            fontSize: 14,// size of the text
            fontWeight: FontWeight.bold,// weight of the text
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,// space between the dates
          children: const [// children of the row
            ChooseDate(// calling the choose date class ,import 'package:med/welcome/widget/choose_date.dart'
              week: 'Sat',// the day
              date: '20',// the date of day

            ),

            ChooseDate(
              week: 'Mon',
              date: '22',

            ),
            ChooseDate(
              week: 'Wed',
              date: '24',

            ),
            ChooseDate(
              week: 'Thu',
              date: '26',

            ),

          ],
        )
      ],
    );
  }
}
