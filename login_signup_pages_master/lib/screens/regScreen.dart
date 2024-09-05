import 'package:flutter/material.dart';
import 'farmer_register.dart';
import 'consumer_register.dart';
import 'mandi_register.dart';
import 'loginScreen.dart'; // Import the login screen

class RegScreen extends StatefulWidget {
  const RegScreen({Key? key}) : super(key: key);

  @override
  _RegScreenState createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  String selectedRole = 'Farmer'; // Default role

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 23, 184, 44),
                Color(0xff281537),
              ]),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 22),
              child: Text(
                'Create Your\nAccount',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Select Your Role',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffB81736),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      title: const Text('Farmer'),
                      leading: Radio<String>(
                        value: 'Farmer',
                        groupValue: selectedRole,
                        onChanged: (String? value) {
                          setState(() {
                            selectedRole = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Consumer'),
                      leading: Radio<String>(
                        value: 'Consumer',
                        groupValue: selectedRole,
                        onChanged: (String? value) {
                          setState(() {
                            selectedRole = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Mandi'),
                      leading: Radio<String>(
                        value: 'Mandi',
                        groupValue: selectedRole,
                        onChanged: (String? value) {
                          setState(() {
                            selectedRole = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      height: 55,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xff2e7d32), // Green
                            Color(0xff1a237e), // Navy Blue
                          ],
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: () {
                            _navigateToRegistrationPage(context, selectedRole);
                          },
                          child: const Center(
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const loginScreen()),
                        );
                      },
                      child: const Text(
                        'Already have an account? Sign In',
                        style: TextStyle(
                          color: Color.fromARGB(255, 37, 36, 36),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
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

  void _navigateToRegistrationPage(BuildContext context, String role) {
    switch (role) {
      case 'Farmer':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FarmerRegisterPage()),
        );
        break;
      case 'Consumer':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ConsumerRegisterPage()),
        );
        break;
      case 'Mandi':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MandiRegisterPage()),
        );
        break;
    }
  }
}
