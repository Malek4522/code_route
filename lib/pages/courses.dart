// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_route/classes/auth.dart';
import 'package:code_route/classes/routeProvider.dart';
import 'package:code_route/util/course.dart';
import 'package:code_route/util/options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cached_network_image/cached_network_image.dart';


class courses extends StatelessWidget {
  courses({
    super.key,
    required this.data
  });
  static const String routeName = 'pages/courses.dart';

  final List<QueryDocumentSnapshot>  data;
  final auth = authservice();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
        key: _scaffoldKey,
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
             AppLocalizations.of(context)?.courseTitle ?? 'courses',
            style:TextStyle(
              color: Colors.black,
              fontSize: 60,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor:  Color(0xFFFDC80F),
          elevation: 0,   
        ),
      
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background.jpg"),          
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            
            children: [  
              
          
              Expanded(
                child: GridView.builder(
                  
                  padding: EdgeInsets.all(20),
                  itemCount: data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 30,
                  ),
                  
                  itemBuilder: (context, index) => Hero(
                    tag: "tag${index+1}", 
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: GestureDetector(
                        onTap: () {
      
                          Provider.of<routeProvider>(context, listen: false).addRoute(course.routeName);                      
                          Map<String,dynamic> options =data[index].data().toString().contains("options")?
                          data[index].get("options"): null;
                          var usdKey = options.keys.firstWhere(
                            (k) => options[k] == true, orElse: () =>"");
      
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => course(
                                index: index,
                                title: (options ==null)? data[index].get("title"):null,
                                description: data[index].data().toString().contains("explication")?
                                data[index].get("explication"): usdKey ,
                                image: data[index].get("url"),
                              )
                            )
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: CachedNetworkImage(imageUrl: data[index]["url"]),
                        ),
                      ),
                    )
                  ) ,
                ),
              ),
            ],
          ),
        )
      
      ),
    );
  }
}