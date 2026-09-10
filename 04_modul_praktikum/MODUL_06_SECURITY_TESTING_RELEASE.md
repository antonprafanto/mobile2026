# MODUL PRAKTIKUM 06: KEAMANAN, PENGUJIAN OTOMATIS, & RILIS PRODUKSI
## Laboratorium Rekayasa Perangkat Lunak - Teknik Informatika

---

## 1. Tujuan Pembelajaran
1. Mahasiswa mampu mengamankan rahasia aplikasi (*API Keys & JWT Tokens*) menggunakan `.env` dan `flutter_secure_storage`.
2. Mahasiswa mampu menulis pengujian unit (*Unit Test*) untuk logika state management menggunakan **bloc_test** dan **mocktail**.
3. Mahasiswa mampu melakukan *code signing* menggunakan Keystore resmi dan mengkompilasi paket produksi *Release APK/AAB* dengan proteksi *Obfuscation*.

---

## 2. Langkah Kerja Terpandu

### Bagian A: Unit Testing Logika Cubit (test/counter_cubit_test.dart)
Buat berkas uji di direktori `test/` untuk memverifikasi perilaku state tanpa perlu emulator visual:

```dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_starter_2026/features/counter_example/presentation/cubit/counter_cubit.dart';
import 'package:mobile_starter_2026/features/counter_example/presentation/cubit/counter_state.dart';

void main() {
  group('CounterCubit Unit Test Suite', () {
    late CounterCubit counterCubit;

    setUp(() {
      counterCubit = CounterCubit();
    });

    tearDown(() {
      counterCubit.close();
    });

    test('Initial state harus memiliki count = 0 dan status initial', () {
      expect(counterCubit.state, const CounterState(count: 0, status: CounterStatus.initial));
    });

    blocTest<CounterCubit, CounterState>(
      'Memancarkan count = 1 ketika increment dipanggil',
      build: () => counterCubit,
      act: (cubit) => cubit.increment(),
      expect: () => [
        const CounterState(count: 1, status: CounterStatus.success),
      ],
    );

    blocTest<CounterCubit, CounterState>(
      'Memancarkan status failure ketika decrement dipanggil saat angka 0',
      build: () => counterCubit,
      act: (cubit) => cubit.decrement(),
      expect: () => [
        const CounterState(
          count: 0,
          status: CounterStatus.failure,
          errorMessage: 'Angka tidak boleh kurang dari 0!',
        ),
      ],
    );
  });
}
```

Jalankan pengujian di terminal:
```bash
flutter test
```

---

### Bagian B: Pembuatan Keystore & Kompilasi Rilis Terproteksi

1. **Membuat Kunci Digital Keystore (Terminal):**
   ```bash
   keytool -genkey -v -keystore android/app/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   ```
2. **Kompilasi dengan Pengacakan Kode (*Code Obfuscation*):**
   ```bash
   flutter build apk --release --obfuscate --split-debug-info=./build/symbols
   ```
3. Berkas APK rilis yang aman dan teroptimasi akan dihasilkan di `build/app/outputs/flutter-apk/app-release.apk`.

---

## 3. Tugas Latihan Mandiri (Graded Lab Task)

> **Tantangan Praktikum 6:**
> 1. Tulis minimal 3 kasus pengujian unit (*Unit Test*) untuk fitur autentikasi atau keranjang belanja yang Anda kembangkan di proyek tim.
> 2. Pastikan seluruh pengujian lulus dengan indikator hijau (`All tests passed!`).
> 3. Lakukan build `app-release.apk` dan verifikasi bahwa ukuran berkas APK tidak melebihi 35 MB.
