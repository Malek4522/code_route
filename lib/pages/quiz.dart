import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_route/classes/routeProvider.dart';
import 'package:code_route/util/option.dart';
import 'package:code_route/util/options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

late Timer _timer;

class quiz extends StatefulWidget {
  const quiz({
    super.key,
    required this.data
  });
  
  static const String routeName = 'pages/quiz.dart';
  final List<QueryDocumentSnapshot>  data;

  @override
  State<quiz> createState() => _quizState();
}

List<T> listPickRandItem<T>(List<T> list, int count){
  final mylist = List<T>.from(list);
  mylist.shuffle();
  return mylist.take(count).toList();
}

class _quizState extends State<quiz> {
  
  List<QueryDocumentSnapshot> mylist= [];
  int i = 0;
  double score = 500;
  bool check = false;
  bool streak = false;
  int streak_score = 0;

  
   
  void check_fct(){
    setState(() {
      check = true;
      _timer.cancel();
    });
  }


  score_fct(){
    setState(() {
      streak = true;
      streak_score++;
    });
    
    if(streak_score>8){
      score= score +  10*mylist[i]["difficulty"]*5*timeleft;
    }else if(streak_score>3){
      score= score +  10*mylist[i]["difficulty"]*(streak_score-2)*timeleft;
    }else{
      score= score +  10*mylist[i]["difficulty"]*timeleft;
    }
  }
  double timeleft = 0;
  

  void counterdown(){
    setState(() {
      timeleft = mylist[i]["difficulty"]+7.0;
    });
      Timer.periodic(Duration(seconds: 1), (timer) {
      if(check){
        setState(() {
          timer.cancel();
          print(timeleft);
        });
      }
      else{
        if(timeleft ==0){
          timer.cancel();
          print(timeleft);
        }
        setState(() {
          timeleft=timeleft-1;
        }); 
      }                     
    });
  }
  

  @override
  void initState() {
    super.initState();
    mylist = listPickRandItem(widget.data, 2) ;
    counterdown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: OptionsBar(),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Provider.of<routeProvider>(context, listen: false).removeroute();
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "QUIZ ${i+1} / 20",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 38,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 233, 169, 51),
        elevation: 0,
      ),    
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpg"),          
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
                  mylist[i]["title"],
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
                  child: Image.network(mylist[i]["url"],)
                ),
              ),

                          
              for(String key in mylist[i]['options'].keys)
                option(
                  title: key,
                  valid: mylist[i]["options"][key] ,
                  check: check,
                  checking: check_fct,
                  score: score_fct,
                ),

              check? Container():
              LinearTimer(durationMiliseconds: (mylist[i]["difficulty"]*1000+7000).round(), onTimerFinish: (){setState(() {
                check=true;
              });},stop: check,), 
              
              GestureDetector(

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    (!mylist[i].data().toString().contains("explication")||!check)? Container():GestureDetector(
                      onTap: () {
                        if(check){
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius:BorderRadius.circular(8)
                              ),
                              //contentPadding: EdgeInsets.all(20),
                              title: Text("Explication",),
                              titleTextStyle: TextStyle(fontSize: 24.0),
                              content: Container(                                
                                child: SingleChildScrollView(
                                  padding: const EdgeInsets.all(8.0),                             
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Text(mylist[i]["explication"],style: TextStyle(fontSize: 30),)
                                      ),

                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);                                                                                  
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(10),
                                          padding: EdgeInsets.fromLTRB(150, 10, 0,0 ),
                                          decoration: BoxDecoration(                                      
                                            borderRadius: BorderRadius.circular(5)
                                          ),
                                          child: Text(
                                            "done",
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 40
                                            ),
                                              
                                          )
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              )  
                            ),
                          );
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 30, 10, 30),
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Text(
                          "explication",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                          fontSize: 30,                                  
                          )
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if(i < mylist.length -1){
                          if(check){
                            if(!streak){
                              setState(() {
                                streak_score = 0;
                              });
                            }else{
                              setState(() {
                                streak = false;
                              });
                            }
                            setState(() {
                              i++;
                              check = false;
                            });
                            counterdown();
                          }
                        }else{
                          if(check){
                            if(!FirebaseAuth.instance.currentUser!.isAnonymous){
                              FirebaseFirestore.instance.collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.uid).collection('scoreHistory').add({
                                'score': score,
                                'date': DateTime.now(),
                              });
                            }  
                            QuickAlert.show(
                              context: context, 
                              type: QuickAlertType.success,
                              title: "You have finished your test",
                              text: "your score is: $score",
                              onConfirmBtnTap: (){
                                Navigator.pop(context);
                                
                                Navigator.pop(context);
                                Provider.of<routeProvider>(context, listen: false).removeroute();
                                
                                
                              }
                            );
                          }
                        }
                      },
                      child:!check?Container():  Container(
                        margin: EdgeInsets.fromLTRB(10, 30, 10, 30),
                        padding: EdgeInsets.fromLTRB(60, 10, 60, 10),             
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Text(
                          "Next",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                          fontSize: 30,                                  
                          )
                        ),
                      ),
                    ),
                 
                  ],
                ),
                
              ),
            ],
          ),
        ),
      )
    );
  }
}

class LinearTimer extends StatefulWidget {
  final int durationMiliseconds;
  final VoidCallback onTimerFinish;
  final bool stop;

  const LinearTimer({
      super.key,
      required this.durationMiliseconds,
      required this.onTimerFinish,
      required this.stop,
    });

  @override
  _LinearTimerState createState() => _LinearTimerState();
}

class _LinearTimerState extends State<LinearTimer> {
  late int _milisecondsRemaining;
  late double _barWidth;
  int durationMiliseconds = 17;

  @override
  void initState() {
    super.initState();
    _milisecondsRemaining = widget.durationMiliseconds;
    _barWidth = 1.0;
    startTimer();
  }

  void startTimer() {
    _timer=Timer.periodic(Duration(milliseconds: durationMiliseconds), (timer) {
      setState(() {
        if(widget.stop){
          timer.cancel();
                  
        }
        if (_milisecondsRemaining > 0) {
          _milisecondsRemaining -= durationMiliseconds;
          _barWidth = _milisecondsRemaining <= 0
              ? 0
              : _milisecondsRemaining / widget.durationMiliseconds;
        } else {
          widget.onTimerFinish();
          timer.cancel();
        }
      });
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 30.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.black,
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: _barWidth,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Text(
                    _milisecondsRemaining <= 0
                        ? "finished"
                        : ("${(_milisecondsRemaining / 1000).toStringAsFixed(0)}s left"),
                    style: TextStyle(
                      color: _milisecondsRemaining <= 0
                          ? Colors.white
                          : Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                const Icon(
                  Icons.timer_sharp,
                  color: Colors.white,
                )
            
              ],
            ),
          ),
        )
      ],
    );
  }
}