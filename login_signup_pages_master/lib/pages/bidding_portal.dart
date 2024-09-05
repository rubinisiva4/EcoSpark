import 'dart:async';
import 'package:flutter/material.dart';
import '../models/produce.dart';
import 'payment_portal.dart';

class BiddingScreen extends StatefulWidget {
  final Produce produce;

  BiddingScreen({required this.produce});

  @override
  _BiddingScreenState createState() => _BiddingScreenState();
}

class _BiddingScreenState extends State<BiddingScreen> {
  TextEditingController bidController = TextEditingController();
  Timer? _timer;
  int _start = 30; // 30 seconds countdown
  bool _showBuyButton = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_start > 0) {
          _start--;
        } else {
          _showBuyButton = true;
          _timer?.cancel();
        }
      });
    });
  }

  void _submitBid() {
    if (_showBuyButton) {
      return; // Do not allow new bids after time is up
    }

    double newBid =
        double.tryParse(bidController.text) ?? widget.produce.currentBid;
    if (newBid > widget.produce.currentBid) {
      setState(() {
        widget.produce.currentBid = newBid; // Update the current bid
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a higher bid amount.'),
          backgroundColor: Colors.red[600],
        ),
      );
    }
    bidController.clear(); // Clear the input field after submitting the bid
  }

  void _navigateToPaymentScreen() {
    // Navigate to payment screen with the current bid amount
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentScreen(produce: widget.produce),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bidding Portal'),
        backgroundColor: Colors.green[800], // Darker green
      ),
      body: Container(
        color: Colors.green[50], // Very light green background
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.produce.name,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.green[900], // Dark green
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Quantity: ${widget.produce.quantity} ${widget.produce.unit}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.green[700], // Medium green
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Current Bid Amount: ₹${widget.produce.currentBid.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 24,
                color: Colors.green[800], // Darker green
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Time Remaining: $_start seconds',
              style: TextStyle(
                fontSize: 20,
                color: Colors.red[700], // Darker red for countdown
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: bidController,
              decoration: InputDecoration(
                labelText: 'Enter your bid',
                labelStyle: TextStyle(color: Colors.green[600]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              keyboardType: TextInputType.number,
              enabled: !_showBuyButton, // Disable the input when time is up
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _showBuyButton ? _navigateToPaymentScreen : _submitBid,
                child: Text(_showBuyButton ? 'Buy Now' : 'Submit Bid'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _showBuyButton ? Colors.green[800] : Colors.green[600], // Darker green for Buy Now
                  foregroundColor: Colors.white, // Text color
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    bidController.dispose(); // Dispose of the controller when done
    _timer?.cancel(); // Cancel the timer if still running
    super.dispose();
  }
}
