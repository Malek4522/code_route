import 'package:code_route/classes/auth.dart';
import 'package:code_route/classes/myuser.dart';
import 'package:flutter/material.dart';

class user_provider extends ChangeNotifier{
  myUser? _user;
  final auth = authservice();
  myUser?  get getuser => _user ;

  Future refreshUser()async{
    myUser? user = await auth.getUserDetail();
    _user = user ;
    notifyListeners();
  }
}