import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_route/classes/routeProvider.dart';
import 'package:code_route/util/option.dart';
import 'package:code_route/util/options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

late Timer _timer;

class quiz extends StatefulWidget {
   quiz({
    super.key,
    this.data,
    this.singledata,
  });

  
  static const String routeName = 'pages/quiz.dart';
  List<Map<String,dynamic>>?  data= [];
  Map<String,dynamic>? singledata;


  @override
  State<quiz> createState() => _quizState();
}



class _quizState extends State<quiz> {
  
  int i = 0;
  bool check = false;
  bool streak = false;
  int streak_score = 0;
  int max_Strike = 0;
  double total_time =0;
  int score=0;

  
   
  void check_fct(){
    setState(() {
      check = true;
      _timer.cancel();
    });
  }


  score_fct(){
    setState(() {
      score++;
      streak = true;
      streak_score++;
    });
    
    
  }
  double timeleft = 0;
  

  void counterdown(){
    setState(() {
      timeleft = widget.data![i]["difficulty"]+12.0;
    });
      Timer.periodic(Duration(seconds: 1), (timer) {
      if(check){
        setState(() {
          timer.cancel();
        });
      }
      else{
        if(timeleft ==0){
          timer.cancel();
        }
        
        timeleft=timeleft-1;
         
      }                     
    });
  }
  

  @override
  void initState() {
    super.initState();
    if(widget.singledata ==null){
      counterdown();
    }else{
      widget.data=[];
      widget.data!.add(widget.singledata!);
      check = true;
    }
    
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      endDrawer: OptionsBar(),
      appBar: AppBar(
         toolbarHeight: 120.0, 
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Provider.of<routeProvider>(context, listen: false).removeroute();
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          (widget.singledata ==null)?AppLocalizations.of(context)?.quizTitle ?? "QUIZ ${i+1} / 20":AppLocalizations.of(context)?.quizTitle ?? "QUIZ",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 60,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFDC80F),
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
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                margin: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25)
                ),
                child:Text(
                  widget.data![i]["title"],
                  style: TextStyle(fontSize: 30),
                )
              ),

              Container(                              
                margin: EdgeInsets.fromLTRB(50,0,50,0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Image.network(widget.data![i]["url"],)
                ),
              ),

                          
              for(String key in widget.data![i]['options'].keys)
                option(
                  title: key,
                  valid: widget.data![i]["options"][key] ,
                  check: check,
                  checking: check_fct,
                  score: score_fct,
                ),

              (widget.singledata !=null)?Container():
              check? Container():
              LinearTimer(durationMiliseconds: (widget.data![i]["difficulty"]*1000+12000).round(), onTimerFinish: (){
                if(!check){
                  setState(() {
                    check = true;
                  });
                }
              },stop: check,), 
              
              GestureDetector(

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    
                    (!widget.data![i].toString().contains("explication")||!check)? Container():GestureDetector(
                      onTap: () {
                        if(check){
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius:BorderRadius.circular(8)
                              ),
                              title: Text(AppLocalizations.of(context)?.explication ?? "Explication",),
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
                                        child:Text(
                                          widget.data![i]["explication"],
                                          style: TextStyle(fontSize: 30),
                                        )
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
                                            AppLocalizations.of(context)?.doneButton ?? "Done",
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
                           AppLocalizations.of(context)?.explaination ?? "Explication",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                          fontSize: 30,                                  
                          )
                        ),
                      ),
                    ),


                    (widget.singledata !=null)? Container(): GestureDetector(
                      onTap: () {
                        if(max_Strike<streak_score)max_Strike=streak_score;
                        total_time+=   widget.data![i]["difficulty"]+12.0-timeleft;

                       


                        if(i < widget.data!.length -1){

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
                            double totaltime=0;
                            for(var data in widget.data!){
                              totaltime +=data["difficulty"]+12;
                            }
                                                      
                            if(!FirebaseAuth.instance.currentUser!.isAnonymous){
                              FirebaseFirestore.instance.collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.uid).collection('scoreHistory').add({                    
                                'type': widget.data![i].toString().contains("explication")? "اولويات":"اشارات",
                                'date': DateTime.now(),
                                'score': score,
                                'testTime':totaltime,
                                'timeSpent':total_time,
                                'strike': max_Strike,

                              });
                            }  
                             String finishTestMessage = AppLocalizations.of(context)!.
                             finishTestMessage("$score/20");
                            QuickAlert.show(
                              context: context, 
                              type: QuickAlertType.success,
                              title: AppLocalizations.of(context)?.finishTestTitle ?? "Quiz Completed",
                               text: finishTestMessage,
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
                          color: Color(0xFFFDC80F),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Text(
                           AppLocalizations.of(context)?.nextButton ?? "Next",
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
                  child: Container(
                    child: Text(
                      _milisecondsRemaining <= 0
                          ?  AppLocalizations.of(context)?.finished ?? "finished"
                          : ("${(_milisecondsRemaining / 1000).toStringAsFixed(0)}s left"),
                      style: TextStyle(
                        color: _milisecondsRemaining <= 0
                            ? Colors.white
                            : Colors.black,
                        fontSize: 14,
                      ),
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