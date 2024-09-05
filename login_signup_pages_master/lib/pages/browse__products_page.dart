import 'package:flutter/material.dart';

class BrowseProductsPage extends StatelessWidget {
  const BrowseProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample list of products
    final List<Map<String, dynamic>> products = [
      {'name': 'Apple', 'price': 1.99, 'image': 'assets/apple.png'},
      {'name': 'Banana', 'price': 0.99, 'image': 'assets/banana.png'},
      {'name': 'Orange', 'price': 1.49, 'image': 'assets/orange.png'},
      // Add more products as needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Browse Products'),
        backgroundColor: Colors.green[700], // Same theme as ConsumerHomePage
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: ListTile(
              leading: Image.asset(
                product['image'],
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(product['name']),
              subtitle: Text('\$${product['price'].toStringAsFixed(2)}'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to product detail page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailPage(product: product),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// Sample ProductDetailPage for detailed product view
class ProductDetailPage extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['name']),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(product['image'], height: 200, fit: BoxFit.cover),
            const SizedBox(height: 20),
            Text(
              product['name'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              '\$${product['price'].toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 20),
            Text(
              'Product description goes here.',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
