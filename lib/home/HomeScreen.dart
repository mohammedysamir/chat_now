import 'package:chat_now/add_room/RoomComponent.dart';
import 'package:chat_now/add_room/AddRoom.dart';
import 'package:chat_now/database/DatabaseAPI.dart';
import 'package:chat_now/model/Room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Background.dart';
import '../AppProvider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AppProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);
    return Stack(
      children: [
        Background(),
        DefaultTabController(
          //add tab bar
          length: 2,
          initialIndex: 0,
          child: Scaffold(
            drawer: Drawer(
              elevation: 20,
              child: Container(),
            ),
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              bottom: TabBar(indicatorColor: Colors.white, tabs: <Widget>[
                Tab(
                  child: Text('My Rooms'),
                ),
                Tab(
                  child: Text('Browse'),
                ),
              ]),
              title: Text(
                'Chat App',
                style: TextStyle(fontSize: 25),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            body: TabBarView(
              children: <Widget>[
                Center(
                  child:
                      // provider.listSize() == 0
                      //     ? Text("No rooms joined yet")
                      //     :
                      createRoomList(), //when the list is empty type no rooms joined
                ),
                Center(
                  child: createRoomList(),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AddRoom.routeName);
              },
              child: Icon(Icons.add),
            ),
          ),
        )
      ],
    );
  }

  Widget createRoomList() {
    DatabaseAPI db = new DatabaseAPI();
    Stream<QuerySnapshot> roomsStream = db.rooms.getRoomsStream();
    return StreamBuilder<QuerySnapshot>(
      stream: roomsStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 5, crossAxisSpacing: 5, crossAxisCount: 2),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext ctx, int index) {
              {
                if (snapshot.data!.docs.length!= 0) {
                  Room room = snapshot.data!.docs.map((doc) {
                    Room room = doc.data()! as Room;
                    return room;
                  }).toList()[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RoomComponent(
                      new RoomData(
                          roomName: room.name,
                          // members: provider.roomList.elementAt(index).room.members,
                          category:
                              room.category,
                          description:
                              room.description,
                          roomID:
                              room.ID!),

                    ),
                  );
                } else
                  return Text("No rooms joined yet");
              }
            });
      }
    );
  }
}
