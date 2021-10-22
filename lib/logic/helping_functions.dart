import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final db = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

Future<bool?> isUserMale(googleUser) async {
  final http.Response gender = await http.get(
    Uri.parse('https://people.googleapis.com/v1/people/me/'
        '?requestMask.includeField=person.genders'),
    headers: await googleUser.authHeaders,
  );
  if (gender.statusCode == 200) {
    Map<String, dynamic> genderResponse = json.decode(gender.body);
    if (genderResponse['genders'] != null) {
      return genderResponse['genders'][0]["formattedValue"] == "Male";
    }
    return null;
  }
}

Future<int?> calculateUserAge(googleUser) async {
  final http.Response birthDay = await http.get(
    Uri.parse('https://people.googleapis.com/v1/people/me/'
        '?requestMask.includeField=person.birthdays'),
    headers: await googleUser.authHeaders,
  );
  if (birthDay.statusCode == 200) {
    Map<String, dynamic> birthdayResponse = json.decode(birthDay.body);
    if (birthdayResponse["birthdays"] != null) {
      DateTime now = DateTime.now();
      final dateOfBirth = birthdayResponse["birthdays"][0]["date"];
      // turning the value from type num into string and then we parse it into int
      // to avoid expectation errors
      int age = (now.year - int.parse(dateOfBirth["year"].toString()));

      if (now.month < dateOfBirth["month"]) age = age - 1;

      return age;
    }
    return null;
  }
}

Future<bool?> facebookIsUserMale(authData) async {
  final http.Response gender = await http.get(Uri.parse(
      'https://graph.facebook.com/me?access_token=${authData.accessToken!.token}&fields=gender'));

  if (gender.statusCode == 200) {
    Map<String, dynamic> genderResponse = json.decode(gender.body);
    if (genderResponse["gender"] != null) {
      return genderResponse["gender"] == "male";
    }
    return null;
  }
  return true;
}

Future<int?> facebookCalculateUserAge(authData) async {
  // TODO: finish tha facebook fitch age part

  final http.Response birthday = await http.get(Uri.parse(
      'https://graph.facebook.com/me?access_token=${authData.accessToken!.token}&fields=birthday'));

  if (birthday.statusCode == 200) {
    Map<String, dynamic> birthdayResponse = json.decode(birthday.body);
    if (birthdayResponse["birthday"] != null) {
      DateTime now = DateTime.now();

      final birthDates = birthdayResponse["birthday"].split("/");
      final birthYear = birthDates[2];
      final birthMonth = birthDates[0];
      int age = (now.year - int.parse(birthYear));
      if (now.month < int.parse(birthMonth)) age = age - 1;
      return age;
    }
  }
  return null;
}

bool handleFirebaseError(err, context) {
  if (err
      .toString()
      .contains("[firebase_auth/account-exists-with-different-credential]")) {
    _errorSnackBar(context,
        message:
            "this account contains email that already in use, try another account");

    return true;
  } else if (err.toString().contains("[firebase_auth/email-already-in-use]")) {
    _errorSnackBar(context,
        message: "this email already in use, try another one");
    return true;
  } else if (err.toString().contains("[firebase_auth/user-not-found]") ||
      err.toString().contains("[firebase_auth/wrong-password]")) {
    _errorSnackBar(context, message: "password or email is wrong");
    return true;
  } else if (err != null) {
    _errorSnackBar(context, message: "something went wrong, try again later");
    return true;
  }
  return false;
}

void _errorSnackBar(context, {message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      duration: const Duration(milliseconds: 1500),
    ),
  );
}

Future<DocumentReference?> addDataIfFirstTime({isMale, age}) async {
  final docs = await db
      .collection("users")
      .where("uid", isEqualTo: _auth.currentUser!.uid)
      .get();
  if (docs.docs.isEmpty) {
    return db.collection("users").add({
      "uid": _auth.currentUser!.uid,
      "isMale": isMale,
      "age": age,
    });
  }
}

Future<QuerySnapshot<Map<String, dynamic>>> getUserData() {
  return db
      .collection("users")
      .where("uid", isEqualTo: _auth.currentUser!.uid)
      .get();
}
