import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  // Status awal: false (artinya Light Mode)
  bool _isDarkMode = false;

  // Getter untuk mengambil status tema saat ini
  bool get isDarkMode => _isDarkMode;

  // Fungsi untuk mengganti tema (toggle)
  void toggleTheme() {
    _isDarkMode = !_isDarkMode; // Ubah nilai dari true ke false atau sebaliknya
    notifyListeners(); // Beritahu seluruh aplikasi agar segera mengubah tampilan (render ulang)
  }
} 