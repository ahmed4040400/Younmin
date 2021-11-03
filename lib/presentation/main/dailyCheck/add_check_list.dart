import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

TextEditingController checkController = TextEditingController();

class AddCheck extends StatelessWidget {
  const AddCheck({Key? key, required this.taskDoc}) : super(key: key);
  final QueryDocumentSnapshot<Map<String, dynamic>> taskDoc;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "add your check",
            style: Theme.of(context).textTheme.headline2,
          ),
          SizedBox(height: 5.h),
          SizedBox(
            height: 10.h,
            width: 35.w,
            child: TextField(
              autofocus: true,
              controller: checkController,
              decoration: const InputDecoration(hintText: "Enter your check"),
            ),
          ),
          SizedBox(height: 5.h),
        ],
      ),
    );
  }
}
