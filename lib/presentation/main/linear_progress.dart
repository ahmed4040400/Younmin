import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/colors.dart';

class LinearProgress extends StatelessWidget {
  const LinearProgress({
    Key? key,
    required this.percentage,
    this.backGroundColor = YounminColors.primaryButtonColor,
    this.progressColor = YounminColors.darkPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  final int percentage;
  final Color backGroundColor;
  final Color progressColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: Padding(
        padding: EdgeInsets.only(left: 1.5.w),
        child: LinearPercentIndicator(
          animation: true,
          lineHeight: 8.0,
          percent: percentage / 100,
          progressColor: backGroundColor,
          backgroundColor: progressColor,
          trailing: Text(
            percentage.toString() + "%",
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}
