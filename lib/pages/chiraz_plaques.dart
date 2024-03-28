import 'package:code_route/util/options.dart';
import 'package:flutter/material.dart';

class CPlaques extends StatefulWidget {
  const CPlaques({super.key});

  @override
  State<CPlaques> createState() => _CPlaquesState();
}

class _CPlaquesState extends State<CPlaques> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        endDrawer: OptionsBar(),
        appBar: AppBar(
          backgroundColor: Colors.orange[700],
          title: const Text(
            "Plaques",
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
              color: Colors.white,
            ),
          ],
        ),
        body: Stack(
          children: [
            // Image de fond
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 3),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/backbleu.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
            ),

            // Bouton
            Positioned(
              left: 380.0, // Décalage à gauche
              top: 50.0, // Décalage en haut
              // Décalage en bas
              child: Material(
                color: Colors.white,
                elevation: 8,
                borderRadius: BorderRadius.circular(28),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Ink.image(
                        image: const AssetImage("images/Danger.jpg"),
                        height: 200,
                        width: 230,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 1),
                      const Text(
                        "Signaux de danger",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 7),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              right: 380.0, // Décalage à gauche
              top: 50.0, // Décalage en haut
              // Décalage en bas
              child: Material(
                color: Colors.white,
                elevation: 8,
                borderRadius: BorderRadius.circular(28),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Ink.image(
                        image: const AssetImage("images/interdit.jpg"),
                        height: 200,
                        width: 230,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 1),
                      const Text(
                        "Signaux d'interdiction",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 7),
                    ],
                  ),
                ),
              ),
            ),
            //intersections
            Positioned(
              right: 380.0, // Décalage à gauche
              top: 300.0, // Décalage en haut

              // Décalage en bas
              child: Material(
                color: Colors.white,
                elevation: 8,
                borderRadius: BorderRadius.circular(28),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Ink.image(
                        image: const AssetImage("images/indi.jpg"),
                        height: 200,
                        width: 230,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 1),
                      const Text(
                        "Signaux d'indication",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ),
            // indications
            Positioned(
              left: 380.0, // Décalage à gauche
              top: 300.0, // Décalage en haut

              // Décalage en bas
              child: Material(
                color: Colors.white,
                elevation: 8,
                borderRadius: BorderRadius.circular(28),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Ink.image(
                        image: const AssetImage("images/prio.jpg"),
                        height: 200,
                        width: 230,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 1),
                      const Text(
                        "Signaux d'intersection",
                        style: TextStyle(
                          fontSize: 19,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
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
