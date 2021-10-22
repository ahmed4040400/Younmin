import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/colors.dart';

import 'linear_progress.dart';

List<String> todayTasks = [
  "Lorem ipsum",
  "have coffee",
  "have breakfast",
  "go to the gym",
  "go to work",
  "watch a spanish movie",
  "learn 50 words of spanish"
];

class RecentProgress extends StatelessWidget {
  const RecentProgress({
    Key? key,
    required this.taskDoc,
  }) : super(key: key);

  final QueryDocumentSnapshot<Map<String, dynamic>> taskDoc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
      child: Column(
        children: [
          FractionallySizedBox(
            widthFactor: 1,
            child: Text(
              "Recent progress",
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Day",
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                "Completed",
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                "mostly felt emotions",
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(top: 2.h),
              itemBuilder: (_, index) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  minLeadingWidth: 10.w,
                  leading: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 10.w),
                    child: Text(
                      "${index + 1}.${todayTasks[index]}",
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  title: Padding(
                    padding: EdgeInsets.only(left: 1.5.w),
                    child: const FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: 1,
                      child: LinearProgress(
                        percentage: 70,
                        progressColor: YounminColors.darkPrimaryColor,
                        backGroundColor: YounminColors.primaryButtonColor,
                        textColor: Colors.black,
                      ),
                    ),
                  ),
                  trailing: Container(
                    margin: EdgeInsets.only(right: 10.w),
                    width: 7.sp,
                    height: 7.sp,
                    child: Image.asset(
                      "assets/images/emoji/1.png",
                    ),
                  ),
                );
              },
              itemCount: todayTasks.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          ),
        ],
      ),
    );
  }
}
