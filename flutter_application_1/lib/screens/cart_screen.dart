import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mendengarkan perubahan data dari CartProvider
    final cart = Provider.of<CartProvider>(context);
    
    // Mengubah Map values menjadi List agar mudah ditampilkan di ListView
    final cartItems = cart.items.values.toList();
    // Menyimpan key (ID Buku) untuk digunakan saat fungsi tambah/kurang
    final cartItemKeys = cart.items.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Column(
        children: [
          Expanded(
            child: cart.items.isEmpty
                ? const Center(
                    child: Text(
                      'Keranjang Anda masih kosong.',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      final productId = cartItemKeys[index];
                      
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        elevation: 2,
                        child: ListTile(
                          title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('Rp ${item.price.toStringAsFixed(0)}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Tombol Kurang (-)
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                                onPressed: () {
                                  context.read<CartProvider>().removeItem(productId);
                                },
                              ),
                              // Jumlah Item
                              Text(
                                '${item.quantity}',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              // Tombol Tambah (+)
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                                onPressed: () {
                                  context.read<CartProvider>().addItem(productId, item.title, item.price);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          
          // Bagian Bawah: Ringkasan Total dan Tombol Checkout
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min, // Agar column hanya memakan ruang seperlunya
                children: [
                  // Baris Total Item
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Item:', style: TextStyle(fontSize: 16)),
                      Text(
                        '${cart.totalItems} Buku',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // Baris Total Pembayaran
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Bayar:',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Rp ${cart.totalPrice.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 20, 
                          fontWeight: FontWeight.bold, 
                          color: Theme.of(context).colorScheme.primary
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Tombol Checkout
                  SizedBox(
                    width: double.infinity, // Membuat tombol penuh ke samping
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      ),
                      // Jika keranjang kosong, tombol disable (null)
                      onPressed: cart.items.isEmpty
                          ? null
                          : () {
                              // 1. Kosongkan keranjang
                              context.read<CartProvider>().clearCart();
                              
                              // 2. Kembali ke halaman sebelumnya (Katalog Buku)
                              Navigator.pop(context);

                              // 3. Tampilkan SnackBar sukses
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Checkout berhasil! Terima kasih telah berbelanja.'),
                                  backgroundColor: Colors.green,
                                  behavior: SnackBarBehavior.floating,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                      child: const Text(
                        'Checkout / Bayar',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}