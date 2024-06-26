
import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_route/classes/routeProvider.dart';
import 'package:code_route/util/futureBuilder_translate.dart';
import 'package:code_route/util/information.dart';
import 'package:code_route/util/options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class generalknowledge extends StatelessWidget {
  generalknowledge({
    super.key,
    required this.data
  });
  static const String routeName = 'pages/general _knowledges.dart';
  final  data;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if(didPop) return;
        Provider.of<routeProvider>(context, listen: false).removeroute();
        Navigator.of(context).pop();
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        endDrawer: OptionsBar(),
        appBar: AppBar(
          toolbarHeight: 120.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Provider.of<routeProvider>(context, listen: false).removeroute();
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            AppLocalizations.of(context)?.courseTitle ?? "course",
            style: TextStyle(
              color: Colors.black,
              fontSize: 60,
              fontWeight: FontWeight.bold,
            ),
          ),
                 
          backgroundColor:Color(0xFFFDC80F),
          elevation: 0,
        ),    
        
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
              subtitle: Container(
                height: 0,
                width: 0,
                child: CachedNetworkImage(imageUrl: data[index]["url"]),
                
              ),
              leading: Text(
                
                (index+1).toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
              ),
              title:Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white
                ),
                child:AppLocalizations.of(context)!.localeName=="ar"? Text(
                    data[index]["title"],
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ):
                  FutureBuilder_translate(
                    text: data[index]["title"],
                    to: AppLocalizations.of(context)!.localeName,
                    style: TextStyle(
                      fontSize: 20
                    ),
      
                  )
              ),
              
              trailing:Hero(
                tag: "tag${index+1}", 
                child:  Icon(Icons.info),           
              ),
              onTap: () {
                Provider.of<routeProvider>(context, listen: false).addRoute(information.routeName);
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
      ),
    );
  }
}