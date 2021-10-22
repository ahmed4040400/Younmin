import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../colors.dart';

// ignore: must_be_immutable
class YounminCheckBox extends StatefulWidget {
  YounminCheckBox({Key? key, required this.value, this.onChanged, this.size})
      : super(key: key) {}

  bool value;
  final void Function(bool?)? onChanged;
  final double? size;

  @override
  State<YounminCheckBox> createState() => _YounminCheckBoxState();
}

class _YounminCheckBoxState extends State<YounminCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: widget.size ?? 0.3.sp,
      child: Checkbox(
        checkColor: YounminColors.checkBoxColor,
        value: widget.value,
        // fillColor: MaterialStateProperty
        //     .all<Color>(Colors.transparent),
        activeColor: Colors.transparent,
        onChanged: (value) {
          print('change state');
          setState(() {
            widget.value = value!;
          });
          widget.onChanged!(value);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.0),
        ),
        side: BorderSide(width: 1.3, color: YounminColors.checkBoxColor),
      ),
    );
  }
}
