// ignore_for_file: unused_field, unused_local_variable, unused_element

import 'package:chat_app/widgets/auth/auth_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  State<AuthScreen> createState() => _AuthBaseScreenState();
}

class _AuthBaseScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  late UserCredential userCredential;
  String message = '';

  void submit(String email, String password, String userName, bool isLogin,
      BuildContext ctx) async {
    try {
      if (isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await FirebaseFirestore.instance
            .collection('users')
            .doc(_auth.currentUser?.uid)
            .set({
          'username': userName,
          'password': password,
        });
      }
    } on FirebaseAuthMultiFactorException catch (e) {
      if (e.code == 'email-already-in-use') {
        message = ('The account already exist for that email');
      } else if (e.code == 'wrong-password') {
        message = ('Wrong password provided for that user.');
      } else if (e.code == 'weak-password') {
        message = ('This password is too week');
      } else if (e.code == 'user-not-found') {
        message = ('No user found for this email ');
      }
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthWidgets(submit);
  }
}
