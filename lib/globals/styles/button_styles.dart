import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../colors.dart';

final textButtonStyle = ButtonStyle(
  overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
  splashFactory: NoSplash.splashFactory,
);

final elevatedButtonStyle = ButtonStyle(
  shape: MaterialStateProperty.all(
    const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
  ),
  backgroundColor:
      MaterialStateProperty.all<Color>(YounminColors.primaryButtonColor),
  minimumSize: MaterialStateProperty.all<Size>(Size(
    21.w,
    6.w,
  )),
);
