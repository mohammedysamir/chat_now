import 'package:flutter/material.dart';

class RoomComponent extends StatelessWidget {
  final RoomData room;

  RoomComponent(this.room);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            room.roomImagePath,
            width: 90,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              room.roomName,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            '${room.members} Member(s)',
            style: TextStyle(color: Colors.grey, fontSize: 13),
          )
        ],
      ),
    );
  }
}

class RoomData {
  String roomName, roomImagePath, category, description;
  int members;

  RoomData(
      {required this.roomName,
      required this.category,
      required this.description,
      required this.roomImagePath,
      required this.members});
}
