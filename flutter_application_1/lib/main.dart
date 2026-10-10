import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Import file provider
import 'providers/cart_provider.dart';
import 'providers/theme_provider.dart';

// Import file screen
import 'screens/book_list_screen.dart';

void main() {
  runApp(
    // 1. Menggunakan MultiProvider di root aplikasi
    MultiProvider(
      providers: [
        // Mendaftarkan CartProvider
        ChangeNotifierProvider(create: (context) => CartProvider()),
        // Mendaftarkan ThemeProvider
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const NusaBookstoreApp(),
    ),
  );
}

class NusaBookstoreApp extends StatelessWidget {
  const NusaBookstoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 2. Menggunakan Consumer agar MaterialApp mendengarkan perubahan tema
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'NusaBookstore',
          
          // Konfigurasi Tema Terang (Light Mode)
          theme: ThemeData(
            brightness: Brightness.light,
            colorSchemeSeed: Colors.brown,
            useMaterial3: true,
          ),
          
          // Konfigurasi Tema Gelap (Dark Mode)
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            colorSchemeSeed: Colors.brown,
            useMaterial3: true,
          ),
          
          // Membaca status isDarkMode dari ThemeProvider
          themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          
          home: const BookListScreen(),
        );
      },
    );
  }
}