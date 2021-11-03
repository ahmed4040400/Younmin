import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/YounminWidgets/check_box.dart';
import 'package:younmin/globals/YounminWidgets/choose_feeling.dart';
import 'package:younmin/globals/colors.dart';
import 'package:younmin/logic/dailyTodo/daily_todo_cubit.dart';

class DailyTodoTile extends StatelessWidget {
  const DailyTodoTile(
      {Key? key,
      this.index,
      required this.item,
      required this.taskDoc,
      this.selectedDate})
      : super(key: key);

  final int? index;
  final QueryDocumentSnapshot<Map<String, dynamic>> item;
  final QueryDocumentSnapshot<Map<String, dynamic>> taskDoc;
  final DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
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
          builder: (_) => ChooseFeeling(
            onChoosed: (feelingNumber) {
              BlocProvider.of<DailyTodoCubit>(context).changeFeeling(context,
                  feeling: feelingNumber,
                  todoDoc: item,
                  taskDoc: taskDoc,
                  date: selectedDate);
            },
          ),
        );
      },
      contentPadding: EdgeInsets.zero,
      title: Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
          width: 10.sp,
          height: 10.sp,
          child: Image.asset("assets/images/emoji/${item["feeling"]}.png"),
        ),
      ),
      minLeadingWidth: 10.w,
      leading: Tooltip(
        message: "${(index ?? -1) + 1}.${item["todo"]}",
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 12.w),
          child: Text(
            "${(index ?? -1) + 1}.${item["todo"]}",
            overflow: TextOverflow.ellipsis,
            style:
                Theme.of(context).textTheme.headline3!.copyWith(fontSize: 5.sp),
          ),
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          YounminCheckBox(
            value: item["isChecked"],
            onChanged: (value) {
              BlocProvider.of<DailyTodoCubit>(context)
                  .changeIsChecked(value: value, todoDoc: item);
            },
          ),
          IconButton(
              padding: EdgeInsets.zero,
              iconSize: 10.sp,
              onPressed: () {
                BlocProvider.of<DailyTodoCubit>(context).deleteDailyTodo(
                    todoDoc: item, taskDoc: taskDoc, date: selectedDate);
              },
              icon: const FaIcon(Icons.close)),
        ],
      ),
    );
  }
}
