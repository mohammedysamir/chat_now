import 'package:flutter/material.dart';
import 'package:chat_now/auth/loginsreen.dart';
import 'package:chat_now/auth/registrationscreen.dart';
import 'package:chat_now/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      // map that consist if key and value pairs
      routes:{
        SplashScreen.routeName:(context)=>SplashScreen(),
        RegisterationScreen.routeName:(context)=>RegisterationScreen(),
        LoginScreen.routeName:(context)=>LoginScreen()
      } ,
      initialRoute: SplashScreen.routeName,
      
    );
  }}
  