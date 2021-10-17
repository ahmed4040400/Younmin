import 'dart:typed_data';

import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/YounminWidgets/logo_button.dart';
import 'package:younmin/globals/colors.dart';
import 'package:younmin/logic/login/login_cubit.dart';
import 'package:younmin/presentation/yearlyTodo/add_yearly_todo.dart';
import 'package:younmin/router/router.gr.dart';

List<String> todos = [
  "Learn spanish",
  "learn maths",
  "learn machine learning",
  "loose weight",
];

Future<Uint8List> getImage() async {
  final ByteData imageData =
      await NetworkAssetBundle(Uri.parse("YOUR_URL")).load("");
  return imageData.buffer.asUint8List();
}

class YearlyTodo extends StatelessWidget {
  const YearlyTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    print(user!.photoURL);
    if (user == null) {
      context.router.navigate(LoginRoute());
      return Scaffold();
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: YounminColors.primaryColor,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AddYearlyTodo();
              });
        },
        child: FaIcon(FontAwesomeIcons.plus),
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
                        backgroundImage: NetworkImage(user.photoURL ?? " "),
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
                        BlocProvider.of<LoginCubit>(context).logout(context);
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
                child: ListView.separated(
                  itemCount: todos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 10.h,
                      child: Card(
                        color: Colors.white,
                        child: ListTile(
                          onTap: () {
                            context.router.navigate(const MainPageRoute());
                          },
                          title: Text(todos[index]),
                          subtitle: Text("feeling about the app"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: FaIcon(FontAwesomeIcons.edit),
                                splashRadius: 5.sp,
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: FaIcon(FontAwesomeIcons.trash),
                                splashRadius: 5.sp,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(height: 1.h),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
