import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/globals/YounminWidgets/logo_button.dart';
import 'package:younmin/globals/colors.dart';
import 'package:younmin/presentation/yearlyTodo/add_yearly_todo.dart';
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
                        backgroundImage: AssetImage('assets/images/home/1.png'),
                        backgroundColor: YounminColors.primaryColor,
                        radius: 15.sp,
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        "Ahmed Elshentenawy",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {},
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
                        child: Expanded(
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
