// ignore_for_file: prefer_const_constructors

import 'package:code_route/classes/routeProvider.dart';
import 'package:code_route/pages/coursesType.dart';
import 'package:code_route/util/information.dart';
import 'package:code_route/util/options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class generalknowledge extends StatelessWidget {
  generalknowledge({
    super.key,
    required this.data
  });
  static const String routeName = 'pages/general _knowledges.dart';
  final  data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
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
          AppLocalizations.of(context)?.courseTitle ?? "course",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 38,
          ),
        ),
               
        backgroundColor:Color(0xFFFDC80F),
        elevation: 0,
      ),    
      
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backround.jpg"),          
            fit: BoxFit.fill,
          ),
        ),
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context,index) => ListTile(
            leading: Text(
              (index+1).toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20
              ),
            ),
            title:Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white
              ),
              child: Padding(
                padding: EdgeInsets.all(25),
                child: Text(data[index]["title"],textDirection: TextDirection.rtl),
              ),
            ),
            
            trailing:Hero(
              tag: "tag${index+1}", 
              child:  Icon(Icons.info),           
            ),
            onTap: () {
              Provider.of<routeProvider>(context, listen: false).addRoute(information.routeName);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => information(
                        title: data[index]["title"],
                        index: index, 
                        description: data[index]["explication"], 
                        image: data[index]["url"],
                      )
                    )
                   )
                  );
                },
                
        ),
      )
      )
    );
  }
}