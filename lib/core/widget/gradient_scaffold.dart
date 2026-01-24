import 'package:flutter/material.dart';

class GradientScaffold extends StatelessWidget {
  final Widget child;

  const GradientScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.red.shade900,
              // Colors.red.shade700,
              // Colors.red.shade500,
              // Colors.red.shade400,
              Colors.black,
            ],
            // begin: Alignment.topCenter,
            // end: Alignment.bottomCenter,
          ),
        ),
        child: child,
      ),
    );
  }
}
