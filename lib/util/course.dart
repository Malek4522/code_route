import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_route/classes/routeProvider.dart';
import 'package:code_route/util/futureBuilder_translate.dart';
import 'package:code_route/util/options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class course extends StatefulWidget {
    course({
      super.key,
      required this.index,
      required this.title,
      this.description,
      required this.image,      
    });
  int index;
  final String? title;
  final String? description;
  final String image;

  static const String routeName = 'pages/course.dart';

  @override
  State<course> createState() => _courseState();
}

class _courseState extends State<course> {
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
             AppLocalizations.of(context)?.courseTitle ?? 'courses', 
            style:  TextStyle(
              color: Colors.black,
              fontSize: 60,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Color(0xFFFDC80F),
          elevation: 0,
        ),     
        body: Container(
          decoration: BoxDecoration(
            
            image: DecorationImage(
              image: AssetImage("assets/background.jpg"),          
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
            child: ListView(
                                  
              children: [ 
                
                widget.title==null? Container(): Container(
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child:AppLocalizations.of(context)!.localeName=="ar"? Text(
                    widget.title!,
                    style: TextStyle(fontSize: 50),
                  ):
                  FutureBuilder_translate(
                    text: widget.title!,
                    style: TextStyle(fontSize: 50),
                    to: AppLocalizations.of(context)!.localeName,
      
                  )
                  
                ),
                SizedBox(height: 20,),
                Hero(
                  tag: "tag${widget.index+1}", 
                  child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)
                  ),
                  
                  child: CachedNetworkImage(imageUrl: widget.image),
                )
                ),
                SizedBox(height: 20,),
      
                widget.description==null? Container(): Container(
                  
                  margin: EdgeInsets.all(50),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child:AppLocalizations.of(context)!.localeName=="ar"? Text(
                      widget.description!,
                      style: TextStyle(fontSize: 20),
                    ):
                    FutureBuilder_translate(
                      text: widget.description!,
                      style: TextStyle(fontSize: 20),
                      to: AppLocalizations.of(context)!.localeName,
      
                    )
                  ),
                  
                ),
      
                Container(
                  margin: EdgeInsets.fromLTRB(100, 10, 100, 30),
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: GestureDetector(
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          AppLocalizations.of(context)?.doneButton ?? "done",
                          style: TextStyle(fontSize: 50),
                        ),
                      ),
                    ),
                    onTap: () {
                      Provider.of<routeProvider>(context, listen: false).removeroute();
                      Navigator.pop(context);
                    },
                    ),
                
                  ),
                
              ],
            ),
          ),
        ),
        
      ),
    );
  }
}