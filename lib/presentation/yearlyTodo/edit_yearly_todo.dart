import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/YounminWidgets/choose_feeling.dart';
import 'package:younmin/globals/colors.dart';
import 'package:younmin/logic/yearlyTodo/yearly_todo_cubit.dart';

class EditYearlyTodo extends StatefulWidget {
  const EditYearlyTodo({Key? key, required this.taskDoc}) : super(key: key);

  final QueryDocumentSnapshot<Map<String, dynamic>> taskDoc;

  @override
  _EditYearlyTodoState createState() => _EditYearlyTodoState();
}

int feeling = 1;
TextEditingController goalController = TextEditingController();

class _EditYearlyTodoState extends State<EditYearlyTodo> {
  @override
  void initState() {
    goalController.text = widget.taskDoc['goal'];
    super.initState();
  }

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
                "Edit your goal",
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 10.sp),
              ),
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("what do you wanna do for this year",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: YounminColors.textHeadline1Color)),
                  ),
                  SizedBox(height: 1.h),
                  SizedBox(
                    height: 5.h,
                    width: double.infinity,
                    child: TextField(
                      controller: goalController,
                      style: Theme.of(context).textTheme.headline3,
                    ),
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
                      child: ChooseFeeling(onChoosed: (feelingNum) {
                        feeling = feelingNum;
                      }),
                    ),
                  )
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<YearlyTodoCubit>(context).updateYearlyTodo(
                        context,
                        goalController: goalController,
                        feeling: feeling,
                        doc: widget.taskDoc);
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(Size(
                      double.infinity,
                      6.w,
                    )),
                  ),
                  child: Text(
                    'Edit goal',
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
