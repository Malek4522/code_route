import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_route/classes/auth.dart';
import 'package:code_route/util/course.dart';
import 'package:code_route/util/options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';//.....
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class courses extends StatelessWidget {
  courses({
    super.key,
    required this.data
  });

  final List<QueryDocumentSnapshot>  data;
  final auth = authservice();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      endDrawer: OptionsBar(), 
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,size: 40,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            onPressed:() => _scaffoldKey.currentState!.openEndDrawer(), 
            icon: Icon(Icons.menu,color: Colors.white,size: 40,)
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpg"),          
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          
          children: [       
            Center(
              child: Container(
                margin: EdgeInsets.all(30),
                child: Text(AppLocalizations.of(context)?.courseType ?? 'Course Type',style: TextStyle(fontSize: 50),),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50)                
                ),
              ),
            ),
        
        
            Expanded(
              child: GridView.builder(
                
                padding: EdgeInsets.all(20),
                itemCount: data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 30,
                ),
                
                itemBuilder: (context, index) => Hero(
                  tag: "tag${index+1}", 
                  child: Container(
                    
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: GestureDetector(
                      onTap: () {                       
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => course(
                              index: index,
                              title: data[index].get("title"),
                              description: data[index].toString().contains("explication")?
                              data[index].get("explication"): null ,
                              image: data[index].get("url"),
                            )
                          )
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Image.network(data[index]["url"],)
                      ),
                    ),
                  )
                ) ,
              ),
            ),
          ],
        ),
      )

    );
  }
}