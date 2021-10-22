// ignore: implementation_imports
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/YounminWidgets/logo_button.dart';
import 'package:younmin/globals/colors.dart';
import 'package:younmin/logic/login/login_cubit.dart';
import 'package:younmin/logic/yearlyTodo/yearly_todo_cubit.dart';
import 'package:younmin/presentation/yearlyTodo/add_yearly_todo.dart';
import 'package:younmin/presentation/yearlyTodo/yearly_todo_tile.dart';
import 'package:younmin/router/router.gr.dart';

List<String> todos = [
  "Learn spanish",
  "learn maths",
  "learn machine learning",
  "loose weight",
];

class YearlyTodo extends StatelessWidget {
  const YearlyTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    YearlyTodoCubit().getYearlyTodo();
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      context.router.navigate(const LoginRoute());
      return const Scaffold();
    }
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
          body: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 4.h),
                        child: const LogoButton(
                          textColor: YounminColors.darkPrimaryColor,
                        ),
                      ),
                      Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(user.photoURL ??
                                "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/542px-Unknown_person.jpg"),
                            backgroundColor: YounminColors.primaryColor,
                            radius: 15.sp,
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            user.displayName ?? " ",
                            style: Theme.of(context).textTheme.headline3,
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
                            style: Theme.of(context).textTheme.bodyText1,
                          )),
                      SizedBox(
                        height: 10.h,
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
                    padding: EdgeInsets.only(top: 5.h),
                    child: BlocBuilder<YearlyTodoCubit, YearlyTodoState>(
                        builder: (BuildContext context, state) {
                      return ImplicitlyAnimatedList(
                        items: state.yearlyTodoDocs,
                        itemBuilder: (BuildContext context,
                            animation,
                            QueryDocumentSnapshot<Map<String, dynamic>> item,
                            int index) {
                          return SizeFadeTransition(
                            sizeFraction: 0.2,
                            curve: Curves.easeInOut,
                            animation: animation,
                            child: BlocProvider.value(
                              value: BlocProvider.of<YearlyTodoCubit>(context),
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
                        areItemsTheSame:
                            (QueryDocumentSnapshot<Map<String, dynamic>>
                                        oldItem,
                                    QueryDocumentSnapshot<Map<String, dynamic>>
                                        newItem) =>
                                oldItem['createdAt'] == newItem["createdAt"],

                        removeItemBuilder: (context,
                            animation,
                            QueryDocumentSnapshot<Map<String, dynamic>>
                                oldItem) {
                          return FadeTransition(
                            opacity: animation,
                            child: BlocProvider.value(
                              value: BlocProvider.of<YearlyTodoCubit>(context),
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
          ),
        );
      }),
    );
  }
}
