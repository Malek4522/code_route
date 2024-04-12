import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_route/classes/content.dart';
import 'package:code_route/classes/storage.dart';

class firestore{
  final db = FirebaseFirestore.instance;
  var content ;
  
  Future<String> uploadcontent({
    required DocumentReference monitorRef,
    required String title,
    required Uint8List image,
    required String type,
    String? plaqueType,
    String? explication,
    Map<String,dynamic>? options,
  })async{
    String state ="error";
    try{
      if(type =="معلومات عامة"){
        await db.collection("معلومات عامة").add({
          "monitorRef" : monitorRef,
          "approved" : true,
          //"approved" : false,
          "title" : title,
          "explication" : explication,
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
      }
      else if(type == "اولويات"){
        await db.collection("اولويات").add({
          "monitorRef" : monitorRef,
          "approved" : true,
          //"approved" : false,
          "title" : title,
          "options" : options,
          "explication" : explication,
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
          "approved" : true,
          //"approved" : false,
          "title" : title,
          "options" : options,
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

  Future<List<dynamic>> retrivePost({
    required String type,
    String? subType,
  })async{
    List<dynamic> myList = [];  
      if(subType == null){
        await db.collection(type).get().then((QuerySnapshot snap)async{
          for(var doc in snap.docs){
            myList.add(generality.fromsnap(doc));          
          }
          return myList;
        });
      }else{
        await db.collection(type).where("type").get().then((QuerySnapshot snap)async{
          for(var doc in snap.docs){
            myList.add(generality.fromsnap(doc));          
          }
          return myList;
        });
      }   
           
        

      
        
    
    return myList;

  }
  

}