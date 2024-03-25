import 'package:firebase_auth/firebase_auth.dart';

class authservice{
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future sign_anonym()async{
    try{
      UserCredential result =  await auth.signInAnonymously();
      User? user = result.user  ;
      return user ;
    }
    catch(e){
      print("error in sign_anonym $e");
      return null;
    }
  }

}