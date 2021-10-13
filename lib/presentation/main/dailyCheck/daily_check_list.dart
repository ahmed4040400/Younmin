import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/YounminWidgets/check_box.dart';
import 'package:younmin/globals/colors.dart';
import 'package:younmin/globals/styles/decoration.dart';
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

class DailyCheckList extends StatefulWidget {
  const DailyCheckList({Key? key}) : super(key: key);

  @override
  State<DailyCheckList> createState() => _DailyCheckListState();
}

class _DailyCheckListState extends State<DailyCheckList> {
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
                      "Goal 1: ",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                ),
                IconButton(
                  color: YounminColors.darkPrimaryColor,
                  iconSize: 10.sp,
                  onPressed: () {
                    showModalBottomSheet<dynamic>(
                      backgroundColor: YounminColors.backGroundColor,
                      shape: RoundedRectangleBorder(
                        //the rounded corner is created here
                        borderRadius: BorderRadius.circular(5.sp),
                      ),
                      isScrollControlled: true,
                      context: context,
                      builder: (conext) => const AddCheck(),
                    );
                  },
                  icon: FaIcon(Icons.add_circle_outline),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.fromLTRB(2.sp, 5.sp, 2.sp, 2.sp),
              itemBuilder: (_, index) {
                return ListTile(
                  minLeadingWidth: 10.w,
                  leading: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 10.w),
                    child: Text(
                      "${index + 1}.${checkList[index]}",
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
              itemCount: checkList.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          )
        ],
      ),
    );
  }
}
