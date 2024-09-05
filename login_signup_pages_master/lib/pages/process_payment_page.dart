import 'package:flutter/material.dart';
import '../model/produce.dart'; // Adjust the import based on your project structure

class ProcessPaymentPage extends StatelessWidget {
  final Produce? produce; // Make sure to pass Produce object if needed

  ProcessPaymentPage({this.produce});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Process Payment'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Payment Details',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              if (produce != null) 
                Text(
                  'You are about to purchase ${produce!.name} for \$${produce!.currentBid.toStringAsFixed(2)}.',
                  style: TextStyle(fontSize: 18),
                ),
              SizedBox(height: 20),
              Text(
                'Please enter your payment details below:',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              // Example of a payment form (you might want to customize this)
              TextField(
                decoration: InputDecoration(
                  labelText: 'Card Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Expiry Date',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.datetime,
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'CVV',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle payment processing here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Payment processed successfully!'),
                    ),
                  );
                  // Navigate back or to another page
                  Navigator.pop(context);
                },
                child: Text('Submit Payment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
