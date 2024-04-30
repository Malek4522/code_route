import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_route/classes/routeProvider.dart';
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
        title: Text(AppLocalizations.of(context)?.scoreHistoryTitle ?? 'score history',),
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
            child: Text(AppLocalizations.of(context)?.noQuizHistory ?? 'you havent passed any quiz yet',),
          ),
        ):
        ListView.builder(
          itemCount: dataa.length,
          itemBuilder: (context,index)=>Card(
            child: ListTile(
              title: Text(dataa[index].get("score").toString()),
              subtitle: Text(
                (dataa[index].get("date")as Timestamp).toDate().toString()
                
              ),
              trailing: Text(dataa[index].get("type")),
            ),
          )
        ),
      )
    );
  }
}