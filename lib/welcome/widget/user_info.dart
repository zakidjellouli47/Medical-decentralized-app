import 'package:flutter/material.dart';
import 'package:med/constant.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),//padding 15px from the left
      child: Row(//row
        children: [ //children widgets of the row
          Image.asset(
            'assets/images/avatar.png',// the doctor image
            width: 100,// the size of image width
            height: 100,// the size of image height
          ),
          const SizedBox(width: 24),// space between the image and the column
          Column(// calling the widget child which is the column
            crossAxisAlignment: CrossAxisAlignment.start,// align the texts in the start next to the pic of the doctor
            children: const [
              Text(
                'dr.Djellouli Zakaria',// text name of the doctor
                style: TextStyle(
                  color: mButtonColor,// color of the text
                  fontSize: 18,// size of the text
                  fontWeight: FontWeight.bold,// weight of the text
                ),
              ),
              Text('Generalist',style: TextStyle(fontSize: 12),),// the role of the doctor
              Text('0xd5b6858a1858B6c25B2AC268bd92Ce4Da6C453dB',style: TextStyle(fontSize: 12),)
              // ethereum address of the doctor

            ],
          )
        ],
      ),
    );
  }
}
