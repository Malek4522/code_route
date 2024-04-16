import 'package:flutter/material.dart';
import 'dart:async';

class timedbutton extends StatefulWidget {
  timedbutton({
    super.key,
    required this.validate,
    required this.ontap,
    required this.returning,
    required this.started

  });
  final VoidCallback ontap;
  final VoidCallback returning;
  final bool validate;
  final bool started;


  @override
  State<timedbutton> createState() => _timedbuttonState();
}

class _timedbuttonState extends State<timedbutton> {
  int timeleft = -1;
  Timer? _timer ;
  bool enable = true;

  
  void counterdown(){
    widget.ontap();
    widget.returning();  
    setState(() {
      enable = false;
      timeleft = 30;
    });
    _timer=Timer.periodic(Duration(seconds: 1), (timer) {
      if(timeleft ==0){
        _timer!.cancel();
        setState(() {
          enable = true;
          widget.returning(); 
        });
      }
      setState(() {
        timeleft--;
      });                    
      
     
    });
  }
  

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  @override
  void initState() {
    
    super.initState();
    if(widget.started){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        counterdown();
      },);
    }
    
  }
  

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 233, 169, 51),
          borderRadius: BorderRadius.circular(16),
        ),
        child: GestureDetector(
          
          onTap: enable? widget.validate? counterdown:null : null,
          child: ListTile(
            title: Text(
              widget.started?"send again":"send",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            subtitle: (timeleft <0)? null:Text(
              "wait (${timeleft}) to send again",
              style: TextStyle(color: Colors.grey)
            ),
            
          )
        ),
      ),
    );
  }
}