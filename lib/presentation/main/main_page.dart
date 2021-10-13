import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:younmin/globals/YounminWidgets/logo_button.dart';
import 'package:younmin/globals/colors.dart';
import 'package:younmin/globals/styles/decoration.dart';
import 'package:younmin/presentation/main/recent_progress.dart';
import 'package:younmin/presentation/main/sentences/sentences_list.dart';
import 'package:younmin/presentation/main/yearlyProgress/overall_yearly_progress.dart';

import 'dailyCheck/daily_check_list.dart';
import 'yearlyTodo/daily_todo.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
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
                  backgroundImage: const AssetImage('assets/images/home/1.png'),
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
                          selectionMode: DateRangePickerSelectionMode.single,
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
                    child: const OverAllYearlyProgress(
                      monthlyPercentage: 78,
                      yearlyPercentage: 53,
                    ),
                  ),
                ),
              ],
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 15.sp),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: DailyTodo(),
                            flex: 7,
                          ),
                          SizedBox(width: 2.w),
                          const Expanded(
                            child: DailyCheckList(),
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
                        child: const RecentProgress(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            flex: 5,
          ),
        ],
      ),
    );
  }
}
