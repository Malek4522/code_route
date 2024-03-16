import 'package:code_route/pages/quiz.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const Myapp());
}
//chiraaz

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: quiz(),
    );
  }
}