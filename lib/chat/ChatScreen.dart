



import 'package:chat_now/Background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ChatScreenContent.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key, required this.roomID}) : super(key: key);

  final String roomID;

  static const String routeName = "/chat";

  @override
  Widget build(BuildContext context) {
    return UnifiedScaffold(
      body: Container(
        margin: EdgeInsets.all(20.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        // alignment: Alignment.center,
        child: ChatScreenContent(roomID: this.roomID),
      ),
      isImplyLeading: true,
      title: "The Movies Zone",
      resizeToAvoidBottomInset: true,
    );
  }
}

