import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/Strings/main_page_strings.dart';
import 'package:younmin/globals/colors.dart';
import 'package:younmin/logic/helping_functions.dart';
import 'package:younmin/logic/history/history_cubit.dart';

import 'linear_progress.dart';

class RecentProgress extends StatelessWidget {
  const RecentProgress({
    Key? key,
    required this.taskDoc,
  }) : super(key: key);

  final QueryDocumentSnapshot<Map<String, dynamic>> taskDoc;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HistoryCubit>(context).getHistory(taskDoc: taskDoc);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
      child: Column(
        children: [
          Tooltip(
            message: 'the progress you have made through this goal',
            child: FractionallySizedBox(
              widthFactor: 1,
              child: Text(
                MainPageStrings.recentProgress,
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                MainPageStrings.day,
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                MainPageStrings.completed,
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                MainPageStrings.mostlyFeltEmotions,
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
          Expanded(
            child: BlocBuilder<HistoryCubit, HistoryState>(
                builder: (context, state) {
              return ImplicitlyAnimatedList(
                padding: EdgeInsets.only(top: 2.h),
                items: state.history.reversed.toList(),
                itemBuilder: (_, animation,
                    QueryDocumentSnapshot<Map<String, dynamic>> item, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    minLeadingWidth: 10.w,
                    leading: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 10.w),
                      child: Text(
                        formatDate(item["date"]),
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(fontSize: 4.sp),
                      ),
                    ),
                    title: Padding(
                      padding: EdgeInsets.only(left: 1.5.w),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: 1,
                        child: LinearProgress(
                          percentage: item["dailyProgress"] ?? 0,
                          progressColor: YounminColors.darkPrimaryColor,
                          backGroundColor: YounminColors.primaryButtonColor,
                          textColor: Colors.black,
                        ),
                      ),
                    ),
                    trailing: Container(
                      margin: EdgeInsets.only(right: 10.w),
                      width: 10.sp,
                      height: 10.sp,
                      child: Image.asset(
                        "assets/images/emoji/${item["mostlyFelt"]}.png",
                      ),
                    ),
                  );
                },
                areItemsTheSame: (QueryDocumentSnapshot<Map<String, dynamic>>
                            oldItem,
                        QueryDocumentSnapshot<Map<String, dynamic>> newItem) =>
                    oldItem["date"] == newItem["date"],
              );
            }),
          ),
        ],
      ),
    );
  }
}
