import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/logic/dailyTodo/daily_todo_cubit.dart';

TextEditingController todoController = TextEditingController();

class AddTodo extends StatelessWidget {
  const AddTodo({Key? key, this.onChoosed, required this.taskDoc})
      : super(key: key);

  final QueryDocumentSnapshot<Map<String, dynamic>> taskDoc;

  final void Function(int feelingIndex)? onChoosed;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 20.h,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: SizedBox(
                height: 5.h,
                width: 35.w,
                child: TextField(
                  controller: todoController,
                  decoration: InputDecoration(hintText: "Enter your task"),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 5.w),
              child: ElevatedButton(
                onPressed: () async {
                  BlocProvider.of<DailyTodoCubit>(context).createDailyTodo(
                      context,
                      taskDoc: taskDoc,
                      todoController: todoController,
                      feeling: 1);
                },
                child: Text(
                  "Add todo",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
