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
/*
class Myapp extends StatelessWidget {
  const Myapp({super.key});

  Future fetchData_p()async{
    final db = firestore();
    return await db.retrivePost(type: "اشارات");
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: futureBuilder(
          fetchData: [fetchData_p()],
          result_with: (data) => testing(data: data),
        ),
      ),
    );
  }
}

class testing extends StatefulWidget {
  const testing({
    super.key,
    required this.data,
  });
  final data;

  @override
  State<testing> createState() => _testingState();
}

class _testingState extends State<testing> {
  int index =0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data[0][index].id),
        centerTitle: true,
      ),
      body: Image.network(widget.data[0][index]["url"]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50)
        ),
        child: GestureDetector(
          child: Text(
            widget.data[0][index]["type"],
            style: TextStyle(fontSize: 50),
          ),
          onTap: () {
              setState(() {
                index++;
              });;
          },
          ),
              
      ),
    );
  }
}
*/

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




