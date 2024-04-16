import 'package:flutter/material.dart';

class course extends StatefulWidget {
    course({
      super.key,
      required this.index,
      required this.title,
      this.description,
      required this.image
    });
  int index;
  final String title;
  final String? description;
  final String image;

  @override
  State<course> createState() => _courseState();
}

class _courseState extends State<course> {
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
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Text(
                  widget.title,
                  style: TextStyle(fontSize: 50),
                ),
              ),
              SizedBox(height: 20,),
              Hero(
                tag: "tag${widget.index+1}", 
                child: Image.network(widget.image,)
              ),
              SizedBox(height: 20,),

              widget.description==null? Container(): Container(
                
                margin: EdgeInsets.all(50),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                   widget.description!,                               
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