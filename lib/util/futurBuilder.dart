import 'package:code_route/classes/user_provider.dart';
import 'package:code_route/pages/addContent.dart';
import 'package:code_route/pages/courses.dart';
import 'package:code_route/pages/firstpage.dart';
import 'package:code_route/pages/general%20_knowledges.dart';
import 'package:code_route/pages/quiz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class futureBuilder extends StatefulWidget {
  const futureBuilder({super.key});

  @override
  State<futureBuilder> createState() => _futureBuilderState();
}

class _futureBuilderState extends State<futureBuilder> {
  Future readdata()async{
    user_provider provider = Provider.of(context,listen: false);
    await provider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: readdata(), 
      builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }else if(snapshot.hasError){
          return Center(
            child: Text("future builder error"),
          );
        }else{
          return addContent();
        }
        
      }
    );
  }
}