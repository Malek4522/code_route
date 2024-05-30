import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_route/classes/routeProvider.dart';
import 'package:code_route/util/futureBuilder_translate.dart';
import 'package:code_route/util/options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScoreHistory extends StatelessWidget {
  ScoreHistory({
    super.key,
    required this.data
  });
  final data;
  static const String routeName = 'pages/scoreHistory.dart';

  final dateFormatter = DateFormat('yyyy-MM-dd');
  final timeFormatter = DateFormat('HH:mm:ss');

  @override
  Widget build(BuildContext context) {
    final List<DocumentSnapshot> dataa = data[0];
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
          title: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(AppLocalizations.of(context)?.scoreHistoryTitle ?? 'score history',)
          ),
          backgroundColor: Color.fromARGB(255, 233, 169, 51),
          elevation: 0,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background.jpg"),          
              fit: BoxFit.fill,
            ),
          ),
          child: dataa.length==0? Center(
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Text(
                AppLocalizations.of(context)?.noQuizHistory ?? 'you havent passed any quiz yet',
                style: TextStyle(fontSize: 50),
              ),
            ),
          ):
          ListView.builder(
            itemCount: dataa.length,
            itemBuilder: (context,index)=>Card(
              
              child: Column(
                children: [
                  Text(AppLocalizations.of(context)!.sscore + dataa[index].get("score").toString()) ,
                  Text(AppLocalizations.of(context)!.maxStrike +dataa[index].get("strike").toString()),
                  Text(AppLocalizations.of(context)!.timeSpent +dataa[index].get("timeSpent").toString()+"/ "+dataa[index].get("testTime").toString()) ,
      
      
                  AppLocalizations.of(context)!.localeName=="ar"?
                  Text("نوع: ${dataa[index].get("type")}"):
      
                  FutureBuilder_translate(
                    text: "type: ${dataa[index].get("type")}",
                    to: AppLocalizations.of(context)!.localeName,
                
                  ),
      
      
                  Text(AppLocalizations.of(context)!.date +(dataa[index].get("date")as Timestamp).toDate().toString()) ,
                  
                ],
              ),
            )
          ),
        )
      ),
    );
  }
}