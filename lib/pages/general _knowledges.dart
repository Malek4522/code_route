// ignore_for_file: prefer_const_constructors

import 'package:code_route/util/information.dart';
import 'package:flutter/material.dart';

class generalknowledge extends StatelessWidget {
  generalknowledge({
    super.key,
    required this.data
  });
  final  data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backround.jpg"),          
            fit: BoxFit.fill,
          ),
        ),
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context,index) => ListTile(
            leading: Text(
              (index+1).toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20
              ),
            ),
            title:Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white
              ),
              child: Padding(
                padding: EdgeInsets.all(25),
                child: Text(data[index]["title"],textDirection: TextDirection.rtl),
              ),
            ),
            
            trailing:Hero(
              tag: "tag${index+1}", 
              child:  Icon(Icons.info),           
            ),
            onTap: () {
                   Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => information(
                        title: data[index]["title"],
                        index: index, 
                        description: data[index]["explication"], 
                        image: data[index]["url"],
                      )
                    )
                   )
                   );
                },
                
        ),
      )
      )
    );
  }
}