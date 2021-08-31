import 'package:flutter/material.dart';
import 'model/user.dart';
class AppProvider extends ChangeNotifier{
  User? currentuser; // nullable

  void updateuser(User? user){
    notifyListeners();
  }
}