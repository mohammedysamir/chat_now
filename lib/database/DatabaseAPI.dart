


import 'package:chat_now/database/ChatCollectionHandler.dart';
import 'package:chat_now/database/RoomCollectionHandler.dart';
import 'package:chat_now/database/UserCollectionHandler.dart';


// Usage:
// 1) create new DatabaseAPI object
// - DatabaseAPI db = new DatabaseAPI();
// 2) choose a handler from the three collection handlers
// 3) use the methods, these methods are async so use accordingly // TODO: createMessage()
// - db.users.registerUser("email", "username", "password"); // used to register a new user
// - db.rooms.getRooms() // gets all available rooms
// - db.chats.getChats("some room id"); // used to get all messages posted in a certain room
class DatabaseAPI {
  UserCollectionHandler users = new UserCollectionHandler();
  RoomCollectionHandler rooms = new RoomCollectionHandler();
  ChatCollectionHandler chats = new ChatCollectionHandler();
}