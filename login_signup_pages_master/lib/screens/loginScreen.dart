import 'package:flutter/material.dart';
import '../pages/farmer_home_page.dart';
import '../pages/consumer_home_page.dart';
import '../pages/mandi_home_page.dart';
import 'regScreen.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  String _selectedRole = 'Farmer'; // Default selection
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff2e7d32), // Green
                  Color(0xff1a237e), // Navy Blue
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 22),
              child: Text(
                'Hello\nSign in!',
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
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: const Text('Farmer'),
                            leading: Radio<String>(
                              value: 'Farmer',
                              groupValue: _selectedRole,
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedRole = value!;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('Consumer'),
                            leading: Radio<String>(
                              value: 'Consumer',
                              groupValue: _selectedRole,
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedRole = value!;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('Mandi'),
                            leading: Radio<String>(
                              value: 'Mandi',
                              groupValue: _selectedRole,
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedRole = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Phone number input field
                      TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(
                            Icons.phone,
                            color: Colors.grey,
                          ),
                          label: Text(
                            'Phone Number',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff2e7d32), // Green
                            ),
                          ),
                        ),
                      ),
                      TextField(
                        controller: _otpController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                          label: Text(
                            'OTP',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff2e7d32), // Green
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: _signIn,
                        child: Container(
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
                          child: const Center(
                            child: Text(
                              'SIGN IN',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 100),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RegScreen()), // Navigate to RegScreen
                            );
                          },
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                "Sign up",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.black,
                                ),
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
          ),
        ],
      ),
    );
  }

  void _signIn() {
    final String phoneNumber = _phoneController.text;
    final String otp = _otpController.text;

    if (phoneNumber.isEmpty || otp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both phone number and OTP')),
      );
      return;
    }

    // Define sample phone numbers and OTPs
    const Map<String, String> validCredentials = {
      '1234567890': '1234', // Farmer
      '0987654321': '1234', // Consumer
      '0123456789': '1234', // Mandi
    };

    if (validCredentials[phoneNumber] == otp) {
      _navigateBasedOnRole(_selectedRole);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid phone number or OTP')),
      );
    }
  }

  void _navigateBasedOnRole(String role) {
    switch (role) {
      case 'Consumer':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ConsumerHomePage()),
        );
        break;
      case 'Mandi':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MandiHomePage()),
        );
        break;
      case 'Farmer':
      default:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const FarmerHomePage()),
        );
        break;
    }
  }
}
