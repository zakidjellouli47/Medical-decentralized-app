import 'package:flutter/material.dart';
import 'package:med/constant.dart';

class ChooseDate extends StatelessWidget {// class choose date to decorate the dates
  final String week;// week includes the days such as saturday , sunday...etc
  final String date;// the date includes the date of the day such 20,21,22...etc


  const ChooseDate({// constructor
    Key? key,
    required this.week,
    required this.date,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {// build function
    return Column(// column
      children: [// children of the column
        Text(
          week,
          style: const TextStyle(
            color: mTitleTextColor,//  color of the slot
            fontSize: 14,// size of the slot
            fontWeight: FontWeight.w500,// weight of the slot
          ),
        ),
        const SizedBox(// space between slots
          height: 6,// 6 px height
        ),
        Container(// container of the date slots
          width: 48,//width of the date slots
          height: 48,// height of the date slots
          alignment: Alignment.center,// the date is in the center of the container
          decoration: BoxDecoration(// decoration of the box container
            color:  Colors.lightBlueAccent ,// color of the container
            border: Border.all(// all the border
                color:  Colors.black),// color of the border
            borderRadius: BorderRadius.circular(20),// make ir circular with the thikness of 20
          ),
          child: Text(// date text
            date,
            style: const TextStyle(
              color:  Colors.white ,// color of the text
              fontSize: 16,// size of the text
            ),
          ),
        ),
      ],
    );
  }
}
