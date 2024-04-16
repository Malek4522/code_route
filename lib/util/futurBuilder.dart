import 'package:flutter/material.dart';

class futureBuilder extends StatelessWidget {
  futureBuilder({
    super.key,
    required this.fetchData,
    this.result_with,
    this.result_without,
  });
  final List <Future> fetchData;
  final Widget Function(dynamic data)? result_with;
  final Widget? result_without;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait(fetchData),
      builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }else if(snapshot.hasError){
          return Center(
            child: Text("future builder error: ${snapshot.error}"),
          );
        }else{
          final collection =snapshot.data!;        
          if(result_with != null) return result_with!(collection);  
          else if(result_without != null) return result_without!;
          return Text("future builder error");
          
          

        }      
      }
    );
  }
}