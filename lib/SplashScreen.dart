import 'dart:async';

import 'package:chat_now/home/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:chat_now/auth/LoginSreen.dart';
import 'package:provider/provider.dart';

import 'AppProvider.dart';
class SplashScreen extends StatefulWidget {
  static String routeName='Splash';

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  late AppProvider provider;

  route() {
    Navigator.pushNamed(context, provider.currentuser==null?LoginScreen.routeName:HomeScreen.routeName);// if the user already logged in then save it and redirect to home
  }
  @override
  void initState() {
    super.initState();
    // ignore: prefer_const_constructors
    Timer(Duration(seconds: 3),
            () => Navigator.pushReplacement(context, route()));
  }

  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);
    return Scaffold(
        body: Stack(
          children: [
            Container(
              child: Image.asset("assets/splash.png", fit: BoxFit.fill),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
            ),
          ],
        ));
  }
}