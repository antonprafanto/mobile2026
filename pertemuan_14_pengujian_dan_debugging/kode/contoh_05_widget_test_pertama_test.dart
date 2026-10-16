// =====================================================================
// PEMROGRAMAN PIRANTI BERGERAK - PERTEMUAN 14: PENGUJIAN & DEBUGGING
// CONTOH 05: Widget Test Pertama
// Topik: Aplikasi "Cek Nilai Akhir" (memakai fungsi Contoh 01) diuji
//        seperti pengguna memakainya: mengetik, mengetuk, lalu melihat
//        layar. Yang dipelajari:
//        - testWidgets() dan WidgetTester (tester);
//        - pumpWidget(): membangun tampilan; pump(): menggambar ulang;
//        - finder: find.text, find.byKey, find.byType, find.byTooltip,
//          find.widgetWithText;
//        - aksi: tester.enterText() dan tester.tap();
//        - matcher: findsOneWidget, findsNothing, findsNWidgets(n).
// =====================================================================
// CARA MENJALANKAN:
// Terminal, dari folder utama repositori:
//    flutter test pertemuan_14_pengujian_dan_debugging/kode/contoh_05_widget_test_pertama_test.dart
// Widget test TIDAK dijalankan di DartPad (modul Bagian 6.6). Ingin
// melihat aplikasinya? Di DartPad, ganti nama main() milik tes menjadi
// mainTes(), lalu tambahkan: void main() => runApp(const AplikasiCekNilai());
// =====================================================================

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// ======================= BERKAS: lib/nilai.dart =======================
// Sama dengan Contoh 01 (versi yang sudah diperbaiki).

double hitungNilaiAkhir({
  required int tugas,
  required int uts,
  required int uas,
}) {
  final double akhir = tugas * 0.3 + uts * 0.3 + uas * 0.4;
  return (akhir * 100).round() / 100;
}

String nilaiHuruf(double angka) {
  if (angka >= 85) {
    return 'A';
  } else if (angka >= 70) {
    return 'B';
  } else if (angka >= 55) {
    return 'C';
  } else if (angka >= 40) {
    return 'D';
  }
  return 'E';
}

// ======================= BERKAS: lib/main.dart =======================

class AplikasiCekNilai extends StatelessWidget {
  const AplikasiCekNilai({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cek Nilai Akhir',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const HalamanCekNilai(),
    );
  }
}

class HalamanCekNilai extends StatefulWidget {
  const HalamanCekNilai({super.key});

  @override
  State<HalamanCekNilai> createState() => _HalamanCekNilaiState();
}

class _HalamanCekNilaiState extends State<HalamanCekNilai> {
  final GlobalKey<FormState> _kunciForm = GlobalKey<FormState>();
  final TextEditingController _tugas = TextEditingController();
  final TextEditingController _uts = TextEditingController();
  final TextEditingController _uas = TextEditingController();
  double? _akhir; // null = belum dihitung

  @override
  void dispose() {
    _tugas.dispose();
    _uts.dispose();
    _uas.dispose();
    super.dispose();
  }

  String? _periksaNilai(String? isi) {
    final String teks = (isi ?? '').trim();
    if (teks.isEmpty) {
      return 'Wajib diisi';
    }
    final int? angka = int.tryParse(teks);
    if (angka == null) {
      return 'Isi dengan angka bulat';
    }
    if (angka < 0 || angka > 100) {
      return 'Nilai 0 sampai 100';
    }
    return null;
  }

  void _hitung() {
    if (!_kunciForm.currentState!.validate()) {
      setState(() => _akhir = null);
      return;
    }
    setState(() {
      _akhir = hitungNilaiAkhir(
        tugas: int.parse(_tugas.text.trim()),
        uts: int.parse(_uts.text.trim()),
        uas: int.parse(_uas.text.trim()),
      );
    });
  }

  void _kosongkan() {
    _tugas.clear();
    _uts.clear();
    _uas.clear();
    _kunciForm.currentState!.reset(); // pesan "Wajib diisi" ikut hilang
    setState(() => _akhir = null);
  }

  Widget _isian(Key kunci, String label, TextEditingController kontrol) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        key: kunci,
        controller: kontrol,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: _periksaNilai,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double? akhir = _akhir;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cek Nilai Akhir'),
        actions: [
          IconButton(
            onPressed: _kosongkan,
            tooltip: 'Kosongkan',
            icon: const Icon(Icons.restart_alt),
          ),
        ],
      ),
      body: Form(
        key: _kunciForm,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _isian(const Key('isian_tugas'), 'Tugas (30%)', _tugas),
            _isian(const Key('isian_uts'), 'UTS (30%)', _uts),
            _isian(const Key('isian_uas'), 'UAS (40%)', _uas),
            FilledButton.icon(
              onPressed: _hitung,
              icon: const Icon(Icons.calculate),
              label: const Text('Hitung'),
            ),
            const SizedBox(height: 24),
            if (akhir != null)
              KartuHasil(key: const Key('kartu_hasil'), akhir: akhir),
          ],
        ),
      ),
    );
  }
}

