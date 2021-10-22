import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:younmin/globals/YounminWidgets/logo_button.dart';
import 'package:younmin/globals/colors.dart';
import 'package:younmin/globals/styles/decoration.dart';
import 'package:younmin/logic/dailyCheckList/daily_check_cubit.dart';
import 'package:younmin/logic/dailyTodo/daily_todo_cubit.dart';
import 'package:younmin/presentation/main/recent_progress.dart';
import 'package:younmin/presentation/main/sentences/sentences_list.dart';
import 'package:younmin/presentation/main/yearlyProgress/overall_yearly_progress.dart';

import 'dailyCheck/daily_check_list.dart';
import 'todo/daily_todo.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.taskDoc, required this.taskOrderNum})
      : super(key: key);

  final QueryDocumentSnapshot<Map<String, dynamic>> taskDoc;
  final int taskOrderNum;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => DailyTodoCubit()),
        BlocProvider(create: (BuildContext context) => DailyCheckCubit()),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(15.sp),
            child: AppBar(
              automaticallyImplyLeading: false,
              title: const LogoButton(
                textColor: Colors.white,
              ),
              actions: [
                IconButton(
                  iconSize: 10.sp,
                  splashRadius: 6.sp,
                  onPressed: () {},
                  icon: FaIcon(
                    FontAwesomeIcons.questionCircle,
                    color: YounminColors.primaryColor,
                  ),
                ),
                IconButton(
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
                      builder: (conext) => const Sentences(),
                    );
                  },
                  splashRadius: 6.sp,
                  icon: const FaIcon(
                    Icons.apps_rounded,
                    color: YounminColors.darkPrimaryColor,
                  ),
                  tooltip: "Sentences",
                ),
                Padding(
                  padding: EdgeInsets.only(right: 3.w),
                  child: IconButton(
                    iconSize: 20.sp,
                    splashRadius: 9.sp,
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    icon: CircleAvatar(
                      backgroundImage:
                          const AssetImage('assets/images/home/1.png'),
                      backgroundColor: YounminColors.primaryColor,
                      radius: 20.sp,
                    ),
                    tooltip: "profile",
                  ),
                ),
              ],
            ),
          ),
          body: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        color: YounminColors.darkPrimaryColor,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(3.w, 10.h, 3.w, 4.h),
                          child: Container(
                            decoration: cardBoxDecoration,
                            child: SfDateRangePicker(
                              selectionColor: YounminColors.primaryColor,
                              rangeSelectionColor: YounminColors.primaryColor,
                              todayHighlightColor: YounminColors.primaryColor,
                              onSelectionChanged:
                                  (DateRangePickerSelectionChangedArgs args) {
                                print(args.value);
                              },
                              selectionMode:
                                  DateRangePickerSelectionMode.single,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: YounminColors.primaryColor,
                        child: OverAllYearlyProgress(
                          monthlyPercentage: widget.taskDoc["progress"]
                              ["monthly"],
                          yearlyPercentage: widget.taskDoc["progress"]
                              ["yearly"],
                        ),
                      ),
                    ),
                  ],
                ),
                flex: 2,
              ),
              Expanded(
                child: Column(
                  children: [
                    Align(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 3.h, horizontal: 2.5.w),
                        child: Text(
                          "Goal${widget.taskOrderNum}: ${widget.taskDoc['goal']}",
                          style: Theme.of(context).textTheme.headline2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: DailyTodo(
                                taskDoc: widget.taskDoc,
                              ),
                              flex: 7,
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: DailyCheckList(taskDoc: widget.taskDoc),
                              flex: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(5.sp),
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: cardBoxDecoration,
                          child: RecentProgress(
                            taskDoc: widget.taskDoc,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                flex: 5,
              ),
            ],
          ),
        );
      }),
    );
  }
}
