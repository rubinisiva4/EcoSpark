import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConsumerRegisterPage extends StatefulWidget {
  const ConsumerRegisterPage({Key? key}) : super(key: key);

  @override
  _ConsumerRegisterPageState createState() => _ConsumerRegisterPageState();
}

class _ConsumerRegisterPageState extends State<ConsumerRegisterPage> {
  String? _selectedGender;
  bool _otpSent = false;
  bool _otpVerified = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consumer Registration'),
        backgroundColor: const Color(0xff2e7d32),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Register as a Consumer',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff2e7d32),
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  'Full Name',
                  _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildGenderField(),
                const SizedBox(height: 16),
                _buildPhoneField(),
                const SizedBox(height: 16),
                if (_otpSent) _buildOTPField(),
                const SizedBox(height: 16),
                _buildTextField(
                  'Address',
                  _addressController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  'State',
                  _stateController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your state';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  'District',
                  _districtController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your district';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Container(
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xff2e7d32),
                        Color(0xff1a237e),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: InkWell(
                    onTap: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        if (_otpVerified) {
                          await _registerConsumer();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please verify your OTP first!')),
                          );
                        }
                      }
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: const Center(
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
      validator: validator,
    );
  }

  Widget _buildGenderField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gender',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xff2e7d32),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ListTile(
                title: const Text('Male'),
                leading: Radio<String>(
                  value: 'Male',
                  groupValue: _selectedGender,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: const Text('Female'),
                leading: Radio<String>(
                  value: 'Female',
                  groupValue: _selectedGender,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPhoneField() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              if (value.length != 10) {
                return 'Please enter a valid 10-digit phone number';
              }
              return null;
            },
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              setState(() {
                _otpSent = true;
              });
              // Simulate sending OTP
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('OTP Sent to ${_phoneController.text}')),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 164, 243, 168),
          ),
          child: const Text('Send OTP'),
        ),
      ],
    );
  }

  Widget _buildOTPField() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _otpController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Enter OTP',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the OTP';
              }
              return null;
            },
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            // Simulate OTP verification
            if (_otpController.text == '1234') { // Dummy OTP for simulation
              setState(() {
                _otpVerified = true;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('OTP Verified!')),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Invalid OTP!')),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 162, 239, 166),
          ),
          child: const Text('Verify OTP'),
        ),
      ],
    );
  }

  Future<void> _registerConsumer() async {
    try {
      await FirebaseFirestore.instance.collection('consumers').add({
        'name': _nameController.text,
        'phone': _phoneController.text,
        'address': _addressController.text,
        'state': _stateController.text,
        'district': _districtController.text,
        'gender': _selectedGender,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful!')),
      );

      // Clear the form
      _nameController.clear();
      _phoneController.clear();
      _otpController.clear();
      _addressController.clear();
      _stateController.clear();
      _districtController.clear();
      setState(() {
        _selectedGender = null;
        _otpSent = false;
        _otpVerified = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error registering consumer: $e')),
      );
    }
  }
}
