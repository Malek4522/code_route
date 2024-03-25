import 'package:firebase_auth/firebase_auth.dart';
import 'package:code_route/classes/myuser.dart';

class authservice{
  final FirebaseAuth auth = FirebaseAuth.instance;
  
  myUser? userfromfirebase(User? user){
    return user != null? myUser(uid: user.uid):null  ;
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

}