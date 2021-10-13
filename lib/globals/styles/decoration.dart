import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

BoxDecoration cardBoxDecoration = BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 10,
        offset: const Offset(0, 3), // changes position of shadow
      ),
    ],
    borderRadius: BorderRadius.circular(5.sp), // radius of 10
    color: Colors.white // green as background color
    );

BoxDecoration sideCardDecoration = BoxDecoration(boxShadow: [
  BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    spreadRadius: 5,
    blurRadius: 10,
    offset: const Offset(0, 3), // changes position of shadow
  ),
], color: Colors.white70 // green as background color
    );
