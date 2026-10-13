// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 02: DASAR PEMROGRAMAN DART
// CONTOH 08: Perulangan
// Topik: for, for-in, while, do-while, break, dan continue.
// =====================================================================
// CARA MENJALANKAN (pilih salah satu):
// A. Buka https://dartpad.dev, tempel seluruh isi berkas ini, klik Run.
// B. Di terminal: dart run 08_perulangan.dart
// =====================================================================

void main() {
  // 1) for klasik: (nilai awal; syarat lanjut; perubahan tiap putaran)
  for (int i = 1; i <= 3; i++) {
    print('Perulangan ke-$i');
  }

  // 2) for-in: ambil isi daftar satu per satu
  List<String> buah = ['Apel', 'Mangga', 'Durian'];
  for (String namaBuah in buah) {
    print('Saya suka $namaBuah');
  }

  // 3) while: ulangi SELAMA syarat benar (bisa saja 0 kali)
  int uangJajan = 50000;
  int hari = 0;
  while (uangJajan >= 15000) {
    uangJajan -= 15000; // jajan Rp15.000 per hari
    hari++;
  }
  print('Uang jajan cukup untuk $hari hari, sisa Rp$uangJajan');

  // 4) do-while: jalankan DULU, baru periksa syarat (minimal 1 kali)
  int percobaan = 0;
  do {
    percobaan++;
    print('Mencoba terhubung ke server, percobaan ke-$percobaan');
  } while (percobaan < 3);

  // 5) continue = lewati sisa putaran ini; break = hentikan perulangan
  for (int i = 1; i <= 10; i++) {
    if (i % 2 == 0) {
      continue; // angka genap dilewati
    }
    if (i > 7) {
      break; // berhenti total begitu melewati 7
    }
    print('Bilangan ganjil: $i');
  }
}

// OUTPUT:
// Perulangan ke-1
// Perulangan ke-2
// Perulangan ke-3
// Saya suka Apel
// Saya suka Mangga
// Saya suka Durian
// Uang jajan cukup untuk 3 hari, sisa Rp5000
// Mencoba terhubung ke server, percobaan ke-1
// Mencoba terhubung ke server, percobaan ke-2
// Mencoba terhubung ke server, percobaan ke-3
// Bilangan ganjil: 1
// Bilangan ganjil: 3
// Bilangan ganjil: 5
// Bilangan ganjil: 7
