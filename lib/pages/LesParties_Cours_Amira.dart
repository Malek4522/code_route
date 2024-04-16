import 'package:flutter/material.dart';
import 'package:code_route/util/options.dart';

class PartieCours extends StatefulWidget {
  const PartieCours({super.key});

  @override
  State<PartieCours> createState() => _PartieCoursState();
}

class _PartieCoursState extends State<PartieCours> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: OptionsBar(),
      appBar: AppBar(
        toolbarHeight: 80.0,
        backgroundColor: Colors.orange,
        title: const SizedBox(
          height: 30.0,
          child: Text('COURS '),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: Stack(
        // Use Stack for layering
        children: [
          // Background image container
          Container(
            padding: const EdgeInsets.all(120.0),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/backround.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    minimumSize: const Size(300.0, 75.0),
                  ),
                  child: const Text(
                    'Les plaques',
                    style: TextStyle(color: Colors.black, fontSize: 18.0),
                  ),
                ),
                const SizedBox(height: 45.0),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    minimumSize: const Size(300.0, 75.0),
                  ),
                  child: const Text(
                    'Généralités ',
                    style: TextStyle(color: Colors.black, fontSize: 18.0),
                  ),
                ),
                const SizedBox(height: 45.0),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    minimumSize: const Size(300.0, 75.0),
                  ),
                  child: const Text(
                    'Propriétés',
                    style: TextStyle(color: Colors.black, fontSize: 18.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
