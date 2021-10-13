import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/presentation/main/yearlyProgress/yearly_progress.dart';

import '../linear_progress.dart';

class OverAllYearlyProgress extends StatelessWidget {
  const OverAllYearlyProgress({
    Key? key,
    required this.yearlyPercentage,
    required this.monthlyPercentage,
  }) : super(key: key);

  final int yearlyPercentage;
  final int monthlyPercentage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(child: SizedBox(height: 3.h)),
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(left: 2.w),
            child: Align(
              heightFactor: 0.9,
              alignment: Alignment.centerLeft,
              child: Text(
                'Overall yearly progress',
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
        Flexible(child: SizedBox(height: 1.h)),
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(left: 2.w),
            child: Align(
              heightFactor: 0.9,
              alignment: Alignment.centerLeft,
              child: Text(
                'Goal 1: Learn spanish',
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
        Flexible(child: SizedBox(height: 5.h)),
        Align(
          alignment: Alignment.center,
          child: YearlyProgress(
            percentage: yearlyPercentage,
          ),
        ),
        Flexible(child: SizedBox(height: 5.h)),
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(left: 2.w),
            child: Align(
              heightFactor: 0.9,
              alignment: Alignment.centerLeft,
              child: Text(
                'This month',
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
        Flexible(child: SizedBox(height: 1.h)),
        Flexible(
          child: LinearProgress(
            percentage: monthlyPercentage,
          ),
        ),
      ],
    );
  }
}
