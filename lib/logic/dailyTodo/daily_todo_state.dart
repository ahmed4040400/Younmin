part of 'daily_todo_cubit.dart';

class DailyTodoState {
  DailyTodoState({required this.dailyTodoDocs});
  List<QueryDocumentSnapshot<Map<String, dynamic>>> dailyTodoDocs;
}
