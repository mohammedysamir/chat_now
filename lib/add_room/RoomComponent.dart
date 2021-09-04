import 'package:flutter/material.dart';

class RoomComponent extends StatefulWidget {
  final RoomData room;
  bool isFromBrowse;

  RoomComponent(this.room, {this.isFromBrowse = false});

  @override
  _RoomComponentState createState() => _RoomComponentState();
}

class _RoomComponentState extends State<RoomComponent> {
  String joinMessage = 'Join';
  bool isButtonDisabled = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        if (widget.isFromBrowse)
          {
            showJoinDialog(context),
          }
        else
          null //implement going to chat room
      },
      child: Container(
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
              widget.room.roomImagePath,
              width: 90,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                widget.room.roomName,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              '${widget.room.members} Member(s)',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            )
          ],
        ),
      ),
    );
  }

  void showJoinDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (buildContext) {
          return AlertDialog(
            insetPadding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            contentPadding: EdgeInsets.all(25),
            title: Center(
              child: Text(
                'Hello Welcome to our chat room',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Join ${widget.room.roomName}\'s chat room',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Image.asset(
                    widget.room.roomImagePath,
                  ),
                  Text(
                    widget.room.description,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: isButtonDisabled
                            ? MaterialStateProperty.all<Color>(Colors.grey)
                            : MaterialStateProperty.all<Color>(Colors.blue),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.fromLTRB(30, 10, 30, 10)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ))),
                    onPressed: () => {
                      if (!isButtonDisabled)
                        {
                          addMember(),
                          Navigator.pop(context),
                          //Navigate to the chat room
                        }
                      else
                        null
                    },
                    child: Text(joinMessage,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  )
                ]),
          );
        });
  }

  void addMember() {
    setState(() {
      widget.room.members++;
      joinMessage = 'Already joined';
      isButtonDisabled = true;
      widget.isFromBrowse=false; //disable this dialog for joined rooms
    });
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
