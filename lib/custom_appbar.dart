// File: Custom_appbar
// Author: Sconl Peter
// Email: sconl@proton.me
// Description: Code to implement a custom appbar in my flutter projects

import 'package:flutter/material.dart';
import 'package:shape_clipper/s_clipper.dart'; // Import SClipper

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height; // Adjustable height for the AppBar
  final String title; // Text to display in the center
  final List<Widget> leadingWidgets; // List of widgets for the left side
  final List<Widget> trailingWidgets; // List of widgets for the right side
  final CustomClipper<Path>? customClipper; // Custom shape from 'shape_clipper' package
  final double bottomPadding; // Adjustable padding to move the app bar down
  final double topPadding; // Added this line for top padding
  final double rowPadding; // Added this line for row padding

  const CustomAppBar({
    Key? key,
    required this.height,
    this.title = "",
    this.leadingWidgets = const [],
    this.trailingWidgets = const [],
    this.customClipper,
    this.bottomPadding = 0.0,
    this.topPadding = 0.0,
    this.rowPadding = 20, // Initialize rowPadding
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height + bottomPadding); // Adjust total height

  @override
  Widget build(BuildContext context) {
    final clipper = customClipper ?? SClipper();
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(
        top: 0, // Remove top padding to extend into safe area
        left: MediaQuery.of(context).padding.left,
        right: MediaQuery.of(context).padding.right,
      ),
      child: Stack(
        children: [
          ClipPath(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            clipper: clipper,
            child: Container(
              // Extend height to cover safe area:
              height: height + MediaQuery.of(context).padding.top + MediaQuery.of(context).padding.bottom,
              color: Theme.of(context).primaryColor,
              child: Padding(
                // Add top padding here:
                padding: EdgeInsets.only(top: 0.02, left: screenWidth * 0.02, right: screenWidth * 0.02, bottom: screenWidth * 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Padding( // Wrap the Row in a Padding widget
                        padding: EdgeInsets.only(top: rowPadding), // Add top padding to the Row
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Leading widgets
                            Row(
                              children: leadingWidgets.isNotEmpty ? leadingWidgets : [Container()],
                            ),
                            // Centered title
                            Expanded(
                              child: Center(child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19.0))),
                            ),
                            // Trailing widgets
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end, // Align trailing widgets to the right
                              children: trailingWidgets.isNotEmpty ? trailingWidgets : [Container()],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
