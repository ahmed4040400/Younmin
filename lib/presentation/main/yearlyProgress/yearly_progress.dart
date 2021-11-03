import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/colors.dart';

class YearlyProgress extends StatelessWidget {
  const YearlyProgress({
    Key? key,
    required this.percentage,
  }) : super(key: key);

  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'the progress you\'ve made though this year',
      child: CircularPercentIndicator(
        animation: true,
        radius: 35.sp,
        lineWidth: 2.7.sp,
        percent: percentage / 100,
        backgroundColor: YounminColors.darkPrimaryColor,
        progressColor: YounminColors.primaryButtonColor,
        startAngle: 180,
        center: Text(
          percentage.toStringAsFixed(2) + "%",
          style: Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
