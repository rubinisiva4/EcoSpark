import 'package:flutter/material.dart';
import '../model/produce.dart'; // Ensure this import is correct
import 'bidding_screen.dart'; // Import the bidding screen

class BiddingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
    );
  }
}
