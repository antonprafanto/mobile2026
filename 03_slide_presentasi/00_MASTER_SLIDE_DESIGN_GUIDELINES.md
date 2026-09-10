# MASTER SLIDE DESIGN GUIDELINES & PEDOMAN PRESENTASI DOSEN
## Standar Desain Bahan Tayang Mata Kuliah Pemrograman Piranti Bergerak

---

## 1. Format & Aspek Teknis Slide

* **Rasio Layar:** **16:9** (Standar proyektor lab dan layar modern).
* **Gaya Desain Resmi:** **Neo-Brutalism** (Mengacu pada standar `designprompts.dev/neo-brutalism`).
* **Karakteristik Kunci Neo-Brutalism:**
  1. **ZERO BORDER RADIUS (Tanpa Sudut Melengkung):** Seluruh card, tag badge, dan container wajib menggunakan sudut siku-siku 90 derajat tajam (`MSO_SHAPE.RECTANGLE`). Dilarang keras menggunakan `ROUNDED_RECTANGLE`!
  2. **BOLD SOLID BLACK BORDERS:** Setiap elemen dibatasi oleh garis tepi hitam solid setebal `2.5 Pt - 3 Pt` (`#000000`).
  3. **HARD OFFSET BLOCK SHADOWS:** Tidak menggunakan bayangan buram (*no blurry drop shadows*). Gunakan bayangan blok hitam pekat yang bergeser sejauh `+6px` secara horizontal dan vertikal di belakang kartu.
  4. **VIBRANT HIGH-CONTRAST ACCENTS:**
     * Latar Belakang Kanvas: *Warm Cream Canvas* (`#FAF8F5`).
     * Kartu Konten: *Pure White* (`#FFFFFF`).
     * Aksen Saturated Pop: *Canary Yellow* (`#FFE600`), *Electric Cyan* (`#38BDF8`), *Neo Mint* (`#4ADE80`), *Neo Coral* (`#FB7185`), *Lavender* (`#C084FC`).
     * Box Kode: *Deep Solid Black* (`#121212`) dengan bar header kuning dan teks monospace mint.

---

## 2. Prinsip "Anti-Boring Lecturer": Aturan 30-40-30

1. **30% - Konseptual & Kasus Nyata (The "Why"):**
   * Jangan langsung memulai dengan sintaks. Awali dengan: *"Mengapa aplikasi Tokopedia butuh fitur ini?"* atau *"Apa masalahnya jika kita membuat kode seperti ini?"*.
2. **40% - Diagram Mental Model & Visual Tree:**
   * Tampilkan pohon widget (*Widget Tree*), aliran data reaktif (*Data Stream Flow*), atau layer arsitektur. Otak manusia memproses gambar arsitektur jauh lebih cepat daripada teks paragraf.
3. **30% - Cuplikan Kode Berwarna (Syntax-Highlighted Snippets):**
   * Batasi maksimal 15 baris kode per slide.
   * Gunakan penanda kotak kuning/merah pada baris yang sedang dibahas. Hindari menaruh 50 baris kode dalam 1 slide dengan font kecil.

---

## 3. Struktur Baku Setiap Slide Deck (Pertemuan)

Setiap deck pertemuan (rata-rata 25–30 slide) harus memiliki alur narasi:
1. **The Hook (Slide 1–3):** Problem nyata di aplikasi populer.
2. **Mental Model & Konsep (Slide 4–8):** Visualisasi cara kerja di balik layar (Flutter Engine/Dart VM).
3. **Live Code Demo Step-by-Step (Slide 9–18):** Tahapan yang dipraktikkan dosen di depan kelas.
4. **Common Pitfalls & Anti-Patterns (Slide 19–22):** Kesalahan fatal yang sering dilakukan pemula (dan cara mendebugnya).
5. **Hands-on Quest (Slide 23–25):** Tantangan praktikum berdurasi 30–45 menit untuk mahasiswa di lab.
