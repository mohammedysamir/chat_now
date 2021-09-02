import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Background.dart';
import '../AppProvider.dart';
import 'RoomComponent.dart';

class AddRoom extends StatefulWidget {
  static const String routeName = 'addroom';

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
  final _addroomkey = GlobalKey<FormState>();
  late AppProvider provider;

  String roomName = '';

  String description = '';

  List<String> categories = ['sports', 'movies', 'music'];

  String selectedCategory = 'sports';

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);
    return UnifiedScaffold(
        title: 'Chat App',
        isImplyLeading: true,
        body: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ]),
            margin: EdgeInsets.symmetric(vertical: 80, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Create New Room',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                Image.asset(
                  'assets/people.png',
                ),
                Form(
                  key: _addroomkey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          onChanged: (textValue) {
                            roomName = textValue;
                          },
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              labelText: 'Room Name',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.auto),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Room Name';
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 24, 8, 10),
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                            decoration: BoxDecoration(border: Border.all()),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint: Text('Select Room Category'),
                                value: selectedCategory,
                                iconSize: 24,
                                elevation: 16,
                                isExpanded: true,
                                items: categories.map((name) {
                                  return DropdownMenuItem(
                                    value: name,
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/$name.png',
                                          width: 40,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          child: Text(
                                            name,
                                            style: TextStyle(fontSize: 22),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newselected) {
                                  setState(() {
                                    selectedCategory = newselected as String;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        TextFormField(
                          onChanged: (textValue) {
                            description = textValue;
                          },
                          decoration: InputDecoration(
                              labelText: 'Description',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.auto),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter your description';
                            }
                            return null;
                          },
                        ),
                      ]),
                ),
                Spacer(),
                ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ))),
                  onPressed: () => {
                    provider.updateRoomList(new RoomComponent(new RoomData(
                      roomName: roomName,
                      roomImagePath: 'assets/$selectedCategory.png',
                      description: description,
                      category: selectedCategory,
                      members: 0, //always starts with 0 members
                    ))),
                    Navigator.pop(context),
                  },
                  child: Text('Create'),
                )
              ],
            )));
  }
}
