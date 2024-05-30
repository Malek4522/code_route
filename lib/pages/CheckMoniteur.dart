import 'package:cached_network_image/cached_network_image.dart';
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

class CheckMoniteur extends StatefulWidget {
  CheckMoniteur({
    super.key,
    required this.data
  });

  final List data;

  static const String routeName = 'pages/CheckMoniteur.dart';

  @override
  State<CheckMoniteur> createState() => _CheckMoniteurState();
}

class _CheckMoniteurState extends State<CheckMoniteur> {
  int i =0;

  @override
  Widget build(BuildContext context) { 
    final List<DocumentSnapshot> dataa = widget.data[0];
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if(didPop) return;
        Provider.of<routeProvider>(context, listen: false).removeroute();
        Navigator.of(context).pop();
      },
      child: Scaffold(   
        endDrawer: OptionsBar(),
        appBar: AppBar(
          toolbarHeight: 120.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Provider.of<routeProvider>(context, listen: false).removeroute();
              Navigator.of(context).pop();
            },
          ),
          title: FittedBox(
           fit: BoxFit.scaleDown,
            child: Text(
               AppLocalizations.of(context)?.appBarTitle ?? 'added content',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 38,
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
          
          : Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(onPressed: (i<=0)?null: (){
                      
                      setState(() {
                        i=i-10;
                      });
                        
                      }, 
                      icon: AppLocalizations.of(context)!.localeName =='ar'?
                      Icon(Icons.keyboard_double_arrow_right,size: 50,color: Colors.white,):
                      Icon(Icons.keyboard_double_arrow_left,size: 50,color: Colors.white,),
                    ),
                    
      
                    Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text("${i+1} - ${i+10<dataa.length+1?i+10:dataa.length}",style: TextStyle(fontSize: 50),)
                    ),
                    IconButton(onPressed: (i+10>=dataa.length)? null:(){
                      setState(() {
                        i=i+10;
                      });
                    }, 
                      icon: AppLocalizations.of(context)!.localeName =='ar'?
                      Icon(Icons.keyboard_double_arrow_left,size: 50,color: Colors.white,):
                      Icon(Icons.keyboard_double_arrow_right,size: 50,color: Colors.white,),
                    ),
                    
      
                  ],
            ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.fromLTRB(5, 20, 5, 20),
                  itemCount: (i+10<dataa.length)?10:dataa.length-i,
                  itemBuilder: (context,index) => Card(
                    child: ListTile(
                      subtitle: Container(
                        height: 0,
                        width: 0,
                        child: CachedNetworkImage(imageUrl: dataa[index+i].get("url")),
                        //Image.network(dataa[index+i].get("url")),
                      ),
                      leading: 
                      (dataa[index+i].get("approved") ==true)?
                      Icon(Icons.check,color: Colors.green,):Icon(Icons.pending_actions_outlined),
                      
                      title: AppLocalizations.of(context)!.localeName=="ar"? Text(
                          dataa[index+i].get("title"),
                      ):
                      FutureBuilder_translate(
                          text: dataa[index+i].get("title"),
                          to: AppLocalizations.of(context)!.localeName,
                
                      ),
                      trailing: Hero(
                        tag: "tag${index+i}",
                        child: ElevatedButton(
                          onPressed: (){
                            final db = firestore();
                            if(dataa[index+i].data().toString().contains("options")){ 
                                                
                              Provider.of<routeProvider>(context, listen: false).addRoute(quiz.routeName);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context)=>FutureBuilder(
                                    future: db.translateContent([dataa[index+i]], AppLocalizations.of(context)!.localeName), 
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
                                    title: dataa[index+i].get("title"), 
                                    index: index+1+i, 
                                    description: dataa[index+i].get("explication"), 
                                    image: dataa[index+i].get("url")
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
