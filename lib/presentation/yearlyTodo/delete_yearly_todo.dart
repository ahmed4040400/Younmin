import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:younmin/globals/colors.dart';
import 'package:younmin/logic/yearlyTodo/yearly_todo_cubit.dart';

class DeleteYearlyTodo extends StatelessWidget {
  const DeleteYearlyTodo({Key? key, required this.taskDoc}) : super(key: key);

  final QueryDocumentSnapshot<Map<String, dynamic>> taskDoc;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Delete this task?",
        style: Theme.of(context)
            .textTheme
            .headline2!
            .copyWith(color: YounminColors.textHeadline1Color),
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        TextButton(
          child: Text("close", style: Theme.of(context).textTheme.headline3),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(
            "delete",
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: Colors.red),
          ),
          onPressed: () {
            BlocProvider.of<YearlyTodoCubit>(context)
                .deleteYearlyTodo(context, doc: taskDoc);
          },
        ),
      ],
    );
  }
}
