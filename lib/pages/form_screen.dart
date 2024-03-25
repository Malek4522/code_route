import 'package:flutter/material.dart';


class FormScreen extends StatefulWidget {
   const FormScreen({super.key}) ;

  @override
  State<FormScreen> createState() => _FormScreenState();
} 

class _FormScreenState extends State<FormScreen> {
  String valueChoose = "Condidat";

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
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 3),
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
              height: 70,
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
              ),const SizedBox(
              height: 15,
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
                  hintText: 'E-mail...',
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child:  Icon(
                      Icons.email, 
                      color: Colors.black, 
                              
                    ),
                
                  )
                ),
                
              ),
              
              
            ),
              const SizedBox(
              height: 15,
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
                  hintText: 'Numero de telephone...',
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child:  Icon(
                      Icons.phone, 
                      color: Colors.black, 
                              
                    ),
                  )
                ),
              ),
            ),
            const SizedBox(
              height: 15,
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
                  hintText: 'Mot de passe...',
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    
                   child:  Icon(
                      Icons.lock, 
                      color: Colors.black, 
                      ),
                  
                  ),
                  
                ),
              ),
            ),
            const SizedBox(
              height: 15,
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
                  hintText: 'Confirmer le mot de passe...',
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                     child:  Icon(
                      Icons.lock, 
                      color: Colors.black, 
                              
                   ),
                  )
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                
              ),
              child:  DropdownButton  (
                hint: const Text("Je suis un  "),
                dropdownColor: Colors.white,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 36,
                isExpanded: true,
                underline: const SizedBox(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22
                ),
                value: valueChoose,
                onChanged: (newValue) {
                  setState(() {
                    valueChoose = newValue!;
                  });
                },
                items: const[
                  DropdownMenuItem<String>(
                   value: 'Condidat',
                   child: Text('Condidat'),
                  ),
                  DropdownMenuItem<String>(
                   value: 'Moniteur',
                   child: Text('Moniteur'),
                  ),
                ],
                
               ),

            )
           





         ],
         ),
         ),
         ),
    
    

      
        
      );
      
   
    
   
  }
}
  