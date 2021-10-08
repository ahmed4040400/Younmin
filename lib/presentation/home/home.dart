import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/Strings/home_page_strings.dart';

import 'app_bar_buttons.dart';
import 'home_row/resbonsive_home_row.dart';

late ScrollController scrollController = ScrollController();

// to iterate through in the listBuilder and set it to true to start the animation
// based on the order
List<bool> animateApproveList = [true, false, false, false];

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScrollAppBar(
        controller: scrollController,
        toolbarHeight: 10.h, // double
        title: Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: Logo(
            onPressed: () {},
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 2.w, top: 3.h),
            child: SignUp(
              onPressed: () {},
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 3.w, top: 3.5.h),
            child: Login(
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Scrollbar(
        controller: scrollController,
        child: InViewNotifierList(
          controller: scrollController,
          isInViewPortCondition:
              (double deltaTop, double deltaBottom, double vpHeight) {
            return deltaTop < (0.5 * vpHeight) &&
                deltaBottom > (0.5 * vpHeight);
          },
          itemCount: 4,
          builder: (BuildContext context, int index) {
            return InViewNotifierWidget(
                key: UniqueKey(),
                id: index.toString(),
                builder: (BuildContext context, bool isInView, Widget? child) {
                  if (isInView) animateApproveList[index] = true;
                  print(animateApproveList[index]);
                  return ResponsiveHomeRow(
                    animate: isInView,
                    alignFromStart: (index + 1) % 2 != 0,
                    mainText: mainTextStringList[index],
                    subText: subTextStringList[index],
                    imageAsset:
                        AssetImage('assets/images/home/${index + 1}.png'),
                    mainTextSize: index == 0 ? 15.sp : 10.sp,
                    mainTextConstraint: index == 0 ? 60.w : 40.w,
                    subTextConstraint: index == 0 ? 53.w : 35.w,
                  );
                });
          },
        ),
      ),
    );
  }
}

//
// ListView(
// controller: scrollController,
// children: [
// Container(
// decoration: const BoxDecoration(
// image: DecorationImage(
// image: AssetImage(
// 'assets/images/home/background.png'), //?? AssetImage('assets/images/image1.jpg'),
// fit: BoxFit.cover,
// ),
// ),
// child: Column(
// children: [
// ResponsiveHomeRow(
// animate: true,
// alignFromStart: true,
// mainText: HomePageStrings1.mainText,
// subText: HomePageStrings1.subText,
// imageAsset: const AssetImage('assets/images/home/1.png'),
// mainTextSize: 15.sp,
// mainTextConstraint: 60.w,
// subTextConstraint: 53.w,
// ),
// ResponsiveHomeRow(
// animate: true,
// alignFromStart: false,
// mainText: HomePageStrings2.mainText,
// subText: HomePageStrings2.subText,
// imageAsset: const AssetImage('assets/images/home/2.png'),
// mainTextSize: 10.sp,
// mainTextConstraint: 50.w,
// subTextConstraint: 40.w,
// ),
// ResponsiveHomeRow(
// animate: true,
// alignFromStart: true,
// mainText: HomePageStrings3.mainText,
// subText: HomePageStrings3.subText,
// imageAsset: const AssetImage('assets/images/home/3.png'),
// mainTextSize: 10.sp,
// mainTextConstraint: 35.w,
// subTextConstraint: 30.w,
// ),
// ResponsiveHomeRow(
// animate: true,
// alignFromStart: false,
// mainText: HomePageStrings4.mainText,
// subText: HomePageStrings4.subText,
// imageAsset: const AssetImage('assets/images/home/4.png'),
// mainTextSize: 10.sp,
// mainTextConstraint: 50.w,
// subTextConstraint: 30.w,
// ),
// Padding(
// padding: EdgeInsets.only(bottom: 15.h),
// child: Subscribe(
// onPressed: () {},
// ),
// ),
//
//
// ],
// ),
// ),
// ],
// ),
