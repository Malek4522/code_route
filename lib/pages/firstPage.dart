import 'package:code_route/classes/myuser.dart';
import 'package:code_route/classes/user_provider.dart';
import 'package:code_route/pages/addContent.dart';
import 'package:code_route/pages/coursesType.dart';
import 'package:code_route/pages/quizTypes.dart';
import 'package:code_route/util/options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class firstPage extends StatelessWidget {
  const firstPage({super.key});

  @override
  Widget build(BuildContext context) {
    myUser? user = Provider.of<user_provider>(context).getuser;
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
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=>coursesType()
                        )
                  );
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(130, 150, 130, 40),
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
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=>quizTypes()
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
                margin: EdgeInsets.fromLTRB(70, 30, 70, 50),
                padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: GestureDetector(
                  onTap: () {
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