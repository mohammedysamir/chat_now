import 'package:chat_now/database/DatabaseAPI.dart';
import 'package:chat_now/model/Chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageForm extends StatefulWidget {
  const MessageForm({Key? key, required this.roomID}) : super(key: key);
  final roomID;

  @override
  MessageFormState createState() {
    return MessageFormState();
  }
}

class MessageFormState extends State<MessageForm> {

  TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final userID = auth.currentUser!.uid;
    // Build a Form widget using the _formKey created above.
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.only(right: 10.0),
            child: TextFormField(
              controller: messageController,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            onPressed: () async {
              print('submit successful');
              DatabaseAPI db = new DatabaseAPI();
              final user = await db.users.getUser(userID);

              if (user == null) return;

              await db.chats.addChat(Chat(
                message: messageController.text,
                authorID: userID,
                sentBy: user.username,
                roomID: widget.roomID,
                time: DateTime.now().millisecondsSinceEpoch,
              ));
              messageController.text = "";
            },
            child: const Text('Submit'),
          ),
        ),
      ],
    );
  }
}