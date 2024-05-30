import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_route/classes/routeProvider.dart';
import 'package:code_route/pages/chiraz_plaques.dart';
import 'package:code_route/pages/courses.dart';
import 'package:code_route/pages/general%20_knowledges.dart';
import 'package:code_route/util/options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class coursesType extends StatelessWidget {
  coursesType({
    super.key,
    required this.data
  });
  static const String routeName = 'pages/coursesType.dart';

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
          leading: 
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Provider.of<routeProvider>(context, listen: false).removeroute();
              Navigator.of(context).pop();
            },
          ),
          
          title: Text(
            AppLocalizations.of(context)?.courseTitle ?? 'Courses',
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
                    Provider.of<routeProvider>(context, listen: false).addRoute(CPlaques.routeName);              
                    Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context)=>CPlaques(data: data[0],)
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
                             AppLocalizations.of(context)?.plaques ?? 'Plaques',
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold,
                                fontSize: 45,
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
                    Provider.of<routeProvider>(context, listen: false).addRoute(courses.routeName);
                    Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context)=>courses(data: data[1],)
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
                    child:  Center(
                      child: Column(
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                               AppLocalizations.of(context)?.priority ?? 'Priority',
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold,
                                fontSize: 45,
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
      
      
                GestureDetector(
                  onTap: () {
                    Provider.of<routeProvider>(context, listen: false).addRoute(generalknowledge.routeName);                
                    Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context)=> generalknowledge(data: data[2])
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
                               AppLocalizations.of(context)?.generality ?? 'Generality',
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold,
                                fontSize: 45,
                              ),
                            ),
                          ),
                          Text(
                            data[2].length.toString(),
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

                //  image caching
                Expanded(
                  child: ListView.builder(
                    itemCount: data[0].length,
                    itemBuilder: (context, index) => Container(
                      height: 0,
                      width: 0,
                      child: CachedNetworkImage(imageUrl: data[0][index]["url"]),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: data[1].length,
                    itemBuilder: (context, index) => Container(
                      height: 0,
                      width: 0,
                      child: CachedNetworkImage(imageUrl: data[1][index]["url"]),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: data[2].length,
                    itemBuilder: (context, index) => Container(
                      height: 0,
                      width: 0,
                      child: CachedNetworkImage(imageUrl: data[2][index]["url"]),
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