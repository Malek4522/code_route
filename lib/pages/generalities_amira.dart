import 'package:flutter/material.dart';

class CenteredRectClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Calculate the center of the container
    final centerX = size.width / 2;
    final centerY = size.height / 2 - size.height * 0.05;

    // Define the width and height of the small rectangle
    final rectWidth = size.width * 1; // Adjust for desired width
    final rectHeight = size.height * 0.9; // Adjust for desired height

    // Calculate the top-left corner coordinates of the rectangle
    final topLeftX = centerX - rectWidth / 2;
    final topLeftY = centerY - rectHeight / 2;

    // Add the rectangle to the path
    path.addRect(Rect.fromLTWH(topLeftX, topLeftY, rectWidth, rectHeight));

    return path;
  }

  @override
  bool shouldReclip(CenteredRectClipper oldClipper) => false;
}

class Generalities extends StatefulWidget {
  final Function()? onTap;
  final bool isChecked; // Add a property for check state

  const Generalities({super.key, required this.onTap, required this.isChecked});

  @override
  State<Generalities> createState() => _GeneralitiesState();
}

class _GeneralitiesState extends State<Generalities> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CenteredRectClipper(), // Use the custom clipper
      child: Stack(
        // Use Stack for positioning
        children: [
          GestureDetector(
            onTap: widget.onTap,
            child: Container(
              height: 65,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  "GÉNÉRALITÉS",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 10.0, // Adjust horizontal offset from left edge
            top: 10.0, // Adjust vertical offset from top
            child: CheckSquare(
              // Use a separate widget for check square
              isChecked: widget.isChecked, // Pass check state
            ),
          ),
        ],
      ),
    );
  }
}

class CheckSquare extends StatelessWidget {
  final bool isChecked;
  final Color checkColor;
  final Color squareColor;

  const CheckSquare({
    super.key,
    this.isChecked = true,
    this.checkColor = Colors.white,
    this.squareColor = Colors.green,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.0,
      width: 20.0,
      decoration: BoxDecoration(
        color: squareColor,
        shape: BoxShape.circle,
      ),
      child: isChecked
          ? Icon(
              Icons.check,
              size: 15.0,
              color: checkColor,
            )
          : null,
    );
  }
}
