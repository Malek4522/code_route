import 'package:code_route/classes/firestore.dart';
import 'package:code_route/classes/myuser.dart';
import 'package:code_route/classes/routeProvider.dart';
import 'package:code_route/classes/user_provider.dart';
import 'package:code_route/pages/addContent.dart';
import 'package:code_route/pages/coursesType.dart';
import 'package:code_route/pages/dev.dart';
import 'package:code_route/pages/quizTypes.dart';
import 'package:code_route/util/futurBuilder.dart';
import 'package:code_route/util/options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
    myUser? user = Provider.of<user_provider>(context,listen: true).getuser;
    return Scaffold(
      endDrawer: OptionsBar(),
      appBar: AppBar(
          toolbarHeight: 120.0,
       
        title:  FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
             AppLocalizations.of(context)?.start ?? 'Start',        
            style: TextStyle(    
              color: Colors.black,
              fontSize: 70,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Color(0xFFFDC80F),
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
                  margin: EdgeInsets.fromLTRB(100, 150, 100, 40),
                  padding: EdgeInsets.fromLTRB(8, 20, 8, 20),
                  
                  decoration: BoxDecoration(
                    color: const Color(0xFFF46833),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:  Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                          AppLocalizations.of(context)?.courses ?? 'Courses',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                        ),
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
                  //margin: EdgeInsets.fromLTRB(125, 0, 125, 50),
                  //padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  margin: EdgeInsets.fromLTRB(100, 0, 100, 50),
                  padding: EdgeInsets.fromLTRB(8, 20, 8, 20),
                  
                  decoration: BoxDecoration(
                    color: Color(0xFFFBAB18),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:  Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        AppLocalizations.of(context)?.quiz ?? 'Quiz',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              (user!.userType == 'Condidat')? SizedBox(height: 1,):Container(
                
                margin: EdgeInsets.fromLTRB(50, 40, 50, 50),
                padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                
                decoration: BoxDecoration(
                  color: Color(0xFFFBAB18),
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
                  child:  Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        
                         AppLocalizations.of(context)?.addContent ?? 'Add Content',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 45,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed:(){ 
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)=>futureBuilder(
                        fetchData: [fetchData_1(),fetchData_2(),fetchData_3()],
                        result_with: (data) => devtool(data: data,),
                      )
                    )
                  );
                }, 
                child: Text("dev tool",style: TextStyle(color: Colors.white),),
              )

            ],
          ),
        ),
      )
    );
  }
  Future fetchData_1()async{
    final db = firestore();
    return await db.db.collection('معلومات عامة').where('approved' ,isEqualTo: false).get().
    then((value) => value.docs);
    
  }
  Future fetchData_2()async{
    final db = firestore();
    return await db.db.collection("اشارات").where("approved" ,isEqualTo: false).get().
    then((value) => value.docs);
  }
  Future fetchData_3()async{
    final db = firestore();
    return await db.db.collection('اولويات').where("approved" ,isEqualTo: false).get().
    then((value) => value.docs);
  }

}