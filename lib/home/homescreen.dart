import 'package:chat_now/add_room/RoomComponent.dart';
import 'package:chat_now/add_room/addroom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Background.dart';
import '../appprovider.dart';

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
            resizeToAvoidBottomInset: false,
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
              automaticallyImplyLeading: false,
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
                  child: Text("Suggested rooms"),
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
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 5, crossAxisSpacing: 5, crossAxisCount: 2),
        itemCount: provider.listSize(),
        itemBuilder: (BuildContext ctx, int index) {
          {
            if (provider.listSize() != 0) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: RoomComponent(new RoomData(
                    roomImagePath: provider.roomList.elementAt(index).room.roomImagePath,
                    roomName: provider.roomList.elementAt(index).room.roomName,
                    members: provider.roomList.elementAt(index).room.members,
                    category: provider.roomList.elementAt(index).room.category,
                    description: provider.roomList.elementAt(index).room.description
                )
                ),
              );
            } else
              return Text("No rooms joined yet");
          }
        }
    );
  }
}