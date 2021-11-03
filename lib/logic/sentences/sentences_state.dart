part of 'sentences_cubit.dart';

class SentencesState {
  SentencesState({this.disableAddButton = false, this.sentencesDocs});
  final List<QueryDocumentSnapshot<Map<String, dynamic>>>? sentencesDocs;
  final bool disableAddButton;
}
