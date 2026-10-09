import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/cart_provider.dart';
import 'cart_screen.dart'; // Import layar keranjang

class BookListScreen extends StatelessWidget {
  const BookListScreen({super.key});

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
        title: const Text('NusaBookstore'),
        backgroundColor: Colors.brown.shade100,
        actions: [
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
                if (cart.items.isNotEmpty)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: CircleAvatar(
                      radius: 9,
                      backgroundColor: Colors.red,
                      child: Text(
                        cart.items.length.toString(),
                        style: const TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
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
                  backgroundColor: Colors.brown.shade50,
                ),
                onPressed: () {
                  Provider.of<CartProvider>(context, listen: false).addBook(book);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${book.title} ditambahkan ke keranjang!'),
                      duration: const Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: const Text('Beli'),
              ),
            ),
          );
        },
      ),
    );
  }
}