class KartuHasil extends StatelessWidget {
  const KartuHasil({super.key, required this.akhir});

  final double akhir;

  @override
  Widget build(BuildContext context) {
    final String huruf = nilaiHuruf(akhir);
    final bool lulus = huruf == 'A' || huruf == 'B' || huruf == 'C';
    final ColorScheme warna = Theme.of(context).colorScheme;
    return Card(
      color: lulus ? warna.primaryContainer : warna.errorContainer,
      child: ListTile(
        leading: CircleAvatar(child: Text(huruf)),
        title: Text('Nilai akhir ${akhir.toStringAsFixed(1)}'),
        subtitle: Text(lulus ? 'Lulus' : 'Mengulang'),
      ),
    );
  }
}

// ================ BERKAS: test/cek_nilai_test.dart ================

/// Mengisi ketiga isian. Dipakai beberapa tes, jadi dijadikan fungsi.
Future<void> isiNilai(
  WidgetTester tester, {
  required String tugas,
  required String uts,
  required String uas,
}) async {
  await tester.enterText(find.byKey(const Key('isian_tugas')), tugas);
  await tester.enterText(find.byKey(const Key('isian_uts')), uts);
  await tester.enterText(find.byKey(const Key('isian_uas')), uas);
}

void main() {
  // testWidgets memberi kita "tester": robot yang bisa membangun layar,
  // mengetik, mengetuk, dan menggambar ulang.
  testWidgets('tampilan awal: tiga isian dan belum ada hasil', (
    WidgetTester tester,
  ) async {
    // pumpWidget: bangun dan gambar aplikasinya satu kali.
    await tester.pumpWidget(const AplikasiCekNilai());

    expect(find.text('Cek Nilai Akhir'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(3));
    expect(find.text('Hitung'), findsOneWidget);
    expect(find.byKey(const Key('kartu_hasil')), findsNothing);
  });

  testWidgets('isian kosong: ketiganya bertuliskan "Wajib diisi"', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AplikasiCekNilai());

    await tester.tap(find.text('Hitung'));
    // tap() hanya mengetuk. Layar baru berubah setelah pump().
    await tester.pump();

    expect(find.text('Wajib diisi'), findsNWidgets(3));
    expect(find.byKey(const Key('kartu_hasil')), findsNothing);
  });

  testWidgets('nilai di luar 0 sampai 100 ditolak', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AplikasiCekNilai());

    await isiNilai(tester, tugas: '80', uts: '75', uas: '120');
    await tester.tap(find.text('Hitung'));
    await tester.pump();

    expect(find.text('Nilai 0 sampai 100'), findsOneWidget);
    expect(find.byKey(const Key('kartu_hasil')), findsNothing);
  });

  testWidgets('60, 82, 31 menghasilkan 55.0 dengan huruf C', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AplikasiCekNilai());

    // Isian juga bisa dicari dari tulisan labelnya.
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Tugas (30%)'),
      '60',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'UTS (30%)'),
      '82',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'UAS (40%)'),
      '31',
    );
    await tester.tap(find.text('Hitung'));
    await tester.pump();

    expect(find.text('Nilai akhir 55.0'), findsOneWidget);
    expect(find.text('C'), findsOneWidget);
    expect(find.text('Lulus'), findsOneWidget);
  });

  testWidgets('di bawah 55 tertulis Mengulang', (WidgetTester tester) async {
    await tester.pumpWidget(const AplikasiCekNilai());

    await isiNilai(tester, tugas: '60', uts: '55', uas: '48');
    await tester.tap(find.text('Hitung'));
    await tester.pump();

    expect(find.text('Nilai akhir 53.7'), findsOneWidget);
    expect(find.text('D'), findsOneWidget);
    expect(find.text('Mengulang'), findsOneWidget);
  });

  testWidgets('tombol Kosongkan menghapus isian dan hasil', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AplikasiCekNilai());
    await isiNilai(tester, tugas: '90', uts: '85', uas: '88');
    await tester.tap(find.text('Hitung'));
    await tester.pump();
    expect(find.byKey(const Key('kartu_hasil')), findsOneWidget);

    // Tombol ikon tidak punya tulisan, jadi dicari dari tooltip-nya.
    await tester.tap(find.byTooltip('Kosongkan'));
    await tester.pump();

    expect(find.byKey(const Key('kartu_hasil')), findsNothing);
    expect(find.text('90'), findsNothing);
  });
}

// HASIL (baris terakhir; angka waktu di depannya bisa berbeda):
// 00:03 +6: All tests passed!
