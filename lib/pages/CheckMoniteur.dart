import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_route/classes/routeProvider.dart';
import 'package:code_route/util/options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckMoniteur extends StatelessWidget {
  const CheckMoniteur({
    super.key,
    required this.data
  });

  final data;

  static const String routeName = 'pages/CheckMoniteur.dart';
  
  


  @override
  Widget build(BuildContext context) {
    final List<DocumentSnapshot> dataa = data[0];
    return Scaffold(
      endDrawer: OptionsBar(),
      appBar: AppBar(
        title: Text(
          'added Content',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 38,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Provider.of<routeProvider>(context, listen: false).removeroute();
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color.fromARGB(255, 233, 169, 51),
        elevation: 0,
      ),
      body:(dataa.length==0)?Center(
        child: Text("you havnt add any content yet"),
      ) 
      :ListView.builder(
        itemCount: dataa.length,
        itemBuilder: (context,index) => Card(
          child: ListTile(
            leading: Icon(Icons.pending_actions_outlined),
            //Icon(Icons.close),//refused        
            //Icon(Icons.check)
            title: Text(dataa[index].get("title")),
            trailing: ElevatedButton(
              onPressed: null,
              child: Text('preview'),
            ),
          )
        ),
        
      ),
    );
  }
}
