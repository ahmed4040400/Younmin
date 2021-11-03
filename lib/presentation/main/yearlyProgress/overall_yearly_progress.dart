import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/Strings/main_page_strings.dart';
import 'package:younmin/presentation/main/yearlyProgress/yearly_progress.dart';

import '../linear_progress.dart';
import '../main_page.dart';

class OverAllYearlyProgress extends StatelessWidget {
  const OverAllYearlyProgress({
    Key? key,
    required this.yearlyPercentage,
    required this.monthlyPercentage,
  }) : super(key: key);

  final double yearlyPercentage;
  final double monthlyPercentage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 3.h),
        Padding(
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
        SizedBox(height: 1.h),
        Padding(
          padding: EdgeInsets.only(left: 2.w),
          child: Align(
            heightFactor: 0.9,
            alignment: Alignment.centerLeft,
            child: Text(
              "${MainPageStrings.goal}: ${taskDoc['goal']}",
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
        SizedBox(height: 5.h),
        Align(
          alignment: Alignment.center,
          child: YearlyProgress(
            percentage: yearlyPercentage,
          ),
        ),
        SizedBox(height: 5.h),
        Padding(
          padding: EdgeInsets.only(left: 2.w),
          child: Align(
            heightFactor: 0.9,
            alignment: Alignment.centerLeft,
            child: Text(
              MainPageStrings.thisMonth,
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
        SizedBox(height: 1.h),
        Tooltip(
          message: "the progress you've made though this month",
          child: LinearProgress(
            percentage: monthlyPercentage,
          ),
        ),
      ],
    );
  }
}
