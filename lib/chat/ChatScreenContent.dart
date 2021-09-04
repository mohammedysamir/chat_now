

import 'package:chat_now/chat/MessageForm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ChatList.dart';

class ChatScreenContent extends StatelessWidget {
  ChatScreenContent({Key? key, required this.roomID}) : super(key: key);
  final String roomID;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: ChatList(roomID: this.roomID),
        ),
        Expanded(child: MessageForm(roomID: roomID,)),
      ],
    );
  }
}
