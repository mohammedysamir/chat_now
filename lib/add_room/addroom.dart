import 'package:flutter/material.dart';
class AddRoom extends StatefulWidget {
  static const String routeName='addroom';

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
  final _addroomkey=GlobalKey <FormState>();

  String roomName='';

  String description='';

  List <String> categories=['sports','movies','music'];

  String selectedcategory='sports';

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child:Image.asset('assets/SIGN IN – 1.png',
              fit:BoxFit.cover,
              width:double.infinity,
              height:double.infinity,
            ),),
          Scaffold(
              appBar: AppBar(
                title:Text('Chat App!'),
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                centerTitle: true,
              ),
              body:Center(
                child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4,
                            offset: Offset(4,8),
                          ),
                        ]
                    ),
                    margin: EdgeInsets.symmetric(vertical: 32,horizontal: 12),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children:  [
                        Text('Create New Room',style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                          textAlign: TextAlign.center,
                        ),
                        Image(
                          image:AssetImage('assets/group.png'),
                        ),
                        Form(
                          key: _addroomkey,
                          child:Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextFormField(
                                  onChanged: (textValue){
                                    roomName=textValue;
                                  },
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                      labelText:'Room Name',
                                      floatingLabelBehavior:FloatingLabelBehavior.auto
                                  ),
                                  validator: (value){
                                    if(value==null || value.isEmpty){
                                      return 'Please Enter Room Name';
                                    }
                                    return null;
                                  },
                                ),
                                DropdownButton(
                                  value: selectedcategory,
                                  iconSize: 24,
                                  elevation: 16,
                                  items:
                                  categories.map((name){
                                    return DropdownMenuItem(
                                      value: name,
                                      child: Row(
                                        children: [
                                          Image(
                                            image:AssetImage('assets/$name.png'),
                                            width: 24,
                                            height: 24,
                                          ),
                                          Text(name),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (newselected){
                                    setState(() {
                                      selectedcategory=newselected as String;
                                    });
                                  },
                                ),

                                TextFormField(
                                  onChanged: (textValue){
                                    description=textValue;
                                  },
                                  decoration: InputDecoration(
                                      labelText:'description',
                                      floatingLabelBehavior:FloatingLabelBehavior.auto
                                  ),
                                  validator: (value){
                                    if(value==null || value.isEmpty){
                                      return 'Please Enter your description';
                                    }
                                    return null;
                                  },

                                ),
                              ]),),
                        Spacer(),
                        ElevatedButton(onPressed: (){},
                          child: Text('Create'),)





                      ],
                    )
                ),
              )
          ),
        ]
    );
  }
}
