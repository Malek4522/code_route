import 'package:code_route/classes/firestore.dart';
import 'package:code_route/classes/routeProvider.dart';
import 'package:code_route/pages/addContent.dart';
import 'package:code_route/pages/coursesType.dart';
import 'package:code_route/pages/quizTypes.dart';
import 'package:code_route/util/futurBuilder.dart';
import 'package:code_route/util/options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class firstPage extends StatelessWidget {
  const firstPage({super.key});
  static const String routeName = 'pages/firstPage.dart';

  Future fetchData_g()async{
    final db = firestore();
    return await db.retrivePost(type: "معلومات عامة");
  }

  Future fetchData_p()async{
    final db = firestore();
    return await db.retrivePost(type: "اشارات");
  }

  Future fetchData_s()async{
    final db = firestore();
    return await db.retrivePost(type: "اولويات");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: OptionsBar(),
      appBar: AppBar(
      
        title: Text(
          'commencer',
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
                  Provider.of<routeProvider>(context, listen: false).addRoute(coursesType.routeName);
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=>futureBuilder(
                            fetchData: [fetchData_p(),fetchData_s(),fetchData_g()],
                            result_with: (data) => coursesType(data: data),
                          )
                        )
                  );
                  
                },
                
                child: Container(
                  margin: EdgeInsets.fromLTRB(120, 150, 120, 40),
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      'Courses',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
              ),


              GestureDetector(
                onTap: () {
                  Provider.of<routeProvider>(context, listen: false).addRoute(quizTypes.routeName);
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:(context)=> futureBuilder(
                            fetchData: [fetchData_p(),fetchData_s()],
                            result_with: (data) => quizTypes(data: data,),
                          )
                        )
                  );
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(130, 0, 130, 50),
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      'quiz',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
              ),

              //(user!.userType == 'Condidat')? SizedBox(height: 1,):Container(
              Container(  
                margin: EdgeInsets.fromLTRB(70, 40, 70, 50),
                padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: GestureDetector(
                  onTap: () {
                    Provider.of<routeProvider>(context, listen: false).addRoute(addContent.routeName);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=>addContent()
                        )
                    );
                    
                  },
                  child: const Center(
                    child: Text(
                      'add content',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
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