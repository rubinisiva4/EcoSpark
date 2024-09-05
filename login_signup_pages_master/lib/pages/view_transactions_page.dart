import 'package:flutter/material.dart';

class ViewTransactionsPage extends StatelessWidget {
  const ViewTransactionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> transactionsList = [
      {
        'produceName': 'Tomatoes',
        'consumerName': 'Alice Johnson',
        'transactionAmount': '1000',
        'status': 'Completed',
        'date': '2024-09-01',
      },
      {
        'produceName': 'Cucumbers',
        'consumerName': 'Bob Smith',
        'transactionAmount': '450',
        'status': 'Completed',
        'date': '2024-09-02',
      },
      {
        'produceName': 'Carrots',
        'consumerName': 'Charlie Brown',
        'transactionAmount': '750',
        'status': 'Pending',
        'date': '2024-09-03',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('View Transaction Details'),
        backgroundColor: Colors.green[700],
      ),
      body: ListView.builder(
        itemCount: transactionsList.length,
        itemBuilder: (context, index) {
          final transaction = transactionsList[index];
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
                    'Produce Name: ${transaction['produceName']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Consumer Name: ${transaction['consumerName']}',
                      style: const TextStyle(fontSize: 16)),
                  Text('Transaction Amount: ${transaction['transactionAmount']}',
                      style: const TextStyle(fontSize: 16)),
                  Text('Status: ${transaction['status']}',
                      style: TextStyle(
                        fontSize: 16,
                        color: transaction['status'] == 'Completed' 
                          ? Colors.green
                          : Colors.orange, // Assuming 'Pending' for other statuses
                      )),
                  Text('Date: ${transaction['date']}',
                      style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
