import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:younmin/router/router.gr.dart';

part 'login_state.dart';

final googleSignIn = GoogleSignIn();
final _auth = FirebaseAuth.instance;

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());
  void loginWithGoogle(BuildContext context) async {
    if (_auth.currentUser != null) {
      await _auth.signOut();
    }
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    print(googleSignInAccount);
    if (googleSignInAccount != null) {
      final googleAuth = await googleSignInAccount.authentication;
      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credentials);
      context.router.navigate(YearlyTodoRoute());
    }
  }

  void loginWithFacebook(BuildContext context) async {
    if (_auth.currentUser != null) {
      _auth.signOut();
    }
    final authData = await FacebookAuth.instance
        .login(permissions: ["public_profile", "user_gender", "email"]);

    final data = await FacebookAuth.i.getUserData();
    print(data);
    final facebookCredential =
        FacebookAuthProvider.credential(authData.accessToken!.token);
    await _auth.signInWithCredential(facebookCredential);

    context.router.navigate(YearlyTodoRoute());
  }

  void logout(BuildContext context) async {
    if (_auth.currentUser != null) {
      await _auth.signOut();
    }
    context.router.navigate(HomeRoute());
  }
}
