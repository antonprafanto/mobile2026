# SETUP GITHUB CLASSROOM & AUTOMATED CI WORKFLOW
## Otomasi Pengumpulan Tugas, Code Review, & Deteksi Otomatis Kesalahan

---

## 1. Mengapa Menggunakan GitHub Classroom?

Sebagai dosen informatika modern, pengumpulan tugas melalui email atau file `.zip` di LMS konvensional sudah usang dan menimbulkan masalah:
* Tidak ada riwayat pengerjaan (*commit history*).
* File `.zip` sering menyertakan folder `build/` dan `.dart_tool/` yang membengkak hingga ratusan MB.
* Sangat sulit melacak kontribusi individu dalam kelompok.

**GitHub Classroom memberikan solusi:**
1. Pembuatan repositori tugas privat secara otomatis untuk setiap mahasiswa atau tim.
2. Integrasi *GitHub Actions* untuk menjalankan uji kelayakan kode (*automated lint & unit tests*) setiap kali mahasiswa melakukan `git push`.
3. Dashboard terpusat untuk memantau waktu pengumpulan (*timestamp*) secara akurat.

---

## 2. Struktur Konfigurasi GitHub Actions (.github/workflows/ci.yml)

Setiap starter template tugas dilengkapi berkas workflow GitHub Actions berikut agar mahasiswa terbiasa dengan budaya CI/CD (*Continuous Integration*):

```yaml
name: Flutter CI & Automated Assessment

on:
  push:
    branches: [ main, master, development ]
  pull_request:
    branches: [ main, master ]

jobs:
  analyze_and_test:
    name: Code Quality & Unit Tests
    runs-on: ubuntu-latest
    timeout-minutes: 10

    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Setup Java Environment
        uses: actions/setup-java@v4
        with:
          distribution: 'zulu'
          java-version: '17'

      - name: Setup Flutter SDK
        uses: subosito/flutter-action@v2
        with:
          channel: 'stable'
          cache: true

      - name: Install Dependencies
        run: flutter pub get

      - name: Check Formatting
        run: dart format --output=none --set-exit-if-changed .

      - name: Static Code Analysis (Linter)
        run: flutter analyze --no-fatal-infos

      - name: Run Automated Tests
        run: flutter test --coverage
```

---

## 3. Aturan Pull Request & Code Review Antar Rekan Tim

Untuk proyek UTS dan UAS berkelompok:
1. **Branch Protection Rule:** Branch `main` dikunci (*protected*). Dilarang melakukan `git push origin main` secara langsung.
2. **Fitur Branching Workflow:** Setiap fitur baru harus dikerjakan di branch terpisah (contoh: `feature/auth-cubit` atau `feature/product-catalog-ui`).
3. **Penyatuan Kode via Pull Request (PR):**
   * Mahasiswa pembuat fitur mengajukan PR ke branch `development` atau `main`.
   * **Wajib di-review dan di-approve oleh minimal 1 rekan satu tim** sebelum di-merge.
   * CI GitHub Actions wajib berstatus **hijau (PASS)**.
4. **Bukti Penilaian Dosen:**
   * Dosen dan asisten menilai kualitas komunikasi teknis pada kolom komentar Pull Request.
   * Mahasiswa yang hanya menjadi *approver pasif* tanpa memberikan catatan/review akan dievaluasi pada rubrik kolaborasi.
