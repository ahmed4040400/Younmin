import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/Strings/login_page_strings.dart';
import 'package:younmin/globals/YounminWidgets/logo_button.dart';
import 'package:younmin/globals/colors.dart';
import 'package:younmin/presentation/login/text_fields.dart';
import 'package:younmin/router/router.gr.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

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
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: SelectableText(
                    LoginStrings.loginToAccount,
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: 8.sp),
                  ),
                ),
                Flexible(child: SizedBox(height: 8.h)),
                const Flexible(child: EmailField()),
                Flexible(child: SizedBox(height: 3.h)),
                const Flexible(child: PasswordField()),
                Flexible(child: SizedBox(height: 5.h)),
                Flexible(
                  child: ElevatedButton(
                      onPressed: () {
                        context.router.navigate(const YearlyTodoRoute());
                      },
                      child: Text(
                        LoginStrings.login,
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(fontSize: 7.sp),
                      )),
                ),
                Flexible(child: SizedBox(height: 2.h)),
                Flexible(
                  child: TextButton(
                    onPressed: () {
                      context.router.navigate(const SignUpRoute());
                    },
                    child: Text(
                      LoginStrings.createAccount,
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: YounminColors.darkPrimaryColor,
                            fontSize: 4.sp,
                          ),
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    LoginStrings.loginWith,
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: YounminColors.darkPrimaryColor,
                          fontSize: 6.sp,
                        ),
                  ),
                ),
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const FaIcon(
                          FontAwesomeIcons.facebook,
                          color: YounminColors.faceBookColor,
                        ),
                        iconSize: 5.w,
                        splashRadius: 2.5.w,
                        splashColor: YounminColors.primaryColor,
                      ),
                      SizedBox(width: 1.w),
                      IconButton(
                        onPressed: () {},
                        icon: const FaIcon(
                          FontAwesomeIcons.googlePlus,
                          color: YounminColors.googleColor,
                        ),
                        iconSize: 5.w,
                        splashRadius: 2.5.w,
                        splashColor: YounminColors.primaryColor,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
