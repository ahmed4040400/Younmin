import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

part 'questions_state.dart';

final _auth = FirebaseAuth.instance;
final _db = FirebaseFirestore.instance;

List<QueryDocumentSnapshot<Map<String, dynamic>>> initState = [];
List<QueryDocumentSnapshot<Map<String, dynamic>>> answersInitState = [];

class QuestionsCubit extends Cubit<QuestionsState> {
  QuestionsCubit()
      : super(QuestionsState(
            questionDocs: initState, answerDocs: answersInitState));

  void getQuestions() async {
    final questions = await _db.collection("questions").get();
    emit(QuestionsState(questionDocs: questions.docs));
  }

  void getAnswers(
      QueryDocumentSnapshot<Map<String, dynamic>> questionDoc) async {
    final answers =
        await questionDoc.reference.collection("answers").orderBy("date").get();
    emit(QuestionsState(answerDocs: answers.docs));
  }

  void addAnswer(QueryDocumentSnapshot<Map<String, dynamic>> questionDoc,
      TextEditingController answerController) async {
    await questionDoc.reference.collection("answers").add({
      "answer": answerController.text,
      "date": DateTime.now(),
      "uid": _auth.currentUser!.uid,
      "photoUrl": _auth.currentUser!.photoURL
    });
    answerController.clear();
    getAnswers(questionDoc);
  }
}
