import 'package:code_route/classes/routeProvider.dart';
import 'package:code_route/classes/user_provider.dart';
import 'package:code_route/pages/emailVirification.dart';
import 'package:code_route/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform;

void main()async{
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:  DefaultFirebaseOptions.currentPlatform ,
  );
  await SharedPreferences.getInstance().then((value){
    runApp(Myapp(pref: value,));
  });
  
  
}  



class Myapp extends StatefulWidget {
  Myapp({
    super.key,
    required this.pref
  });
  final SharedPreferences pref;

  @override
  State<Myapp> createState() => _MyappState();
  static _MyappState of(BuildContext context) => context.findAncestorStateOfType<_MyappState>()!;
}

class _MyappState extends State<Myapp> {

  Locale? locale ;
  setlocal(String _languageCode){
    setState(() {
      widget.pref.setString("language", _languageCode);
      locale = Locale(_languageCode);
    });
  } 
  @override
  void initState() {
    locale = Locale(widget.pref.getString('language')?? 'en');
    super.initState();
  }

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
         localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],

        locale: locale, 

        supportedLocales: [
          Locale('en'),
          Locale('ar'),
          Locale('fr')
        ],

        builder:(context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor:Platform.isIOS? 0.8:1),
            child: child!,
          );
        },


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




