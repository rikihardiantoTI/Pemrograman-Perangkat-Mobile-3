import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Import file yang sudah kita pisah
import 'providers/cart_provider.dart';
import 'screens/book_list_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: const NusaBookstoreApp(),
    ),
  );
}

class NusaBookstoreApp extends StatelessWidget {
  const NusaBookstoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NusaBookstore',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        useMaterial3: true,
      ),
      home: const BookListScreen(),
    );
  }
}