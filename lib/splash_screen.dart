import 'package:flutter/material.dart';

import 'device_registration.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;  // Use 'late' keyword

  @override
  void initState() {
    super.initState();
    DeviceRegistration deviceRegistration = DeviceRegistration();
    deviceRegistration.registerDevice();

    // Initialize AnimationController
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3), // Duration of the animation (3 seconds)
    );

    // Start the animation
    _animationController.forward();

    // Navigate to login screen after the animation completes
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  void dispose() {
    // Dispose of the AnimationController when the widget is disposed
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/splscr.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Sliding dot at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0), // Adjust this value to move it further up or down
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Container(
                    width: 200, // Width of the slider
                    height: 4,  // Height of the slider
                    child: Stack(
                      children: [
                        // Base line for the slider
                        Container(
                          width: 200,
                          height: 4,
                          color: Colors.grey[300], // Grey base line
                        ),
                        // Moving dot or bar
                        Positioned(
                          left: _animationController.value * 150, // Move along the slider
                          child: Container(
                            width: 20, // Size of the sliding dot
                            height: 4,
                            color: Colors.red, // Color of the dot
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
