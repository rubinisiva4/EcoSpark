import 'package:flutter/material.dart';
import '../pages/browse__products_page.dart';
import 'view_orders_page.dart';
import '../pages/produce_page.dart';

class ConsumerHomePage extends StatefulWidget {
  const ConsumerHomePage({Key? key}) : super(key: key);

  @override
  _ConsumerHomePageState createState() => _ConsumerHomePageState();
}

class _ConsumerHomePageState extends State<ConsumerHomePage> {
  final List<Widget> _pages = [
    ProductPage(),
    const ViewOrdersPage(),
  ];

  int _selectedIndex = 0;

  void _onDrawerItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Close the drawer after an item is tapped
  }

  void _logout() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Consumer Home',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green[800],
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Add search functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: const Text('Consumer Name'),
              accountEmail: const Text('consumer@example.com'),
              decoration: BoxDecoration(
                color: Colors.green[800],
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  'C',
                  style: TextStyle(fontSize: 40.0, color: Colors.green[800]),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Browse Products'),
              onTap: () => _onDrawerItemTapped(0),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('View Orders'),
              onTap: () => _onDrawerItemTapped(1),
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: _logout,
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Browse Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'View Orders',
          ),
        ],
        backgroundColor: Colors.green[800],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
      ),
    );
  }
}
