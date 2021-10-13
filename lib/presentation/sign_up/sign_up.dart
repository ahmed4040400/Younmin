import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/Strings/sign_up_page_strings.dart';
import 'package:younmin/globals/YounminWidgets/logo_button.dart';
import 'package:younmin/globals/colors.dart';
import 'package:younmin/presentation/sign_up/text_fields.dart';
import 'package:younmin/router/router.gr.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const LogoButton(textColor: YounminColors.darkPrimaryColor),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/login/background.png"),
                fit: BoxFit.cover)),
        child: Center(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  child: SelectableText(
                    SignUpStrings.signUpToAccount,
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: 8.sp),
                  ),
                ),
                Flexible(child: SizedBox(height: 8.h)),
                Flexible(
                  child: SizedBox(
                      height: 7.h,
                      width: 40.w,
                      child: FirstNameAndGender(
                        onGenderChange: (state) {
                          print('turned ${(state) ? 'male' : 'female'}');
                        },
                      )),
                ),
                Flexible(child: SizedBox(height: 3.h)),
                const Flexible(
                  child: LastNameAndAge(),
                ),
                Flexible(child: SizedBox(height: 3.h)),
                const Flexible(
                  child: EmailField(),
                ),
                Flexible(child: SizedBox(height: 3.h)),
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                          height: 7.h,
                          width: 19.w,
                          child: TextFormField(
                            obscureText: true,
                            cursorColor: YounminColors.darkPrimaryColor,
                            decoration: InputDecoration(
                                hintText: SignUpStrings.password),
                            style: Theme.of(context).textTheme.headline3,
                          )),
                      SizedBox(width: 2.w),
                      SizedBox(
                          height: 7.h,
                          width: 19.w,
                          child: TextFormField(
                            obscureText: true,
                            cursorColor: YounminColors.darkPrimaryColor,
                            decoration: InputDecoration(
                                hintText: SignUpStrings.confirmPassword),
                            style: Theme.of(context).textTheme.headline3,
                          )),
                    ],
                  ),
                ),
                Flexible(child: SizedBox(height: 3.h)),
                Flexible(
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        SignUpStrings.signUp,
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(fontSize: 7.sp),
                      )),
                ),
                Flexible(child: SizedBox(height: 3.h)),
                Flexible(
                  child: Text(
                    SignUpStrings.alreadyHasAccount,
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: YounminColors.darkPrimaryColor,
                          fontSize: 5.sp,
                        ),
                  ),
                ),
                Flexible(
                  child: TextButton(
                    onPressed: () {
                      context.router.navigate(const LoginRoute());
                    },
                    child: Text(
                      SignUpStrings.login,
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: YounminColors.darkPrimaryColor,
                            fontSize: 4.sp,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
