import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/cart_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/book_list_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
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
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'NusaBookstore',
          
          theme: ThemeData(
            brightness: Brightness.light,
            colorSchemeSeed: Colors.brown,
            useMaterial3: true,
          ),
          
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            colorSchemeSeed: Colors.brown,
            useMaterial3: true,
          ),
          
          themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          
          // ---> TAMBAHKAN BAGIAN INI UNTUK MEMBUAT TAMPILAN SEPERTI HP <---
          builder: (context, child) {
            return Container(
              // Warna background untuk area kosong di kiri-kanan layar Chrome
              color: themeProvider.isDarkMode ? Colors.black87 : Colors.grey.shade200,
              child: Center(
                child: Container(
                  // Membatasi lebar maksimal aplikasi seperti ukuran HP standar (misal: 420 pixel)
                  width: 420,
                  decoration: BoxDecoration(
                    // Memberikan efek bayangan agar terlihat seperti bentuk HP fisik
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 15,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  // Child di sini adalah seluruh UI aplikasi Anda (halaman Katalog, Keranjang, dll)
                  child: child,
                ),
              ),
            );
          },
          
          home: const BookListScreen(),
        );
      },
    );
  }
}