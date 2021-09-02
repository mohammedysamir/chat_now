import 'package:chat_now/Background.dart';
import 'package:chat_now/auth/RegistrationScreen.dart';
import 'package:chat_now/database/databasehelper.dart';
import 'package:chat_now/home/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../AppProvider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AppProvider provider;
  final _loginformkey = GlobalKey<FormState>();
  String email = '';

  String password = '';

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);
    return UnifiedScaffold(
      title: 'Login',
      isImplyLeading: false,
      body: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Text(
                'Welcome back!',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 0),
                child: Form(
                  key: _loginformkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        onChanged: (textValue) {
                          email = textValue;
                        },
                        decoration: InputDecoration(
                            labelText: 'Email',
                            floatingLabelBehavior: FloatingLabelBehavior.auto),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Username';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        obscureText: true,
                        autocorrect: false,
                        enableSuggestions: false,
                        onChanged: (textValue) {
                          password = textValue;
                        },
                        decoration: InputDecoration(
                            labelText: 'Password',
                            floatingLabelBehavior: FloatingLabelBehavior.auto),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Password';
                          } else if (value.length < 6) {
                            return 'Password length should be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    onPressed: null,
                    child: Text(
                      'Forget password?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                    primary: Colors.blue,
                    elevation: 5),
                onPressed: () => {
                  if (_loginformkey.currentState!.validate()) {
                    loginUser()
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(fontSize: 16),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      size: 22,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, RegisterationScreen.routeName);
                    },
                    child: Text(
                      'Or Create My Account!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }

  bool isloading = false;

  void loginUser() async {
    setState(() {
      isloading = true;
    });
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user == null) {
        showErrorMessage(
            'Invalid credentials no user exist with this email and password');
      } else {
        print("User accepted");
        getuserscollection()
            .doc(userCredential.user!.uid)
            .get()
            .then((retriveduser) {
          provider.updateuser(retriveduser.data());
          Navigator.pushNamed(context, HomeScreen.routeName);
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showErrorMessage('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showErrorMessage('Wrong password provided for that user.');
      }
      setState(() {
        isloading = false;
      });
    }
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (buildContext) {
          return AlertDialog(
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Ok'))
            ],
          );
        });
  }
}
