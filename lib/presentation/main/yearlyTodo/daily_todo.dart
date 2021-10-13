import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/YounminWidgets/check_box.dart';
import 'package:younmin/globals/colors.dart';
import 'package:younmin/globals/styles/decoration.dart';

import '../../../globals/YounminWidgets/choose_feeling.dart';
import 'add_todo.dart';

List<String> todayTasks = [
  "Lorem ipsum",
  "have coffee",
  "have breakfast",
  "go to the gym",
  "go to work",
  "watch a spanish movie",
  "learn 50 words of spanish"
];

String imageAsset = "assets/images/emoji/1.png";

List<bool> isChecked = List.generate(todayTasks.length, (index) => false);

class DailyTodo extends StatefulWidget {
  @override
  _DailyTodoState createState() => _DailyTodoState();
}

class _DailyTodoState extends State<DailyTodo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: cardBoxDecoration,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 3.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    child: Text(
                      "Goal 1: Learn spanish",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                ),
                IconButton(
                  color: YounminColors.darkPrimaryColor,
                  iconSize: 10.sp,
                  icon: FaIcon(Icons.add_circle_outline),
                  onPressed: () {
                    showModalBottomSheet<dynamic>(
                      backgroundColor: YounminColors.backGroundColor,
                      shape: RoundedRectangleBorder(
                        //the rounded corner is created here
                        borderRadius: BorderRadius.circular(5.sp),
                      ),
                      isScrollControlled: true,
                      context: context,
                      builder: (conext) => AddTodo(),
                    );
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.fromLTRB(2.sp, 5.sp, 2.sp, 2.sp),
              itemBuilder: (_, index) {
                return ListTile(
                  onTap: () {
                    showModalBottomSheet<dynamic>(
                      backgroundColor: YounminColors.backGroundColor,
                      shape: RoundedRectangleBorder(
                        //the rounded corner is created here
                        borderRadius: BorderRadius.circular(5.sp),
                      ),
                      isScrollControlled: true,
                      context: context,
                      builder: (conext) => ChooseFeeling(
                        onChoosed: (feelingIndex) {
                          setState(() {
                            imageAsset =
                                "assets/images/emoji/${feelingIndex + 1}.png";
                          });
                        },
                      ),
                    );
                  },
                  title: SizedBox(
                    width: 8.sp,
                    height: 8.sp,
                    child: Image.asset(imageAsset),
                  ),
                  minLeadingWidth: 10.w,
                  leading: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 10.w),
                    child: Text(
                      "${index + 1}.${todayTasks[index]}",
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  trailing: YounminCheckBox(
                    value: isChecked[index],
                    onChanged: (value) {
                      setState(() {
                        isChecked[index] = value!;
                      });
                    },
                  ),
                );
              },
              itemCount: todayTasks.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          )
        ],
      ),
    );
  }
}
