import 'dart:async';

import 'package:flutter/material.dart';
import 'package:chat_now/auth/registrationscreen.dart';
// ignore: use_key_in_widget_constructors
class SplashScreen extends StatefulWidget {
  static String routeName='Splash';

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  route() {
    Navigator.pushNamed(context, RegisterationScreen.routeName);
  }
  @override
  void initState() {
    super.initState();
    // ignore: prefer_const_constructors
    Timer(Duration(seconds: 3),
            () => Navigator.pushReplacement(context, route()));
  }

  Widget build(BuildContext context) {
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