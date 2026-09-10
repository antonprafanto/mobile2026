// =====================================================================
// SLIDE 03: THE STATE PROBLEM: EPHEMERAL VS APP STATE
// Topik: Membedakan State Lokal vs State Global Aplikasi
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(const StateComparisonApp());
}

class StateComparisonApp extends StatefulWidget {
  const StateComparisonApp({super.key});

  @override
  State<StateComparisonApp> createState() => _StateComparisonAppState();
}

class _StateComparisonAppState extends State<StateComparisonApp> {
  // 1. Ephemeral State: Cukup di widget ini saja (misal: buka-tutup kartu)
  bool _isCardExpanded = false;

  // 2. App State: Dibutuhkan di banyak halaman (misal: jumlah barang keranjang)
  int _cartItemCount = 3;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 03 - Ephemeral vs App State',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Slide 03: Dua Jenis State'),
          actions: [
            Badge(
              label: Text('$_cartItemCount'),
              child: const Icon(Icons.shopping_cart),
            ),
            const SizedBox(width: 16),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Card(
                child: ListTile(
                  leading: const Icon(Icons.lock_clock),
                  title: const Text('Ephemeral State (Lokal)'),
                  subtitle: Text(
                    _isCardExpanded
                        ? 'Status: Terbuka (cukup setState biasa)'
                        : 'Status: Tertutup',
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      _isCardExpanded ? Icons.expand_less : Icons.expand_more,
                    ),
                    onPressed: () {
                      setState(() => _isCardExpanded = !_isCardExpanded);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.public, color: Colors.deepOrange),
                  title: const Text('App State (Global / Bersama)'),
                  subtitle: Text(
                    'Keranjang: $_cartItemCount barang '
                    '(wajib dikelola Cubit / BLoC)',
                  ),
                  trailing: FilledButton.tonal(
                    onPressed: () {
                      setState(() => _cartItemCount++);
                    },
                    child: const Text('Tambah'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
