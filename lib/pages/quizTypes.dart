import 'package:code_route/util/options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';//.....
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class quizTypes extends StatelessWidget {
  const quizTypes({
    super.key,
    required this.data
  });

  final data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: OptionsBar(),
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)?.quizTitle ?? 'Quiz',
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
                          builder: (context)=>quizTypes()
                        )
                    );
                  */
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(100, 130, 100, 0),
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  
                  decoration: BoxDecoration(  
                    color: Colors.white,              
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:  Center(
                    child: Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)?.plaques?? 'plaques',
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            fontSize: 60,
                          ),
                        ),
                        Text(
                          data[0].length.toString(),
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
                          builder: (context)=>quizTypes()
                        )
                    );
                  */
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(100, 50, 100, 0),
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  
                  decoration: BoxDecoration(
                    color: Colors.white,                
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)?.priority ?? 'priority',
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            fontSize: 60,
                          ),                         
                        ),
                        Text(
                          data[1].length.toString(),
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