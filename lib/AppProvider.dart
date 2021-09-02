import 'package:chat_now/add_room/RoomComponent.dart';
import 'package:flutter/material.dart';
import 'model/MyUser.dart';
class AppProvider extends ChangeNotifier{
  MyUser? currentuser; // nullable
  late List<RoomComponent> roomList=List.empty(growable: true); //save user's room list
  void updateuser(MyUser? user){
    notifyListeners();
  }
  void updateRoomList(RoomComponent roomComponent){
    roomList.add(roomComponent);
  }
  int listSize(){
    return roomList.length;
  }
}