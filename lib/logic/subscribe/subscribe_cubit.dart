import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'subscribe_state.dart';

class SubscribeCubit extends Cubit<SubscribeState> {
  SubscribeCubit() : super(SubscribeState());

  final db = FirebaseFirestore.instance;
  void subscribeWithEmail(BuildContext context,
      {required GlobalKey<FormState> formKey,
      required TextEditingController emailController}) async {
    if (formKey.currentState!.validate()) {
      await db.collection("subscribeEmails").add({
        "email": emailController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("thanks for subscribing "),
        duration: Duration(milliseconds: 500),
      ));
      emailController.clear();
    }
  }
}
