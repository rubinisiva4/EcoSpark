import 'package:flutter/material.dart';

class ViewExistingProducePage extends StatelessWidget {
  const ViewExistingProducePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> produceList = [
      {
        'name': 'Tomatoes',
        'quantity': '50',
        'unit': 'kg',
        'price': '20',
        'biddingPrice': '1000',
        'biddingStatus': 'Active',
        'variety': 'Cherry',
        'harvestDate': '2024-09-01',
      },
      {
        'name': 'Cucumbers',
        'quantity': '30',
        'unit': 'kg',
        'price': '15',
        'biddingPrice': '450',
        'biddingStatus': 'Finished',
        'variety': 'Slicer',
        'harvestDate': '2024-08-15',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('View Existing Produce'),
        backgroundColor: Colors.green[700],
      ),
      body: ListView.builder(
        itemCount: produceList.length,
        itemBuilder: (context, index) {
          final produce = produceList[index];
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
                    produce['name']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Quantity: ${produce['quantity']} ${produce['unit']}',
                      style: const TextStyle(fontSize: 16)),
                  Text('Price per Unit: ${produce['price']}',
                      style: const TextStyle(fontSize: 16)),
                  Text('Bidding Price: ${produce['biddingPrice']}',
                      style: const TextStyle(fontSize: 16)),
                  Text('Bidding Status: ${produce['biddingStatus']}',
                      style: TextStyle(
                        fontSize: 16,
                        color: produce['biddingStatus'] == 'Active'
                            ? Colors.green
                            : Colors.red,
                      )),
                  Text('Variety: ${produce['variety']}',
                      style: const TextStyle(fontSize: 16)),
                  Text('Harvest Date: ${produce['harvestDate']}',
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
