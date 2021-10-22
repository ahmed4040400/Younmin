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

class DailyTodo extends StatefulWidget {
  const DailyTodo({Key? key, required this.taskDoc}) : super(key: key);

  final QueryDocumentSnapshot<Map<String, dynamic>> taskDoc;

  @override
  _DailyTodoState createState() => _DailyTodoState();
}

class _DailyTodoState extends State<DailyTodo> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DailyTodoCubit>(context)
        .getDailyTodo(taskDoc: widget.taskDoc);
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
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 20.w),
                      child: Text(
                        "Today's tasks",
                        style: Theme.of(context).textTheme.headline2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  color: YounminColors.darkPrimaryColor,
                  iconSize: 10.sp,
                  icon: const FaIcon(Icons.add_circle_outline),
                  onPressed: () {
                    showModalBottomSheet<dynamic>(
                      backgroundColor: YounminColors.backGroundColor,
                      shape: RoundedRectangleBorder(
                        //the rounded corner is created here
                        borderRadius: BorderRadius.circular(5.sp),
                      ),
                      isScrollControlled: true,
                      context: context,
                      builder: (_) => BlocProvider.value(
                          value: BlocProvider.of<DailyTodoCubit>(context),
                          child: AddTodo(
                            taskDoc: widget.taskDoc,
                          )),
                    );
                  },
                )
              ],
            ),
          ),
          Expanded(
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
