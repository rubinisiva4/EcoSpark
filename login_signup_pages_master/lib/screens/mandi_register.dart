import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MandiRegisterPage extends StatefulWidget {
  const MandiRegisterPage({Key? key}) : super(key: key);

  @override
  _MandiRegisterPageState createState() => _MandiRegisterPageState();
}

class _MandiRegisterPageState extends State<MandiRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _mandiNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _commoditiesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mandi Registration'),
        backgroundColor: const Color(0xff2e7d32),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Register Mandi',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff2e7d32),
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _mandiNameController,
                  labelText: 'Mandi Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the mandi name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _locationController,
                  labelText: 'Location',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the location';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _stateController,
                  labelText: 'State',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the state';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _districtController,
                  labelText: 'District',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the district';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _pincodeController,
                  labelText: 'Pincode',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the pincode';
                    }
                    if (value.length != 6) {
                      return 'Please enter a valid 6-digit pincode';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _emailController,
                  labelText: 'Email ID',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the email ID';
                    }
                    if (!RegExp(
                            r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
                        .hasMatch(value)) {
                      return 'Please enter a valid email ID';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _phoneController,
                  labelText: 'Phone Number',
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the phone number';
                    }
                    if (value.length != 10) {
                      return 'Please enter a valid 10-digit phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _commoditiesController,
                  labelText: 'Commodities Traded',
                  maxLines: 2,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the commodities traded';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                Center(
                  child: Container(
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
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _registerMandi();
                        }
                      },
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      ),
      validator: validator,
    );
  }

  void _registerMandi() async {
    try {
      await FirebaseFirestore.instance.collection('mandis').add({
        'mandi_name': _mandiNameController.text,
        'location': _locationController.text,
        'state': _stateController.text,
        'district': _districtController.text,
        'pincode': _pincodeController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'commodities': _commoditiesController.text,
        'registration_date': Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mandi Registered Successfully!')),
      );

      _clearFields();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to register mandi: $e')),
      );
    }
  }

  void _clearFields() {
    _mandiNameController.clear();
    _locationController.clear();
    _stateController.clear();
    _districtController.clear();
    _pincodeController.clear();
    _emailController.clear();
    _phoneController.clear();
    _commoditiesController.clear();
  }
}
