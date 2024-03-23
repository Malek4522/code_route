// ignore_for_file: prefer_const_constructors

import 'package:code_route/util/information.dart';
import 'package:flutter/material.dart';

class generalknowledge extends StatelessWidget {
  generalknowledge({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backround.jpg"),          
            fit: BoxFit.fill,
          ),
        ),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context,index) => ListTile(
            leading: Text(
              (index+1).toString(),
              style: TextStyle(
                color: Colors.white,
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
            
            trailing:Hero(
              tag: "tag${index+1}", 
              child:  Icon(Icons.info),           
            ),
            onTap: () {
                   Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => information(
                        title: "title",
                        index: index, 
                        description: "description", 
                        //image: "${index+1}.png"
                        image: "assets/${index+1}.png",
                      )
                    )
                   )
                   );
                },
                
        ),
      )
      )
    );
  }
}