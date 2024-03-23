import 'package:flutter/material.dart';


class FormScreen extends StatefulWidget {
   const FormScreen({super.key}) ;

  @override
  State<FormScreen> createState() => _FormScreenState();
} 

class _FormScreenState extends State<FormScreen> {
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
              backgroundColor: Colors.amber,
              title: const Text("Creer Un Neauveau Compte"),
              
              leading: IconButton( onPressed: () {} , icon: const Icon(Icons.arrow_back),  color: Colors.white,),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.menu), color: Colors.white,)
              ],
            ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          width: double.infinity,
          height: 750,
          decoration : const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/backround.jpg"),
              fit: BoxFit.fill,
          )
         ),
         
         child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
             Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                
              ),
              child: const TextField(
                decoration: InputDecoration(
                  contentPadding:
                     EdgeInsets.symmetric(vertical: 10),
                  border: InputBorder.none,
                  hintText: 'Nom complet...',
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child:  Icon(
                      Icons.person, 
                      color: Colors.black, 
                              
                    ),
                  )
                ),
              ),

            ),
              const SizedBox(
              height: 100,
            ),

            Container(
              
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                
              ),
              child: const TextField(
                decoration: InputDecoration(
                  contentPadding:
                     EdgeInsets.symmetric(vertical: 10),
                  border: InputBorder.none,
                  hintText: 'Email...',
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child:  Icon(
                      Icons.email, 
                      color: Colors.white, 
                              
                    ),
                  )
                ),
              ),
            )

         ],
         ),
         ),
      ),
    

      
        
      );
      
   
    
   
  }
}