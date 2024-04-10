import 'package:code_route/classes/auth.dart';
import 'package:code_route/classes/myuser.dart';
import 'package:code_route/classes/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OptionsBar extends StatefulWidget {
  const OptionsBar({super.key});
  @override
  State<OptionsBar> createState() => OptionsBarState();
}

class OptionsBarState extends State<OptionsBar> {
  final _auth =authservice();
  
  @override
  Widget build(BuildContext context) {
     myUser? user = Provider.of<user_provider>(context).getuser;
    return Drawer(
      backgroundColor: Color.fromARGB(255, 233, 169, 51),
      child: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white24,
              child: Icon(
                CupertinoIcons.person,
                color: Colors.white,
              ),
            ),
            title: Text(user!.name,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                )),
            subtitle: Text(user!.email,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                )),
          ),
          SizedBox(
            height: 60,
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('COURS'),
            onTap: () {},
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(Icons.question_mark),
            title: Text('QUIZ'),
            onTap: () {},
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('PARAMETRE'),
            onTap: () {},
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(Icons.lightbulb),
            title: Text('ABOUT'),
            onTap: () {},
          ),
          SizedBox(
            height: 40,
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('DECONNECCTER'),
            onTap: () async{
              await _auth.signOut();
            },
          ),
        ],
      ),
    );
  }
}
