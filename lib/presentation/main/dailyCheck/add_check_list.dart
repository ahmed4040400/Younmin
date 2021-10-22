import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/logic/dailyCheckList/daily_check_cubit.dart';

class AddCheck extends StatelessWidget {
  const AddCheck({Key? key, required this.taskDoc}) : super(key: key);
  final QueryDocumentSnapshot<Map<String, dynamic>> taskDoc;
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
                child: const TextField(
                  decoration: InputDecoration(hintText: "Enter your task"),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 5.w),
              child: ElevatedButton(
                onPressed: () {
                  BlocProvider.of<DailyCheckCubit>(context)
                      .createCheck(context, taskDoc: taskDoc);
                },
                child: Text(
                  "Add check",
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
