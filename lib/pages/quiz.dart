import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_route/classes/routeProvider.dart';
import 'package:code_route/pages/quizTypes.dart';
import 'package:code_route/util/option.dart';
import 'package:code_route/util/options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

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
  int score = 0;
  bool check = false;
   
  void check_fct(){
    setState(() {
      check = true;
    });
  }

  void score_fct(){
    score++;
  }
  
  @override
  void initState() {
    mylist = listPickRandItem(widget.data, 2) ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
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
                            setState(() {
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
                              onConfirmBtnTap: (){
                                Navigator.pop(context);
                                /*
                                Navigator.pop(context);
                                Provider.of<routeProvider>(context, listen: false).removeroute();
                                */
                                
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