import 'package:flutter/material.dart';

class OrderedProducePage extends StatelessWidget {
  const OrderedProducePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> ordersList = [
      {
        'produceName': 'Tomatoes',
        'pricePerUnit': '20',
        'consumerName': 'Alice Johnson',
        'biddedPrice': '1000',
        'orderStatus': 'Completed',
      },
      {
        'produceName': 'Cucumbers',
        'pricePerUnit': '15',
        'consumerName': 'Bob Smith',
        'biddedPrice': '450',
        'orderStatus': 'Completed',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ordered Produce'),
        backgroundColor: Colors.green[700],
      ),
      body: ListView.builder(
        itemCount: ordersList.length,
        itemBuilder: (context, index) {
          final order = ordersList[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Produce Name: ${order['produceName']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Price per Unit: ${order['pricePerUnit']}',
                      style: const TextStyle(fontSize: 16)),
                  Text('Consumer Name: ${order['consumerName']}',
                      style: const TextStyle(fontSize: 16)),
                  Text('Bidded Price: ${order['biddedPrice']}',
                      style: const TextStyle(fontSize: 16)),
                  Text('Order Status: ${order['orderStatus']}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green, // Assuming all orders are completed
                      )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
