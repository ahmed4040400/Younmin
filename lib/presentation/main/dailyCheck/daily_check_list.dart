import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/YounminWidgets/check_box.dart';
import 'package:younmin/globals/colors.dart';
import 'package:younmin/globals/styles/decoration.dart';
import 'package:younmin/logic/dailyCheckList/daily_check_cubit.dart';
import 'package:younmin/presentation/main/dailyCheck/add_check_list.dart';

List<String> checkList = [
  "Lorem ipsum",
  "have coffee",
  "have breakfast",
  "go to the gym",
  "go to work",
  "watch a spanish movie",
  "learn 50 words of spanish"
];

List<bool> isChecked = List.generate(checkList.length, (index) => false);

class DailyCheckList extends StatelessWidget {
  const DailyCheckList({Key? key, required this.taskDoc, this.selectedDate})
      : super(key: key);
  final DateTime? selectedDate;
  final QueryDocumentSnapshot<Map<String, dynamic>> taskDoc;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DailyCheckCubit>(context)
        .getCheck(taskDoc: taskDoc, date: selectedDate);
    return Container(
      decoration: cardBoxDecoration,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 3.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    child: Text(
                      "Daily checklist",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: "add a check",
                  color: YounminColors.darkPrimaryColor,
                  iconSize: 10.sp,
                  onPressed: () {
                    AwesomeDialog(
                            context: context,
                            dialogType: DialogType.SUCCES,
                            headerAnimationLoop: false,
                            animType: AnimType.BOTTOMSLIDE,
                            body: AddCheck(
                              taskDoc: taskDoc,
                            ),
                            btnOkText: "Add check",
                            btnOkOnPress: () {
                              BlocProvider.of<DailyCheckCubit>(context)
                                  .createCheck(context,
                                      taskDoc: taskDoc,
                                      checkController: checkController,
                                      date: selectedDate);
                            },
                            btnCancelOnPress: () {})
                        .show();
                  },
                  icon: const FaIcon(Icons.add_circle_outline),
                )
              ],
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: BlocBuilder<DailyCheckCubit, DailyCheckState>(
                builder: (context, state) {
              return ImplicitlyAnimatedList(
                  items: state.dailyCheckDocs,
                  controller: ScrollController(),
                  padding: EdgeInsets.fromLTRB(2.sp, 5.sp, 2.sp, 2.sp),
                  itemBuilder: (BuildContext _,
                      animation,
                      QueryDocumentSnapshot<Map<String, dynamic>> item,
                      int index) {
                    return SizeFadeTransition(
                      sizeFraction: 0.2,
                      curve: Curves.easeInOut,
                      animation: animation,
                      child: ListTile(
                        minLeadingWidth: 10.w,
                        leading: Tooltip(
                          message: "${index + 1}.${item["check"]}",
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 7.w),
                            child: Text(
                              "${index + 1}.${item["check"]}",
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(fontSize: 5.sp),
                            ),
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            YounminCheckBox(
                              value: item["isChecked"],
                              onChanged: (value) {
                                BlocProvider.of<DailyCheckCubit>(context)
                                    .changeIsChecked(
                                        value: value, checkDoc: item);
                              },
                            ),
                            IconButton(
                                iconSize: 10.sp,
                                onPressed: () {
                                  BlocProvider.of<DailyCheckCubit>(context)
                                      .deleteCheck(
                                          checkDoc: item,
                                          taskDoc: taskDoc,
                                          date: selectedDate);
                                },
                                icon: FaIcon(Icons.close)),
                          ],
                        ),
                      ),
                    );
                  },
                  areItemsTheSame:
                      (QueryDocumentSnapshot<Map<String, dynamic>> oldItem,
                              QueryDocumentSnapshot<Map<String, dynamic>>
                                  newItem) =>
                          oldItem["date"] == newItem["date"],
                  removeItemBuilder: (context, animation,
                      QueryDocumentSnapshot<Map<String, dynamic>> oldItem) {
                    return FadeTransition(
                        opacity: animation,
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          minLeadingWidth: 10.w,
                          leading: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 10.w),
                            child: Text(
                              "0.${oldItem["check"]}",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              YounminCheckBox(
                                value: oldItem["isChecked"],
                                onChanged: (value) {},
                              ),
                              IconButton(
                                  iconSize: 10.sp,
                                  onPressed: () {},
                                  icon: const FaIcon(Icons.close)),
                            ],
                          ),
                        ));
                  }
                  // itemCount: checkList.length,
                  // separatorBuilder: (BuildContext context, int index) =>
                  //     const Divider(),
                  );
            }),
          )
        ],
      ),
    );
  }
}
