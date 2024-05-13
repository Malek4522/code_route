import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_route/classes/firestore.dart';
import 'package:code_route/classes/routeProvider.dart';
import 'package:code_route/pages/quiz.dart';
import 'package:code_route/util/futureBuilder_translate.dart';
import 'package:code_route/util/information.dart';
import 'package:code_route/util/options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CheckMoniteur extends StatelessWidget {
  const CheckMoniteur({
    super.key,
    required this.data
  });

  final data;

  static const String routeName = 'pages/CheckMoniteur.dart';

  @override
  Widget build(BuildContext context) {
    
    final List<DocumentSnapshot> dataa = data[0];
    return Scaffold(
      endDrawer: OptionsBar(),
      appBar: AppBar(
        title: Text(
           AppLocalizations.of(context)?.appBarTitle ?? 'added content',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 38,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Provider.of<routeProvider>(context, listen: false).removeroute();
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color(0xFFFDC80F),
        elevation: 0,
      ),
      body: Container(
         decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backround.jpg"), fit: BoxFit.fill),
          ),
        child:(dataa.length==0)?Center(
          child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text( AppLocalizations.of(context)?.noContentAlert ?? 'you havent added anything yet'),
          ),
        ) 
        
        : Row(
          children: [
            
            ListView.builder(
              padding: EdgeInsets.fromLTRB(5, 20, 5, 20),
              itemCount: dataa.length,
              itemBuilder: (context,index) => Card(
                child: ListTile(
                  leading: 
                  (dataa[index].get("approved") ==true)?
                  Icon(Icons.check,color: Colors.green,):Icon(Icons.pending_actions_outlined),
                  
                  title: AppLocalizations.of(context)!.localeName=="ar"? Text(
                      dataa[index].get("title"),
                  ):
                  FutureBuilder_translate(
                      text: dataa[index].get("title"),
                      to: AppLocalizations.of(context)!.localeName,
            
                  ),
                  trailing: Hero(
                    tag: "tag${index+1}",
                    child: ElevatedButton(
                      onPressed: (){
                        final db = firestore();
                        if(dataa[index].data().toString().contains("options")){ 
                                            
                          Provider.of<routeProvider>(context, listen: false).addRoute(quiz.routeName);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context)=>FutureBuilder(
                                future: db.translateContent([dataa[index]], AppLocalizations.of(context)!.localeName), 
                                builder: (context, snapshot){
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Center(child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return quiz(singledata: snapshot.data![0],); 
                                  }
                                }
                              )
                            )
                                
                          );
                      
                        }else{
                          Provider.of<routeProvider>(context, listen: false).addRoute(information.routeName);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context)=>information(
                                title: dataa[index].get("title"), 
                                index: index, 
                                description: dataa[index].get("explication"), 
                                image: dataa[index].get("url")
                              )
                            )
                                
                          );
                        }
                    
                    
                      },
                      child: Text( AppLocalizations.of(context)?.previewButton ?? 'preview'),
                    ),
                  ),
                )
              ),
              
            ),
          ],
        ),
      ),
    );
  }
}
