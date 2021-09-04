import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Image.asset(
        'assets/background.png',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}

class UnifiedScaffold extends StatelessWidget {
  final Widget body;
  bool isImplyLeading;
  String title;
  bool resizeToAvoidBottomInset;

  UnifiedScaffold(
      {required this.body, required this.isImplyLeading,
        required this.title, this.resizeToAvoidBottomInset = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
        Background(),
        Scaffold(
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              automaticallyImplyLeading: isImplyLeading,
              title: Text(
                title,
                style: TextStyle(fontSize: 25),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            body: body)
      ],
    );
  }
}
