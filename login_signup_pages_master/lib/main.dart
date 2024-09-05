import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'pages/current_bid_page.dart';
import 'screens/WelcomeScreen.dart';
import 'screens/loginScreen.dart';
import 'screens/regScreen.dart';
import 'screens/farmer_register.dart';
import 'screens/consumer_register.dart';
import 'screens/mandi_register.dart';
import 'pages/farmer_home_page.dart';
import 'pages/manage_produce_page.dart';
import 'pages/view_existing_produce_page.dart';
import 'pages/ordered_produce_page.dart';
import 'pages/view_transactions_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("Initialized properly");

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase connected");
  } catch (e) {
    print("Firebase initialization error: $e");
  }

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const loginScreen(),
        '/register': (context) => const RegScreen(),
        '/farmer_register': (context) => const FarmerRegisterPage(),
        '/consumer_register': (context) => const ConsumerRegisterPage(),
        '/mandi_register': (context) => const MandiRegisterPage(),
        '/farmer_home': (context) => const FarmerHomePage(),
        '/manage_produce': (context) => const ManageProducePage(),
        '/view_existing_produce': (context) => const ViewExistingProducePage(),
        '/ordered_produce': (context) => const OrderedProducePage(),
        '/view_transactions': (context) => const ViewTransactionsPage(),
        '/current_bidding': (context) => const CurrentBiddingPage(), // Ensure this route is defined
      },
    );
  }
}
