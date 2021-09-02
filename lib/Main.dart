import 'package:chat_now/SplashScreen.dart';
import 'package:chat_now/database/DatabaseAPI.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'add_room/AddRoom.dart';
import 'AppProvider.dart';
import 'auth/LoginSreen.dart';
import 'auth/RegistrationScreen.dart';
import 'home/HomeScreen.dart';
Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  Future<void> test() async {
    
    DatabaseAPI api = new DatabaseAPI();
    await api.users.getUsers().then((users) {
      users.forEach((user) {
        print(user.toJson());
      });
    });

    await api.rooms.getRooms().then((ds) {
      ds.forEach((d) {
        print(d.toJson());
      });
    });

    await api.rooms.getRoom("chat room 1").then((ds) {
      ds.forEach((d) {
        print(d.toJson());
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    test();
    // ignore: prefer_const_constructors
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      builder: (context,widget){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Chat App',
          // map that consist if key and value pairs
          routes:{
            SplashScreen.routeName:(context)=>SplashScreen(),
            RegisterationScreen.routeName:(context)=>RegisterationScreen(),
            LoginScreen.routeName:(context)=>LoginScreen(),
            HomeScreen.routeName:(context)=>HomeScreen(),
            AddRoom.routeName:(context)=>AddRoom(),
          } ,
          initialRoute: SplashScreen.routeName,

        );},);

  }}
