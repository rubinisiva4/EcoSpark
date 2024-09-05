import 'package:flutter/material.dart';
import '../pages/product_management.dart';

class MandiHomePage extends StatelessWidget {
  const MandiHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mandi Home'),
        backgroundColor: const Color(0xff2e7d32), // Green
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome, Mandi!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 54, 155, 59), // Dark green
              ),
            ),
            const SizedBox(height: 20),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              elevation: 5,
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                title: const Text(
                  'Manage Produce',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text(
                  'View and manage the produce in your mandi.',
                  style: TextStyle(fontSize: 14),
                ),
                trailing: Icon(
                  Icons.manage_accounts,
                  color: Colors.green[600],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProductManagementPage()),
                  );
                },
              ),
            ),
            // Uncomment to add transactions page
            Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              elevation: 5,
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                title: const Text(
                  'View Transactions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text(
                  'View your transaction history.',
                  style: TextStyle(fontSize: 14),
                ),
                trailing: Icon(
                  Icons.history,
                  color: Colors.green[600],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ViewTransactionsPage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ManageProducePage extends StatelessWidget {
  const ManageProducePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Produce'),
        backgroundColor: const Color(0xff2e7d32), // Green
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Manage produce options will be here.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ViewTransactionsPage extends StatelessWidget {
  const ViewTransactionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Transactions'),
        backgroundColor: const Color(0xff2e7d32), // Green
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Transaction history will be here.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
