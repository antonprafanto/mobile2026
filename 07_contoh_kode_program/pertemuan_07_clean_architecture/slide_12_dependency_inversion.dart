// =====================================================================
// SLIDE 12: DEPENDENCY INVERSION PRINCIPLE (DIP)
// Topik: Bergantung Pada Abstraksi Kontrak, Bukan Implementasi Konkret
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

// Kontrak Abstrak:
abstract class NotifierService {
  String send(String message);
}

// Implementasi Nyata (Email):
class EmailNotifier implements NotifierService {
  @override
  String send(String message) => 'Kirim Email: $message';
}

// Implementasi Alternatif (WhatsApp / SMS) tanpa mengubah pemanggil:
class WhatsAppNotifier implements NotifierService {
  @override
  String send(String message) => 'Kirim WA: $message';
}

// Konsumen hanya bergantung pada NotifierService (Interface):
class OrderNotificationManager {
  final NotifierService service;
  OrderNotificationManager(this.service);

  String notifyCustomer() => service.send('Pesanan Anda Siap!');
}

void main() {
  runApp(const DIPDemoApp());
}

class DIPDemoApp extends StatefulWidget {
  const DIPDemoApp({super.key});

  @override
  State<DIPDemoApp> createState() => _DIPDemoAppState();
}

class _DIPDemoAppState extends State<DIPDemoApp> {
  String _status = 'Pilih saluran notifikasi';

  void _kirimVia(NotifierService service) {
    final manager = OrderNotificationManager(service);
    setState(() => _status = manager.notifyCustomer());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 12 - Dependency Inversion',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: Scaffold(
        appBar: AppBar(title: const Text('Slide 12: Dependency Inversion')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _status,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FilledButton.tonal(
                      onPressed: () => _kirimVia(EmailNotifier()),
                      child: const Text('Via Email'),
                    ),
                    const SizedBox(width: 12),
                    FilledButton(
                      onPressed: () => _kirimVia(WhatsAppNotifier()),
                      child: const Text('Via WhatsApp'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
