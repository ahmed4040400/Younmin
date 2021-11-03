import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:younmin/logic/helping_functions.dart';

part 'daily_todo_state.dart';

List<QueryDocumentSnapshot<Map<String, dynamic>>> initState = [];

class DailyTodoCubit extends Cubit<DailyTodoState> {
  DailyTodoCubit() : super(DailyTodoState(dailyTodoDocs: initState));

  Future<void> getDailyTodo(
      {required QueryDocumentSnapshot<Map<String, dynamic>> taskDoc,
      DateTime? date}) async {
    String? year;
    String? month;
    String? day;

    if (date != null) {
      year = date.year.toString();
      month = date.month.toString();
      day = date.day.toString();
    }

    final todoDocs = await taskDoc.reference
        .collection("year")
        .doc(year ?? thisYear())
        .collection("month")
        .doc(month ?? thisMonth())
        .collection("days")
        .doc(day ?? today())
        .collection('dailyTodo')
        .orderBy("date")
        .get();
    emit(DailyTodoState(dailyTodoDocs: todoDocs.docs));
  }

  void createDailyTodo(BuildContext context,
      {required QueryDocumentSnapshot<Map<String, dynamic>> taskDoc,
      required TextEditingController todoController,
      required int feeling,
      DateTime? date}) async {
    String? year;
    String? month;
    String? day;

    if (date != null) {
      year = date.year.toString();
      month = date.month.toString();
      day = date.day.toString();
    }

    await taskDoc.reference
        .collection("year")
        .doc(year ?? thisYear())
        .collection("month")
        .doc(month ?? thisMonth())
        .collection("days")
        .doc(day ?? today())
        .collection('dailyTodo')
        .add({
      "todo": todoController.text,
      "isChecked": false,
      "feeling": feeling,
      "date": DateTime.now()
    });
    getDailyTodo(taskDoc: taskDoc, date: date);
    todoController.clear();
  }

  void changeIsChecked(
      {required value,
      required QueryDocumentSnapshot<Map<String, dynamic>> todoDoc}) async {
    await todoDoc.reference.update({"isChecked": value});
  }

  void changeFeeling(context,
      {required int feeling,
      required QueryDocumentSnapshot<Map<String, dynamic>> todoDoc,
      required QueryDocumentSnapshot<Map<String, dynamic>> taskDoc,
      DateTime? date}) async {
    await todoDoc.reference.update({"feeling": feeling});
    getDailyTodo(taskDoc: taskDoc, date: date);
    Navigator.pop(context);
  }

  void deleteDailyTodo(
      {required QueryDocumentSnapshot<Map<String, dynamic>> todoDoc,
      required QueryDocumentSnapshot<Map<String, dynamic>> taskDoc,
      DateTime? date}) async {
    await todoDoc.reference.delete();
    getDailyTodo(taskDoc: taskDoc, date: date);
  }
}
