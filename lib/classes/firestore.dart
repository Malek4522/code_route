import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_route/classes/storage.dart';

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
          "approved" : true,
          "type" : plaqueType,
          //"approved" : false,
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
        return await db.collection(type).get().then((value) => value.docs);
      }else if(subType == null){
        return await db.collection(type).orderBy("difficulty").get().then((value) => value.docs);
        
      }else{
        return await db.collection(type).where("type",isEqualTo: subType).orderBy("difficulty").get().then((value) => value.docs);
      }   

  }

  Future<List> retriveAddedContent({required uid})async{   
    
    var addedContentQuery = db
      .collection("users")
      .doc(uid)
      .collection("addedContent")
      .orderBy("date");

    var addedContentSnapshot = await addedContentQuery.get();

    var contentRefs = addedContentSnapshot.docs.map((doc) => doc.get("contentRef")).toList();

    // Ensure that contentRefs is of type List<DocumentReference>
    List<DocumentReference> documentReferences = contentRefs.cast<DocumentReference>();

    var contentFutures = documentReferences.map((ref) => ref.get()).toList();
    var contentSnapshots = await Future.wait(contentFutures);

    return contentSnapshots;
    
    
  }

}
