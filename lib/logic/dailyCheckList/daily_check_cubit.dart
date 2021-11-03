import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:younmin/logic/helping_functions.dart';

part 'daily_check_state.dart';

List<QueryDocumentSnapshot<Map<String, dynamic>>> initState = [];

class DailyCheckCubit extends Cubit<DailyCheckState> {
  DailyCheckCubit() : super(DailyCheckState(dailyCheckDocs: initState));

  void getCheck(
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

    final checkDoc = await taskDoc.reference
        .collection("year")
        .doc(year ?? thisYear())
        .collection("month")
        .doc(month ?? thisMonth())
        .collection("days")
        .doc(day ?? today())
        .collection('checkList')
        .orderBy("date")
        .get();
    emit(DailyCheckState(dailyCheckDocs: checkDoc.docs));
  }

  void createCheck(BuildContext context,
      {required QueryDocumentSnapshot<Map<String, dynamic>> taskDoc,
      required TextEditingController checkController,
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
        .collection('checkList')
        .add({
      "check": checkController.text,
      "isChecked": false,
      "date": DateTime.now()
    });
    getCheck(taskDoc: taskDoc, date: date);
    checkController.clear();
  }

  void changeIsChecked(
      {required value,
      required QueryDocumentSnapshot<Map<String, dynamic>> checkDoc}) async {
    await checkDoc.reference.update({"isChecked": value});
  }

  void deleteCheck(
      {required QueryDocumentSnapshot<Map<String, dynamic>> checkDoc,
      required QueryDocumentSnapshot<Map<String, dynamic>> taskDoc,
      DateTime? date}) async {
    await checkDoc.reference.delete();
    getCheck(taskDoc: taskDoc, date: date);
  }
}
