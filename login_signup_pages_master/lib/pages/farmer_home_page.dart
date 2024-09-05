import 'package:flutter/material.dart';
import '../services/data_service.dart'; // Update with your actual import path

class FarmerHomePage extends StatefulWidget {
  const FarmerHomePage({Key? key}) : super(key: key);

  @override
  _FarmerHomePageState createState() => _FarmerHomePageState();
}

class _FarmerHomePageState extends State<FarmerHomePage> {
  final DataService _dataService = DataService();
  List<Map<String, dynamic>> _data = [];
  String _selectedState = '';
  String _selectedDistrict = '';
  String _selectedCommodity = '';

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final data = await _dataService.fetchData();
      setState(() {
        _data = data;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e')),
      );
    }
  }

  List<String> _getDistinctValues(String key,
      [String? filterKey, String? filterValue]) {
    if (_data.isEmpty) return [];

    return _data
        .where((item) => filterKey == null || item[filterKey] == filterValue)
        .map((item) => item[key])
        .whereType<String>()
        .toSet()
        .toList();
  }

  List<Map<String, dynamic>> _filterData() {
    return _data.where((item) {
      final stateMatch =
          _selectedState.isEmpty || item['State'] == _selectedState;
      final districtMatch =
          _selectedDistrict.isEmpty || item['District'] == _selectedDistrict;
      final commodityMatch =
          _selectedCommodity.isEmpty || item['Commodity'] == _selectedCommodity;
      return stateMatch && districtMatch && commodityMatch;
    }).toList();
  }

  void _logout() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final filteredData = _filterData();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Farmer Home Page',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green[700],
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchData,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green[700],
              ),
              child: const Text(
                'Farmer Dashboard',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.production_quantity_limits),
              title: const Text('Manage Produce'),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/manage_produce',
                  arguments: {'produceId': '123'},
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.visibility),
              title: const Text('View Existing Produce'),
              onTap: () =>
                  Navigator.pushNamed(context, '/view_existing_produce'),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Ordered Produce'),
              onTap: () => Navigator.pushNamed(context, '/ordered_produce'),
            ),
            ListTile(
              leading: const Icon(Icons.monetization_on),
              title: const Text('View Transactions'),
              onTap: () => Navigator.pushNamed(context, '/view_transactions'),
            ),
            ListTile(
              leading: const Icon(Icons.timer),
              title: const Text('Current Bidding'),
              onTap: () => Navigator.pushNamed(context, '/current_bidding'),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDropdown(
              value: _selectedState,
              hint: 'Select State',
              items: _getDistinctValues('State'),
              onChanged: (value) {
                setState(() {
                  _selectedState = value ?? '';
                  _selectedDistrict = '';
                  _selectedCommodity = '';
                });
              },
            ),
            if (_selectedState.isNotEmpty) ...[
              _buildDropdown(
                value: _selectedDistrict,
                hint: 'Select District',
                items: _getDistinctValues('District', 'State', _selectedState),
                onChanged: (value) {
                  setState(() {
                    _selectedDistrict = value ?? '';
                    _selectedCommodity = '';
                  });
                },
              ),
            ],
            if (_selectedDistrict.isNotEmpty) ...[
              _buildDropdown(
                value: _selectedCommodity,
                hint: 'Select Commodity',
                items: _getDistinctValues(
                    'Commodity', 'District', _selectedDistrict),
                onChanged: (value) {
                  setState(() {
                    _selectedCommodity = value ?? '';
                  });
                },
              ),
            ],
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredData.length,
                itemBuilder: (context, index) {
                  final item = filteredData[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${item['Commodity']} (${item['Variety']})',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[800]),
                          ),
                          const SizedBox(height: 8),
                          _buildAlignedRow('State ', item['State']),
                          _buildAlignedRow('District ', item['District']),
                          _buildAlignedRow('Market ', item['Market']),
                          const SizedBox(height: 10),
                          _buildAlignedRow('Min Price (In Quintal) ',
                              item['Min_x0020_Price']),
                          _buildAlignedRow('Max Price (In Quintal) ',
                              item['Max_x0020_Price']),
                          _buildAlignedRow('Modal Price (In Quintal) ',
                              item['Modal_x0020_Price']),
                          const SizedBox(height: 10),
                          _buildAlignedRow('Variety ', item['Variety']),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black),
        ),
        child: DropdownButton<String>(
          value: value.isEmpty ? null : value,
          hint: Text(hint, style: const TextStyle(color: Colors.black)),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: const TextStyle(color: Colors.black)),
            );
          }).toList(),
          onChanged: onChanged,
          isExpanded: true,
          underline: const SizedBox(),
        ),
      ),
    );
  }

  Widget _buildAlignedRow(String label, dynamic value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            '$label ',
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ),
        Expanded(
          child: Text(
            value.toString(),
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ),
      ],
    );
  }
}
