import 'package:code_route/classes/qst.dart';
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
  List<qst> mylist =[];
  
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
      appBar: AppBar(
        title: Text("question ${i+1}"),
        centerTitle: true,
      ),
      
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backround.jpg"),          
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25)
                ),
                child: Text(
                  "   "+mylist[i].title+"   ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30),
                ),
              ),

              Container(
                margin: EdgeInsets.fromLTRB(50,0,50,0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Image.asset('assets/${i+1}.png',fit: BoxFit.fill,)
                ),
              ),             
              for(String key in mylist[i].options.keys)
                option(
                  title: key,
                  valid: mylist[i].options[key] as bool,
                  check: check,
                  checking: check_fct,
                  score: score_fct,
                ),

              SizedBox(height: 50,)
            ],
          ),
        ),
      ),
      

      

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        child: Container(
          margin: EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30)
          ),
          child: Text(
            "   Next   ",
            style: TextStyle(
              fontSize: 30,                   
            )
          ),
        ),
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