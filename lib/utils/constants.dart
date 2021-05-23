import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';

const COLOR_WHITE = Colors.white;
const COLOR_GREY = Colors.grey;
var deepPurple = Colors.deepPurple[100];
var indigo = Colors.indigo.shade300;
var colorPurple = Colors.deepPurple[300];
// Colors.purple.shade300;
var colorPurpleLight = Colors.purple[200];
var colorGrey = Colors.grey.withOpacity(0.35);

var buttonTextStyle = TextStyle(
  fontSize: 20,
  color: COLOR_WHITE,
);

var titleTextStyle = TextStyle(fontSize: 50, color: indigo);
var inputDecor = BoxDecoration(
    borderRadius: BorderRadius.circular(30),
    color: COLOR_GREY.withOpacity(0.4),
    boxShadow: [
      // BoxShadow(
      //   color: COLOR_GREY.withOpacity(0.5),
      //   blurRadius: 7,
      //   spreadRadius: 5,
      //   offset: Offset(0, 3),
      // )
    ]);
var colorGradiant = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: [indigo, colorPurpleLight],
);

var textTheme = TextTheme(
  headline3: TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ),

  bodyText1: TextStyle(
    color: Colors.black,
  ),
  // headline1: GoogleFonts.playfairDisplay(
  //   textStyle: TextStyle(
  //       fontSize: 18,
  //       fontWeight: FontWeight.w600,
  //       color: COLOR_BLACK,
  //       letterSpacing: 0),
  // ),
);
