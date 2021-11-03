part of 'questions_cubit.dart';

class QuestionsState {
  QuestionsState({this.answerDocs, this.questionDocs});
  final List<QueryDocumentSnapshot<Map<String, dynamic>>>? questionDocs;
  final List<QueryDocumentSnapshot<Map<String, dynamic>>>? answerDocs;
}
