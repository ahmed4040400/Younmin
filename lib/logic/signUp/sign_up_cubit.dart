import 'dart:typed_data';

// ignore: implementation_imports
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:younmin/logic/helping_functions.dart';
import 'package:younmin/router/router.gr.dart';

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
      try {
        await _auth.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
      } catch (err) {
        handleFirebaseError(err, context);
        return;
      }

      await _auth.currentUser!.updateDisplayName(
          "${firstNameController.text} ${lastNameController.text}");

      if (result != null) {
        // if the user choosed a profile photo we handle uploading it
        final ref = FirebaseStorage.instance.ref(
            "${_auth.currentUser!.uid}/profile.${result!.files.single.extension}");
        final task = ref.putData(result!.files.single.bytes!);

        task.snapshotEvents.listen((event) {
          final percent =
              event.bytesTransferred.toDouble() / event.totalBytes.toDouble();
          emit(SignUpState(
              progress: percent, visible: percent > 0 && percent < 1));
        });
        task.then((uploadedTask) async {
          final photoUrl = await uploadedTask.ref.getDownloadURL();
          await _auth.currentUser!.updatePhotoURL(photoUrl);
        });
      }

      final userData = result != null
          ? {
              "isMale": isMale,
              "age": int.parse(ageController.text),
              "photoUrl": _auth.currentUser!.photoURL,
              "uid": _auth.currentUser!.uid,
            }
          : {
              "isMale": isMale,
              "age": int.parse(ageController.text),
              "uid": _auth.currentUser!.uid,
            };

      // adding the additional data to the fireStore
      await FirebaseFirestore.instance.collection('users').add(userData);
      context.router.navigate(YearlyTodoRoute(fistLogin: true));
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
