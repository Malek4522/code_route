import 'package:code_route/util/options.dart';
import 'package:flutter/material.dart';

class CheckMoniteur extends StatelessWidget {
  const CheckMoniteur({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const ListTileExample(),
    );
  }
}

class ListTileExample extends StatelessWidget {
  const ListTileExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: OptionsBar(),
      appBar: AppBar(
        title: Text(
          '???????',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 38,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 233, 169, 51),
        elevation: 0,
      ),
      body: ListView(
        children: const <Widget>[
          Card(
              child: ListTile(
            leading: Icon(Icons.check),
            //Icon(Icons.close),//refused
            // Icon(Icons.refresh),//waiting
            title: Text('One-line ListTile'),
            trailing: ElevatedButton(
              onPressed: null,
              child: Text('preview'),
            ),
          )),
          Card(
            child: ListTile(
              leading: Icon(Icons.check),
              //Icon(Icons.close),//refused
              // Icon(Icons.refresh),//waiting
              title: Text('One-line with leading widget'),
              trailing: ElevatedButton(
                onPressed: null,
                child: Text('preview'),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.check),
              //Icon(Icons.close),//refused
              // Icon(Icons.refresh),//waiting
              title: Text('One-line with trailing widget'),
              trailing: ElevatedButton(
                onPressed: null,
                child: Text('preview'),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.check),
              //Icon(Icons.close),//refused
              // Icon(Icons.refresh),//waiting
              title: Text('One-line with both widgets'),
              trailing: ElevatedButton(
                onPressed: null,
                child: Text('preview'),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.check),
              //Icon(Icons.close),//refused
              // Icon(Icons.refresh),//waiting
              title: Text('One-line dense ListTile'),
              trailing: ElevatedButton(
                onPressed: null,
                child: Text('preview'),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.check),
              //Icon(Icons.close),//refused
              // Icon(Icons.refresh),//waiting
              title: Text('Two-line ListTile'),
              trailing: ElevatedButton(
                onPressed: null,
                child: Text('preview'),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.check),
              //Icon(Icons.close),//refused
              // Icon(Icons.refresh),//waiting
              title: Text('Three-line ListTile'),
              trailing: ElevatedButton(
                onPressed: null,
                child: Text('preview'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
