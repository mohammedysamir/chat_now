


import 'package:chat_now/database/ChatCollectionHandler.dart';
import 'package:chat_now/database/RoomCollectionHandler.dart';
import 'package:chat_now/database/UserCollectionHandler.dart';

class DatabaseAPI {
  UserCollectionHandler users = new UserCollectionHandler();
  RoomCollectionHandler rooms = new RoomCollectionHandler();
  ChatCollectionHandler chats = new ChatCollectionHandler();
}