import 'package:flutter/material.dart';
import '../models/produce.dart';

class PaymentScreen extends StatefulWidget {
  final Produce produce;

  PaymentScreen({required this.produce});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController bidController = TextEditingController();
  bool isValidBid = false;

  void _checkBid() {
    final input = bidController.text;
    if (input.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a bid amount.'),
        ),
      );
      return;
    }

    double? newBid = double.tryParse(input);
    if (newBid != null && newBid == widget.produce.currentBid) {
      setState(() {
        isValidBid = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter the exact bid amount as before.'),
        ),
      );
    }
  }

  void _confirmPayment() {
    // Payment confirmation logic goes here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payment of ₹${widget.produce.currentBid} confirmed!'),
      ),
    );
    Navigator.pop(context); // Navigate back to previous screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Portal'),
        backgroundColor: const Color(0xFF4CAF50), // Darker green
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Confirm Your Bid',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'You have bid: ₹${widget.produce.currentBid}',
              style: TextStyle(
                fontSize: 20,
                color: Colors.brown[600],
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: bidController,
              decoration: InputDecoration(
                labelText: 'Re-enter your bid',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _checkBid();
              },
              child: Text('Check Bid'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF81C784), // Medium green
              ),
            ),
            SizedBox(height: 20),
            isValidBid
                ? ElevatedButton(
                    onPressed: _confirmPayment,
                    child: Text('Confirm Payment'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50), // Darker green
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
