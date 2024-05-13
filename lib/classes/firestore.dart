import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_route/classes/storage.dart';
import 'package:translator/translator.dart';

class firestore{
  final db = FirebaseFirestore.instance;
  
  Future<String> uploadcontent({
    required DocumentReference monitorRef,
    required String title,
    required Uint8List image,
    required String type,
    double ? difficulty,
    String? plaqueType,
    String? explication,
    Map<String,dynamic>? options,
  })async{
    String state ="error";
    try{
      if(type =="معلومات عامة"){
        await db.collection("معلومات عامة").add({
          "monitorRef" : monitorRef,
          "approved" : false,
          "title" : title,
          "explication" : explication,
        }).then((DocumentReference doc)async{
          await storage().uploadimage(image: image, reference: doc).then((String url)async{
            await doc.update({
              'url' : url
            });
            
            
          });          
        });
      }
      else if(type == "اولويات"){
        await db.collection("اولويات").add({
          "monitorRef" : monitorRef,
          "approved" : false,
          "title" : title,
          "options" : options,
          "explication" : explication,
          "difficulty" : difficulty,
        }).then((DocumentReference doc)async{
          await storage().uploadimage(image: image, reference: doc).then((String url)async{
            await doc.update({
              'url' : url
            });
            await monitorRef.collection("addedContent").add({
              'id' : doc,
              'date' : DateTime.now(),
            });
          });          
        });
      }else{
        await db.collection("اشارات").add({
          "monitorRef" : monitorRef,
          "approved" : false,
          "type" : plaqueType,
          "title" : title,
          "options" : options,
          "difficulty" : difficulty,
        }).then((DocumentReference doc)async{
          
          await storage().uploadimage(image: image, reference: doc).then((String url)async{
            await doc.update({
              'url' : url
            });
            await monitorRef.collection("addedContent").add({
              'contentRef' : doc,
              'date' : DateTime.now(),
            });
          });          
        });
      }
            
      state = "done";
      
    }catch(e){
      state = e.toString();
      print('my error: '+state);
    }
    return state; 
  }

  Future<List<DocumentSnapshot>> retrivePost({
    required String type,
    String? subType,
  })async{
      if(type =='معلومات عامة'){
        return await db.collection(type).where("approved",isEqualTo: true).get().then((value) => value.docs);
      }else if(subType == null){
        return await db.collection(type).where("approved",isEqualTo: true).orderBy("difficulty").get().then((value) => value.docs);
        
      }else{
        return await db.collection(type).where("approved",isEqualTo: true).where("type",isEqualTo: subType).orderBy("difficulty").get().then((value) => value.docs);
      }   

  }

  Future<List> retriveAddedContent({required uid})async{   
    
    var contentFutures =[
      db.collection("اشارات").where("monitorRef",isEqualTo: db.collection('users').doc(uid)).get(),
      db.collection('اولويات').where("monitorRef",isEqualTo: db.collection('users').doc(uid)).get(),
      db.collection('معلومات عامة').where("monitorRef",isEqualTo: db.collection('users').doc(uid)).get()
    ];
    var contentSnapshots = await Future.wait(contentFutures);
    
    
    return contentSnapshots[0].docs+contentSnapshots[1].docs+contentSnapshots[2].docs;

  }

  Future<List<Map<String,dynamic>>> translateContent(List<DocumentSnapshot> content, String to)async{
    if(to=="ar")return Future.value(content.map((e) => e.data() as Map<String,dynamic>).toList());
    final translator = GoogleTranslator();
    List<Map<String,dynamic>> translatedData = [];

    for(var doc in content){
      String? translatedtitle;
      String? translatedexplication;
      Map<String,dynamic> translatedoptions={};


      translatedtitle = await translator.translate(
        doc.get("title"),to: to).then((value) => value.toString());

      if(doc.data().toString().contains("explication")){
         translatedexplication = await translator.translate(
        doc.get("explication"),to: to).then((value) => value.toString());
      }

      if(doc.data().toString().contains("options")){
        Map<String,dynamic>options= doc.get("options");
               
        var futureKeys =options.keys.map((e) => translator.translate(e,to: to)).toList();
        var translatedkeys= await Future.wait(futureKeys);
        for(int i=0;i<translatedkeys.length;i++){
          translatedoptions[translatedkeys[i].toString()]= options.values.elementAt(i);
        }
        
        
        
      }
     
      
      Map<String,dynamic>mymap = {};
      

      mymap.addAll({
        'title':translatedtitle,
        'approved':doc.get("approved"),
        'monitorRef': doc.get("monitorRef"),
        'url': doc.get("url"),
      });
      if(doc.data().toString().contains("difficulty")){
        mymap.addAll({'difficulty':doc.get('difficulty')});
      }
      if(doc.data().toString().contains("options")){
        mymap.addAll({'options':translatedoptions});
      }
      if(doc.data().toString().contains("explication")){
        mymap.addAll({'explication':translatedexplication});
      }
      translatedData.add(mymap);
    }
    return translatedData;

  }

}
