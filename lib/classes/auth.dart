import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:code_route/classes/myuser.dart';

class authservice{
  final FirebaseAuth auth = FirebaseAuth.instance;
  
  myUser? userfromfirebase(User? user){
    return user != null? myUser(uid: user.uid):null  ;
  }
  
  Stream<myUser?> get user{
    return auth.authStateChanges().map((User? user) => userfromfirebase(user));
  }
  
  Future sign_anonym()async{
    try{
      UserCredential result =  await auth.signInAnonymously();
      User? user = result.user  ;
      return userfromfirebase(user);
    }
    catch(e){
      print("error in sign_anonym $e");
      return null;
    }
  }

  Future signOut()async{
    try{
      return await auth.signOut();
    }
    catch(e){
      print("error signing out $e");
      return null;
    }
  }

}