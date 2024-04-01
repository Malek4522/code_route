import 'package:code_route/classes/myuser.dart';
import 'package:code_route/pages/courses.dart';
import 'package:code_route/pages/emailVirification.dart';
import 'package:code_route/pages/login.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class wraper extends StatelessWidget {
  wraper({super.key});
  

  @override
  Widget build(BuildContext context) {
    final  User = Provider.of<myUser?>(context);
    if(User == null){ 
      return login();
    }
    else{
      return courses();
      
    }
  }
}