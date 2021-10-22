import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

part 'daily_check_state.dart';

List<QueryDocumentSnapshot<Map<String, dynamic>>> initState = [];

class DailyCheckCubit extends Cubit<DailyCheckState> {
  DailyCheckCubit() : super(DailyCheckState(dailyCheckDocs: initState));

  void getCheck(
      {required QueryDocumentSnapshot<Map<String, dynamic>> taskDoc}) async {
    final checkDoc =
        await taskDoc.reference.collection("checkList").orderBy("date").get();
    emit(DailyCheckState(dailyCheckDocs: checkDoc.docs));
  }

  void createCheck(BuildContext context,
      {required QueryDocumentSnapshot<Map<String, dynamic>> taskDoc}) async {
    await taskDoc.reference
        .collection("checkList")
        .add({"check": "test", "isChecked": false, "date": DateTime.now()});
    getCheck(taskDoc: taskDoc);
    Navigator.pop(context);
  }

  void changeIsChecked(
      {required value,
      required QueryDocumentSnapshot<Map<String, dynamic>> checkDoc}) async {
    await checkDoc.reference.update({"isChecked": value});
  }

  void deleteDailyTodo(
      {required QueryDocumentSnapshot<Map<String, dynamic>> checkDoc,
      required QueryDocumentSnapshot<Map<String, dynamic>> taskDoc}) async {
    await checkDoc.reference.delete();
    getCheck(taskDoc: taskDoc);
  }
}
