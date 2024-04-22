import 'package:code_route/classes/routeProvider.dart';
import 'package:code_route/classes/user_provider.dart';
import 'package:code_route/pages/coursesType.dart';
import 'package:code_route/pages/emailVirification.dart';
import 'package:code_route/pages/firstPage.dart';
import 'package:code_route/pages/login.dart';
import 'package:code_route/util/options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main()async{
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:  DefaultFirebaseOptions.currentPlatform ,
  );
  
  runApp(Myapp());
  
}  



class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create:(_) => user_provider(),
        ),
        ChangeNotifierProvider(
          create: (_) => routeProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.active){
              if(snapshot.hasData){
                return emailVirification();                
              }else{
                return login();
              }

            }
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }
            return login();
          },

        ),      
      ),
      
    );

  }
}




