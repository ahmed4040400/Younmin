import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/Strings/login_page_strings.dart';
import 'package:younmin/globals/colors.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    Key? key,
    this.controller,
  }) : super(key: key);

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 7.h,
      width: 40.w,
      child: TextFormField(
        controller: controller,
        cursorColor: YounminColors.darkPrimaryColor,
        decoration: InputDecoration(hintText: LoginStrings.email),
        style: Theme.of(context).textTheme.headline3,
        validator: (value) {
          if (value!.isEmpty) return "required";
          if (EmailValidator.validate(value)) {
            return null;
          }
          return "not a valid E-mail";
        },
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  const PasswordField({
    Key? key,
    this.controller,
  }) : super(key: key);

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 7.h,
      width: 40.w,
      child: TextFormField(
        controller: controller,
        obscureText: true,
        cursorColor: YounminColors.darkPrimaryColor,
        decoration: InputDecoration(hintText: LoginStrings.password),
        style: Theme.of(context).textTheme.headline3,
        validator: (value) {
          if (value == null) return "required";
        },
      ),
    );
  }
}
