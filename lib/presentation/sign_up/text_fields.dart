import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rolling_switch/rolling_switch.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/Strings/sign_up_page_strings.dart';
import 'package:younmin/globals/colors.dart';

class FirstNameAndGender extends StatelessWidget {
  const FirstNameAndGender({
    Key? key,
    this.controller,
    required this.onGenderChange,
  }) : super(key: key);

  final TextEditingController? controller;
  final void Function(bool) onGenderChange;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: YounminColors.darkPrimaryColor,
      decoration: InputDecoration(
        hintText: SignUpStrings.firstName,
        suffixIcon: Padding(
          padding: EdgeInsets.all(1.sp),
          child: RollingSwitch.icon(
            width: 30.sp,
            onChanged: onGenderChange,
            rollingInfoRight: const RollingIconInfo(
              icon: Icons.male,
            ),
            rollingInfoLeft: const RollingIconInfo(
              icon: Icons.female,
              backgroundColor: Colors.pink,
            ),
          ),
        ),
      ),
      style: Theme.of(context).textTheme.headline3,
    );
  }
}

class LastNameAndAge extends StatelessWidget {
  const LastNameAndAge({
    Key? key,
    this.lastNameController,
    this.ageController,
  }) : super(key: key);

  final TextEditingController? lastNameController;
  final TextEditingController? ageController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
            height: 7.h,
            width: 30.w,
            child: TextFormField(
              controller: lastNameController,
              cursorColor: YounminColors.darkPrimaryColor,
              decoration: InputDecoration(
                hintText: SignUpStrings.lastName,
              ),
              style: Theme.of(context).textTheme.headline3,
            )),
        SizedBox(width: 1.w),
        SizedBox(
            height: 7.h,
            width: 9.w,
            child: TextFormField(
              controller: ageController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter
                    .digitsOnly, // Only numbers can be entered
                LengthLimitingTextInputFormatter(
                    3), // only 3 numbers can be entered
              ],
              cursorColor: YounminColors.darkPrimaryColor,
              decoration: InputDecoration(hintText: SignUpStrings.age),
              style: Theme.of(context).textTheme.headline3,
            )),
      ],
    );
  }
}

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
          decoration: InputDecoration(hintText: SignUpStrings.email),
          style: Theme.of(context).textTheme.headline3,
        ));
  }
}
