import 'package:code_route/classes/question.dart';
import 'package:flutter/material.dart';

class quiz extends StatefulWidget {
  const quiz({super.key});

  @override
  State<quiz> createState() => _quizState();
}

class _quizState extends State<quiz> {
  int i = 0;
  List <question> mylist =[
    question(
      title: '2+2',
      option: {
        '3': false,
        '4': true,
        '5': false
      }
    ),
    question(
      title: '2*3',
      option: {
        '6': true,
        '7': false
      }
    ),
    question(
      title: '8+2 = 10',
      option: {
        'no': false,
        'yes': true,
      }
    ),
    question(
      title: '2+2',
      option: {
        '3': false,
        '4': true,
        '5': false
      }
    ),
    question(
      title: '1*4',
      option: {
        '1': false,
        '2': false,
        '3': false,
        '4': true,
      }
    ),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("question ${i+1}"),
        centerTitle: true,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(mylist[i].title)
          ],
        ),
      ),


      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        child: Text("Next"),
        onTap: () {
          if(i < mylist.length -1){
            setState(() {
              i++;
            });
          }
        },
      ),

    );
  }
}