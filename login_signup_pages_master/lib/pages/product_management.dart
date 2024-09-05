import 'package:flutter/material.dart';

class Product {
  String name;
  String product1;
  String quantity;
  String quality;

  Product({
    required this.name,
    required this.product1,
    required this.quantity,
    required this.quality,
  });
}

class ProductManagementPage extends StatefulWidget {
  const ProductManagementPage({super.key});

  @override
  _ProductManagementPageState createState() => _ProductManagementPageState();
}

class _ProductManagementPageState extends State<ProductManagementPage> {
  final List<Product> _products = [
    Product(
        name: 'Ashok', product1: 'Wheat', quantity: '100kg', quality: 'Good'),
    Product(
        name: 'Karthick',
        product1: 'Rice',
        quantity: '200kg',
        quality: 'Excellent'),
    Product(
        name: 'Tharun',
        product1: 'Barley',
        quantity: '150kg',
        quality: 'Average'),
  ];

  final List<Product> _filteredProducts = []; // List to hold search results
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredProducts
        .addAll(_products); // Initially, all products are displayed
  }

  void _filterProducts(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredProducts.clear();
        _filteredProducts.addAll(_products); // Reset to original list
      });
    } else {
      setState(() {
        _filteredProducts.clear();
        _filteredProducts.addAll(
          _products.where((product) =>
              product.product1.toLowerCase().contains(query.toLowerCase())),
        );
      });
    }
  }

  Future<void> _navigateToProductDetails(Product product) async {
    final updatedProduct = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailPage(product: product),
      ),
    );

    if (updatedProduct != null && updatedProduct is Product) {
      setState(() {
        // Find and update the product in the list
        final index =
            _products.indexWhere((p) => p.name == updatedProduct.product1);
        if (index != -1) {
          _products[index] = updatedProduct;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Farmer Produce'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar for filtering products
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search Products',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _filterProducts, // Call this when the user types
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _filteredProducts.isEmpty
                  ? const Center(child: Text('No products found'))
                  : ListView.builder(
                      itemCount: _filteredProducts.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            title: Text(_filteredProducts[index].product1),
                            subtitle: Text(
                              'Farmer: ${_filteredProducts[index].name}\n'
                              'Quantity: ${_filteredProducts[index].quantity}\n'
                              'Quality: ${_filteredProducts[index].quality}',
                            ),
                            onTap: () => _navigateToProductDetails(
                                _filteredProducts[index]),
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
}

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late TextEditingController _qualityController;

  @override
  void initState() {
    super.initState();
    _qualityController = TextEditingController(text: widget.product.quality);
  }

  @override
  void dispose() {
    _qualityController.dispose();
    super.dispose();
  }

  void _updateQuality() {
    final String updatedQuality = _qualityController.text;

    if (updatedQuality.isNotEmpty) {
      widget.product.quality = updatedQuality;
      Navigator.pop(context, widget.product); // Pass updated product back
    } else {
      _showErrorDialog('Quality cannot be empty.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product: ${widget.product.product1}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Text(
              'Name: ${widget.product.name}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Text(
              'Quantity: ${widget.product.quantity}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Text(
              'Quality:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TextField(
              controller: _qualityController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateQuality,
              child: const Text('Update Quality'),
            ),
          ],
        ),
      ),
    );
  }
}
