import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/Strings/global_strings.dart';
import 'package:younmin/globals/colors.dart';
import 'package:younmin/globals/styles/button_styles.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: textButtonStyle,
      child: Text(
        GlobalStrings.appName,
        style: Theme.of(context).textTheme.headline1!.copyWith(
              fontSize: 8.sp,
            ),
      ),
    );
  }
}

class SignUp extends StatelessWidget {
  const SignUp({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        GlobalStrings.signUp,
        style: Theme.of(context)
            .textTheme
            .headline3!
            .copyWith(fontWeight: FontWeight.bold, fontSize: 6.sp),
      ),
    );
  }
}

class Login extends StatelessWidget {
  const Login({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
            backgroundColor: YounminColors.materialStatePrimeryColor,
            minimumSize: MaterialStateProperty.all<Size>(Size(
              10.w,
              6.w,
            )),
          ),
      onPressed: onPressed,
      child: Text(
        GlobalStrings.login,
        style: Theme.of(context)
            .textTheme
            .headline3!
            .copyWith(fontSize: 5.sp, color: Colors.white),
      ),
    );
  }
}
