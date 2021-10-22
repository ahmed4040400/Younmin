import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

part 'daily_todo_state.dart';

List<QueryDocumentSnapshot<Map<String, dynamic>>> initState = [];

class DailyTodoCubit extends Cubit<DailyTodoState> {
  DailyTodoCubit() : super(DailyTodoState(dailyTodoDocs: initState));

  Future<void> getDailyTodo(
      {required QueryDocumentSnapshot<Map<String, dynamic>> taskDoc}) async {
    final todoDocs =
        await taskDoc.reference.collection("dailyTodo").orderBy("date").get();
    emit(DailyTodoState(dailyTodoDocs: todoDocs.docs));
  }

  void createDailyTodo(BuildContext context,
      {required QueryDocumentSnapshot<Map<String, dynamic>> taskDoc,
      required TextEditingController todoController,
      required int feeling}) async {
    await taskDoc.reference.collection('dailyTodo').add({
      "todo": todoController.text,
      "isChecked": false,
      "feeling": feeling,
      "date": DateTime.now()
    });
    getDailyTodo(taskDoc: taskDoc);
    todoController.clear();

    Navigator.pop(context);
  }

  void changeIsChecked(
      {required value,
      required QueryDocumentSnapshot<Map<String, dynamic>> todoDoc}) async {
    await todoDoc.reference.update({"isChecked": value});
  }

  void changeFeeling(context,
      {required int feeling,
      required QueryDocumentSnapshot<Map<String, dynamic>> todoDoc,
      required QueryDocumentSnapshot<Map<String, dynamic>> taskDoc}) async {
    await todoDoc.reference.update({"feeling": feeling});
    getDailyTodo(taskDoc: taskDoc);
    Navigator.pop(context);
  }

  void deleteDailyTodo(
      {required QueryDocumentSnapshot<Map<String, dynamic>> todoDoc,
      required QueryDocumentSnapshot<Map<String, dynamic>> taskDoc}) async {
    await todoDoc.reference.delete();
    getDailyTodo(taskDoc: taskDoc);
  }
}
