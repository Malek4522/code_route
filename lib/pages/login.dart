import 'package:code_route/pages/courses.dart';
import 'package:flutter/material.dart';
import 'package:code_route/classes/auth.dart';

class login extends StatelessWidget {
  login({super.key});
  final email_controller = TextEditingController();
  final password_controller = TextEditingController();
  final auth = authservice();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Conection"),
        backgroundColor: const Color.fromARGB(255, 233, 169, 51),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/backround.jpg"),fit: BoxFit.fill)
        ),
        child: Column(
          children: [
            SizedBox(height: 100,),
            Container(
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextField(
                  controller: email_controller,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      border: InputBorder.none,
                      hintText: 'E-MAIL',
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                      )),
                ),
              ),
              SizedBox(height: 30),
              Container(
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextField(
                  controller: password_controller,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      border: InputBorder.none,
                      hintText: 'Password',
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.lock,
                          color: Colors.black,
                        ),
                      )),
                ),
              ),
              Text(
                "Mot de pass oublier?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,                 
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.left,
              ),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: (){

                  },
                                     
                  child: Container(
                    margin: EdgeInsets.all(10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 80, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 233, 169, 51),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'Log in',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Text(
                "dont have account ?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,                 
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: (){
                    
                  },
                                      
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 80, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 233, 169, 51),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'creat account',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Text(
                "or",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,                 
                  fontWeight: FontWeight.bold
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: ()async{                    
                    dynamic result = await auth.sign_anonym();                   
                    if(result == null)print("NUll");
                    else print(result);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context)=>courses()
                      )
                    );
                  },
                                      
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 80, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 233, 169, 51),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'continue as guess',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}