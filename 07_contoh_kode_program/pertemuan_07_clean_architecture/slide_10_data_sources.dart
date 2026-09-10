// =====================================================================
// SLIDE 10: DATA LAYER - DATA SOURCES (REMOTE & LOCAL)
// Topik: Membedakan Sumber Data API Jaringan vs Penyimpanan Lokal
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

// Kontrak Data Source Jaringan:
abstract class UserRemoteDataSource {
  Future<Map<String, dynamic>> fetchUserRaw(int id);
}

// Implementasi Remote Data Source:
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  @override
  Future<Map<String, dynamic>> fetchUserRaw(int id) async {
    // Simulasi delay HTTP request:
    await Future.delayed(const Duration(milliseconds: 500));
    return {'id': id, 'name': 'Siti Aminah', 'role': 'Mobile Engineer'};
  }
}

void main() {
  runApp(const DataSourceDemoApp());
}

class DataSourceDemoApp extends StatefulWidget {
  const DataSourceDemoApp({super.key});

  @override
  State<DataSourceDemoApp> createState() => _DataSourceDemoAppState();
}

class _DataSourceDemoAppState extends State<DataSourceDemoApp> {
  final UserRemoteDataSource _dataSource = UserRemoteDataSourceImpl();
  Map<String, dynamic>? _data;
  bool _isLoading = false;

  Future<void> _load() async {
    setState(() => _isLoading = true);
    final res = await _dataSource.fetchUserRaw(1);
    setState(() {
      _data = res;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 10 - Data Source',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepOrange),
      home: Scaffold(
        appBar: AppBar(title: const Text('Slide 10: Data Sources')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_isLoading)
                  const CircularProgressIndicator()
                else if (_data != null)
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.cloud_done),
                      title: Text(_data!['name'] as String),
                      subtitle: Text('Role: ${_data!['role']}'),
                    ),
                  )
                else
                  const Text(
                    'Tekan tombol untuk mengambil data mentah dari Remote Data Source.',
                  ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: _isLoading ? null : _load,
                  icon: const Icon(Icons.download),
                  label: const Text('Panggil RemoteDataSource'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
