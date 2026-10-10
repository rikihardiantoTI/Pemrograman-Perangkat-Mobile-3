import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/book.dart';
import '../providers/cart_provider.dart';
import '../providers/theme_provider.dart';
import 'cart_screen.dart';

class BookListScreen extends StatelessWidget {
  const BookListScreen({super.key});

  // Minimal 4 Buku
  static final List<Book> dummyBooks = [
    Book(id: 'b1', title: 'Bumi Manusia', author: 'Pramoedya Ananta Toer', price: 95000),
    Book(id: 'b2', title: 'Laskar Pelangi', author: 'Andrea Hirata', price: 85000),
    Book(id: 'b3', title: 'Cantik Itu Luka', author: 'Eka Kurniawan', price: 110000),
    Book(id: 'b4', title: 'Laut Bercerita', author: 'Leila S. Chudori', price: 105000),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Buku'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          // Tombol Light/Dark Mode
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return IconButton(
                icon: Icon(
                  themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                ),
                onPressed: () {
                  // Menggunakan context.read() untuk merubah data tema
                  context.read<ThemeProvider>().toggleTheme();
                },
              );
            },
          ),

          // Ikon Keranjang dengan Badge
          Consumer<CartProvider>(
            builder: (context, cart, child) => Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CartScreen()),
                    );
                  },
                ),
                // Badge akan otomatis muncul & berubah angkanya ketika ada item
                if (cart.items.isNotEmpty)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: CircleAvatar(
                      radius: 9,
                      backgroundColor: Colors.red,
                      child: Text(
                        cart.totalItems.toString(),
                        style: const TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
      // Menggunakan ListView dan Card sesuai ketentuan
      body: ListView.builder(
        itemCount: dummyBooks.length,
        itemBuilder: (context, index) {
          final book = dummyBooks[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 2,
            child: ListTile(
              leading: const Icon(Icons.book, size: 40, color: Colors.brown),
              title: Text(book.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${book.author}\nRp ${book.price.toStringAsFixed(0)}'),
              isThreeLine: true,
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                ),
                onPressed: () {
                  // Menggunakan context.read() untuk menambah data ke keranjang
                  context.read<CartProvider>().addItem(
                    book.id,
                    book.title,
                    book.price,
                  );
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${book.title} ditambahkan!'),
                      duration: const Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: const Text('Tambah ke Keranjang'), // Label tombol disesuaikan
              ),
            ),
          );
        },
      ),
    );
  }
}