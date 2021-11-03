import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:younmin/logic/helping_functions.dart';

part 'sentences_state.dart';

List<QueryDocumentSnapshot<Map<String, dynamic>>> initState = [];

class SentencesCubit extends Cubit<SentencesState> {
  SentencesCubit() : super(SentencesState(sentencesDocs: initState));

  void getSentences() async {
    final userData = await getUserData();
    final sentence = await userData.docs.first.reference
        .collection("sentences")
        .orderBy("date")
        .get();

    emit(SentencesState(sentencesDocs: sentence.docs));
  }

  void createSentence(
      {required bool saidMe,
      required bool madeMeHappy,
      required TextEditingController sentenceController,
      required TextEditingController toldNumberController}) async {
    emit(SentencesState(disableAddButton: true));
    final userData = await getUserData();

    await userData.docs.first.reference.collection("sentences").add({
      "saidMe": saidMe,
      "madeMeHappy": madeMeHappy,
      "sentence": sentenceController.text,
      "toldNumber": int.parse(toldNumberController.text),
      "date": DateTime.now()
    });
    sentenceController.clear();
    toldNumberController.clear();
    getSentences();
    emit(SentencesState(disableAddButton: false));
  }

  void deleteSentence(
      {required QueryDocumentSnapshot<Map<String, dynamic>>
          sentenceDoc}) async {
    await sentenceDoc.reference.delete();
    getSentences();
  }
}
