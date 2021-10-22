import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:younmin/logic/yearlyTodo/yearly_todo_cubit.dart';
import 'package:younmin/router/router.gr.dart';

import 'delete_yearly_todo.dart';
import 'edit_yearly_todo.dart';

class YearlyTodoTile extends StatelessWidget {
  const YearlyTodoTile({Key? key, this.index, required this.item})
      : super(key: key);

  final int? index;
  final QueryDocumentSnapshot<Map<String, dynamic>> item;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10.h,
      child: Card(
        color: Colors.white,
        child: ListTile(
          onTap: () {
            context.router.navigate(
                MainPageRoute(taskOrderNum: (index ?? 0) + 1, taskDoc: item));
          },
          title: Text(item['goal']),
          subtitle: Row(
            children: [
              const Text("feeling about this task: "),
              SizedBox(
                width: 4.5.sp,
                height: 4.5.sp,
                child:
                    Image.asset("assets/images/emoji/${item['feeling']}.png"),
              )
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext _) {
                        return BlocProvider.value(
                            child: EditYearlyTodo(
                              taskDoc: item,
                            ),
                            value: BlocProvider.of<YearlyTodoCubit>(context));
                      });
                },
                icon: const FaIcon(FontAwesomeIcons.edit),
                splashRadius: 5.sp,
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext _) => BlocProvider.value(
                            value: BlocProvider.of<YearlyTodoCubit>(context),
                            child: DeleteYearlyTodo(
                              taskDoc: item,
                            ),
                          ));
                },
                icon: const FaIcon(FontAwesomeIcons.trash),
                splashRadius: 5.sp,
              )
            ],
          ),
        ),
      ),
    );
  }
}
