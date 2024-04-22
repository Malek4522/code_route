import 'package:code_route/classes/auth.dart';
import 'package:code_route/classes/myuser.dart';
import 'package:flutter/material.dart';

class user_provider extends ChangeNotifier{
  myUser? _user;
  myUser?  get getuser => _user ;

  
  
  Future refreshUser()async{
    final auth = authservice();
    myUser? user = await auth.getUserDetail();
    _user = user ;
    notifyListeners();
  }
}