import 'package:code_route/classes/auth.dart';
import 'package:code_route/classes/firestore.dart';
import 'package:code_route/classes/myuser.dart';
import 'package:code_route/classes/routeProvider.dart';
import 'package:code_route/classes/user_provider.dart';
import 'package:code_route/pages/coursesType.dart';
import 'package:code_route/pages/firstPage.dart';
import 'package:code_route/pages/parametre.dart';
import 'package:code_route/pages/quizTypes.dart';
import 'package:code_route/util/futurBuilder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OptionsBar extends StatefulWidget {
  const OptionsBar({super.key,});

  @override
  State<OptionsBar> createState() => OptionsBarState();
}

class OptionsBarState extends State<OptionsBar> {
  final _auth =authservice();
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
    Provider.of<user_provider>(context,listen: false).refreshUser();
    myUser? user = Provider.of<user_provider>(context,listen: true).getuser;
    return Drawer(
      backgroundColor: Color.fromARGB(255, 233, 169, 51),
      child: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white24,
              child: Icon(
                CupertinoIcons.person,
                color: Colors.white,
              ),
            ),
            title: Text(user!.name,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                )),
            subtitle: Text(user.email,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                )),
          ),
          SizedBox(
            height: 60,
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('COURS'),
            onTap: () {
              Navigator.pop(context);
              if(Provider.of<routeProvider>(context, listen: false).current!=coursesType.routeName){
                popManager(context, coursesType.routeName) ;
                if(Provider.of<routeProvider>(context, listen: false).current!=coursesType.routeName){

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
                }  
              }          
            },
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(Icons.question_mark),
            title: Text('QUIZ'),
            onTap: () {
              Navigator.pop(context);
              if(Provider.of<routeProvider>(context, listen: false).current!=quizTypes.routeName){
                popManager(context, quizTypes.routeName) ;
                if(Provider.of<routeProvider>(context, listen: false).current!=quizTypes.routeName){
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
                }                                
              }
               
            },
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('PARAMETRE'),
            onTap: () {
              Navigator.pop(context);
              if(Provider.of<routeProvider>(context, listen: false).current!=Settings.routeName){
                popManager(context, Settings.routeName);
                if(Provider.of<routeProvider>(context, listen: false).current!=Settings.routeName){
                  Provider.of<routeProvider>(context, listen: false).addRoute(Settings.routeName);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:(context)=> Settings(),
                    )
                  );

                }
              }

            },
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(Icons.lightbulb),
            title: Text('ABOUT'),
            onTap: () {},
          ),
          SizedBox(
            height: 40,
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('DECONNECCTER'),
            onTap: () async{
              await _auth.signOut();
              Navigator.pop(context);
              while(Provider.of<routeProvider>(context, listen: false).current!=firstPage.routeName){
                Navigator.pop(context);
                Provider.of<routeProvider>(context, listen: false).removeroute();

              }
            },
          ),
        ],
      ),
    );
  }
}

popManager(BuildContext context, String destination){
  if(Provider.of<routeProvider>(context, listen: false).history.contains(destination)){
    while(Provider.of<routeProvider>(context, listen: false).current != destination){
      Navigator.pop(context);
      Provider.of<routeProvider>(context, listen: false).removeroute();
    }
  }
}





  

