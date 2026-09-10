// =====================================================================
// CONTOH KODE SEDERHANA - SLIDE 15: STACK & POSITIONED
// TOPIK: Menumpuk Elemen Melayang (Z-Index / Lencana Diskon)
// =====================================================================

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: HalamanStack()),
  );
}

class HalamanStack extends StatelessWidget {
  const HalamanStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stack & Positioned')),
      body: Center(
        // Stack menumpuk widget dari belakang ke depan
        child: SizedBox(
          width: 200,
          height: 200,
          child: Stack(
            children: [
              // Lapisan 1: Kotak Biru di Bawah
              Container(
                width: 200,
                height: 200,
                color: Colors.blue[100],
                child: const Center(child: Text('Kotak Utama')),
              ),
              // Lapisan 2: Lencana Merah Melayang di Pojok Kanan Atas
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: const Text(
                    'BARU',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
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
