import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'history_state.dart';

List<QueryDocumentSnapshot<Map<String, dynamic>>> initState = [];

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryState(history: initState));

  void getHistory(
      {required QueryDocumentSnapshot<Map<String, dynamic>> taskDoc}) async {
    final history = await taskDoc.reference.collection("history").get();
    emit(HistoryState(history: history.docs));
  }
}
