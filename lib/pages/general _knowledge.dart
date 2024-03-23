import 'package:flutter/material.dart';

class generalknowledge extends StatelessWidget {
  generalknowledge({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context,index) => ListTile(
          leading: Text(
            (index+1).toString(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 20
            ),
          ),
          title:Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white
            ),
            child: Padding(
              padding: EdgeInsets.all(25),
              child: Text('title number ${index+1}')
            ),
          ),
          /*
          trailing:Hero(
            tag: "tag${index+1}", 
            child:GestureDetector(
              onTap: () {
                  
              },
              
            )
          ),
          */
        )
      )
    );
  }
}