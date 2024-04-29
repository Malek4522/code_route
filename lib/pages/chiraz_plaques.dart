import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_route/pages/courses.dart';
import 'package:code_route/util/options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';//.....
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CPlaques extends StatelessWidget {
  CPlaques({
    super.key,
    required this.data
  });
  final  List<QueryDocumentSnapshot> data;

  final List<String> assets = ["assets/danger.jpg","assets/indication.jpg","assets/ordre.jpg","assets/obligation.jpg"];
  final List plaqueType = ["التحذير","الارشاد","الممنوع","الاجباري"];
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      endDrawer: OptionsBar(),
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        title: Text(
         AppLocalizations.of(context)?.plaquesTitle ?? 'Plaques',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: () {
              
            },
            icon: const Icon(Icons.menu),
            color: Colors.white,
          ),
        ],
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
