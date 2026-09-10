// =====================================================================
// KODE LENGKAP RUNNABLE - SLIDE 15: STREAM REAKTIF (ASYNC* & YIELD)
// TOPIK: Aliran Data Kontinu (Live Data GPS / Hitungan Waktu Real-Time)
// =====================================================================
// CARA MENJALANKAN:
// 1. Lewat Terminal: dart run slide_15_stream_reactive_data.dart
// 2. Lewat Browser : salin ke https://dartpad.dev lalu klik "Run"
// =====================================================================

Stream<int> hitungMundurWaktu(int detikAwal) async* {
  for (int s = detikAwal; s >= 1; s--) {
    await Future.delayed(const Duration(seconds: 1));
    yield s;
  }
}

Stream<String> lacakPosisiKurir() async* {
  final posisi = [
    'Restoran Kafe (Pesanan Diambil)',
    'Jl. Sudirman No. 10 (Sedang di Jalan)',
    'Simpang Kampus (500 meter lagi)',
    'Depan Gerbang Lab Informatika (Tiba!)',
  ];

  for (var pos in posisi) {
    await Future.delayed(const Duration(milliseconds: 800));
    yield pos;
  }
}

Future<void> main() async {
  print('=== DEMO STREAM REAKTIF DART (async* & yield) ===');
  print('');

  print('🚀 MEMULAI HITUNG MUNDUR PELUNCURAN ROKET:');
  await for (int detik in hitungMundurWaktu(3)) {
    print('   ⏱️ $detik detik lagi...');
  }
  print('   🎉 BOOM! ROKET MELUNCUR SEMPURNA!');
  print('');
  print('-----------------------------------------------------');
  print('');

  print('📦 MEMULAI PELACAKAN STATUS KURIR REAL-TIME:');
  await for (String updateLokasi in lacakPosisiKurir()) {
    print('   📍 Update GPS: $updateLokasi');
  }

  print('');
  print('💡 KESIMPULAN:');
  print('• Future = Datang 1 kali (single value).');
  print(
    '• Stream = Mengalir berkali-kali sepanjang waktu (continuous stream of data).',
  );
  print(
    'Di Flutter, Stream digunakan oleh StreamBuilder & library flutter_bloc!',
  );
}
