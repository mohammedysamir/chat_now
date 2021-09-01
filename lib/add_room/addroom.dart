import 'package:flutter/material.dart';

import '../Background.dart';

class AddRoom extends StatefulWidget {
  static const String routeName = 'addroom';

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
  final _addroomkey = GlobalKey<FormState>();

  String roomName = '';

  String description = '';

  List<String> categories = ['sports', 'movies', 'music'];

  String selectedcategory = 'sports';

  @override
  Widget build(BuildContext context) {
    return UnifiedScaffold(
        title: 'Chat App',
        isImplyLeading: true,
        body: Center(
          child: Container(
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
              margin: EdgeInsets.symmetric(vertical: 32, horizontal: 12),
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
                        mainAxisAlignment: MainAxisAlignment.center,
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
                                  value: selectedcategory,
                                  iconSize: 24,
                                  elevation: 16,
                                  isExpanded: true,
                                  items: categories.map((name) {
                                    return DropdownMenuItem(
                                      value: name,
                                      child: Row(
                                        children: [
                                          Text(name),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (newselected) {
                                    setState(() {
                                      selectedcategory = newselected as String;
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
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ))),
                    onPressed: () {},
                    child: Text('Create'),
                  )
                ],
              )),
        ));
  }
}
