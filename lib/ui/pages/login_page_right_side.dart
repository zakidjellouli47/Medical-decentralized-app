import 'dart:ui';
import 'package:flutter/material.dart';
class LoginPageRightSide extends StatelessWidget {
  const LoginPageRightSide({super.key});
  @override
  Widget build(BuildContext context) {// the builder function of the login right side
    return Expanded(// to expand the rest of the screen
        child: Container(// container of the expanded widget
          color: Colors.lightBlue,// color of the container
          child: Container(
            decoration: const BoxDecoration(// fill the image inside the container
              image: DecorationImage(
                  image: AssetImage('assets/bg.jpg'),
                  fit: BoxFit.cover),
            ),
            child: Center( // put it in the center
              child: SizedBox(// create a sized box in the center
                height: 500,// height of the sized box
                child: Stack(// create a stack to overlap the widgets
                  children: [// children of the stack
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60.0),// padding the stack from left and right with 60 px
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),// circular radius of the stack with 40
                        child: BackdropFilter(
                          //https://www.youtube.com/watch?v=rBJBr4nuuuE
                          filter: ImageFilter.blur(sigmaY: 12, sigmaX: 12),// 12 is the number of the bluring effects on the x and y
                          // if we want to make it more blurry we would increase the values of sigmaY and sigmaX
                          child: Container(

                            color: Colors.white.withOpacity(0.3),//the opacity of white color


                          ),
                        ),
                      ),
                    ),

                      Padding(// padding of the hospital image
                        padding: const EdgeInsets.fromLTRB(70, 100, 50, 100),// padding from all
                        child: Image.asset('assets/images/h.png', width: 400,),// width 400 of the image
                      ),

                    Align(
                      alignment: Alignment.topRight,// alignment of the container in the top right
                      child: Container(// container of the text icon
                        height: 60,
                        width: 60,
                        alignment: Alignment.center,//align the icon text in the center of the container
                        margin: const EdgeInsets.only(right: 30,top: 100),// margin to  take space from the top and right
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,// circular box
                            color: Colors.white// color of the box
                        ),
                        child: const Text("🤞", style: TextStyle(fontSize: 24),),// icon text
                      ),
                    ),
                    Container(// container of the text icon
                      height: 60,
                      width: 60,
                      alignment: Alignment.center,// align the
                      margin: const EdgeInsets.only(left: 30,top: 300),// margin wih 30 px on the left and 300 px on the top
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,// circular box
                          color: Colors.white// color of the box
                      ),
                      child: const Text("🖐", style: TextStyle(fontSize: 24),),// icon text
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
