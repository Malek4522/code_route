import 'package:code_route/util/course.dart';
import 'package:flutter/material.dart';


class courses extends StatefulWidget {
  const courses({super.key});

  @override
  State<courses> createState() => _coursesState();
}

class _coursesState extends State<courses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Column(
        
        children: [
          
          Center(
            child: Container(
              margin: EdgeInsets.all(30),
              child: Text("  course-type  ",style: TextStyle(fontSize: 50),),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50)                
              ),
            ),
          ),


          Expanded(
            child: GridView.builder(
              
              padding: EdgeInsets.all(20),
              itemCount: 10,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 30,
              ),
              /*
              itemBuilder: (context,index)=>Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(image: AssetImage('assets/ (${index+1}).png'),scale: 12),
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Hero(
                  tag: "tag${index+1}", 
                  child: Icon(Icons),
                )
                
              )
              */
              itemBuilder: (context, index) => Hero(
                tag: "tag${index+1}", 
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(image: AssetImage('assets/ (${index+1}).png'),scale: 12),
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => course(
                            index: index,
                            title: "title-test-${index+1}",
                            description: "description-test-${index+1}",
                          )
                        )
                      );
                    },
                  ),
                )
              ) ,
            ),
          ),
        ],
      )

    );
  }
}