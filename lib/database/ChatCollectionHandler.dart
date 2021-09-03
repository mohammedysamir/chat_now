import 'package:chat_now/model/Chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatCollectionHandler {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final chatsRef = FirebaseFirestore.instance
      .collection(Chat.COLLECTION_NAME)
      .withConverter<Chat>(
    fromFirestore: (snapshot, _) => Chat.fromJson(snapshot.data()!),
    toFirestore: (chat, _) => chat.toJson(),
  );

  // user crud operations
  // EFFECTS: returns a list of rooms from the database, returns an empty list in case of an error
  Future<List<Chat>> getChats(String roomID) async {
    try {
      QuerySnapshot chats = await chatsRef.where('roomID', isEqualTo: roomID).orderBy('time').get();
      return chats.docs.map((doc) {
        Chat chat = doc.data()! as Chat;
        return chat;
      }).toList();
    } catch (e) {
      print(e);
      return List.empty();
    }
  }

  // EFFECTS: returns a stream of rooms that updates in real time to be used in a stream builder
  Stream getRoomsStream(String roomID) {
    return chatsRef.where('roomID', isEqualTo: roomID).orderBy('time').snapshots();
  }

}
