// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class information extends StatelessWidget {
  information({
    super.key,
    required this.title,
    required this.index,
    required this.description,
    required this.image
  });

  final String title;
  final int index;
  final String description;
  final String image;

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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,                       
            children: [ 
              
              Container(
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Text(
                  "  "+title+"  ",
                  style: TextStyle(fontSize: 50),
                ),
              ),
              SizedBox(height: 20,),
              Hero(
                tag: "tag${index+1}", 
                
                child: Image.asset(image,scale: 10,)
              ),
              SizedBox(height: 20,),
              Container(
                
                margin: EdgeInsets.all(50),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    description,                               
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                
              ),
              
            ],
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50)
        ),
        child: GestureDetector(
          child: Text(
            "   Done   ",
            style: TextStyle(fontSize: 50),
          ),
          onTap: () {
              Navigator.pop(context);
          },
          ),
              
      ),
    );
  }
}