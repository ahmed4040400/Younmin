import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../helping_functions.dart';

part 'yearly_todo_state.dart';

final _auth = FirebaseAuth.instance;
final _db = FirebaseFirestore.instance;
List<QueryDocumentSnapshot<Map<String, dynamic>>> initState = [];

class YearlyTodoCubit extends Cubit<YearlyTodoState> {
  YearlyTodoCubit() : super(YearlyTodoState(yearlyTodoDocs: initState));

  void getYearlyTodo() async {
    final userData = await getUserData();
    final yearlyTodo = await userData.docs.first.reference
        .collection("yearlyTodo")
        .orderBy("createdAt")
        .get();

    emit(YearlyTodoState(yearlyTodoDocs: yearlyTodo.docs));
    print('called');
  }

  void createNewYearlyTodo(context,
      {required TextEditingController goalController, required feeling}) async {
    final userData = await getUserData();

    await userData.docs.first.reference.collection("yearlyTodo").add({
      "feeling": feeling,
      "goal": goalController.text,
      "progress": {"monthly": 0, "yearly": 0},
      "createdAt": DateTime.now(),
    });

    final docs = await userData.docs.first.reference
        .collection("yearlyTodo")
        .orderBy("createdAt")
        .get();

    emit(YearlyTodoState(yearlyTodoDocs: docs.docs));
    goalController.clear();
    Navigator.pop(context);
  }

  void updateYearlyTodo(context,
      {required TextEditingController goalController,
      required feeling,
      required QueryDocumentSnapshot<Map<String, dynamic>> doc}) async {
    await doc.reference.update({
      "feeling": feeling,
      "goal": goalController.text,
    });
    Navigator.pop(context);
    goalController.clear();
    getYearlyTodo();
  }

  void deleteYearlyTodo(context,
      {required QueryDocumentSnapshot<Map<String, dynamic>> doc}) async {
    await doc.reference.delete();
    Navigator.pop(context);
    getYearlyTodo();
  }
}
