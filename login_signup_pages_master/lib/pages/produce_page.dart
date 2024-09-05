import 'package:flutter/material.dart';
import 'bidding_portal.dart';
import '../pages/payment_portal.dart';
import '../models/produce.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        backgroundColor: Colors.green[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ProductTile(
              name: 'Tomato',
              variety: 'Cherry',
              harvestDate: '6.9.24',
              quantity: 50,
              biddingPrice: 1000,
              pricePerUnit: 20,
            ),
            SizedBox(height: 20),
            ProductTile(
              name: 'Potato',
              variety: 'Chorry',
              harvestDate: '5.9.24',
              quantity: 40,
              biddingPrice: 800,
              pricePerUnit: 15,
            ),
          ],
        ),
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  final String name;
  final String variety;
  final String harvestDate;
  final int quantity;
  final int biddingPrice;
  final int pricePerUnit;

  ProductTile({
    required this.name,
    required this.variety,
    required this.harvestDate,
    required this.quantity,
    required this.biddingPrice,
    required this.pricePerUnit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Variety: $variety',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Harvest Date: $harvestDate',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Quantity: $quantity kg',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Bidding Price: \$${biddingPrice}',
              style: TextStyle(fontSize: 16, color: Colors.red[700]),
            ),
            Text(
              'Price Per Unit: \$${pricePerUnit}',
              style: TextStyle(fontSize: 16, color: Colors.blue[700]),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProcessPaymentPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 138, 234,
                          143), // Use backgroundColor instead of primary
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Buy Now',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: const Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BiddingScreen(
                            produce: Produce(
                              name: name,
                              variety: variety,
                              harvestDate: harvestDate,
                              quantity: quantity,
                              biddingPrice: biddingPrice,
                              pricePerUnit: pricePerUnit,
                              unit: "kg",
                            ),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 241, 179,
                          118), // Use backgroundColor instead of primary

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Negotiate',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: const Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProcessPaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Process Payment'),
        backgroundColor: Colors.green[800],
      ),
      body: Center(
        child: Text(
          'Process Payment Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
