import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/Strings/sign_up_page_strings.dart';
import 'package:younmin/globals/YounminWidgets/logo_button.dart';
import 'package:younmin/globals/colors.dart';
import 'package:younmin/logic/signUp/sign_up_cubit.dart';
import 'package:younmin/presentation/sign_up/text_fields.dart';
import 'package:younmin/router/router.gr.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

bool isMale = false;

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      create: (context) => SignUpCubit(),
      child: Builder(builder: (context) {
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
                key: formKey,
                child: BlocBuilder<SignUpCubit, SignUpState>(
                    buildWhen: (preState, state) =>
                        preState.visible != state.visible,
                    builder: (BuildContext context, state) {
                      return IgnorePointer(
                        ignoring: state.visible,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            BlocBuilder<SignUpCubit, SignUpState>(
                                builder: (BuildContext context, state) {
                              return Visibility(
                                visible: state.visible,
                                child: CircularPercentIndicator(
                                  radius: 20.sp,
                                  lineWidth: 2.sp,
                                  percent: state.progress,
                                  center: Text((state.progress * 100)
                                      .toStringAsFixed(2)),
                                  progressColor: Colors.green,
                                ),
                              );
                            }),
                            Flexible(
                              child: SelectableText(
                                SignUpStrings.signUpToAccount,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(fontSize: 35),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Flexible(child: SizedBox(height: 50)),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 50),
                                child: SizedBox(
                                    height: 70,
                                    width: 500,
                                    child: FirstNameAndGender(
                                      controller: firstNameController,
                                      onGenderChange: (state) {
                                        isMale = state;
                                      },
                                    )),
                              ),
                            ),
                            Flexible(child: SizedBox(height: 20)),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 50),
                                child: LastNameAndAge(
                                  lastNameController: lastNameController,
                                  ageController: ageController,
                                ),
                              ),
                            ),
                            Flexible(child: SizedBox(height: 20)),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 50),
                                child: EmailField(
                                  controller: emailController,
                                ),
                              ),
                            ),
                            Flexible(child: SizedBox(height: 20)),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 50),
                                child: PasswordFields(
                                  passwordController: passwordController,
                                  confirmController: confirmPasswordController,
                                ),
                              ),
                            ),
                            Flexible(child: SizedBox(height: 20)),
                            Flexible(
                              child: ElevatedButton(
                                  onPressed: () {
                                    BlocProvider.of<SignUpCubit>(context)
                                        .signUp(
                                      context,
                                      firstNameController: firstNameController,
                                      lastNameController: lastNameController,
                                      ageController: ageController,
                                      emailController: emailController,
                                      passwordController: passwordController,
                                      confirmPasswordController:
                                          confirmPasswordController,
                                      isMale: isMale,
                                      formKey: formKey,
                                    );
                                  },
                                  child: Text(
                                    SignUpStrings.signUp,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(fontSize: 25),
                                  )),
                            ),
                            Flexible(child: SizedBox(height: 20)),
                            Flexible(
                              child: Text(
                                SignUpStrings.alreadyHasAccount,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
                                      color: YounminColors.darkPrimaryColor,
                                      fontSize: 25,
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                        color: YounminColors.darkPrimaryColor,
                                        fontSize: 30,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
          ),
        );
      }),
    );
  }
}
