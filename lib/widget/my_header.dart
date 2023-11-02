import 'package:flutter/material.dart';

class MyHeader extends StatelessWidget {
  final double height;// declaring  the height of the header
  final String imageUrl;// declaring the image asset of the header
  final Widget child;// declaring child widget of the header which is the column


  const MyHeader({// the header constractor
    //https://stackoverflow.com/questions/54181838/flutter-required-keyword
    required this.height,// required keyword because it's required to give the object height value ,an annotation that will create a warning for you to remember that the named parameter is necessary for the class to work as expected.
    required this.imageUrl,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(// clip path to have your unique shape
      clipper: MyCliper(),// calling clipper function in order to get a curved ui
      child: Container(// the container that contains the clipper

        height: height,
        width: double.infinity,// taking the whole width of the container
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(imageUrl), fit: BoxFit.fill),//loading the image inside the container
        ),
        child: child,// the child widget of the header which is the column
      ),
    );
  }
}
//https://www.youtube.com/watch?v=8QdLBQhnHAQ
class MyCliper extends CustomClipper<Path> {// clipper function that builds a curved ui
  @override
  Path getClip(Size size) {// function getClip takes the size as an argument
    var path = Path();//creating a new path

    path.lineTo(0, size.height); // starting point p0  from 0 to the height
    var first = Offset(size.width / 4.5, size.height-40);// the controlling point p1

    var end  = Offset(size.width / 2.25, size.height);// the final point p2 , the reach point
    path.quadraticBezierTo(first.dx , first.dy,end.dx,end.dy);

    
    var secondFirst = Offset(size.width / 1.5,size.height -40);// the controlling point p3
    var secondEnd = Offset(size.width, size.height);//the final point p4, the reach point
    path.quadraticBezierTo(secondFirst.dx, secondFirst.dy,secondEnd.dx,secondEnd.dy);// the controlling point p3
    path.lineTo(size.width,0);// ending point
    path.close();// closing the path
    return path;// returning the result path
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
