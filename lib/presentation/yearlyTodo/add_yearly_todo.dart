import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/YounminWidgets/choose_feeling.dart';
import 'package:younmin/globals/colors.dart';

class AddYearlyTodo extends StatefulWidget {
  const AddYearlyTodo({Key? key}) : super(key: key);

  @override
  _AddYearlyTodoState createState() => _AddYearlyTodoState();
}

class _AddYearlyTodoState extends State<AddYearlyTodo> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2.sp),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: Container(
        width: 55.w,
        height: 50.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Add new goal for the year",
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 10.sp),
              ),
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Add new goal for the year",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: YounminColors.textHeadline1Color)),
                  ),
                  SizedBox(height: 1.h),
                  SizedBox(
                    height: 5.h,
                    width: double.infinity,
                    child: TextField(),
                  )
                ],
              ),
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("That feeling when you achieve your goal",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: YounminColors.textHeadline1Color)),
                  ),
                  SizedBox(height: 1.h),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(3.sp), // if you need this
                      side: const BorderSide(
                        color: YounminColors.textFieldColor,
                        width: 2,
                      ),
                    ),
                    child: Container(
                      color: Colors.transparent,
                      width: double.infinity,
                      height: 15.h,
                      child: ChooseFeeling(onChoosed: (feelingIndex) {}),
                    ),
                  )
                ],
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(Size(
                      double.infinity,
                      6.w,
                    )),
                  ),
                  child: Text(
                    'Add goal',
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: 7.sp),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
