import 'package:flutter/material.dart';
import 'regScreen.dart';
import 'loginScreen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image with transparency
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/farmer_logo.jpg'), // Farmer logo as background
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black45, // Adds a transparency layer
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          // Foreground content
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0x002e7d32), // Transparent color on top
                  Color(0xcc66bb6a), // Semi-transparent color on bottom
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 150.0),
                  child: Image(
                    image: AssetImage('assets/ecospark_logo.png'),  // Replace with ecospark logo
                    height: 150,  // Adjust the image size as needed
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                const Text(
                  'Harvest Hub',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const loginScreen()),
                    );
                  },
                  child: Container(
                    height: 53,
                    width: 320,
                    decoration: BoxDecoration(
                      color: const Color(0xff388e3c),  // Darker green for button background
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white),
                    ),
                    child: const Center(
                      child: Text(
                        'SIGN IN',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegScreen()),
                    );
                  },
                  child: Container(
                    height: 53,
                    width: 320,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white),
                    ),
                    child: const Center(
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff388e3c),  // Darker green for text color
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                const Text(
                  'Connecting Farmers to Markets',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
