import 'package:flutter/material.dart';
import 'product_management.dart';

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
        backgroundColor: Colors.green[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${widget.product.product1}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Text(
              'Farmer: ${widget.product.name}',
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
            const SizedBox(height: 10),
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
