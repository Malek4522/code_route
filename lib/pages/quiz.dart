import 'package:code_route/classes/question.dart';
import 'package:code_route/util/option.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class quiz extends StatefulWidget {
  const quiz({super.key});

  @override
  State<quiz> createState() => _quizState();
}

class _quizState extends State<quiz> {
  int i = 0;
  int score = 0;
  bool check = false;
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
      title: '8+2 = 10',
      option: {
        'no': false,
        'yes': true,
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
  
  void check_fct(){
    setState(() {
      check = true;
    });
  }

  void score_fct(){
    score++;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[800],
      appBar: AppBar(
        title: Text("question ${i+1}"),
        centerTitle: true,
      ),
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/1.png',scale: 3),
            Text(mylist[i].title),
            for(String key in mylist[i].option.keys)
              option(
                title: key,
                valid: mylist[i].option[key] as bool,
                check: check,
                checking: check_fct,
                score: score_fct,
              )

          ],
        ),
      ),
      

      

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        child: Text("Next",style: TextStyle(backgroundColor: Colors.white),),
        onTap: () {
          if(i < mylist.length -1){
            if(check){
              setState(() {
                i++;
                check = false;
              });
            }
          }
          else{
            QuickAlert.show(
              context: context, 
              type: QuickAlertType.success,
              title: "You have finished your test",
              text: "your score is: $score",

            );
          }
        },
      ),

    );
  }
}