# INSTRUMEN EVALUASI: LIVE CODE DEFENSE & ANTI FREE-RIDER
## Dokumen Asesmen Ujian Lisan & Verifikasi Integritas Individu

---

## 1. Lembar Penilaian Live Code Defense Individu

Setiap mahasiswa diuji secara individual di depan dosen selama 5–7 menit saat sesi demo proyek.

**Nama Mahasiswa:** _________________________ | **NIM:** _________________________  
**Kelompok / Nama Aplikasi:** _________________________________________________

| No | Parameter Asesmen Individu | Skor Maksimal | Skor Capaian | Catatan Penguji |
| :---: | :--- | :---: | :---: | :--- |
| **1** | **Pemahaman Arsitektur & Aliran Data:**<br>Mampu menjelaskan siklus hidup data mulai dari interaksi UI $\rightarrow$ Cubit $\rightarrow$ Repository $\rightarrow$ Data Source. | 25 | | |
| **2** | **Penguasaan Asynchronous & Exception:**<br>Mampu menjelaskan cara kerja penanganan error (`try-catch`, `DioException`, `StreamSubscription`). | 25 | | |
| **3** | **Tantangan Modifikasi Kode di Tempat (*Live Modification*):**<br>Mampu mengubah warna, menambah validasi, atau memodifikasi output state dalam waktu $\le 5$ menit tanpa bantuan AI. | 35 | | |
| **4** | **Penguasaan Logika Bersih (*Clean Code*):**<br>Mampu mempertanggungjawabkan alasan pemilihan suatu widget atau pola desain tertentu pada kode yang ditulisnya. | 15 | | |
| **Total** | **Skor Penguasaan Individu (0 - 100)** | **100** | | |

---

## 2. Bank Pertanyaan Kritis Ujian Lisan (*Examiner's Question Bank*)

Berikut adalah 10 pertanyaan standar yang digunakan dosen penguji untuk memverifikasi pemahaman otentik mahasiswa:

1. *"Mengapa Anda memilih `BlocBuilder` di bagian ini alih-alih `BlocConsumer` atau `BlocListener`?"*
2. *"Jika server mengembalikan status HTTP 401 Unauthorized, apa yang terjadi di aplikasi Anda? Tunjukkan kodenya!"*
3. *"Coba matikan koneksi internet di smartphone sekarang. Mengapa data profil pengguna masih bisa muncul? Di mana data tersebut disimpan?"*
4. *"Apa yang membedakan `late final` dan `final String?` pada variabel yang Anda deklarasikan di baris ini?"*
5. *"Bagaimana cara kerja caching yang Anda buat? Kapan data lokal diperbarui oleh data server?"*
6. *"Tunjukkan di mana kunci rahasia API disimpan dan buktikan bahwa kunci tersebut tidak bisa dibaca oleh orang lain dari repositori publik GitHub!"*
7. *"Mengapa Anda menggunakan `ListView.builder` dan bukan `SingleChildScrollView(child: Column(...))` untuk daftar barang ini? Apa dampaknya terhadap konsumsi RAM?"*
8. *"Coba ubah pesan error pada validasi form ini agar hanya menerima alamat email kampus `@ac.id` sekarang juga!"*
9. *"Jika method `dispose()` pada controller ini saya hapus, apa resiko yang akan dialami oleh perangkat pengguna?"*
10. *"Jelaskan fungsi dari berkas `analysis_options.yaml` yang Anda pasang di repositori ini!"*

---

## 3. Instrumen Evaluasi Rekan Sejawat (*Peer Review Checklist*)

Mahasiswa mengisi kuesioner rahasia ini untuk setiap rekan dalam kelompoknya:

```text
[FORM EVALUASI RAHASIA ANGGOTA TIM]
Nama Penilai       : ____________________ (NIM: __________)
Nama Rekan Dinilai : ____________________ (NIM: __________)

Berikan nilai skor 1 - 5 pada setiap pernyataan berikut:
[ ] 1. Keaktifan menghadiri pertemuan kelompok dan responsif di grup komunikasi.
[ ] 2. Menyelesaikan porsi modul/fitur kode yang menjadi tanggung jawabnya tepat waktu.
[ ] 3. Kualitas kode yang dihasilkan bersih, rapi, dan mematuhi arsitektur tim.
[ ] 4. Mengajukan Pull Request dan berkontribusi aktif saat pemecahan bug.
[ ] 5. Berkontribusi aktif dalam penyusunan dokumentasi dan persiapan demo expo.

Catatan Jujur / Feedback Khusus untuk Rekan Ini:
"__________________________________________________________________________"
```
