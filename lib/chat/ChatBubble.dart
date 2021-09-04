import 'package:bubble/bubble.dart';
import 'package:chat_now/model/Chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({Key? key, required this.chat}) : super(key: key);
  final Chat chat;


  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final userID = auth.currentUser!.uid;
    var color = Color(0xFFF8F8F8);
    var textColor = Color(0xFF707070);
    var alignment = Alignment.topLeft;
    var nip = BubbleNip.leftTop;
    var datetime = DateTime.fromMillisecondsSinceEpoch(chat.time);
    if (chat.authorID == userID) {
      color = Colors.blue;
      textColor = Colors.white;
      alignment = Alignment.topRight;
      nip = BubbleNip.rightTop;
    }

    print(chat.sentBy);
    return Column(
      children: [
        (chat.authorID == userID
            ? Container()
            : Container(
                alignment: Alignment.centerLeft,
                child: Text(chat.sentBy,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: textColor)),
              )),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            (chat.authorID == userID
                ? Expanded(
                    child: Text(DateFormat('hh:mm a').format(datetime),
                        style: TextStyle(fontSize: 10.0),
                        textAlign: TextAlign.right))
                : Expanded(
                    flex: 3,
                    child: Bubble(
                      margin: BubbleEdges.only(top: 10),
                      alignment: alignment,
                      nip: nip,
                      color: color,
                      child: Text(chat.message,
                          style: TextStyle(color: textColor)),
                      padding: BubbleEdges.all(10.0),
                    ),
                  )),
            (chat.authorID == userID
                ? Expanded(
                    flex: 3,
                    child: Bubble(
                      margin: BubbleEdges.only(top: 10),
                      alignment: alignment,
                      nip: nip,
                      color: color,
                      child: Text(chat.message,
                          style: TextStyle(color: textColor)),
                      padding: BubbleEdges.all(10.0),
                    ),
                  )
                : Expanded(
                    child: Text(DateFormat('hh:mm a').format(datetime),
                        style: TextStyle(fontSize: 10.0),
                        textAlign: TextAlign.left))),
          ],
        ),
      ],
    );
  }
}
