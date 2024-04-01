import 'package:cloud_firestore/cloud_firestore.dart';

class myUser{
  final String uid;
  final String name;
  final String email;
  final String phoneNum;
  final String userType;
  

  myUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNum,
    required this.userType    
  });

  static myUser? fromsnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String,dynamic>;
    return myUser(
      uid: snap.id,
      name: snapshot['name'], 
      email: snapshot['email'], 
      phoneNum: snapshot['phoneNum'],
      userType: snapshot['userType']     
    );
  }

  Map<String,dynamic> toJson() =>{
    'email': email,
    'name' : name,
    'phoneNum' : phoneNum,
    'userType' : userType  
  };

}