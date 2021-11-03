import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/colors.dart';
import 'package:younmin/globals/styles/decoration.dart';
import 'package:younmin/logic/dailyTodo/daily_todo_cubit.dart';
import 'package:younmin/presentation/main/todo/daily_todo_tile.dart';

import '../main_page.dart';
import 'add_todo.dart';

class DailyTodo extends StatefulWidget {
  const DailyTodo({Key? key, required this.taskDoc, this.selectedDate})
      : super(key: key);

  final QueryDocumentSnapshot<Map<String, dynamic>> taskDoc;
  final DateTime? selectedDate;

  @override
  _DailyTodoState createState() => _DailyTodoState();
}

class _DailyTodoState extends State<DailyTodo> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DailyTodoCubit>(context)
        .getDailyTodo(taskDoc: widget.taskDoc, date: widget.selectedDate);
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
                  child: Text(
                    "Today's tasks",
                    style: Theme.of(context).textTheme.headline2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  fit: FlexFit.loose,
                ),
                IconButton(
                  tooltip: "add a task",
                  color: YounminColors.darkPrimaryColor,
                  iconSize: 10.sp,
                  icon: const FaIcon(Icons.add_circle_outline),
                  onPressed: () {
                    AwesomeDialog(
                            context: context,
                            dialogType: DialogType.SUCCES,
                            headerAnimationLoop: false,
                            animType: AnimType.BOTTOMSLIDE,
                            body: AddTodo(
                              taskDoc: widget.taskDoc,
                            ),
                            btnOkText: "Add task",
                            btnOkOnPress: () {
                              BlocProvider.of<DailyTodoCubit>(context)
                                  .createDailyTodo(context,
                                      taskDoc: taskDoc,
                                      todoController: todoController,
                                      feeling: 1,
                                      date: widget.selectedDate);
                            },
                            btnCancelOnPress: () {})
                        .show();
                  },
                )
              ],
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: BlocBuilder<DailyTodoCubit, DailyTodoState>(
                builder: (BuildContext context, state) {
              return ImplicitlyAnimatedList(
                items: state.dailyTodoDocs,
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
                      child: BlocProvider.value(
                        value: BlocProvider.of<DailyTodoCubit>(context),
                        child: DailyTodoTile(
                          taskDoc: widget.taskDoc,
                          item: item,
                          index: index,
                          selectedDate: widget.selectedDate,
                        ),
                      ));
                },
                // separatorBuilder: (BuildContext context, int index) =>
                //     const Divider(),
                areItemsTheSame: (QueryDocumentSnapshot<Map<String, dynamic>>
                            oldItem,
                        QueryDocumentSnapshot<Map<String, dynamic>> newItem) =>
                    oldItem['date'] == newItem['date'],
                removeItemBuilder: (context, animation,
                    QueryDocumentSnapshot<Map<String, dynamic>> oldItem) {
                  return FadeTransition(
                    opacity: animation,
                    child: BlocProvider.value(
                        value: BlocProvider.of<DailyTodoCubit>(context),
                        child: DailyTodoTile(
                            taskDoc: widget.taskDoc, item: oldItem)),
                  );
                },
              );
            }),
          )
        ],
      ),
    );
  }
}
