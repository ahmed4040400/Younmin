import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    return Tooltip(
      message: "show daily tasks",
      child: SizedBox(
        height: 120,
        child: Card(
          color: Colors.white,
          child: ListTile(
            onTap: () {
              context.router.navigate(MainPageRoute(
                  taskOrderNum: (index ?? 0) + 1,
                  docid: item.id,
                  key: UniqueKey()));
            },
            title: Text(
              item['goal'],
              style: Theme.of(context).textTheme.headline2,
            ),
            subtitle: Row(
              children: [
                Text(
                  "feeling about this task: ",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                SizedBox(
                  width: 25,
                  height: 25,
                  child:
                      Image.asset("assets/images/emoji/${item['feeling']}.png"),
                )
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: IconButton(
                    iconSize: 30,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext _) {
                            return BlocProvider.value(
                                child: EditYearlyTodo(
                                  taskDoc: item,
                                ),
                                value:
                                    BlocProvider.of<YearlyTodoCubit>(context));
                          });
                    },
                    icon: const FaIcon(FontAwesomeIcons.edit),
                    splashRadius: 30,
                  ),
                ),
                Flexible(
                  child: IconButton(
                    iconSize: 30,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext _) => BlocProvider.value(
                                value:
                                    BlocProvider.of<YearlyTodoCubit>(context),
                                child: DeleteYearlyTodo(
                                  taskDoc: item,
                                ),
                              ));
                    },
                    icon: const FaIcon(FontAwesomeIcons.trash),
                    splashRadius: 30,
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
