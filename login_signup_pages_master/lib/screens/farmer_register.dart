import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FarmerRegisterPage extends StatefulWidget {
  const FarmerRegisterPage({Key? key}) : super(key: key);

  @override
  _FarmerRegisterPageState createState() => _FarmerRegisterPageState();
}

class _FarmerRegisterPageState extends State<FarmerRegisterPage> {
  String? _selectedGender;
  String? _aadhaarProofFilePath;
  bool _otpSent = false; // Track whether OTP has been sent
  bool _otpVerified = false; // Track whether OTP has been verified
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _villageController = TextEditingController();
  final TextEditingController _bankAccountController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _ifscCodeController = TextEditingController();
  final TextEditingController _accountHolderNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farmer Registration'),
        backgroundColor: const Color(0xff2e7d32), // Green color for AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Register as a Farmer',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff2e7d32), // Green color for title
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField('Full Name', _nameController),
              const SizedBox(height: 16),
              _buildPhoneField(),
              const SizedBox(height: 16),
              if (_otpSent) _buildOTPField(),
              const SizedBox(height: 16),
              _buildTextField('Address', _addressController),
              const SizedBox(height: 16),
              _buildTextField('Pincode', _pincodeController),
              const SizedBox(height: 16),
              _buildTextField('State', _stateController),
              const SizedBox(height: 16),
              _buildTextField('District', _districtController),
              const SizedBox(height: 16),
              _buildTextField('Village', _villageController),
              const SizedBox(height: 16),
              _buildTextField('Bank Account Number', _bankAccountController),
              const SizedBox(height: 16),
              _buildTextField('Bank Name', _bankNameController),
              const SizedBox(height: 16),
              _buildTextField('IFSC Code', _ifscCodeController),
              const SizedBox(height: 16),
              _buildTextField('Account Holder Name', _accountHolderNameController),
              const SizedBox(height: 16),
              _buildAadhaarField(),
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
              Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff2e7d32), // Green
                      Color(0xff1a237e), // Navy Blue
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: InkWell(
                  onTap: _registerFarmer,
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
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
    );
  }

  Widget _buildPhoneField() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _otpSent = true;
            });
            // Simulate sending OTP
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('OTP Sent to ${_phoneController.text}')),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                const Color.fromARGB(255, 174, 241, 177), // Green color
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
          child: TextField(
            controller: _otpController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Enter OTP',
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            // Simulate OTP verification
            if (_otpController.text == '1234') {
              // Dummy OTP for simulation
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
            backgroundColor:
                const Color.fromARGB(255, 167, 242, 171), // Green color
          ),
          child: const Text('Verify OTP'),
        ),
      ],
    );
  }

  Widget _buildAadhaarField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Aadhaar Proof PDF',
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
              child: Text(
                _aadhaarProofFilePath ?? 'No file selected',
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: _pickAadhaarProof,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color.fromARGB(255, 167, 242, 171), // Green color
              ),
              child: const Text('Upload'),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _pickAadhaarProof() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _aadhaarProofFilePath = result.files.single.path;
      });
    }
  }

  Future<void> _registerFarmer() async {
    if (_nameController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _addressController.text.isEmpty ||
        _pincodeController.text.isEmpty ||
        _stateController.text.isEmpty ||
        _districtController.text.isEmpty ||
        _villageController.text.isEmpty ||
        _bankAccountController.text.isEmpty ||
        _bankNameController.text.isEmpty ||
        _ifscCodeController.text.isEmpty ||
        _accountHolderNameController.text.isEmpty ||
        _selectedGender == null ||
        !_otpVerified ||
        _aadhaarProofFilePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields and verify OTP!')),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('farmers').add({
        'name': _nameController.text,
        'phone': _phoneController.text,
        'address': _addressController.text,
        'pincode': _pincodeController.text,
        'state': _stateController.text,
        'district': _districtController.text,
        'village': _villageController.text,
        'bank_account': _bankAccountController.text,
        'bank_name': _bankNameController.text,
        'ifsc_code': _ifscCodeController.text,
        'account_holder_name': _accountHolderNameController.text,
        'gender': _selectedGender,
        'aadhaar_proof': _aadhaarProofFilePath,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Farmer Registered Successfully!')),
      );

      // Clear input fields
      _nameController.clear();
      _phoneController.clear();
      _addressController.clear();
      _pincodeController.clear();
      _stateController.clear();
      _districtController.clear();
      _villageController.clear();
      _bankAccountController.clear();
      _bankNameController.clear();
      _ifscCodeController.clear();
      _accountHolderNameController.clear();
      _selectedGender = null;
      _otpController.clear();
      setState(() {
        _otpSent = false;
        _otpVerified = false;
        _aadhaarProofFilePath = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}
