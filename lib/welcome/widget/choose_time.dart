import 'package:flutter/material.dart';


class ChooseTime extends StatelessWidget {// choose time class
  final String time;// string value time


  const ChooseTime({ //constructor
    Key? key,
    required this.time,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {// build function
    return Container(// container of the time
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(// decoration of the box container
        color:  Colors.lightBlueAccent ,// color of the container
        border: Border.all(// all the border
            color:  Colors.black),// color of the border
        borderRadius: BorderRadius.circular(20),// make ir circular with the thikness of 20
      ),
      child: Text(
        time,
        style: const TextStyle(
            fontSize: 12, color:  Colors.white ),
      ),
    );
  }
}