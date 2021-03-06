import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:younmin/globals/Strings/global_strings.dart';
import 'package:younmin/globals/colors.dart';
import 'package:younmin/globals/styles/button_styles.dart';
import 'package:younmin/router/router.gr.dart';

class LogoButton extends StatelessWidget {
  const LogoButton({
    Key? key,
    this.textColor = YounminColors.textHeadline1Color,
    this.navigateOnTap = true,
  }) : super(key: key);

  final Color textColor;
  final bool navigateOnTap;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "logoButton",
      child: TextButton(
        onPressed: navigateOnTap
            ? () {
                context.router.navigate(const HomeRoute());
              }
            : () {},
        style: textButtonStyle,
        child: Text(
          GlobalStrings.appName,
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(fontSize: 30, color: textColor),
        ),
      ),
    );
  }
}
