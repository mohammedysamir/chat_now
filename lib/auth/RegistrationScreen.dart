import 'package:chat_now/Background.dart';
import 'package:chat_now/database/databasehelper.dart';
import 'package:chat_now/home/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_now/model/MyUser.dart';

import 'package:provider/provider.dart';

import '../AppProvider.dart';

class RegisterationScreen extends StatefulWidget {
  static const String routeName = 'register';

  @override
  State<RegisterationScreen> createState() => _RegisterationScreenState();
}

class _RegisterationScreenState extends State<RegisterationScreen> {
  final _registerformkey = GlobalKey<FormState>();

  String username = '';

  String email = '';

  String password = '';
  late AppProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);
    return UnifiedScaffold(
        body: Container(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _registerformkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          onChanged: (textValue) {
                            username = textValue;
                          },
                          decoration: InputDecoration(
                              labelText: 'UserName',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.auto),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Username';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          onChanged: (textValue) {
                            email = textValue;
                          },
                          decoration: InputDecoration(
                              labelText: 'Email',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.auto),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Email';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          onChanged: (textValue) {
                            password = textValue;
                          },
                          obscureText: true,
                          autocorrect: false,
                          enableSuggestions: false,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.auto),
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
                isloading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              onPrimary: Colors.grey,
                              primary: Colors.white,
                              elevation: 5),
                          onPressed: () => {createaccout(),Navigator.pop(context)},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Create Account'),
                              Icon(Icons.arrow_forward,size: 22),
                            ],
                          ),
                        ),
                      ),
              ],
            )),
        isImplyLeading: true,
        title: 'Create Account');
  }

  bool isloading = false;
  final database = FirebaseFirestore.instance;

  void createaccout() {
    if (_registerformkey.currentState?.validate() == true) {
      registerUser();
    }
  }

  final auth = FirebaseAuth.instance;

  void registerUser() async {
    setState(() {
      isloading = true;
    });
    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // pointer to the user collection
      final userCollectionRef = getuserscollection();
      final userr = MyUser(
          ID: userCredential.user!.uid, username: username, email: email);
      userCollectionRef.doc(userr.ID).set(userr).then((value) {
        // save user
        provider.updateuser(userr); // save user
        // navigate to home screen
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      });
      showErrormessage("User Registered successfully");
      // to be completed to insert user data in the database.
    } on FirebaseAuthException catch (e) {
      showErrormessage(e.message ??
          "something went wrong! please try again"); // in case the massage is null
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    setState(() {
      isloading = false;
    });
  }

  void showErrormessage(String message) {
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
