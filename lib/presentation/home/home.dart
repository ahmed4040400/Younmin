import 'package:animate_do/animate_do.dart';
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/Strings/home_page_strings.dart';
import 'package:younmin/globals/YounminWidgets/login_button.dart';
import 'package:younmin/globals/YounminWidgets/logo_button.dart';
import 'package:younmin/presentation/home/subscribe.dart';
import 'package:younmin/router/router.gr.dart';

import 'app_bar_buttons.dart';
import 'home_row/resbonsive_home_row.dart';

late ScrollController scrollController = ScrollController();

// to iterate through in the listBuilder and set it to true to start the animation
// based on the order
List<bool> animateApproveList = [true, false, false, false, false];

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: ScrollAppBar(
        automaticallyImplyLeading: false,
        controller: scrollController,
        toolbarHeight: 80, // double
        title: Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: const LogoButton(),
        ),
        actions: <Widget>[
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(right: 2.w, top: 3.h),
              child: SignUpButton(
                onPressed: () {
                  context.router.navigate(const SignUpRoute());
                },
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(right: 3.w, top: 3.5.h),
              child: LoginButton(
                onPressed: () {
                  context.router.navigate(const LoginRoute());
                },
              ),
            ),
          ),
        ],
      ),
      body: Scrollbar(
        controller: scrollController,
        child: InViewNotifierList(
          physics: const ClampingScrollPhysics(),
          controller: scrollController,
          isInViewPortCondition:
              (double deltaTop, double deltaBottom, double vpHeight) {
            return deltaTop < (0.65 * vpHeight) &&
                deltaBottom > (0.5 * vpHeight);
          },
          itemCount: 5,
          builder: (BuildContext context, int index) {
            return InViewNotifierWidget(
              id: index.toString(),
              builder: (BuildContext context, bool isInView, Widget? child) {
                if (isInView) animateApproveList[index] = true;
                if ((index + 1) % 2 != 0 && index < 4) {
                  return FadeInLeft(
                    animate: animateApproveList[index],
                    child: ResponsiveHomeRow(
                        alignFromStart: (index + 1) % 2 != 0,
                        mainText: mainTextStringList[index],
                        subText: subTextStringList[index],
                        imageAsset:
                            AssetImage('assets/images/home/${index + 1}.png'),
                        mainTextSize: index == 0 ? 40 : 30,
                        mainTextConstraint: index == 0 ? 450 : 350,
                        subTextConstraint: 500),
                  );
                }
                if (index < 4) {
                  return FadeInRight(
                    animate: animateApproveList[index],
                    child: ResponsiveHomeRow(
                      alignFromStart: (index + 1) % 2 != 0,
                      mainText: mainTextStringList[index],
                      subText: subTextStringList[index],
                      imageAsset:
                          AssetImage('assets/images/home/${index + 1}.png'),
                      mainTextSize: index == 0 ? 40 : 30,
                      mainTextConstraint: index == 0 ? 450 : 400,
                      subTextConstraint: 500,
                    ),
                  );
                }
                return Padding(
                  padding: EdgeInsets.only(bottom: 15.h),
                  child: FadeInUp(
                    animate: animateApproveList[index],
                    child: const Subscribe(),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
