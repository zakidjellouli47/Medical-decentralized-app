import 'package:flutter/material.dart';
import 'package:med/constant.dart';

class UserInfo_Gastro extends StatelessWidget {
  const UserInfo_Gastro ({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),//padding 15px from the left
      child: Row(//row
        children: [//children widgets of the row
          Image.asset(
            'assets/images/avatar2.png',// the doctor image
            width: 100,// the size of image width
            height: 100,// the size of image height
          ),
          const SizedBox(width: 24),// space between the image and the column
          Column(// calling the widget child which is the column
            crossAxisAlignment: CrossAxisAlignment.start,// align the texts in the start next to the pic of the doctor
            children: const [
              Text(
                'dr.Bakhti karim',// text name of the doctor
                style: TextStyle(
                  color: mButtonColor,// color of the text
                  fontSize: 18,// size of the text
                  fontWeight: FontWeight.bold,// weight of the text
                ),
              ),
              Text('Gastrology Doctor',style: TextStyle(fontSize: 12),),// the role of the doctor
              Text('0x386C1c9161Af48fC3C0563119A3C3e0a21378ff1',style: TextStyle(fontSize: 12)),
              // ethereum address of the doctor
            ],
          )
        ],
      ),
    );
  }
}
