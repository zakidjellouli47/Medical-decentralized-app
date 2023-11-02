import 'package:flutter/material.dart';
import 'package:med/constant.dart';

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(// safe area to avoid os interfaces
      child: Row(// creating a row
        mainAxisAlignment: MainAxisAlignment.center,// the widgets are in the center
        crossAxisAlignment: CrossAxisAlignment.center,// the widgets are in the center
        children: [// groups of widgets(children of the row)
          Image.asset(
            'assets/images/logo.png',// logo of the medical department
            width: 36,//size
            height: 36,//size
          ),
          const SizedBox(width: 12,),// space between the widget
          const Text(
            'medical',// text
            style: TextStyle(
              fontSize: 38,// size of the text
              color:mTitleTextColor,// color of the text
              fontWeight: FontWeight.bold // weight of the text
            ),
          ),
        ],
      ),
    );
  }
}