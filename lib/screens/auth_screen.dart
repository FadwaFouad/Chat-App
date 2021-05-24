import 'dart:io';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:Chat/widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoading = false;

  void saveForm(
    String userName,
    String passwprd,
    String email,
    bool isLogin,
    BuildContext ctx,
    File imageFile,
  ) async {
    setState(() => isLoading = true);
    try {
      UserCredential userResult;
      if (isLogin)
        userResult = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: passwprd);
      else {
        userResult = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: passwprd);

        await FirebaseStorage.instance
            .ref('${imageFile.path}')
            .putFile(imageFile);
        final profileImageUrl = await FirebaseStorage.instance
            .ref('${imageFile.path}')
            .getDownloadURL();

        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userResult.user.uid)
            .set({
          'username': userName,
          'email': email,
          'imageUrl': profileImageUrl,
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() => isLoading = false);

      String errorMessage = '';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      } else if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is badly formatted.';
      } else {
        errorMessage = 'somthing went wrong';
        print("code " + e.code + " \nmess " + e.message);
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
          backgroundColor: Theme.of(context).errorColor));
    } catch (e) {
      setState(() => isLoading = false);
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Theme.of(context).primaryColor.withOpacity(0.9),
      body: AuthForm(saveForm, isLoading),
    );
  }
}
