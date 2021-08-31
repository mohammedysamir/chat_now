import 'package:chat_now/add_room/addroom.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatelessWidget {
  static const String routeName='home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child:Image.asset('assets/background.png',
            fit:BoxFit.cover,
            width:double.infinity,
            height:double.infinity,
          ),),
        Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed:(){
              Navigator.pushNamed(context, AddRoom.routeName);
            } ,
            child: Icon(
                Icons.add
            ),
          ),
        ),
      ],
    );
  }
}
