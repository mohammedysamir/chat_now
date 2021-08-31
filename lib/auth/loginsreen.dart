// ignore_for_file: prefer_const_constructors
import 'package:chat_now/auth/registrationscreen.dart';
import 'package:chat_now/database/databasehelper.dart';
import 'package:chat_now/home/homescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../appprovider.dart';

class LoginScreen extends StatefulWidget {
  /// route name for the login screen
  static const String routeName='login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AppProvider provider; // late initilization
  final _loginformkey=GlobalKey <FormState>();
  String email='';

  String password='';
  @override
  Widget build(BuildContext context) {
    provider= Provider.of<AppProvider>(context);
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child:Image.asset('assets/SIGN IN – 1.png',
            fit:BoxFit.cover,
            width:double.infinity,
            height:double.infinity,
          ) ,
        ),
        Scaffold(
          backgroundColor:Colors.transparent,
          appBar: AppBar(
            title: Text('Login'),
            centerTitle: true,
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 200.0, 8.0, 0),
                    child: Form(
                      key: _loginformkey,
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
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
                                return 'Please Enter Username';
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
                                return 'Password lenght should be atleat 6 charcaters';
                              }
                              return null;
                            },
                          ),

                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: (){
                        if(_loginformkey.currentState?.validate()==true){
                          createFirebaseUser();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child:
                        isloading?Center(
                          child:CircularProgressIndicator(),
                        ):Text('Login'),
                      )),
                  Spacer(),
                  TextButton(
                    onPressed: (){
                      Navigator.pushNamed(context, RegisterationScreen.routeName);
                    },
                    child:Text( 'Create Account!'),
                  )

                ],) ), )], );
  }
  bool isloading=false;
  void createFirebaseUser()async{
    setState(() {
      isloading=true;
    });
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      if(userCredential.user==null){
        showErrormessage ('Invalid credientials nou user exist with this email and password');
      }else{
        getuserscollection().doc(userCredential.user!.uid).get().then((retriveduser) {
          provider.updateuser(retriveduser.data());
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        });
      }
    } on FirebaseAuthException catch (e) {
      showErrormessage(e.message??'');
    } catch(e){
      showErrormessage(e.toString()??'');
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