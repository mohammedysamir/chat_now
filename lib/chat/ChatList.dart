import 'package:chat_now/database/DatabaseAPI.dart';
import 'package:chat_now/model/Chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ChatBubble.dart';

class ChatList extends StatefulWidget {
  ChatList({Key? key, required this.roomID})
      : super(key: key);

  final roomID;

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {

  ScrollController scrollController = new ScrollController();
  late DatabaseAPI db;
  late Stream<QuerySnapshot> chatsStream;
  // bool needsScroll = true;

  @override
  void initState() {
    super.initState();
    db = new DatabaseAPI();
    chatsStream = db.chats.getChatsStream(widget.roomID);
    // needsScroll = false;
  }

  void scrollToBottom(){
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    // print(needsScroll);
    // if (needsScroll) {
    //   WidgetsBinding.instance!
    //       .addPostFrameCallback((_) => scrollToBottom());
    //   needsScroll = false;
    // }
    return StreamBuilder<QuerySnapshot>(
      stream: chatsStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        // setState(() {
        // needsScroll = true; // TODO: test this
        // });

        return ListView.builder(
          controller: scrollController,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (BuildContext context, int index) {
            Chat chat = snapshot.data!.docs.map((doc) {
              Chat chat = doc.data()! as Chat;
              return chat;
            }).toList()[index];
            print(chat.toJson());
            return Container(
                padding: EdgeInsets.only(bottom: 10.0),
                child: ChatBubble(chat: chat));
          });
      }
    );
  }
}
