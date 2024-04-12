import 'package:code_route/util/options.dart';
import 'package:flutter/material.dart';

class coursesType extends StatelessWidget {
  const coursesType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: OptionsBar(),
      appBar: AppBar(
        
        title: Text(
          'cours',
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
            image: AssetImage("assets/backround.jpg"), fit: BoxFit.fill),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              GestureDetector(
                onTap: () {
                  /*
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=>coursesType()
                        )
                    );
                  */
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(45, 130, 130, 0),
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  
                  decoration: BoxDecoration(  
                    color: Colors.white,              
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Column(
                      children: [
                        Text(
                          'plaques',
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                          ),
                        ),
                        Text(
                          '(0)',
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  /*
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=>coursesType()
                        )
                    );
                  */
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(45, 50, 130, 0),
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  
                  decoration: BoxDecoration(
                    color: Colors.white,                
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Column(
                      children: [
                        Text(
                          'priority',
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                          ),
                        ),
                        Text(
                          '(0)',
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),


              GestureDetector(
                onTap: () {
                  /*
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=>coursesType()
                        )
                    );
                  */
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(45, 50, 130, 0),
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  
                  decoration: BoxDecoration( 
                    color: Colors.white,               
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Column(
                      children: [
                        Text(
                          'generality',
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                          ),
                        ),
                        Text(
                          '(0)',
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      )  

    );
  }
}