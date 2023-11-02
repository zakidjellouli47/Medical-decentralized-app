

import 'package:flutter/material.dart';

import 'package:med/ui/pages/login_page_right_side.dart';

import 'login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {// the build function
    return Scaffold(// create a scaffold that shows the app screen
      backgroundColor: Colors.amber.shade100,//
      body: Center(// the body in the center
        child: SingleChildScrollView(// use it to avoid render flex errors
          child: Container(// creating the container of the box
            height: 640,
            width: 1080,
            //https://medium.com/@amorenew/use-clipbehavior-clip-antialiaswithsavelayer-to-remove-rectangle-area-4a7a9f3e4f28
            clipBehavior: Clip.antiAliasWithSaveLayer,
            // used to remove rectangle areas
            decoration: BoxDecoration(// create a box decoration
              borderRadius: BorderRadius.circular(36),// circular with 36
              color: Colors.white,// color or the border is white
            ),
            child: Row(// row
              children: [// children of the row
                const LoginPageLeft(),// call the left side of login in the row
                   const LoginPageRightSide(),// call the right side of login in the row
              ],
            ),
          ),
        ),
      ),
    );
  }
}
