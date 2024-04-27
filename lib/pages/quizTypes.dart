import 'package:code_route/classes/routeProvider.dart';
import 'package:code_route/pages/quiz.dart';
import 'package:code_route/util/options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:code_route/pages/firstPage.dart';

class quizTypes extends StatelessWidget {
  const quizTypes({
    super.key,
    required this.data
  });

  static const String routeName = 'pages/quizType.dart';
  final List data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: OptionsBar(),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Provider.of<routeProvider>(context, listen: false).removeroute();
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'quiz',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 38,
          ),
          
        ),
        backgroundColor: Color.fromARGB(255, 233, 169, 51),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backround.jpg"), fit: BoxFit.fill),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              GestureDetector(
                onTap: () {
                  Provider.of<routeProvider>(context, listen: false).addRoute(quiz.routeName);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)=>quiz(data: data[0],)
                    )
                  );
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(90, 130, 90, 0),
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  
                  decoration: BoxDecoration(  
                    color: Colors.white,              
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:  Center(
                    child: Column(
                      children: [
                        Text(
                          'plaques',
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            fontSize: 55,
                          ),
                        ),
                        Text(
                          data[0].length.toString(),
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  Provider.of<routeProvider>(context, listen: false).addRoute(quiz.routeName);
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=>quiz(data: data[1],)
                        )
                    );
                  
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(90, 50, 90, 0),
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  
                  decoration: BoxDecoration(
                    color: Colors.white,                
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'priority',
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            fontSize: 60,
                          ),                         
                        ),
                        Text(
                          data[1].length.toString(),
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ),
              ),         
            ],
          ),
        ),
      )  
    );
  }
}