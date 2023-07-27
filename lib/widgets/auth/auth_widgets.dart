// ignore_for_file: body_might_complete_normally_nullable, unused_field

import 'package:flutter/material.dart';

class AuthWidgets extends StatefulWidget {
  final void Function(String email, String password, String userName,
      bool isLogin, BuildContext ctx) submitAuth;

  AuthWidgets(this.submitAuth);

  @override
  State<AuthWidgets> createState() => _AuthState();
}

class _AuthState extends State<AuthWidgets> {
  final formKey = GlobalKey<FormState>();

  bool isLogin = true;
  String email = '';
  String userNamr = '';
  String password = '';

  void submit() {
    final isValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      formKey.currentState!.save();
      widget.submitAuth(email, password, userNamr, isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          color: Colors.amberAccent,
          margin: EdgeInsets.all(15),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    key: ValueKey('Email'),
                    decoration: InputDecoration(
                      labelText: 'E-mail Address',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) return 'Fill All Field';
                      if (!value.contains('@')) return 'Invalid Email';
                      return null;
                    },
                    onSaved: (value) => email = value!,
                  ),
                  if (!isLogin)
                    TextFormField(
                      key: ValueKey('userName'),
                      decoration: InputDecoration(
                        labelText: 'UserName',
                      ),
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) return 'Fill All Field';
                        return null;
                      },
                      onSaved: (value) => userNamr = value!,
                    ),
                  TextFormField(
                    key: ValueKey('Password'),
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) return 'Fill All Field';
                      if (!isLogin && value.length < 8) return 'Weak Password';
                      return null;
                    },
                    obscureText: true,
                    onSaved: (value) => password = value!,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                    onPressed: submit,
                    child: isLogin ? Text('Login') : Text('SignUp'),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          isLogin = !isLogin;
                          ;
                        });
                      },
                      child: isLogin
                          ? Text('Create New Account')
                          : Text('I already have an account ')),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
