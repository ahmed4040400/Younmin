// ignore: implementation_imports
import 'package:after_layout/after_layout.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:younmin/globals/YounminWidgets/choose_feeling.dart';
import 'package:younmin/globals/YounminWidgets/logo_button.dart';
import 'package:younmin/globals/colors.dart';
import 'package:younmin/logic/login/login_cubit.dart';
import 'package:younmin/logic/yearlyTodo/yearly_todo_cubit.dart';
import 'package:younmin/presentation/yearlyTodo/add_yearly_todo.dart';
import 'package:younmin/presentation/yearlyTodo/yearly_todo_tile.dart';

Future<User?> getUser() async {
  await Future.delayed(const Duration(seconds: 1));
  return FirebaseAuth.instance.currentUser;
}

class YearlyTodo extends StatefulWidget {
  const YearlyTodo({Key? key, this.fistLogin = false}) : super(key: key);
  final bool fistLogin;

  @override
  State<YearlyTodo> createState() => _YearlyTodoState();
}

class _YearlyTodoState extends State<YearlyTodo>
    with AfterLayoutMixin<YearlyTodo> {
  @override
  Widget build(BuildContext context) {
    YearlyTodoCubit().getYearlyTodo();
    var user = FirebaseAuth.instance.currentUser;

    return BlocProvider<YearlyTodoCubit>(
      create: (BuildContext context) => YearlyTodoCubit(),
      child: Builder(builder: (context) {
        BlocProvider.of<YearlyTodoCubit>(context).getYearlyTodo();
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: YounminColors.primaryColor,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext _) {
                    return BlocProvider.value(
                        child: const AddYearlyTodo(),
                        value: BlocProvider.of<YearlyTodoCubit>(context));
                  });
            },
            child: const FaIcon(FontAwesomeIcons.plus),
          ),
          body: FutureBuilder(
              future: getUser(),
              builder: (context, AsyncSnapshot<User?> asyncSnapshot) {
                if (asyncSnapshot.hasData) {
                  if (asyncSnapshot.data != null) {
                    user = asyncSnapshot.data;
                    return Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: LogoButton(
                                    navigateOnTap: false,
                                    textColor: YounminColors.darkPrimaryColor,
                                  ),
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(user!
                                              .photoURL ??
                                          "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/542px-Unknown_person.jpg"),
                                      backgroundColor:
                                          YounminColors.primaryColor,
                                      radius: 70,
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    Text(
                                      user!.displayName ?? " ",
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      BlocProvider.of<LoginCubit>(context)
                                          .logout(context);
                                    },
                                    child: Text(
                                      "Log out",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(fontSize: 20),
                                    )),
                                const SizedBox(
                                  height: 15,
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            color: YounminColors.yearlyTodoListColor,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child:
                                  BlocBuilder<YearlyTodoCubit, YearlyTodoState>(
                                      builder: (BuildContext context, state) {
                                return ImplicitlyAnimatedList(
                                  items: state.yearlyTodoDocs,
                                  itemBuilder: (BuildContext context,
                                      animation,
                                      QueryDocumentSnapshot<
                                              Map<String, dynamic>>
                                          item,
                                      int index) {
                                    return SizeFadeTransition(
                                      sizeFraction: 0.2,
                                      curve: Curves.easeInOut,
                                      animation: animation,
                                      child: BlocProvider.value(
                                        value: BlocProvider.of<YearlyTodoCubit>(
                                            context),
                                        child: YearlyTodoTile(
                                          index: index,
                                          item: item,
                                        ),
                                      ),
                                    );
                                  },
                                  // separatorBuilder: (BuildContext context, int index) =>
                                  //     SizedBox(
                                  //   height: 5.h,
                                  // ),
                                  areItemsTheSame: (QueryDocumentSnapshot<
                                                  Map<String, dynamic>>
                                              oldItem,
                                          QueryDocumentSnapshot<
                                                  Map<String, dynamic>>
                                              newItem) =>
                                      oldItem['createdAt'] ==
                                      newItem["createdAt"],

                                  removeItemBuilder: (context,
                                      animation,
                                      QueryDocumentSnapshot<
                                              Map<String, dynamic>>
                                          oldItem) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: BlocProvider.value(
                                        value: BlocProvider.of<YearlyTodoCubit>(
                                            context),
                                        child: YearlyTodoTile(
                                          item: oldItem,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }
                return const Center(child: CircularProgressIndicator());
              }),
        );
      }),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    if (widget.fistLogin) {
      AwesomeDialog(
              context: context,
              dialogType: DialogType.QUESTION,
              headerAnimationLoop: false,
              animType: AnimType.BOTTOMSLIDE,
              body: Column(
                children: [
                  Text(
                    "welcome back, how are you feeling today",
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(fontSize: 20),
                  ),
                  ChooseFeeling(
                    onChoosed: (feelingNumber) async => {
                      YearlyTodoCubit()
                          .saveFeeling(context, feelingNumber: feelingNumber)
                    },
                  ),
                ],
              ),
              btnOkText: "Add check",
              btnCancelOnPress: () {})
          .show();
    }
  }
}
