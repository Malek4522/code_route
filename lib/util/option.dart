import 'package:flutter/material.dart';


class option extends StatefulWidget {
  option({
    super.key,
    required this.title,
    required this.valid,
    required this.check,
    required this.checking,
    required this.score
  });
  final String title;
  final bool valid;
  final bool check;
  final VoidCallback checking;
  final VoidCallback score;

  @override
  State<option> createState() => _optionState();
}

class _optionState extends State<option> {
  Color color = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Padding(
     padding: EdgeInsets.all(8),
      child: GestureDetector(
        child: Container(
          margin: EdgeInsets.all(15),
          width: double.infinity,
          height: 35,
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: widget.check?
            (widget.valid)? Colors.green:color:
            (color!= Colors.white)? color =Colors.white:color,
            
          ),
          
        ),
        onTap: () {
          if(widget.valid){
            widget.score();
          }
          if(!widget.check){
            setState(() {
              color = (widget.valid)?  Colors.green:Colors.red ;
              
            });
            
          }
          widget.checking();
          
        },
      ),
    );
  }
}