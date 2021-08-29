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
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 200.0, 8.0, 0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/"),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 50.0, 8.0, 0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/route.png"),
                              // ignore: prefer_const_constructors
                              Text(
                                "supervised by Mohamed Nabil",
                                // ignore: prefer_const_constructors
                                style: TextStyle(
                                  // ignore: prefer_const_constructors
                                  color: Color.fromARGB(255, 57, 165, 82),
                                  fontSize: 18,
                                ),
                              )
                            ]),
                      )
                    ]),
              ),
            ),
          ],
        ));
  }
}