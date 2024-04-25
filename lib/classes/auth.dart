import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:code_route/classes/myuser.dart';



class authservice{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<myUser?> getUserDetail()async{
    User currentuser = _auth.currentUser!;
    
    DocumentSnapshot snap = FirebaseAuth.instance.currentUser!.isAnonymous?
    await _firestore.collection('users').doc("dev").get():
    await _firestore.collection('users').doc(currentuser.uid).get();
    return  myUser.fromsnap(snap);
  }
  

  Future sign_anonym()async{
    try{
      await _auth.signInAnonymously();
      return "done";
    }on FirebaseAuthException catch (e){
      return e.code;
    }catch(e){
      print("myerror: $e");
      
    }
    
  }

  Future signOut()async{
    String state = 'error';
    try{
      if(_auth.currentUser!.isAnonymous){
        await _auth.currentUser!.delete();
      }
      await _auth.signOut();
      state = 'done';
    }
    catch(e){
     state = e.toString();
     
    }
    return state;
  }

  Future<String> changeEmail(String newEmail,String pass)async{
      
     
      
      try{
        var user = FirebaseAuth.instance.currentUser;
        var cred = EmailAuthProvider.credential(email: user!.email!, password: pass);
      

        await user.reauthenticateWithCredential(cred);
        await user.verifyBeforeUpdateEmail(newEmail);      
        signOut();
        return'done';

      }on FirebaseAuthException catch(e){
        return e.code;
      }catch(e){
        return 'unexpected $e';
      } 
    
  }

  Future registerWithEmailPass({
    required String email,
    required String password,
    required String phoneNum,
    required String name,
    required String usertype,

    })async{
    try{
      UserCredential result =  await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );

      myUser user = myUser(
        uid: result.user!.uid, 
        name: name, 
        email: email, 
        phoneNum: phoneNum, 
        userType: usertype,
      );

      await _firestore.collection('users').doc(result.user!.uid).set(        
        user.toJson(),   
      );
      return "done";
    }on FirebaseAuthException catch(e){
      return e.code;
    }catch(e){
      print("myerror: $e");
    }
  }
  
  Future sendVirificationEmail()async{
    
    try{
      await _auth.currentUser!.sendEmailVerification();
    }catch(e){
      print('error virificating $e');
    }
  }
  
  Future loginWithEmailPass({
    required String email, required String password})async{
;
    try{
        await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password
      );
      return "done";
    }on FirebaseAuthException catch (e){
      return e.code;
    } catch(e){
      return e;    
    }
  }
  
  Future resetpassword({
    required String email
  })async{
    String state = 'error';
    try{
      _auth.sendPasswordResetEmail(email: email);
      
      state = 'done';
    }catch(e){
      state = e.toString();
      
    }
    return state;
  }


}