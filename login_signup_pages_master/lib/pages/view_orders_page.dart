import 'package:flutter/material.dart';

class ViewOrdersPage extends StatelessWidget {
  const ViewOrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Orders'),
        backgroundColor: const Color(0xff2e7d32), // Green
      ),
      body: ListView(
        children: [
          OrderTile(
            orderId: '001',
            productName: 'Tomato',
            quantity: 10,
            totalPrice: 200,
            orderDate: '6.9.24',
          ),
          SizedBox(height: 20),
          OrderTile(
            orderId: '002',
            productName: 'Potato',
            quantity: 5,
            totalPrice: 75,
            orderDate: '5.9.24',
          ),
          // Add more OrderTile widgets as needed
        ],
      ),
    );
  }
}

class OrderTile extends StatelessWidget {
  final String orderId;
  final String productName;
  final int quantity;
  final int totalPrice;
  final String orderDate;

  const OrderTile({
    required this.orderId,
    required this.productName,
    required this.quantity,
    required this.totalPrice,
    required this.orderDate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order ID: $orderId', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('Product: $productName'),
            Text('Quantity: $quantity'),
            Text('Total Price: \$${totalPrice}'),
            Text('Order Date: $orderDate'),
          ],
        ),
      ),
    );
  }
}
