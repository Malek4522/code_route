import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_route/classes/auth.dart';
import 'package:code_route/classes/routeProvider.dart';
import 'package:code_route/pages/coursesType.dart';
import 'package:code_route/util/course.dart';
import 'package:code_route/util/options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class courses extends StatelessWidget {
  courses({
    super.key,
    required this.data
  });
  static const String routeName = 'pages/courses.dart';

  final List<QueryDocumentSnapshot>  data;
  final auth = authservice();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: OptionsBar(),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Provider.of<routeProvider>(context, listen: false).removeroute();
            Navigator.of(context).pop();
          },
        ),

        title: Text(
          'courses',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 38,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 233, 169, 51),
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
                child: Text("  course-type  ",style: TextStyle(fontSize: 50),),
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
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Provider.of<routeProvider>(context, listen: false).addRoute(course.routeName);                      
                        Map<String,dynamic> options =data[index].data().toString().contains("options")?
                        data[index].get("options"): null;
                        var usdKey = options.keys.firstWhere(
                          (k) => options[k] == true, orElse: () =>"");

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => course(
                              index: index,
                              title: (options ==null)? data[index].get("title"):null,
                              description: data[index].data().toString().contains("explication")?
                              data[index].get("explication"): usdKey ,
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