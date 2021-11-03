// ignore: implementation_imports
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:younmin/router/router.gr.dart';

import '../helping_functions.dart';

part 'login_state.dart';

final googleSignIn = GoogleSignIn(scopes: [
  "https://www.googleapis.com/auth/user.gender.read",
  "https://www.googleapis.com/auth/user.birthday.read"
]);
final _auth = FirebaseAuth.instance;

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());
  void loginWithGoogle(BuildContext context) async {
    var progress = ProgressHUD.of(context);
    if (_auth.currentUser != null) {
      await _auth.signOut();
    }

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      progress!.show();

      final googleAuth = await googleSignInAccount.authentication;
      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      try {
        await _auth.signInWithCredential(credentials);
      } catch (err) {
        progress.dismiss();

        handleFirebaseError(err, context);
        return;
      }

      await addDataIfFirstTime(
        isMale: await isUserMale(googleSignInAccount),
        age: await calculateUserAge(googleSignInAccount),
      );
      progress.dismiss();

      context.router.navigate(YearlyTodoRoute(fistLogin: true));
    }
  }

  void loginWithFacebook(BuildContext context) async {
    var progress = ProgressHUD.of(context);

    if (_auth.currentUser != null) {
      _auth.signOut();
    }
    final authData = await FacebookAuth.instance.login();

    progress!.show();

    final facebookCredential =
        FacebookAuthProvider.credential(authData.accessToken!.token);
    try {
      await _auth.signInWithCredential(facebookCredential);
    } catch (err) {
      progress.dismiss();

      handleFirebaseError(err, context);
      return;
    }
    await addDataIfFirstTime(
      isMale: await facebookIsUserMale(authData),
      age: await facebookCalculateUserAge(authData),
    );
    progress.dismiss();
    context.router.navigate(YearlyTodoRoute(fistLogin: true));
  }

  void loginWithEmailAndPassword(BuildContext context,
      {required emailController,
      required passwordController,
      required GlobalKey<FormState> formKey}) async {
    if (formKey.currentState!.validate()) {
      var progress = ProgressHUD.of(context);
      progress!.show();
      try {
        await _auth.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
      } catch (err) {
        handleFirebaseError(err, context);
        progress.dismiss();
        return;
      }
      progress.dismiss();
      context.router.navigate(YearlyTodoRoute(fistLogin: true));
    }
  }

  void logout(BuildContext context) async {
    if (_auth.currentUser != null) {
      await _auth.signOut();
    }
    context.router.navigate(const HomeRoute());
  }
}
