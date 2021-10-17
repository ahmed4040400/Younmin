import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rolling_switch/rolling_switch.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/Strings/sign_up_page_strings.dart';
import 'package:younmin/globals/colors.dart';
import 'package:younmin/logic/signUp/sign_up_cubit.dart';

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
      validator: (value) {
        if (value!.length < 3) {
          return "First name must be at least 3 characters";
        }
        return null;
      },
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
              validator: (value) {
                if (value!.length < 3) {
                  return "Last name must be at least 3 characters";
                }
                return null;
              },
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
            validator: (value) {
              if (value!.isEmpty) {
                return "required";
              }
              if (double.parse(value) >= 13 && double.parse(value) <= 150) {
                return null;
              }
              return "between 8 & 150";
            },
          ),
        ),
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
        decoration: InputDecoration(
            hintText: SignUpStrings.email,
            suffixIcon: BlocBuilder<SignUpCubit, SignUpState>(
              buildWhen: (preState, state) => state.imageFile != null,
              builder: (BuildContext context, state) {
                if (state.imageFile != null) {
                  return IconButton(
                    tooltip: "profile image",
                    icon: Image.memory(state.imageFile!),
                    onPressed: () async {
                      BlocProvider.of<SignUpCubit>(context).uploadImage();
                    },
                  );
                }
                return IconButton(
                  tooltip: "profile image",
                  icon: FaIcon(FontAwesomeIcons.fileImage),
                  onPressed: () async {
                    BlocProvider.of<SignUpCubit>(context).uploadImage();
                  },
                );
              },
            )),
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

String? password;

class PasswordFields extends StatelessWidget {
  const PasswordFields({
    Key? key,
    this.passwordController,
    this.confirmController,
  }) : super(key: key);
  final TextEditingController? passwordController;
  final TextEditingController? confirmController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
            height: 7.h,
            width: 19.w,
            child: TextFormField(
              controller: passwordController,
              obscureText: true,
              cursorColor: YounminColors.darkPrimaryColor,
              decoration: InputDecoration(hintText: SignUpStrings.password),
              style: Theme.of(context).textTheme.headline3,
              validator: (value) {
                if (value!.length < 6) {
                  return "Must be at least 6 characters";
                }
              },
              onChanged: (value) {
                password = value;
              },
            )),
        SizedBox(width: 2.w),
        SizedBox(
          height: 7.h,
          width: 19.w,
          child: TextFormField(
            controller: confirmController,
            obscureText: true,
            cursorColor: YounminColors.darkPrimaryColor,
            decoration:
                InputDecoration(hintText: SignUpStrings.confirmPassword),
            style: Theme.of(context).textTheme.headline3,
            validator: (value) {
              if (value != password) {
                return "must be the same password";
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
