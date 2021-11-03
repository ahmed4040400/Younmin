import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: SizedBox(
        height: 100,
        width: 500,
        child: TextFormField(
          autocorrect: false,
          controller: controller,
          cursorColor: YounminColors.darkPrimaryColor,
          decoration: InputDecoration(
            hintText: LoginStrings.email,
            isDense: true,
          ),
          style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: 30),
          validator: (value) {
            if (value!.isEmpty) return "required";
            if (EmailValidator.validate(value)) {
              return null;
            }
            return "not a valid E-mail";
          },
        ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: SizedBox(
        height: 100,
        width: 500,
        child: TextFormField(
          autocorrect: false,
          controller: controller,
          obscureText: true,
          cursorColor: YounminColors.darkPrimaryColor,
          decoration: InputDecoration(hintText: LoginStrings.password),
          style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: 30),
          validator: (value) {
            if (value == null) return "required";
          },
        ),
      ),
    );
  }
}
