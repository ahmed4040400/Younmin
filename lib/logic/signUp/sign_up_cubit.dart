import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_state.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpState());

  FilePickerResult? result;

  void signUp(
    BuildContext context, {
    required firstNameController,
    required lastNameController,
    required ageController,
    required emailController,
    required passwordController,
    required confirmPasswordController,
    required isMale,
    required GlobalKey<FormState> formKey,
  }) async {
    if (formKey.currentState!.validate()) {
      if (result != null) {
        await _auth.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        await _auth.currentUser!.updateDisplayName(
            "${firstNameController.text} ${lastNameController.text}");
        final ref = FirebaseStorage.instance.ref(
            "profileImage/${_auth.currentUser!.uid}/${result!.files.single.name}");
        final task = ref.putData(result!.files.single.bytes!);

        task.snapshotEvents.listen((event) {
          print('listening....');
          final percent =
              event.bytesTransferred.toDouble() / event.totalBytes.toDouble();
          emit(SignUpState(
              progress: percent, visible: percent > 0 && percent < 1));
        });
        task.then((uploadedTask) async {
          final photoUrl = await uploadedTask.ref.getDownloadURL();
          await _auth.currentUser!.updatePhotoURL(photoUrl);
        });

        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .where('uid', isEqualTo: _auth.currentUser!.uid)
            .get();

        if (userDoc.docs.isNotEmpty) {
          userDoc.docs[0].reference.update({
            "isMale": isMale,
            "age": int.parse(ageController.text),
          });
        }

        print(_auth.currentUser);
      }
    }
  }

  void uploadImage() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      final file = result!.files.single.bytes;
      emit(SignUpState(imageFile: file));
    } else {
      // User canceled the picker
    }
  }
}
