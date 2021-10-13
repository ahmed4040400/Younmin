import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/Strings/global_strings.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
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
