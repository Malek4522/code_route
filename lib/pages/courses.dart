import 'package:code_route/classes/auth.dart';
import 'package:code_route/classes/myuser.dart';
import 'package:code_route/classes/user_provider.dart';
import 'package:code_route/util/course.dart';
import 'package:code_route/util/options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class courses extends StatefulWidget {
  const courses({super.key});

  @override
  State<courses> createState() => _coursesState();
}

class _coursesState extends State<courses> {
  final auth = authservice();

  Future readdata()async{
    user_provider provider = Provider.of(context,listen: false);
    await provider.refreshUser();
  }

  
  @override
  Widget build(BuildContext context) {
    readdata();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Provider.of<user_provider>(context).getuser?.name ?? ""
        ),
      ),
      drawer: OptionsBar(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backround.jpg"),          
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          
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
                
                itemBuilder: (context, index) => Hero(
                  tag: "tag${index+1}", 
                  child: Container(
                    
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Image.asset("assets/${index+1}.png")
                      ),
                    ),
                  )
                ) ,
              ),
            ),
          ],
        ),
      )

    );
  }
}