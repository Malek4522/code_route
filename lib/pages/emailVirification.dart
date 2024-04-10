import 'dart:async';
import 'package:code_route/classes/auth.dart';
import 'package:code_route/pages/addQuiz.dart';
import 'package:code_route/pages/courses.dart';
import 'package:code_route/pages/login.dart';
import 'package:code_route/util/futurBuilder.dart';
import 'package:code_route/util/timed_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class emailVirification extends StatefulWidget {
  const emailVirification({super.key});

  @override
  State<emailVirification> createState() => _emailVirificationState();
}

class _emailVirificationState extends State<emailVirification> {
  bool isVirified = false;
  final auth = authservice();
  Timer? timer ;
  bool _returning = true;

  void returning(){
    setState(() {
      _returning =!_returning ;
    });
  }
  
  @override
  void initState() {
    super.initState();
    
    isVirified = FirebaseAuth.instance.currentUser!.isAnonymous? 
      true:FirebaseAuth.instance.currentUser!.emailVerified; 
       
    if(!isVirified){
      timer =Timer.periodic(
        Duration(seconds: 3), 
        (_)async{
          
          try{
            await  FirebaseAuth.instance.currentUser!.reload();
            setState(() {
              isVirified =  FirebaseAuth.instance.currentUser!.emailVerified;
            });
            if(isVirified){
              timer!.cancel();
              
            }
          }catch(e){
            print("my error"+e.toString());
            timer!.cancel();
            
          }
          
        }
        
      );
    }
    
  }
  

  @override
  Widget build(BuildContext context) {
    return isVirified? futureBuilder(): Scaffold(
      appBar: AppBar(
        title: Text("email virificating"),
        centerTitle: true,
        leading:!_returning? null : BackButton(
          onPressed: (){
            authservice().signOut();

          }
        ),
      ),
      
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/backround.jpg"),fit: BoxFit.fill),
          
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "  check your inbox for virification email   ",
                    style: TextStyle(fontSize: 25,),
                  ),
                ),
              ),
              SizedBox(height: 200,),
              timedbutton(
                started: true,
                returning: returning,
                validate: true, 
                ontap:()async{
                  
                  await auth.sendVirificationEmail();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("an email sent")));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}