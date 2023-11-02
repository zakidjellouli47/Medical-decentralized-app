import 'package:flutter/material.dart';
import 'package:med/constant.dart';
import 'package:med/model/choose_model.dart';
import 'package:med/welcome/widget/choose_time.dart';


class ChooseTimeGroup extends StatelessWidget {//choose time function

  final String title;// titles like morning , evening ..etc
  final List<ChooseModel> list;// list of choose models

  const ChooseTimeGroup({
    Key? key, required this.title, required this.list,// constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {// build function
    return Column(// column
      crossAxisAlignment: CrossAxisAlignment.start,// align the titles in the start
      children: [// children of the column
        Text(//
          title,// title
          style: const TextStyle(
            color: mTitleTextColor,// color of the text
            fontSize: 18,// size of the text
            fontWeight: FontWeight.bold,// weight of the text
          ),
        ),
        const SizedBox(
          height: 18,
        ),
        //https://www.youtube.com/watch?v=1nEmFuX1Cig
        Wrap(// wrap is used to wrap widget buttons or items to avoid render flex overflow if the items take the whole screen

          spacing: 12,// space between items
          children:buildItems(),// calling the children items
        )
      ],
    );
  }

  List<Widget> buildItems(){// creating a function that builds a dynamic list
    List<Widget> widgets = [];// list of widgets
    for (ChooseModel item in list) {// allocating the list of items
      widgets.add(// add item
        ChooseTime(time:item.timeOfTheday)// the time value declared in the choosetime takes the item value of the list
        // that was declared in the chooseModel class
      );
    }
    return widgets;// return the widgets since the dynamic list contains widgets
  }

}