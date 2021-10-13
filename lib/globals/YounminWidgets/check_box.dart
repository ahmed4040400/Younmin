import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../colors.dart';

class YounminCheckBox extends StatelessWidget {
  const YounminCheckBox(
      {Key? key, required this.value, this.onChanged, this.size})
      : super(key: key);

  final bool value;
  final void Function(bool?)? onChanged;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: size ?? 0.3.sp,
      child: Checkbox(
        checkColor: YounminColors.checkBoxColor,
        value: value,
        // fillColor: MaterialStateProperty
        //     .all<Color>(Colors.transparent),
        activeColor: Colors.transparent,
        onChanged: onChanged,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.0),
        ),
        side: BorderSide(width: 1.3, color: YounminColors.checkBoxColor),
      ),
    );
  }
}
