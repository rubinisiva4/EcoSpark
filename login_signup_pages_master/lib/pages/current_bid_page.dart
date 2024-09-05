import 'package:flutter/material.dart';
import 'state_manager.dart'; // Import the state manager

class CurrentBiddingPage extends StatelessWidget {
  const CurrentBiddingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bids = StateManager().bids; // Get bids from StateManager

    return Scaffold(
      appBar: AppBar(
        title: const Text('Current Bidding'),
        backgroundColor: Colors.green[800],
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Search functionality can be added here
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: bids.length,
          itemBuilder: (context, index) {
            final bid = bids[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green[50]!, Colors.white],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Icon(
                      Icons.local_offer,
                      color: Colors.green[700],
                      size: 40,
                    ),
                    title: Text(
                      bid['produceName'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quantity: ${bid['quantity']} ${bid['unit']}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Price per Unit: \$${bid['pricePerUnit']}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Bidding Amount: \$${bid['biddingAmount']}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Variety: ${bid['variety']}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Harvest Date: ${bid['harvestDate']}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
