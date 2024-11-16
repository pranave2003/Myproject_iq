import 'package:flutter/material.dart';

var mycolor = Colors.red;
var mycolor1 = Color.fromRGBO(44, 30, 103, 1.0);
var mycolor2 = Color.fromRGBO(139, 127, 197, 1.0);
var mycolor3 = Color.fromRGBO(237, 236, 246, 1.0);
var bgcolor=Color.fromRGBO(25, 24, 48, 0.7803921568627451);
var darkbg=Color.fromRGBO(16, 13, 46, 1.0);

class MyText extends StatelessWidget {
  final Color textcolor;
  final text;
  final double fontsize;
  final fontwaight;

  const MyText({
    super.key,
    required this.text,
    required this.textcolor,
    required this.fontsize,
    required this.fontwaight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: fontwaight,
        fontSize: fontsize,
        color: textcolor,
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  final double height;
  final double width;
  final String text;
  final VoidCallback onPressed;

  const MyButton({
    Key? key,
    required this.height,
    required this.width,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(colors: [mycolor1, mycolor2])),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
