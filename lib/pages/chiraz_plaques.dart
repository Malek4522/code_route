import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_route/classes/routeProvider.dart';
import 'package:code_route/pages/courses.dart';
import 'package:code_route/pages/coursesType.dart';
import 'package:code_route/util/options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CPlaques extends StatelessWidget {
  CPlaques({
    super.key,
    required this.data
  });

  static const String routeName = 'pages/chiraz_plaques.dart';
  final List<QueryDocumentSnapshot> data;

  final List<String> assets = [
    "assets/danger.jpg",
    "assets/indication.jpg",
    "assets/ordre.jpg",
    "assets/obligation.jpg"
  ];
  
  List<String> plaqueType = []; // To be initialized later

  @override
  Widget build(BuildContext context) {
    plaqueType = [
      AppLocalizations.of(context)!.warning,
      AppLocalizations.of(context)!.guidance,
      AppLocalizations.of(context)!.prohibition,
      AppLocalizations.of(context)!.mandatory
    ];

    return Scaffold(
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
           AppLocalizations.of(context)?.courseTitle ?? 'courses',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 38,
          ),
        ),
        backgroundColor: Color(0xFFFDC80F),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backround.jpg"), 
            fit: BoxFit.fill
          ),
        ),       
        
        child: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(15, 150, 15, 0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 30,
                crossAxisSpacing: 20
              ),   
              itemCount: 4,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Provider.of<routeProvider>(context, listen: false).addRoute(courses.routeName);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)=>courses(data: data.where((element) => element["type"]==plaqueType[index]).toList())
                    )
                  );
                                   
                  
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                  decoration: BoxDecoration(             
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child:Column(
                    children: [
                      Expanded(child: Image.asset(assets[index],fit: BoxFit.contain,)),
                      
                      Text(
                        plaqueType[index],
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),                                        
                ),
              )
            ),
          ),
        )
      )
    );
    
  }
}
