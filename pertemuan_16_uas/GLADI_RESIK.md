# 🎯 Gladi Resik UAS — Pertemuan 16

> 🧪 **Lembar kegiatan** · ⏱️ ± 3 × 50 menit (boleh dicicil dalam seminggu) · 👥 Dikerjakan per tim; Kegiatan 6 bersama tim lain
>
> **Hasil akhir:** repositori yang lolos audit, naskah demo, slide, video demo cadangan, dan pengalaman **satu kali "ujian" lengkap** dengan teman sebagai penguji.

[⬅️ Panduan UAS](README.md) · [✍️ Latihan Persiapan](LATIHAN.md) · [🧰 Templat](templat/) · [💻 Kode Contoh](kode/) · [🏠 Beranda](../README.md)

---

| Komponen | Keterangan |
| :--- | :--- |
| Bekal | Proyek akhir yang sudah dirilis ([Pertemuan 15 Bagian 17](../pertemuan_15_build_rilis_dan_finalisasi/README.md#17-finalisasi-proyek-akhir)), laptop dengan Flutter, HP (jika ada), akun GitHub |
| Alat | [Contoh 02: Pengatur Waktu Presentasi](kode/contoh_02_pengatur_waktu_presentasi.dart), [Contoh 03: Kartu Latihan Tanya Jawab](kode/contoh_03_kartu_latihan_tanya_jawab.dart), [templat](templat/) |
| Hasil akhir | Lembar audit terisi, `NASKAH_DEMO.md`, `KONTRIBUSI_TIM.md`, slide PDF, tautan video cadangan, dan lembar umpan balik dari tim lain |

## 🎯 Tujuan Kegiatan

Setelah gladi resik ini, tim Anda mampu:

1. Memeriksa sendiri kesiapan repositori sebelum diperiksa penguji.
2. Menyusun demo yang bercerita dan selesai tepat waktu.
3. Menyiapkan perangkat, layar, dan rencana cadangan.
4. Menjawab pertanyaan tentang kode sendiri dengan tenang, sambil menunjuk kodenya.

## 📌 Petunjuk Umum

1. Kerjakan kegiatan **berurutan**. Setiap kegiatan diakhiri **✅ Hasil yang diharapkan**; jangan lanjut sebelum hasilnya tercapai.
2. Buat berkas `docs/gladi_resik.md` di repositori proyek untuk mencatat hasil setiap kegiatan. Salin kerangka berikut:

```markdown
# Catatan Gladi Resik: <nama tim>

## Kegiatan 1 — Audit repositori

## Kegiatan 2 — Naskah demo

## Kegiatan 3 — Perangkat

## Kegiatan 4 — Video cadangan

## Kegiatan 5 — Slide

## Kegiatan 6 — Umpan balik dari tim lain

## Kegiatan 7 — Perbaikan
```

3. Semua perintah dijalankan di **terminal VS Code** yang terbuka di folder proyek Anda (menu **Terminal** → **New Terminal**).
4. Proyek individu? Semua kegiatan tetap berlaku. Untuk Kegiatan 6, berpasanganlah dengan mahasiswa lain.

> [!NOTE]
> Gladi resik **tidak dinilai**, kecuali dosen mengumumkan lain. Namun gladi inilah yang paling menentukan kelancaran Anda di hari-H.

---

## Kegiatan 1 — Audit Repositori

**Waktu:** ± 20 menit · **Tujuan:** menemukan kekurangan **sebelum** penguji menemukannya.

### Langkah 1 — Samakan isi laptop dengan GitHub

Setiap anggota menjalankan:

```bash
git status
git pull
```

✅ `git status` menulis `nothing to commit, working tree clean`, dan `git pull` menulis `Already up to date.` (atau mengambil perubahan teman tanpa konflik).

### Langkah 2 — Kode rapi, bersih, dan teruji

```bash
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
```

✅ **Hasil yang diharapkan:**

| Perintah | Baris terakhir yang diharapkan |
| :--- | :--- |
| `dart format ...` | `Formatted N files (0 changed) ...` |
| `flutter analyze` | `No issues found! ...` |
| `flutter test` | `+N: All tests passed!` dengan N ≥ 3 |

Jika `dart format` menyebut berkas yang berubah, jalankan `dart format .`, periksa hasilnya, lalu *commit*.

### Langkah 3 — Riwayat dan kontribusi

```bash
git shortlog -sn --no-merges
git log --pretty=format:"%h %ad %an %s" --date=short -15
git tag
```

| Perintah | Yang diperiksa |
| :--- | :--- |
| `git shortlog -sn --no-merges` | Jumlah *commit* setiap anggota. **Setiap** anggota harus muncul dengan namanya sendiri |
| `git log ... -15` | 15 *commit* terakhir beserta tanggal dan penulisnya. Pekerjaan tersebar dalam beberapa minggu, bukan menumpuk di satu malam |
| `git tag` | Ada *tag* rilis, misalnya `v1.0.0` |

> [!TIP]
> Nama yang sama muncul dua kali dengan ejaan berbeda (misalnya `Rina` dan `rina123`)? Itu karena laptop yang berbeda diatur dengan nama berbeda. Tidak masalah untuk UAS; sebutkan saja di `KONTRIBUSI_TIM.md` bahwa keduanya adalah Anda.

### Langkah 4 — Tidak ada rahasia di repositori

```bash
git ls-files "*.jks" "*.keystore" "*key.properties"
```

✅ Perintah ini **tidak menampilkan apa pun**. Jika muncul nama berkas, **berhenti** dan baca [Pertemuan 15 Bagian 11.5](../pertemuan_15_build_rilis_dan_finalisasi/README.md#115-menjaga-kunci-dua-aturan-mutlak). Periksa juga dengan mata: tidak ada kunci API atau kata sandi di berkas `.dart` ([Pertemuan 10 Bagian 14.4](../pertemuan_10_async_dan_rest_api/README.md#144-kunci-api-jangan-disimpan-di-repositori)).

### Langkah 5 — Periksa di GitHub

Buka repositori Anda di *browser*, lalu periksa:

1. Tab **Actions**: *workflow* terakhir bertanda ✅.
2. **Releases** (kolom kanan halaman depan): rilis terbaru berisi APK, dan/atau tautan versi web terbuka dari HP.
3. Halaman depan: `README.md` tampil lengkap ([Pertemuan 15 Bagian 17.2](../pertemuan_15_build_rilis_dan_finalisasi/README.md#172-readmemd-final)), dengan tangkapan layar yang benar-benar tampil.
4. Berkas `CHANGELOG.md`, `KEBIJAKAN_PRIVASI.md`, dan `KONTRIBUSI_TIM.md` ada. Belum punya `KONTRIBUSI_TIM.md`? Salin dari [templat](templat/KONTRIBUSI_TIM.md) dan isi bersama.

### Langkah 6 — Isi lembar audit

Salin tabel berikut ke `docs/gladi_resik.md`, lalu isi kolom **Hasil** dengan ✅ atau ❌:

| No | Periksa | Hasil | Tindakan jika ❌ |
| :---: | :--- | :---: | :--- |
| 1 | Laptop setiap anggota sama dengan GitHub | | |
| 2 | `dart format` tidak mengubah apa pun | | |
| 3 | `flutter analyze` → `No issues found!` | | |
| 4 | `flutter test` → minimal 3 tes, semuanya lulus | | |
| 5 | Setiap anggota punya *commit* sendiri, tersebar dalam beberapa minggu | | |
| 6 | Ada *tag* rilis | | |
| 7 | Tidak ada `.jks`, `key.properties`, kunci API, atau kata sandi | | |
| 8 | Actions ✅ | | |
| 9 | APK dan/atau versi web bisa dipakai dari HP lain | | |
| 10 | `README.md`, `CHANGELOG.md`, `KEBIJAKAN_PRIVASI.md`, `KONTRIBUSI_TIM.md` lengkap | | |

✅ **Hasil yang diharapkan:** semua baris ✅, atau setiap ❌ sudah punya tindakan dan penanggung jawabnya.

---

## Kegiatan 2 — Peta Demo dan Naskah

**Waktu:** ± 25 menit · **Tujuan:** demo yang bercerita, selesai dalam 5 menit, dengan pembagian peran yang jelas.

### Langkah 1 — Pilih tokoh dan ceritanya

Tuliskan satu kalimat: **siapa** pengguna Anda, **apa** masalahnya, dan **apa** yang ingin ia capai hari itu. Contoh: *"Rara, mahasiswi semester tiga, sering lupa tenggat tugas dari enam mata kuliah."*

### Langkah 2 — Tulis naskahnya

Salin [`templat/NASKAH_DEMO.md`](templat/NASKAH_DEMO.md) ke folder `docs/` di repositori Anda, lalu isi. Ikuti urutan yang disarankan di [Panduan UAS Bagian 5.2](README.md#52-urutan-demo-yang-disarankan): alur utama, data tetap ada, satu keadaan sulit, tampilan, lalu halaman Tentang.

### Langkah 3 — Bandingkan dengan contoh

Berikut contoh naskah untuk "Tugas Kuliahku 1.0.0", aplikasi yang Anda bangun di jobsheet Pertemuan 9–15. Total 5 menit, dengan dua orang: **A** memegang HP, **B** bercerita.

| Menit | Yang ditunjukkan (A) | Yang diucapkan (B) |
| :---: | :--- | :--- |
| 0:00–0:30 | Layar utama HP: ikon "Tugas Kuliahku", lalu dibuka; layar pembuka sesaat | "Ini Rara, mahasiswi semester tiga. Tugasnya dari enam mata kuliah sering terlupa. Ia memakai Tugas Kuliahku." |
| 0:30–1:15 | Ketuk ikon awan **Impor dari server**; muncul pesan "... tugas baru diimpor dari server." | "Tugas dari kelas daring diambil dari server. Jumlah tugas yang belum selesai langsung diperbarui." |
| 1:15–2:15 | **Tambah tugas**: isi *Judul tugas* "Laporan praktikum Basis Data", *Mata kuliah* "Basis Data", prioritas **Tinggi**, lalu **Simpan** | "Tugas baru dari dosen langsung dicatat. Judulnya wajib diisi; kalau kosong, formulir menolak." |
| 2:15–2:45 | Ketik "laporan" di kotak **Cari judul tugas**, lalu chip **Tinggi** | "Rara bisa mencari dan menyaring tugas berdasarkan prioritas." |
| 2:45–3:15 | Centang tugas itu: judulnya tercoret dan jumlah "belum selesai" berkurang | "Tugas yang selesai dicentang." |
| 3:15–3:45 | Tutup aplikasi dari daftar aplikasi terbaru, lalu buka lagi: semua masih ada | "Semua tugas disimpan di database HP, jadi tidak hilang saat aplikasi ditutup." |
| 3:45–4:30 | Nyalakan mode pesawat, ketuk **Impor dari server**: muncul "Tidak dapat terhubung. Periksa koneksi internet Anda." Daftar tetap tampil | "Tanpa internet, hanya impor yang gagal, dengan pesan yang jelas. Tugas yang tersimpan tetap bisa dipakai." |
| 4:30–5:00 | Ketuk ikon ⓘ **Tentang aplikasi**: Versi 1.0.0 (build 1), sumber data, kebijakan privasi, lisensi | "Aplikasi ini versi 1.0.0, bisa diunduh dari halaman rilis GitHub kami. Semua tesnya lulus." |

Perhatikan pola naskah ini: **setiap langkah membuktikan satu syarat** (navigasi, API, penyimpanan, keadaan gagal, rilis), dan setiap kalimat berbicara tentang **pengguna**, bukan tentang tombol.

### Langkah 4 — Bagi peran

Tentukan siapa yang memegang perangkat, siapa yang bercerita, dan siapa yang menjelaskan slide arsitektur. Bergantianlah agar **setiap anggota berbicara**. Penguji ingin mendengar suara semua anggota.

✅ **Hasil yang diharapkan:** `docs/NASKAH_DEMO.md` terisi, total ≤ 5 menit demo (ditambah ≤ 2 menit slide), dan setiap anggota punya bagian bicara.

---

## Kegiatan 3 — Siapkan Perangkat dan Layar

**Waktu:** ± 20 menit · **Tujuan:** perangkat demo siap dan semua permintaan uji langsung sudah pernah dicoba.

### Langkah 1 — HP demo

1. Hapus aplikasi lama, lalu **pasang APK dari halaman rilis GitHub** (berkas yang sama dengan yang diunduh pengguna, bukan hasil `flutter run`).
2. Isi data contoh yang rapi dan realistis.
3. Aktifkan **Jangan Ganggu**, kecerahan penuh, dan perpanjang waktu tunggu layar.
4. Pastikan ukuran huruf sistem kembali normal.

### Langkah 2 — Layar HP ke laptop dengan `scrcpy`

Ikuti [Panduan UAS Bagian 5.5](README.md#55-menampilkan-layar-hp-di-proyektor-dengan-scrcpy) untuk memasang `scrcpy`, lalu sambungkan HP dan jalankan:

```bash
scrcpy --stay-awake
```

✅ Jendela berisi layar HP muncul di laptop, dan Anda bisa mengoperasikan aplikasi dengan *mouse*.

Tidak punya HP Android? Siapkan versi web: buka tautan GitHub Pages Anda di Chrome, lalu perbesar tampilannya dengan `Ctrl` + `+`.

### Langkah 3 — Latih semua permintaan uji langsung

Satu anggota menjadi "penguji" dan membacakan setiap baris tabel [Panduan UAS Bagian 6](README.md#6-uji-langsung-oleh-penguji). Anggota lain memperagakannya. Catat yang belum lancar:

| Permintaan | Sudah lancar? |
| :--- | :---: |
| Matikan internet, lalu muat ulang | |
| Tutup aplikasi, lalu buka lagi | |
| Layar lebar dan layar sempit | |
| Mode gelap | |
| Perbesar huruf | |
| Jalankan `flutter test` dan `flutter analyze` | |
| Tunjukkan halaman Tentang | |
| Pasang dari HP penguji (kode QR atau tautan) | |
| Tunjukkan *commit* masing-masing | |

> [!TIP]
> Agar penguji bisa langsung membuka aplikasi dari HP-nya, ubah tautan halaman rilis atau versi web menjadi **kode QR** (misalnya lewat fitur bagikan di Chrome), lalu tempel gambarnya di slide 5.

✅ **Hasil yang diharapkan:** semua baris tabel "Sudah lancar".

---

## Kegiatan 4 — Video Demo Cadangan

**Waktu:** ± 20 menit · **Tujuan:** rekaman 1–3 menit yang bisa diputar jika perangkat atau jaringan bermasalah di hari-H.

### Langkah 1 — Pilih cara merekam

| Cara | Langkah | Hasil |
| :--- | :--- | :--- |
| **`scrcpy`** (HP Android tersambung ke laptop) | `scrcpy --record=demo_uas.mp4`, peragakan naskah, lalu tutup jendela `scrcpy` untuk berhenti | Berkas `demo_uas.mp4` di folder tempat perintah dijalankan. Suara dari HP ikut terekam; tambahkan `--no-audio` jika tidak perlu |
| **Perekam layar bawaan HP Android** | Usap layar dari atas dua kali, ketuk **Perekam layar** (*Screen record*), pilih pengaturan suara, lalu **Mulai**. Hentikan lewat notifikasi | Video tersimpan di galeri. Nama dan letak menu bisa berbeda di setiap merek HP |
| **Snipping Tool** (Windows 11, untuk versi web) | Buka Snipping Tool, pilih **Rekam** (*Record*) lalu **Baru** (*New*), atau tekan `Windows` + `Shift` + `R`. Pilih area layar, tekan **Mulai** (*Start*), lalu **Berhenti** (*Stop*) dan simpan | Video MP4 di folder pilihan Anda |

### Langkah 2 — Rekam

1. Ikuti naskah dari Kegiatan 2, cukup alur utama dan satu keadaan sulit (1–3 menit).
2. Pastikan tidak ada notifikasi pribadi yang ikut terekam.
3. Tonton ulang sekali. Teks di layar harus terbaca.

### Langkah 3 — Unggah dan uji tautannya

1. Unggah ke Google Drive (atur akses **Siapa saja yang memiliki link**) atau YouTube (visibilitas **Tidak publik**).
2. Buka tautannya dari **perangkat lain** atau jendela penyamaran, untuk memastikan orang lain bisa memutarnya.
3. Simpan tautannya di `docs/gladi_resik.md` dan tambahkan di `README.md` proyek sebagai bagian "Video demo". Video ini juga bagus untuk portofolio Anda.

✅ **Hasil yang diharapkan:** tautan video 1–3 menit yang bisa diputar dari perangkat lain.

---

## Kegiatan 5 — Slide

**Waktu:** ± 20 menit · **Tujuan:** enam slide atau kurang, selesai dibawakan dalam ± 2 menit.

1. Unduh [`templat/TEMPLAT_SLIDE_UAS.pptx`](templat/TEMPLAT_SLIDE_UAS.pptx). Setiap slide punya petunjuk isi di **catatan pembicara** (*speaker notes*).
2. Ganti semua tulisan di dalam tanda `< >`. Pakai tangkapan layar asli aplikasi Anda dan gambar arsitektur yang sederhana.
3. Simpan sebagai PDF bernama `uas_<nama-tim>.pdf`:
   - **PowerPoint:** **File** → **Export** → **Create PDF/XPS Document**.
   - **Google Slides:** **File** → **Download** → **PDF document**.
4. Latih slide dengan [Contoh 02](kode/contoh_02_pengatur_waktu_presentasi.dart): bagian slide harus selesai sebelum menit ke-2.

✅ **Hasil yang diharapkan:** PDF ≤ 6 halaman, huruf terbaca dari belakang kelas, dibawakan ≤ 2 menit.

---

## Kegiatan 6 — Gladi Berpasangan

**Waktu:** ± 50 menit · **Tujuan:** merasakan UAS lengkap satu kali, lalu memperbaikinya dari umpan balik.

Pasangkan tim Anda dengan tim lain: **Tim A** dan **Tim B**.

### Langkah 1 — Bagi peran penguji

Saat Tim A tampil, Tim B menjadi penguji:

| Peran (Tim B) | Tugas | Alat |
| :--- | :--- | :--- |
| Pencatat waktu | Menjalankan pengatur waktu, mengingatkan saat "Hampir habis", mencatat waktu setiap bagian | [Contoh 02](kode/contoh_02_pengatur_waktu_presentasi.dart) |
| Penguji 1 | Mengajukan permintaan uji langsung | [Panduan UAS Bagian 6](README.md#6-uji-langsung-oleh-penguji) |
| Penguji 2 | Mengajukan pertanyaan kepada **setiap** anggota Tim A, termasuk satu pertanyaan silang | [Contoh 03](kode/contoh_03_kartu_latihan_tanya_jawab.dart) dan [Latihan bagian B–C](LATIHAN.md#b-jelaskan-kode-ini) |
| Semua | Mengisi lembar umpan balik | [`templat/LEMBAR_UMPAN_BALIK_GLADI.md`](templat/LEMBAR_UMPAN_BALIK_GLADI.md) |

### Langkah 2 — Jalankan ujian 20 menit

Tim A tampil persis seperti hari-H: slide, demo, uji langsung, tanya jawab. **Jangan berhenti** walaupun ada yang salah; catat saja.

### Langkah 3 — Umpan balik 5 menit

Tim B menyampaikan **dua bintang** (hal yang sudah baik) dan **satu harapan** (hal terpenting untuk diperbaiki), lalu menyerahkan lembar umpan baliknya.

### Langkah 4 — Bertukar peran

Ulangi Langkah 2–3 dengan Tim B yang tampil.

✅ **Hasil yang diharapkan:** setiap tim memegang lembar umpan balik dari tim lain, dan setiap anggota sudah menjawab minimal tiga pertanyaan.

---

## Kegiatan 7 — Perbaikan Terakhir dan Rilis 1.0.1 (Opsional)

**Waktu:** ± 20 menit · **Tujuan:** memperbaiki temuan gladi **dengan cara rilis yang benar**.

Jika gladi menemukan *bug* yang perlu diperbaiki:

1. Perbaiki kodenya, lalu tambahkan tes yang menjaga *bug* itu agar tidak kembali ([Pertemuan 14 Bagian 16](../pertemuan_14_pengujian_dan_debugging/README.md#16-pengujian-untuk-proyek-akhir)).
2. Naikkan versi di `pubspec.yaml`, misalnya dari `1.0.0+1` menjadi `1.0.1+2` ([Pertemuan 15 Bagian 5](../pertemuan_15_build_rilis_dan_finalisasi/README.md#5-identitas-aplikasi-2-nomor-versi)).
3. Tambahkan bagian `## [1.0.1] - <tanggal>` di `CHANGELOG.md`, di bawah judul **Diperbaiki**.
4. Periksa, *commit*, buat *tag*, lalu kirim:

```bash
dart format .
flutter analyze
flutter test
git add -A
git commit -m "Perbaiki <hal yang diperbaiki>"
git tag -a v1.0.1 -m "Rilis 1.0.1: perbaikan setelah gladi resik"
git push
git push origin v1.0.1
```

5. Tunggu *workflow* rilis selesai di tab **Actions**, lalu pasang APK `1.0.1` di HP demo dan periksa halaman Tentang. Muncul pesan *paket bentrok*? Hapus dulu versi lama dari HP ([Troubleshooting bagian J](../panduan/04_troubleshooting.md#j-masalah-build-dan-rilis)).

✅ **Hasil yang diharapkan:** halaman Tentang di HP demo menulis **Versi 1.0.1 (build 2)**, dan rilis `v1.0.1` muncul di GitHub.

---

## 📤 Pengumpulan

Gladi resik tidak dikumpulkan, kecuali dosen memintanya. Yang **wajib** dikumpulkan sebelum UAS tercantum di [Panduan UAS Bagian 12](README.md#12-yang-dikumpulkan-sebelum-uas): tautan repositori dengan *tag*, tautan rilis atau web, slide PDF, tautan video cadangan, dan `KONTRIBUSI_TIM.md` di repositori.

## 💭 Refleksi

Jawab di `docs/gladi_resik.md`:

1. Bagian mana dari gladi yang paling membuat Anda gugup? Apa yang akan Anda latih lagi?
2. Pertanyaan apa dari tim lain yang belum bisa Anda jawab dengan baik? Bagian modul mana yang perlu dibaca ulang?
3. Jika waktu demo tinggal 3 menit, bagian naskah mana yang Anda pertahankan, dan mana yang Anda lewati?

---

[⬅️ Kembali ke Panduan UAS](README.md) · [✍️ Lanjut ke Latihan Persiapan](LATIHAN.md) · [🏠 Beranda](../README.md)
