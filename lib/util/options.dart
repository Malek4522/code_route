import 'package:code_route/classes/auth.dart';
import 'package:code_route/classes/firestore.dart';
import 'package:code_route/classes/myuser.dart';
import 'package:code_route/classes/routeProvider.dart';
import 'package:code_route/classes/user_provider.dart';
import 'package:code_route/main.dart';
import 'package:code_route/pages/CheckMoniteur.dart';
import 'package:code_route/pages/coursesType.dart';
import 'package:code_route/pages/firstPage.dart';
import 'package:code_route/pages/parametre.dart';
import 'package:code_route/pages/quiz.dart';
import 'package:code_route/pages/quizTypes.dart';
import 'package:code_route/pages/scoreHistory.dart';
import 'package:code_route/util/futurBuilder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
  Future fetchData_c(String uid)async{
    final db = firestore();
    return await db.db.collection("users").doc(uid).collection('scoreHistory').get().then((value) => value.docs);
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
            subtitle: Text(FirebaseAuth.instance.currentUser!.isAnonymous?
              "": FirebaseAuth.instance.currentUser!.email!,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                )),
          ),
          SizedBox(
            height: 60,
          ),
          
          (Provider.of<routeProvider>(context, listen: false).current == quiz.routeName)?Container():ListTile(
            leading: Icon(Icons.language),
            title: DropdownButton(
              underline: SizedBox(),
              items: [
                DropdownMenuItem( 
                  value: 'ar',
                  child: Row(
                    children: [
                      Text('العربية'),
                    ],
                  ),
                ),
                DropdownMenuItem( 
                  value: 'fr',
                  child: Row(
                    children: [
                      Text('Français'),
                    ],
                  ),
                ),
                DropdownMenuItem( 
                  value: 'en',
                  child: Row(
                    children: [
                      Text('English'),
                    ],
                  ),
                ), 
              ],
              onChanged: (v) => setState(() { 
                Myapp.of(context).setlocal(v!);
              }),
              value: AppLocalizations.of(context)!.localeName,
            )   
          ),
          
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text(AppLocalizations.of(context)?.courses ?? "courses"),
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
            title: Text(AppLocalizations.of(context)?.quiz ?? "quiz "),
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
          (FirebaseAuth.instance.currentUser!.isAnonymous)? Container(): ListTile(
            leading: Icon(Icons.settings),
            title: Text(AppLocalizations.of(context)?.security ?? "security"),
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
          (FirebaseAuth.instance.currentUser!.isAnonymous)?Container(): ListTile(
            leading: Icon(Icons.history),
            title: Text(AppLocalizations.of(context)?.scoreHistoryTitle ?? "score history"),
            onTap: () {
              
              Navigator.pop(context);
              if(Provider.of<routeProvider>(context, listen: false).current!=ScoreHistory.routeName){
                popManager(context, ScoreHistory.routeName);
                
                if(Provider.of<routeProvider>(context, listen: false).current!=ScoreHistory.routeName){
                  Provider.of<routeProvider>(context, listen: false).addRoute(ScoreHistory.routeName);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)=>futureBuilder(
                        fetchData: [fetchData_c(user.uid)],
                        result_with: (data) => ScoreHistory(data: data),
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
          
          (user.userType == "Condidat")? Container(): ListTile(
            leading: Icon(Icons.add_circle_sharp),
            title: Text(AppLocalizations.of(context)?.appBarTitle ?? "added conetent"),
            onTap: () {
              Navigator.pop(context);
              if(Provider.of<routeProvider>(context, listen: false).current!=CheckMoniteur.routeName){
                popManager(context, CheckMoniteur.routeName);
                if(Provider.of<routeProvider>(context, listen: false).current!=CheckMoniteur.routeName){
                  Provider.of<routeProvider>(context, listen: false).addRoute(CheckMoniteur.routeName);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:(context)=> futureBuilder(
                        fetchData: [firestore().retriveAddedContent(uid: user.uid)],
                        result_with: (data) => CheckMoniteur(data: data),
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
            leading: Icon(Icons.lightbulb),
            title: Text(AppLocalizations.of(context)?.about ?? "about"),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius:BorderRadius.circular(8)
                  ),
                  title: Text(AppLocalizations.of(context)?.about ?? "about"),
                  titleTextStyle: TextStyle(fontSize: 24.0),
                  content: Container(                                
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(8.0),                             
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child:Text(
                            AppLocalizations.of(context)?.aboutmsg ?? 'this app was made by lys team a group of computer science',
                            style: TextStyle(fontSize: 30),
                          )
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);                                                                                  
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.fromLTRB(150, 10, 0,0 ),
                            decoration: BoxDecoration(                                      
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                              AppLocalizations.of(context)?.doneButton ?? "Done",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 40
                              ),                                         
                                                        ),
                            )
                        ),
                      )
                    ],
                    ),
                  )
                )  
              )
            );

            },
          ),
          SizedBox(
            height: 40,
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(AppLocalizations.of(context)?.logout ?? "logout"),
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





  

