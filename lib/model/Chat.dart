// parsing from json to object class for the chat room collection
import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  static const String COLLECTION_NAME = 'chats';
  String message;
  String roomID;
  String sentBy;
  String authorID;
  int time;

  Chat({
    required this.message,
    required this.roomID,
    required this.sentBy,
    required this.time,
    required this.authorID,
  });

  // named parameter that must be sent.
  Chat.fromJson(Map<String, Object?> json)
      : this(
    message: json['message']! as String,
    roomID: json['roomID']! as String,
    sentBy: json['sentBy'] ! as String,
    time: json['time']! as int,
    authorID: json['authorID'] as String,
  );

  Map<String, Object?> toJson() {
    return {
      'message': message,
      'roomID': roomID,
      'sentBy': sentBy,
      'time': time,
      'authorID': authorID,
    };
  }
}