import 'package:flutter/material.dart';

// 1. Buat model khusus untuk item di dalam keranjang
class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

// 2. Provider Keranjang Belanja
class CartProvider with ChangeNotifier {
  // Menggunakan Map agar mudah mencari buku berdasarkan ID-nya
  final Map<String, CartItem> _items = {};

  // Getter untuk mengambil daftar buku di keranjang
  Map<String, CartItem> get items => _items;

  // Menghitung jumlah seluruh buku (totalItems)
  int get totalItems {
    int count = 0;
    _items.forEach((key, cartItem) {
      count += cartItem.quantity;
    });
    return count;
  }

  // Menghitung total harga (totalPrice)
  double get totalPrice {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  // Fungsi untuk menambahkan buku / menambah kuantitas
  void addItem(String bookId, String title, double price) {
    if (_items.containsKey(bookId)) {
      // Jika buku sudah ada di keranjang, tambah jumlahnya (quantity + 1)
      _items.update(
        bookId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      // Jika buku belum ada, tambahkan sebagai item baru dengan quantity 1
      _items.putIfAbsent(
        bookId,
        () => CartItem(
          id: bookId,
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners(); // Wajib dipanggil agar layar otomatis diperbarui
  }

  // Fungsi untuk mengurangi jumlah atau menghapus buku
  void removeItem(String bookId) {
    if (!_items.containsKey(bookId)) {
      return; // Jika buku tidak ada, batalkan aksi
    }

    if (_items[bookId]!.quantity > 1) {
      // Jika jumlahnya lebih dari 1, kurangi 1
      _items.update(
        bookId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity - 1,
        ),
      );
    } else {
      // Jika jumlahnya tinggal 1, hapus buku tersebut dari keranjang sepenuhnya
      _items.remove(bookId);
    }
    notifyListeners(); 
  }

  // Fungsi untuk mengosongkan keranjang
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}