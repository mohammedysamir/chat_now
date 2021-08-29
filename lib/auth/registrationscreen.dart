// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Background.dart';
class RegisterationScreen extends StatefulWidget {
  // route name for the registration screen.
  static const String routeName='register'; 

  @override
  State<RegisterationScreen> createState() => _RegisterationScreenState();
}

class _RegisterationScreenState extends State<RegisterationScreen> {
  final _registerformkey=GlobalKey <FormState>();

  String username='';

  String email='';

  String password='';

  @override
  Widget build(BuildContext context) {
    return Stack(
     // ignore: prefer_const_literals_to_create_immutables
     children: [
       Background(),
       Scaffold(
        backgroundColor:Colors.transparent,
        appBar: AppBar(
          
          title: Text('Create Account'),
          backgroundColor:Colors.transparent,
          elevation:0.0,
        ),
        // ignore: avoid_unnecessary_containers
        body:Container(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // ignore: prefer_const_literals_to_create_immutables
            children:[
              Form(
                key: _registerformkey,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      onChanged: (textValue){
                        username=textValue;
                      },
                      decoration: InputDecoration(
                        labelText:'UserName',
                        floatingLabelBehavior:FloatingLabelBehavior.auto
                      ),
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return 'Please Enter Username';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      onChanged: (textValue){
                        email=textValue;
                      },
                      decoration: InputDecoration(
                        labelText:'Email',
                        floatingLabelBehavior:FloatingLabelBehavior.auto
                      ),
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return 'Please Enter Email';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      onChanged: (textValue){
                        password=textValue;
                      },
                      decoration: InputDecoration(
                        labelText:'Password',
                        floatingLabelBehavior:FloatingLabelBehavior.auto
                      ),
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return 'Please Enter Password';
                        }
                        else if (value.length<6){
                          return 'Password length should be at least 6 characters';
                        }
                        return null;
                      },
                    ),

                  ],
                ),
              ),
              isloading? Center(child: CircularProgressIndicator(),):
              ElevatedButton(
                onPressed: ()=>createaccout(),
                 child: Text('Create Account'),
                 ),
               
            ],) ), )], );
  }
  final database=FirebaseFirestore.instance;
  bool isloading=false;
  void createaccout(){
    if(_registerformkey.currentState?.validate()== true){
      registerUser();
      
    }}

    final auth=FirebaseAuth.instance;

  void registerUser()async{
    setState(() {
      isloading=true;
    });
    try {
    // ignore: unused_local_variable
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
    email: email,
    password: password
  );
  showErrormessage("User Registered successfully");
  // to be completed to insert user data in the database.
} on FirebaseAuthException catch (e) {
   showErrormessage(e.message??"something went wrong! please try again"); // in case the massage is null
} catch (e) {
  // ignore: avoid_print
  print(e);
  }
  setState(() {
    isloading=false;
  });
}

void showErrormessage(String message){
     showDialog(
       context: context,
        builder: (buildContext){
          return AlertDialog(content: Text(message),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text('Ok'))
          ],
          );
        });
}
}