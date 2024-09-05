import 'package:flutter/material.dart';
import 'state_manager.dart'; // Import the state manager
import 'current_bid_page.dart';

class ManageProducePage extends StatefulWidget {
  const ManageProducePage({Key? key}) : super(key: key);

  @override
  _ManageProducePageState createState() => _ManageProducePageState();
}

class _ManageProducePageState extends State<ManageProducePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _produceNameController = TextEditingController();
  final TextEditingController _quantityValueController =
      TextEditingController();
  String _selectedUnit = 'kg';
  final TextEditingController _pricePerUnitController = TextEditingController();
  final TextEditingController _varietyController = TextEditingController();
  final TextEditingController _harvestDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Produce',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(
                  controller: _produceNameController,
                  labelText: 'Produce Name',
                  hintText: 'Enter the produce name',
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter the produce name'
                      : null,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _quantityValueController,
                        labelText: 'Quantity',
                        hintText: 'Enter quantity',
                        keyboardType: TextInputType.number,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter quantity'
                            : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedUnit,
                        items: ['kg', 'quintal'].map((unit) {
                          return DropdownMenuItem<String>(
                            value: unit,
                            child: Text(unit,
                                style: const TextStyle(color: Colors.black)),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Unit',
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: const OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _selectedUnit = value!;
                          });
                        },
                        validator: (value) =>
                            value == null ? 'Please select a unit' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _pricePerUnitController,
                  labelText: 'Price per Unit',
                  hintText: 'Enter price per kg/quintal',
                  keyboardType: TextInputType.number,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter price per unit'
                      : null,
                ),
                const SizedBox(height: 16),
                Text(
                  'Bidding Price: ${_getBiddingPrice()}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _varietyController,
                  labelText: 'Variety',
                  hintText: 'Enter variety of produce',
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => _selectHarvestDate(context),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Harvest Date',
                      hintText: 'Select harvest date',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: const OutlineInputBorder(),
                    ),
                    child: Text(
                      _harvestDateController.text.isEmpty
                          ? 'Select harvest date'
                          : _harvestDateController.text,
                      style: TextStyle(
                          color: _harvestDateController.text.isEmpty
                              ? Colors.grey
                              : Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Container(
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
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _saveProduce();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          alignment: Alignment.center,
                          child: const Text(
                            'Add Produce',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
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

  String _getBiddingPrice() {
    double price = double.tryParse(_pricePerUnitController.text) ?? 0.0;
    double quantity = double.tryParse(_quantityValueController.text) ?? 0.0;
    if (_selectedUnit == 'quintal') {
      quantity *= 100;
    }
    return (price * quantity).toStringAsFixed(2);
  }

  void _saveProduce() {
    // Save produce details using StateManager
    StateManager().addBid({
      'produceName': _produceNameController.text,
      'quantity': _quantityValueController.text,
      'unit': _selectedUnit,
      'pricePerUnit': _pricePerUnitController.text,
      'biddingAmount': _getBiddingPrice(),
      'variety': _varietyController.text,
      'harvestDate': _harvestDateController.text,
    });

    // Clear the form data
    _produceNameController.clear();
    _quantityValueController.clear();
    _pricePerUnitController.clear();
    _varietyController.clear();
    _harvestDateController.clear();
    setState(() {
      _selectedUnit = 'kg';
    });

    // Show a Snackbar with a success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Produce details added successfully!'),
        backgroundColor: Colors.green[700],
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _selectHarvestDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        _harvestDateController.text = selectedDate
            .toLocal()
            .toString()
            .split(' ')[0]; // Format as YYYY-MM-DD
      });
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    FormFieldValidator<String>? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[200],
        border: const OutlineInputBorder(),
      ),
      validator: validator,
      onChanged: (value) {
        setState(() {});
      },
    );
  }
}
