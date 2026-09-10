// =====================================================================
// SLIDE 10: DATA LAYER - DATA SOURCES (REMOTE & LOCAL)
// Topik: Membedakan Sumber Data API Jaringan vs Penyimpanan Lokal
// =====================================================================
// Jalankan dengan: flutter run -d chrome
// =====================================================================

import 'package:flutter/material.dart';

// Kontrak & Implementasi Data Source Jaringan (Remote):
abstract class UserRemoteDataSource {
  Future<Map<String, dynamic>> fetchUserRaw(int id);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  @override
  Future<Map<String, dynamic>> fetchUserRaw(int id) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return {
      'id': id,
      'name': 'Siti Aminah (Data Cloud)',
      'role': 'Mobile Engineer',
      'source': 'Remote API Server',
    };
  }
}

// Kontrak & Implementasi Data Source Penyimpanan Lokal (Cache / Local DB):
abstract class UserLocalDataSource {
  Future<Map<String, dynamic>> getCachedUser(int id);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  @override
  Future<Map<String, dynamic>> getCachedUser(int id) async {
    await Future.delayed(const Duration(milliseconds: 50));
    return {
      'id': id,
      'name': 'Siti Aminah (Data Cache Offline)',
      'role': 'Mobile Engineer',
      'source': 'Local SQLite / SharedPreferences',
    };
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
  final UserRemoteDataSource _remoteSource = UserRemoteDataSourceImpl();
  final UserLocalDataSource _localSource = UserLocalDataSourceImpl();

  Map<String, dynamic>? _data;
  bool _isLoading = false;
  String _activeAction = '';

  Future<void> _loadRemote() async {
    setState(() {
      _isLoading = true;
      _activeAction = 'Memanggil Remote API Server...';
    });
    final res = await _remoteSource.fetchUserRaw(1);
    setState(() {
      _data = res;
      _isLoading = false;
    });
  }

  Future<void> _loadLocal() async {
    setState(() {
      _isLoading = true;
      _activeAction = 'Membaca Cache Penyimpanan Lokal...';
    });
    final res = await _localSource.getCachedUser(1);
    setState(() {
      _data = res;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide 10 - Data Sources',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepOrange),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Slide 10: Remote vs Local DataSource'),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_isLoading) ...[
                  const CircularProgressIndicator.adaptive(),
                  const SizedBox(height: 12),
                  Text(
                    _activeAction,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ] else if (_data != null) ...[
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(
                              _data!['source'].toString().contains('Remote')
                                  ? Icons.cloud_done
                                  : Icons.storage,
                              color: Colors.deepOrange,
                              size: 36,
                            ),
                            title: Text(
                              _data!['name'] as String,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text('Role: ${_data!['role']}'),
                          ),
                          const Divider(),
                          Chip(
                            avatar: const Icon(Icons.info_outline, size: 16),
                            label: Text('Sumber: ${_data!['source']}'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ] else ...[
                  const Text(
                    'Pilih sumber data yang ingin diuji:',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FilledButton.icon(
                      onPressed: _isLoading ? null : _loadRemote,
                      icon: const Icon(Icons.cloud_download),
                      label: const Text('Remote API'),
                    ),
                    const SizedBox(width: 12),
                    FilledButton.tonalIcon(
                      onPressed: _isLoading ? null : _loadLocal,
                      icon: const Icon(Icons.storage),
                      label: const Text('Cache Lokal'),
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
