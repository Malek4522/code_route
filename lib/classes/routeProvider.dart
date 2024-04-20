import 'package:code_route/pages/firstPage.dart';
import 'package:flutter/material.dart';

class routeProvider extends ChangeNotifier{
  List<String> _History=[firstPage.routeName];

  String get current => _History.last;
  List<String> get history =>_History;

  addRoute(String route){
    _History.add(route);
    notifyListeners();
  }
  removeroute(){
    _History.removeLast();
    notifyListeners();
  }

}