// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_route/classes/routeProvider.dart';
import 'package:code_route/util/futureBuilder_translate.dart';
import 'package:code_route/util/options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class information extends StatelessWidget {
  information({
    super.key,
    required this.title,
    required this.index,
    required this.description,
    required this.image
  });

  final String title;
  final int index;
  final String description;
  final String image;

  static const String routeName = 'pages/information.dart';

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
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Provider.of<routeProvider>(context, listen: false).removeroute();
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            AppLocalizations.of(context)?.courses ?? "courses",
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
              image: AssetImage("assets/backround.jpg"),          
              fit: BoxFit.fill,
            ),              
          ),
          child: ListView(                       
            children: [ 
              
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50)
                ),
                child:AppLocalizations.of(context)!.localeName=="ar"? Text(
                    title,
                    style: TextStyle(fontSize: 50),
                ):
                FutureBuilder_translate(
                    text: title,
                    style: TextStyle(fontSize: 50),
                    to: AppLocalizations.of(context)!.localeName,
      
                )
              ),
              SizedBox(height: 20,),
              Hero(
                tag: "tag${index+1}", 
                
                child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: CachedNetworkImage(imageUrl: image),
                )
              ),
              SizedBox(height: 20,),
              Container(
                
                margin: EdgeInsets.all(50),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  
                  child:AppLocalizations.of(context)!.localeName=="ar"? Text(
                    description,
                    style: TextStyle(fontSize: 20),
                  ):
                  FutureBuilder_translate(
                    text: description,
                    style: TextStyle(fontSize: 20),
                    to: AppLocalizations.of(context)!.localeName,
      
                  )
                  
                ),
                
              ),
      
              Provider.of<routeProvider>(context, listen: false)
              .history[Provider.of<routeProvider>(context, listen: false).history.length-2]=='pages/CheckMoniteur.dart'? 
              Container():GestureDetector(
                onTap: () {
                  Provider.of<routeProvider>(context, listen: false).removeroute();
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(100, 10, 100, 30),
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        AppLocalizations.of(context)?. doneButton ?? 'done',
                        style: TextStyle(fontSize: 50),
                      ),
                    ),
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