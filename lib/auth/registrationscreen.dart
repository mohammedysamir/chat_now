// ignore_for_file: prefer_const_constructors
import 'package:chat_now/database/databasehelper.dart';
import 'package:chat_now/home/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import'package:chat_now/model/user.dart' as MyUser;

import 'package:provider/provider.dart';

import '../appprovider.dart';
import 'loginsreen.dart';

// ignore: use_key_in_widget_constructors
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
  late AppProvider provider;
  @override
  Widget build(BuildContext context) {
    provider= Provider.of<AppProvider>(context);
    return Stack(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child:Image.asset('assets/background.png',
            fit:BoxFit.cover,
            width:double.infinity,
            height:double.infinity,
          ) ,
        ),
        Scaffold(
          backgroundColor:Colors.transparent,
          appBar: AppBar(
            title: Text('Crearte Account'),
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
                      key: _registerformkey,
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                return 'Password lenght should be atleat 6 charcaters';
                              }
                              return null;
                            },),],),),),
                  isloading? Center(child: CircularProgressIndicator(),):
                  ElevatedButton(
                    onPressed: ()=>createaccout(),
                    child: Text('Create Account'),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: (){
                      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                    },
                    child:Text( 'Already Have Account!'),
                  ),
                  Spacer(),

                ],) ), )], );
  }
  bool isloading=false;
  final database=FirebaseFirestore.instance;
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

      // pointer to the user collection
      final userCollectionRef= getuserscollection();
      final userr= MyUser.User(ID: userCredential.user!.uid, Username: username, email: email);
      userCollectionRef.doc(userr.ID).set(userr).then((value) {
        // save user
        provider.updateuser(userr); // save user
        // navigate to home screen
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      });
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