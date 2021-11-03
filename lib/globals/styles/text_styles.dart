import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/colors.dart';

final TextStyle headline1Style = GoogleFonts.fredokaOne(
    textStyle: TextStyle(
        fontSize: 50,
        fontWeight: FontWeight.w900,
        color: YounminColors.textHeadline1Color));

final TextStyle headline2Style = GoogleFonts.lato(
  textStyle: TextStyle(fontSize: 6.sp, color: YounminColors.darkPrimaryColor),
  fontWeight: FontWeight.w900,
);
final TextStyle headline3Style = GoogleFonts.lato(
  textStyle:
      const TextStyle(fontSize: 20, color: YounminColors.textHeadline1Color),
  fontWeight: FontWeight.w900,
);

final TextStyle body1 = GoogleFonts.lato(
  textStyle: TextStyle(fontSize: 4.sp, color: Colors.black),
  fontWeight: FontWeight.w900,
);
final TextStyle body2 = GoogleFonts.lato(
  textStyle: const TextStyle(fontSize: 12, color: Colors.black),
  fontWeight: FontWeight.w900,
);

final TextStyle headline4Style = GoogleFonts.lato(
  textStyle: TextStyle(fontSize: 4.sp, color: YounminColors.darkPrimaryColor),
  fontWeight: FontWeight.w900,
);
