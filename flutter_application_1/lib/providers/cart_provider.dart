import 'package:flutter/material.dart';
import '../models/book.dart'; // Import model buku

class CartProvider with ChangeNotifier {
  final List<Book> _items = [];

  List<Book> get items => _items;

  double get totalPrice {
    return _items.fold(0.0, (sum, item) => sum + item.price);
  }

  void addBook(Book book) {
    _items.add(book);
    notifyListeners();
  }

  void removeBook(Book book) {
    _items.remove(book);
    notifyListeners();
  }
}