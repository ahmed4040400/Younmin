import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/Strings/home_page_strings.dart';

class Subscribe extends StatelessWidget {
  const Subscribe({
    Key? key,
    required this.onPressed,
    this.animate = false,
  }) : super(key: key);

  final void Function()? onPressed;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      animate: true,
      child: Column(
        children: [
          SelectableText(
            HomePageStrings5.mainText,
            style: Theme.of(context).textTheme.headline1,
            textAlign: TextAlign.center,
          ),
          SelectableText(
            HomePageStrings5.subText,
            style: Theme.of(context).textTheme.headline3,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            width: 55.w,
            child: const TextField(
              decoration: InputDecoration(hintText: 'Enter your email address'),
            ),
          ),
          SizedBox(height: 5.h),
          ElevatedButton(
            onPressed: onPressed,
            child: Text(
              "Send emails",
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    fontSize: 5.8.sp,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
