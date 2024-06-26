import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_route/classes/firestore.dart';
import 'package:code_route/classes/routeProvider.dart';
import 'package:code_route/pages/quiz.dart';
import 'package:code_route/util/options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class quizTypes extends StatelessWidget {
  const quizTypes({
    super.key,
    required this.data
  });

  static const String routeName = 'pages/quizType.dart';
  final List data;

  @override
  Widget build(BuildContext context) {
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
          title: Text(
            AppLocalizations.of(context)?.quizTitle ?? 'Quiz',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 50,
            ),
            
          ),
          backgroundColor:  Color(0xFFFDC80F),
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
                    final db =firestore();
                    Provider.of<routeProvider>(context, listen: false).addRoute(quiz.routeName);
                    Navigator.push(
                      context,
                      MaterialPageRoute(

                        builder: (context)=>FutureBuilder(
                          future: db.translateContent(listPickRandItem(data[0], 20), AppLocalizations.of(context)!.localeName), 
                          builder: (context, snapshot){
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/backround.jpg"), fit: BoxFit.fill),
                                ),
                                child: Center(
                                    child: CircularProgressIndicator(color: Color(0xFFFDC80F)),
                                ),
                                
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
      
                              return quiz(data: snapshot.data,); 
                            }
                          }
                        )
                        
                      )
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(85, 130, 85, 0),
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                    
                    decoration: BoxDecoration(  
                      color: Colors.white,              
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child:  Center(
                      child: Column(
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              AppLocalizations.of(context)?.plaques?? 'plaques',
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold,
                                fontSize: 60,
                              ),
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
                    final db = firestore();
                    Provider.of<routeProvider>(context, listen: false).addRoute(quiz.routeName);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context)=>
                        
                        FutureBuilder(
                          future: db.translateContent(listPickRandItem(data[1], 20), AppLocalizations.of(context)!.localeName), 
                          builder: (context, snapshot){
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/backround.jpg"), fit: BoxFit.fill),
                                ),
                                child: Center(
                                    child: CircularProgressIndicator(color: Color(0xFFFDC80F)),
                                ),
                                
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
      
                              return quiz(data: snapshot.data,); 
                            }
                          }
                        )
                      
                      )
                          
                    );
                    
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(85, 50, 85, 0),
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                    
                    decoration: BoxDecoration(
                      color: Colors.white,                
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                             AppLocalizations.of(context)?.priority ?? 'priority',
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold,
                                fontSize: 60,
                              ),                         
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

                //caching
                Expanded(
                  child: ListView.builder(
                    itemCount: data[0].length,
                    itemBuilder: (context, index) => Container(                    
                      child: CachedNetworkImage(imageUrl: data[0][index]["url"],height: 0,width: 0,),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: data[1].length,
                    itemBuilder: (context, index) => Container(                    
                      child: CachedNetworkImage(imageUrl: data[1][index]["url"],height: 0,width: 0,),
                    ),
                  ),
                ),         
              ],
            ),
          ),
        )  
      ),
    );
  }
}

List<T> listPickRandItem<T>(List<T> list, int count){
  final mylist = List<T>.from(list);
  mylist.shuffle();
  return mylist.take(count).toList();
}