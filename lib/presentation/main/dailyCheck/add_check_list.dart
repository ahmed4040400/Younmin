import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AddCheck extends StatelessWidget {
  const AddCheck({Key? key, this.onChoosed}) : super(key: key);

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
                child: const TextField(
                  decoration: InputDecoration(hintText: "Enter your task"),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 5.w),
              child: ElevatedButton(
                onPressed: () {},
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
