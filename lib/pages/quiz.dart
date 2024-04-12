import 'package:code_route/classes/content.dart';
import 'package:code_route/util/option.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quickalert/quickalert.dart';

class quiz extends StatefulWidget {
  const quiz({super.key});

  @override
  State<quiz> createState() => _quizState();
}

class _quizState extends State<quiz> {
  
  int j = 65;
  int i = 0;
  int score = 0;
  bool check = false;
  List<dynamic> mylist =[
    priority(
      title: 'choose the correct answer',
      explication: 'test test test test test test test test test test test test test test test test test test test test test ',
      options: {
        '1' : false,
        '2' : true,
        '3' : false,
      },
      url: "https://firebasestorage.googleapis.com/v0/b/code-route-f1a0f.appspot.com/o/2.png?alt=media&token=b2c4f7cf-6283-4085-b5e9-49d97ffc482d"
    )
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
                margin: EdgeInsets.fromLTRB(100, 10, 100, 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25)
                ),
                child: Text(
                  mylist[i].runtimeType.toString()+"-QUIZ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 38,
                ),
                ),
              ),

              Container(
                margin: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25)
                ),
                child: Text(
                  mylist[i].title,
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
                  child: Image.network(mylist[i].url,)
                ),
              ),

                          
              for(String key in mylist[i].options.keys)
                option(
                  title: String.fromCharCode(j++)+".  " +key,
                  valid: mylist[i].options[key] as bool,
                  check: check,
                  checking: check_fct,
                  score: score_fct,
                ),
              
              GestureDetector(

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    (mylist[i] is plaque)? SizedBox(height: 1,):GestureDetector(
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
                                        child: Text(mylist[i].explication,style: TextStyle(fontSize: 30),)
                                      ),

                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(10),
                                          padding: EdgeInsets.fromLTRB(200, 10, 0,0 ),
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
                        padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
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
                            setState(() {
                              j = 65;
                              i++;
                              check = false;
                              });
                          }
                        }else{
                          if(check){
                            QuickAlert.show(
                              context: context, 
                              type: QuickAlertType.success,
                              title: "You have finished your test",
                              text: "your score is: $score",
                            );
                          }
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 30, 10, 30),
                        padding: EdgeInsets.fromLTRB(80, 10, 80, 10),             
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