import 'package:flutter/material.dart';

class course extends StatefulWidget {
    course({
      super.key,
      required this.index,
      required this.title,
      required this.description
    });
  int index;
  String title;
  String description;

  @override
  State<course> createState() => _courseState();
}

class _courseState extends State<course> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                  "  "+widget.title+"  ",
                  style: TextStyle(fontSize: 50),
                ),
              ),
              SizedBox(height: 20,),
              Hero(
                tag: "tag${widget.index+1}", 
                child: Image.asset("assets/${widget.index+1}.png",scale: 10,)
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
                   widget.description,                               
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