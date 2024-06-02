import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_route/classes/firestore.dart';
import 'package:code_route/util/futurBuilder.dart';
import 'package:code_route/util/futureBuilder_translate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class devtool extends StatefulWidget {
  devtool({
    super.key,
    required this.data
  });
  final List data;

  @override
  State<devtool> createState() => _devtoolState();
}

class _devtoolState extends State<devtool> {

  List data = [];
  int i=0;
  Map<String,dynamic> my_map ={};
  @override
  void initState() {
    for(var a in widget.data){
      data.addAll(a);
    }
    if(data.length>0)my_map = data[0].data();
    super.initState();
  }
  String content_data= "";

  @override
  Widget build(BuildContext context) {
    content_data+="id: ${(data[i]).reference.path}\n";
    my_map.forEach((key, value) {
      if(key!="url" && key!="monitorRef" && key!="approved"){
        if(key == "options"){
          content_data+="options: \n";
          content_data+=value.entries.map((entry) => '  ${entry.key}: ${entry.value}').join('\n');
          content_data+= '\n';

        }else content_data+="$key: $value\n";


      }
    },);
    return Scaffold(
      appBar: AppBar(
        title: Text("devtool",),
        centerTitle: true,
        backgroundColor:  Color(0xFFFDC80F),
      ),
      body: Container(
        
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backround.jpg"), fit: BoxFit.fill),
        ),
        child: i>=data.length? Center(child: Text("all items were virifed",style: TextStyle(color: Colors.white,fontSize: 30),)):
        ListView(
          children: [
            
            Padding(padding: EdgeInsets.all(10),child: Image.network(data[i]["url"],height: 300,width: 300,)),
            Center(child: Text("contentInfo",style: TextStyle(fontSize: 25,color: Colors.white),)),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Center(
                child:AppLocalizations.of(context)!.localeName=="ar"? Text(
                  content_data,
                  style: TextStyle(fontSize: 20),
                )
                :FutureBuilder_translate(
                  text: content_data,
                  style: TextStyle(fontSize: 20),
                  to: AppLocalizations.of(context)!.localeName,
                )
                /*
                child: Text(
                  content_data,
                  style: TextStyle(fontSize: 20),
                )
                */
              ),
              
            ),
            Center(child: Text("UserInfo",style: TextStyle(fontSize: 25,color: Colors.white),)),         
            futureBuilder(
              fetchData: [get_user_data()],
              result_with: (a)=> Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    
                    (a[0]as Map<String,dynamic>).entries.map((entry) => '${entry.key}: ${entry.value}').join('\n'),
                    style: TextStyle(fontSize: 20),
                  )
                ), 
              ),
              
              
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton.filled(
                  color: Colors.red,
                  iconSize: 40,
                  onPressed: (){
                    (data[i]as DocumentSnapshot).reference.delete();
                    setState(() {
                      i++;
                      if(i<data.length)my_map = data[i].data();
                      content_data ="";
                    });
                  }, 
                  icon: Icon(Icons.delete_forever_sharp,)
                ),

                SizedBox(width: 30,),

                TextButton(
                  onPressed: (){
                    setState(() {
                      i++;
                      if(i<data.length)my_map = data[i].data();
                      content_data ="";
                    });
                  }, 
                  child: Text("decide later",style: TextStyle(fontSize: 30,color: Colors.white),)
                ),

                SizedBox(width: 30,),

                IconButton.filled(
                  color: Colors.green,
                  iconSize: 40,
                  onPressed: (){
                    (data[i]as DocumentSnapshot).reference.update({
                      'approved': true,
                    });
                    setState(() {
                      i++;
                      if(i<data.length)my_map = data[i].data();
                      content_data ="";
                    });
                  }, 
                  icon: Icon(Icons.done_sharp)
                ),
              ],
            )
          ],
          
        ),
      )  
    );
    
  }
  Future get_user_data()async{
    final db = firestore();
    return await (data[i]["monitorRef"] ).get().then((value) => value.data());
  }
}