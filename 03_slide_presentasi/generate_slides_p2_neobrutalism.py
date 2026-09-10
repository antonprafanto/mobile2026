"""
Generator Slide Pertemuan 02 (Edisi Masterpiece 16 Slide Lengkap & Komprehensif)
Mata Kuliah: Pemrograman Piranti Bergerak (Flutter & Dart 2026)
Standar Desain: Neo-Brutalism Murni (designprompts.dev/neo-brutalism)
- ZERO BORDER RADIUS: Sudut 90 derajat siku murni tanpa kelengkungan (MSO_SHAPE.RECTANGLE).
- BOLD SOLID BLACK BORDERS: Garis hitam tegas 2.5 Pt (#000000).
- HARD OFFSET BLOCK SHADOWS: Bayangan blok hitam solid +0.08 inch di belakang kartu.
- PALET NEO-BRUTALISM: Warm Cream (#FAF8F5), Canary Yellow (#FFE600), Electric Cyan (#38BDF8), Mint (#4ADE80), Coral (#FB7185), Lavender (#C084FC).
- FITUR UTAMA: 100% SLIDE PEMBAHASAN DISERTAI KODE NYATA DARTPAD/VS CODE, ANALOGI MEMBUMI, DAN TIPS PRAKTIK.
"""

import os
from pptx import Presentation
from pptx.util import Inches, Pt
from pptx.dml.color import RGBColor
from pptx.enum.shapes import MSO_SHAPE

# --- PALET WARNA NEO-BRUTALISM ---
COLOR_BG = RGBColor(250, 248, 245)        # #FAF8F5 (Warm Cream Canvas)
COLOR_BLACK = RGBColor(0, 0, 0)           # #000000 (Pure Black Border & Hard Shadows)
COLOR_WHITE = RGBColor(255, 255, 255)     # #FFFFFF (Pure White Card)
COLOR_YELLOW = RGBColor(255, 230, 0)      # #FFE600 (Canary Yellow)
COLOR_CYAN = RGBColor(56, 189, 248)       # #38BDF8 (Electric Cyan)
COLOR_MINT = RGBColor(74, 222, 128)       # #4ADE80 (Neo Mint / Green)
COLOR_CORAL = RGBColor(251, 113, 133)     # #FB7185 (Neo Coral / Pink)
COLOR_PURPLE = RGBColor(192, 132, 252)    # #C084FC (Lavender Purple)
COLOR_CODE_BG = RGBColor(18, 18, 18)      # #121212 (Deep Black Code Box)
COLOR_CODE_TEXT = RGBColor(245, 245, 245) # #F5F5F5 (Crisp Monospace)

FONT_HEADING = "Segoe UI"
FONT_BODY = "Segoe UI"
FONT_CODE = "Consolas"

SHADOW_OFFSET = Inches(0.08)
GITHUB_BASE_URL = "https://github.com/antonprafanto/mobile2026/blob/main/07_contoh_kode_program/pertemuan_02_modern_dart"

class NeoBrutalistDeckBuilder:
    def __init__(self, course_name="IF3205 • PEMROGRAMAN PIRANTI BERGERAK"):
        self.prs = Presentation()
        self.prs.slide_width = Inches(13.333)
        self.prs.slide_height = Inches(7.5)
        self.blank_layout = self.prs.slide_layouts[6]
        self.course_name = course_name

    def _set_canvas_bg(self, slide):
        bg = slide.shapes.add_shape(
            MSO_SHAPE.RECTANGLE, 0, 0, self.prs.slide_width, self.prs.slide_height
        )
        bg.fill.solid()
        bg.fill.fore_color.rgb = COLOR_BG
        bg.line.fill.background()
        return bg

    def _add_neobrutal_card(self, slide, x, y, w, h, fill_color=COLOR_WHITE, has_shadow=True, border_width=Pt(2.5)):
        if has_shadow:
            shadow = slide.shapes.add_shape(
                MSO_SHAPE.RECTANGLE, x + SHADOW_OFFSET, y + SHADOW_OFFSET, w, h
            )
            shadow.fill.solid()
            shadow.fill.fore_color.rgb = COLOR_BLACK
            shadow.line.fill.background()

        card = slide.shapes.add_shape(
            MSO_SHAPE.RECTANGLE, x, y, w, h
        )
        card.fill.solid()
        card.fill.fore_color.rgb = fill_color
        card.line.color.rgb = COLOR_BLACK
        card.line.width = border_width
        return card

    def _add_header(self, slide, tag, title, tag_color=COLOR_YELLOW):
        tag_w = Inches(len(tag) * 0.125 + 0.6)
        self._add_neobrutal_card(slide, Inches(0.9), Inches(0.4), tag_w, Inches(0.4), fill_color=tag_color, has_shadow=True)
        tb_tag = slide.shapes.add_textbox(Inches(0.9), Inches(0.4), tag_w, Inches(0.4))
        p_tag = tb_tag.text_frame.paragraphs[0]
        p_tag.text = tag.upper()
        p_tag.font.name = FONT_HEADING
        p_tag.font.size = Pt(11)
        p_tag.font.bold = True
        p_tag.font.color.rgb = COLOR_BLACK

        tb_title = slide.shapes.add_textbox(Inches(0.9), Inches(0.88), Inches(11.5), Inches(0.8))
        p_title = tb_title.text_frame.paragraphs[0]
        p_title.text = title
        p_title.font.name = FONT_HEADING
        p_title.font.size = Pt(21)
        p_title.font.bold = True
        p_title.font.color.rgb = COLOR_BLACK

    # 1. Slide Cover
    def add_cover(self, meeting_num, title, subtitle, presenter_info):
        slide = self.prs.slides.add_slide(self.blank_layout)
        self._set_canvas_bg(slide)

        self._add_neobrutal_card(slide, Inches(0.9), Inches(0.9), Inches(11.533), Inches(5.7), fill_color=COLOR_WHITE)

        tb = slide.shapes.add_textbox(Inches(1.4), Inches(1.3), Inches(10.5), Inches(4.8))
        tf = tb.text_frame
        tf.word_wrap = True

        p0 = tf.paragraphs[0]
        p0.text = f"✦ {self.course_name.upper()} • PERTEMUAN {meeting_num:02d} ✦"
        p0.font.name = FONT_HEADING
        p0.font.size = Pt(12)
        p0.font.bold = True
        p0.font.color.rgb = COLOR_BLACK
        p0.space_after = Pt(18)

        p1 = tf.add_paragraph()
        p1.text = title
        p1.font.name = FONT_HEADING
        p1.font.size = Pt(31)
        p1.font.bold = True
        p1.font.color.rgb = COLOR_BLACK
        p1.space_after = Pt(14)

        p2 = tf.add_paragraph()
        p2.text = subtitle
        p2.font.name = FONT_BODY
        p2.font.size = Pt(15)
        p2.font.color.rgb = RGBColor(60, 60, 60)
        p2.space_after = Pt(40)

        p3 = tf.add_paragraph()
        p3.text = f"■  {presenter_info}  ■  OUTCOME-BASED EDUCATION (OBE)"
        p3.font.name = FONT_HEADING
        p3.font.size = Pt(12)
        p3.font.bold = True
        p3.font.color.rgb = COLOR_BLACK

    # 2. Slide Split Screen: Konsep & Tips di Kiri + Kode Sederhana di Kanan
    def add_concept_with_code(self, tag, title, bullets, code_snippet, filename="latihan.dart", tip=None, tag_color=COLOR_YELLOW, full_code_file=None):
        slide = self.prs.slides.add_slide(self.blank_layout)
        self._set_canvas_bg(slide)
        self._add_header(slide, tag, title, tag_color=tag_color)

        # Left Explanations Card (4.9 Inches)
        self._add_neobrutal_card(slide, Inches(0.9), Inches(1.8), Inches(4.9), Inches(5.1), fill_color=COLOR_WHITE)

        tb_l = slide.shapes.add_textbox(Inches(1.15), Inches(1.95), Inches(4.4), Inches(4.8))
        tf_l = tb_l.text_frame
        tf_l.word_wrap = True

        p_lt = tf_l.paragraphs[0]
        p_lt.text = "KONSEP & CARA KERJA"
        p_lt.font.name = FONT_HEADING
        p_lt.font.size = Pt(11.5)
        p_lt.font.bold = True
        p_lt.font.color.rgb = COLOR_BLACK
        p_lt.space_after = Pt(8)

        for b in bullets:
            p = tf_l.add_paragraph()
            p.text = f"■  {b}"
            p.font.name = FONT_BODY
            p.font.size = Pt(11)
            p.font.color.rgb = RGBColor(20, 20, 20)
            p.space_after = Pt(6)

        if tip:
            p_tip = tf_l.add_paragraph()
            p_tip.text = f"💡 Tips Praktik: {tip}"
            p_tip.font.name = FONT_HEADING
            p_tip.font.size = Pt(10.5)
            p_tip.font.bold = True
            p_tip.font.color.rgb = COLOR_BLACK

        # Right Sharp Black Code Box (6.433 Inches)
        self._add_neobrutal_card(slide, Inches(6.0), Inches(1.8), Inches(6.433), Inches(5.1), fill_color=COLOR_CODE_BG)

        # Yellow Code Header Strip
        c_bar = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, Inches(6.0), Inches(1.8), Inches(6.433), Inches(0.48))
        c_bar.fill.solid()
        c_bar.fill.fore_color.rgb = COLOR_YELLOW
        c_bar.line.color.rgb = COLOR_BLACK
        c_bar.line.width = Pt(2.5)

        tb_cb = slide.shapes.add_textbox(Inches(6.2), Inches(1.86), Inches(6.0), Inches(0.38))
        p_cb = tb_cb.text_frame.paragraphs[0]
        p_cb.text = f"{filename}  |  DART CODE RUNNABLE"
        p_cb.font.name = FONT_CODE
        p_cb.font.size = Pt(10.5)
        p_cb.font.bold = True
        p_cb.font.color.rgb = COLOR_BLACK

        code_box_h = Inches(3.68) if full_code_file else Inches(4.35)
        tb_r = slide.shapes.add_textbox(Inches(6.2), Inches(2.32), Inches(6.0), code_box_h)
        tf_r = tb_r.text_frame
        tf_r.word_wrap = True

        p_code = tf_r.paragraphs[0]
        p_code.text = code_snippet
        p_code.font.name = FONT_CODE
        p_code.font.size = Pt(9.2)
        p_code.font.color.rgb = COLOR_CODE_TEXT

        # Neo-Brutalist Runnable Code Hyperlink Button at Bottom of Right Box
        if full_code_file:
            btn_x = Inches(6.15)
            btn_y = Inches(6.16)
            btn_w = Inches(6.133)
            btn_h = Inches(0.60)

            # Button Shadow (Neo-Brutalism offset)
            btn_shadow = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, btn_x + Inches(0.04), btn_y + Inches(0.04), btn_w, btn_h)
            btn_shadow.fill.solid()
            btn_shadow.fill.fore_color.rgb = COLOR_BLACK
            btn_shadow.line.fill.background()

            # Button Face
            btn = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, btn_x, btn_y, btn_w, btn_h)
            btn.fill.solid()
            btn.fill.fore_color.rgb = COLOR_YELLOW
            btn.line.color.rgb = COLOR_BLACK
            btn.line.width = Pt(2.0)

            tb_btn = slide.shapes.add_textbox(btn_x + Inches(0.08), btn_y + Inches(0.03), btn_w - Inches(0.16), btn_h - Inches(0.06))
            tf_btn = tb_btn.text_frame
            tf_btn.word_wrap = True

            p_btn = tf_btn.paragraphs[0]
            run_btn = p_btn.add_run()
            run_btn.text = f"▶ BUKA KODE LENGKAP DI GITHUB ({full_code_file})"
            run_btn.font.name = FONT_HEADING
            run_btn.font.size = Pt(9.6)
            run_btn.font.bold = True
            run_btn.font.color.rgb = COLOR_BLACK
            run_btn.hyperlink.address = f"{GITHUB_BASE_URL}/{full_code_file}"

            p_btn_sub = tf_btn.add_paragraph()
            p_btn_sub.text = f"💡 Buka di browser / salin source code: github.com/antonprafanto/mobile2026"
            p_btn_sub.font.name = FONT_BODY
            p_btn_sub.font.size = Pt(7.6)
            p_btn_sub.font.color.rgb = RGBColor(60, 60, 60)

    # 3. Slide Lab Quest
    def add_lab_quest(self, meeting_num, title, time_minutes, goals, success_criteria, full_code_file="slide_16_lab_quest_tugas_02.dart"):
        slide = self.prs.slides.add_slide(self.blank_layout)
        self._set_canvas_bg(slide)
        self._add_header(slide, "LAB QUEST MANDIRI", f"Pertemuan {meeting_num:02d}: {title}", tag_color=COLOR_YELLOW)

        self._add_neobrutal_card(slide, Inches(0.9), Inches(1.8), Inches(11.533), Inches(5.1), fill_color=COLOR_WHITE)

        banner = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, Inches(0.9), Inches(1.8), Inches(11.533), Inches(0.52))
        banner.fill.solid()
        banner.fill.fore_color.rgb = COLOR_YELLOW
        banner.line.color.rgb = COLOR_BLACK
        banner.line.width = Pt(2.5)

        tb_b = slide.shapes.add_textbox(Inches(1.2), Inches(1.85), Inches(10.9), Inches(0.45))
        p_b = tb_b.text_frame.paragraphs[0]
        p_b.text = f"⏱️ ALOKASI: {time_minutes} MENIT  ■  TARGET UJI: DARTPAD (BROWSER) ATAU VS CODE TERMINAL"
        p_b.font.name = FONT_HEADING
        p_b.font.size = Pt(11.5)
        p_b.font.bold = True
        p_b.font.color.rgb = COLOR_BLACK

        tb = slide.shapes.add_textbox(Inches(1.3), Inches(2.42), Inches(10.7), Inches(3.6))
        tf = tb.text_frame
        tf.word_wrap = True

        p1 = tf.paragraphs[0]
        p1.text = "Checklist Langkah Praktikum di Lab:"
        p1.font.name = FONT_HEADING
        p1.font.size = Pt(13.5)
        p1.font.bold = True
        p1.font.color.rgb = COLOR_BLACK
        p1.space_after = Pt(4)

        for g in goals:
            p = tf.add_paragraph()
            p.text = f"  [  ]   {g}"
            p.font.name = FONT_BODY
            p.font.size = Pt(10.5)
            p.font.color.rgb = RGBColor(30, 30, 30)
            p.space_after = Pt(2)

        p_crit = tf.add_paragraph()
        p_crit.text = f"✔ Kriteria Keberhasilan (Tunjukkan ke Dosen/Asisten Lab): {success_criteria}"
        p_crit.font.name = FONT_HEADING
        p_crit.font.size = Pt(11)
        p_crit.font.bold = True
        p_crit.font.color.rgb = RGBColor(0, 130, 60)

        # Bottom full code button for Lab Quest
        if full_code_file:
            btn_x = Inches(1.3)
            btn_y = Inches(6.16)
            btn_w = Inches(10.7)
            btn_h = Inches(0.55)

            btn_shadow = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, btn_x + Inches(0.04), btn_y + Inches(0.04), btn_w, btn_h)
            btn_shadow.fill.solid()
            btn_shadow.fill.fore_color.rgb = COLOR_BLACK
            btn_shadow.line.fill.background()

            btn = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, btn_x, btn_y, btn_w, btn_h)
            btn.fill.solid()
            btn.fill.fore_color.rgb = COLOR_MINT
            btn.line.color.rgb = COLOR_BLACK
            btn.line.width = Pt(2.0)

            tb_btn = slide.shapes.add_textbox(btn_x + Inches(0.08), btn_y + Inches(0.03), btn_w - Inches(0.16), btn_h - Inches(0.06))
            tf_btn = tb_btn.text_frame
            tf_btn.word_wrap = True

            p_btn = tf_btn.paragraphs[0]
            run_btn = p_btn.add_run()
            run_btn.text = f"▶ BUKA KODE SOLUSI LENGKAP LAB QUEST DI GITHUB ({full_code_file})"
            run_btn.font.name = FONT_HEADING
            run_btn.font.size = Pt(10)
            run_btn.font.bold = True
            run_btn.font.color.rgb = COLOR_BLACK
            run_btn.hyperlink.address = f"{GITHUB_BASE_URL}/{full_code_file}"

            p_btn_sub = tf_btn.add_paragraph()
            p_btn_sub.text = f"💡 Buka di browser / salin source code: github.com/antonprafanto/mobile2026"
            p_btn_sub.font.name = FONT_BODY
            p_btn_sub.font.size = Pt(8.0)
            p_btn_sub.font.color.rgb = RGBColor(60, 60, 60)

    def save(self, filepath):
        self.prs.save(filepath)
        print(f"[OK] Slide Pertemuan 02 Berhasil Disimpan: {filepath}")


# =====================================================================
# PEMBUATAN 16 SLIDE MASTERPIECE PERTEMUAN 02
# =====================================================================

output_dir = os.path.dirname(os.path.abspath(__file__))
deck2 = NeoBrutalistDeckBuilder()

# ---------------------------------------------------------------------
# Slide 1: Cover
# ---------------------------------------------------------------------
deck2.add_cover(
    2,
    "Pemrograman Modern Dart:\nLogika, Null Safety, & Asinkron",
    "Menyelami bahasa di balik Flutter: sistem tipe data modern, menjinakkan galat null pointer, rekayasa OOP konstruktor, dan aliran data reaktif Future & Stream.",
    "Program Studi Teknik Informatika"
)

# ---------------------------------------------------------------------
# Slide 2: Tempat Menguji Kode (Tools)
# ---------------------------------------------------------------------
deck2.add_concept_with_code(
    "PANDUAN PRAKTIK",
    "Di Mana Kita Mengetik & Menguji Kode Hari Ini?",
    [
        "Opsi 1 (Paling Ringan & Instan): Buka browser dan kunjungi dartpad.dev. Bisa langsung ngoding dan tekan tombol 'Run' tanpa instalasi!",
        "Opsi 2 (Lokal di Laptop): Buat berkas 'latihan.dart' di VS Code, buka terminal (Ctrl + `), lalu ketik 'dart run latihan.dart'.",
        "Tips Dosen: Pasang ekstensi 'Dart' di VS Code. Tombol 'Run' kecil akan otomatis muncul di atas fungsi void main()!"
    ],
    """// Buka https://dartpad.dev di browser Anda,
// atau buat file 'latihan.dart' di VS Code:

void main() {
  print('Halo Dart 2026!');
  print('Siap belajar logika pemrograman modern!');
}

// Cara menjalankan di terminal lokal:
// $ dart run latihan.dart""",
    filename="terminal_dartpad.sh",
    tip="Gunakan DartPad jika laptop lab sedang lemot atau belum terpasang Flutter SDK!",
    tag_color=COLOR_MINT,
    full_code_file="slide_02_tools_dan_environment.dart"
)

# ---------------------------------------------------------------------
# Slide 3: Mindset Pemula: Mengapa Harus Paham Dart Dulu?
# ---------------------------------------------------------------------
deck2.add_concept_with_code(
    "MINDSET PEMULA",
    "Mengapa Kita Wajib Memahami Dart Terlebih Dahulu?",
    [
        "Banyak mahasiswa langsung ingin bikin UI warna-warni tanpa paham logika Dart.",
        "Analogi Kendaraan: Flutter adalah bodi mobil, jok empuk, dan warna cat menawan. Dart adalah mesin bensin, aki, dan kabel transmisinya.",
        "Fakta Industri: Lebih dari 90% bug aplikasi mobile bukan karena salah memilih tombol, melainkan karena salah mengolah data logika!",
        "Dart dibuat oleh Google khusus untuk antarmuka pengguna yang cepat dan reaktif."
    ],
    """// Tanpa logika Dart, tombol UI hanyalah pajangan mati:
void main() {
  final hargaBarang = 50000;
  final diskon = 0.20; // 20%
  
  // Logika perhitungan harga akhir:
  final totalBayar = hargaBarang - (hargaBarang * diskon);
  
  print('Total bayar di kasir: Rp $totalBayar');
}""",
    filename="mindset_dart.dart",
    tip="Logika Dart yang kuat akan membuat Anda sangat mudah menguasai State Management di Minggu ke-6!",
    tag_color=COLOR_YELLOW,
    full_code_file="slide_03_mindset_dart_logika.dart"
)

# ---------------------------------------------------------------------
# Slide 4: Variabel & Tipe Data Modern: var, final, dan const
# ---------------------------------------------------------------------
deck2.add_concept_with_code(
    "DASAR BAHASA",
    "Variabel & Tipe Data: var, final, dan const",
    [
        "Tipe Data Utama: int (bilangan bulat), double (desimal), String (teks), dan bool (true/false).",
        "Kata Kunci var: Dart otomatis menebak tipe datanya (Type Inference).",
        "final vs const (Krusial di Flutter!):",
        "- final: Nilainya dikunci satu kali saat program berjalan / runtime (misal: waktu saat ini atau data API).",
        "- const: Nilainya sudah mutlak pasti sejak sebelum program dikompilasi (misal: nilai Pi = 3.14)."
    ],
    """void main() {
  String nama = 'Kopi Kampus';
  var harga = 18000;      // otomatis int
  var rating = 4.8;       // otomatis double
  var isBuka = true;      // otomatis bool

  // final vs const:
  final jamOrder = DateTime.now(); // ditaksir saat runtime
  const double pajak = 0.11;       // mutlak 11% selamanya

  print('$nama - Rp $harga (Pajak: $pajak) @ $jamOrder');
}""",
    filename="variabel_dasar.dart",
    tip="Di Flutter, selalu pasang 'const' pada widget statis agar performa aplikasi sangat hemat RAM!",
    tag_color=COLOR_CYAN,
    full_code_file="slide_04_variabel_dan_tipe_data.dart"
)

# ---------------------------------------------------------------------
# Slide 5: Sound Null Safety (Menghabisi "Billion-Dollar Mistake")
# ---------------------------------------------------------------------
deck2.add_concept_with_code(
    "KEAMANAN DATA",
    "Sound Null Safety: Analogi Kotak Kado",
    [
        "Tony Hoare (1965) menyebut nilai null tanpa pengaman sebagai 'Billion-Dollar Mistake' karena memicu jutaan aplikasi crash.",
        "Non-nullable (Bawaan): Variabel WAJIB ada isinya. Kompilator menolak keras nilai null.",
        "Nullable (Tanda Tanya ?): Kotak yang BOLEH kosong/null.",
        "Analogi: Non-nullable adalah kotak makan siang yang wajib ada nasinya; Nullable adalah kotak bekal yang wajar jika kosong."
    ],
    """void main() {
  // 1. Non-nullable: Wajib ada isinya!
  String namaMahasiswa = 'Rian Syah';
  // namaMahasiswa = null; // ❌ ERROR KOMPILATOR!

  // 2. Nullable (?): Boleh bernilai null
  String? catatanDiet; // default bernilai null
  print('Catatan awal: $catatanDiet'); // null

  catatanDiet = 'Kurangi gula dan es batu';
  print('Catatan baru: $catatanDiet');
}""",
    filename="null_safety_intro.dart",
    tip="Gunakan tanda tanya (?) hanya pada data yang memang wajar jika tidak diisi oleh pengguna!",
    tag_color=COLOR_CORAL,
    full_code_file="slide_05_sound_null_safety.dart"
)

# ---------------------------------------------------------------------
# Slide 6: Operator Penjinak Null: ?., ??, !, dan late
# ---------------------------------------------------------------------
deck2.add_concept_with_code(
    "OPERATOR PENJINAK NULL",
    "Empat Operator Sakti Pengaman Data Kosong",
    [
        "1. Operator ?. (Safe Navigation): Akses properti hanya jika datanya tidak null (tidak akan crash!).",
        "2. Operator ?? (Default Fallback): Berikan nilai pengganti cadangan jika datanya null.",
        "3. Operator ! (Force Unwrap): Memaksa program percaya data ada. AWAS: Rawan crash jika ternyata null!",
        "4. Kata Kunci late: Janji kepada Dart bahwa variabel akan diisi nilainya sebelum dipanggil."
    ],
    """void main() {
  String? emailUser; // bernilai null

  // 1. Safe Navigation (?.)
  print('Panjang email: ${emailUser?.length}'); // null (aman!)

  // 2. Default Fallback (??)
  String tampilan = emailUser ?? 'email.belum@disetel.com';
  print('Email tampil: $tampilan');

  // 3. late keyword
  late String tokenRahasia;
  tokenRahasia = 'XYZ-998877'; // diisi nanti
  print('Token: $tokenRahasia');
}""",
    filename="null_operators.dart",
    tip="Hindari memakai tanda seru (!) jika Anda tidak 100% yakin datanya pasti ada!",
    tag_color=COLOR_YELLOW,
    full_code_file="slide_06_operator_penjinak_null.dart"
)

# ---------------------------------------------------------------------
# Slide 7: Sintaks Ringkas: Fat Arrow Functions (=>)
# ---------------------------------------------------------------------
deck2.add_concept_with_code(
    "SINTAKS ELEGAN",
    "Fat Arrow Functions (=>): Ringkas 1 Baris",
    [
        "Di Flutter, Anda akan melihat tanda panah tebal '=>' di hampir semua berkas kode.",
        "Tanda panah fat arrow '=>' adalah singkatan resmi dari kurung kurawal '{ return ...; }'.",
        "Hanya boleh digunakan untuk fungsi yang memiliki TEPAT SATU ekspresi baris perintah.",
        "Membuat kode Anda sangat bersih, mudah dibaca, dan tidak penuh dengan kurung kurawal bersarang."
    ],
    """// Cara Konvensional (Panjang & Berbelit):
int kaliDuaTradisional(int x) {
  return x * 2;
}

// Cara Modern Dart (Fat Arrow =>):
int kaliDua(int x) => x * 2;

// Sangat populer di fungsi main Flutter:
void main() => print('Hasil 10 x 2 = ${kaliDua(10)}');""",
    filename="fat_arrow_demo.dart",
    tip="Gunakan fat arrow '=>' untuk fungsi sederhana agar kode Flutter Anda terlihat profesional!",
    tag_color=COLOR_MINT,
    full_code_file="slide_07_fat_arrow_functions.dart"
)

# ---------------------------------------------------------------------
# Slide 8: OOP Modern 1: Named Parameters ({ })
# ---------------------------------------------------------------------
deck2.add_concept_with_code(
    "OOP DASAR",
    "Class, Constructor, & Named Parameters",
    [
        "Mengapa Named Parameters ({ }) Sangat Penting di Flutter?",
        "Di bahasa C++/Java: Mahasiswa('Budi', 20, true). Urutan angka dan boolean sangat mudah tertukar dan memicu bug!",
        "Di Dart: Kita bungkus parameter dengan kurung kurawal {required this.nama, this.usia}.",
        "Pemanggilan menjadi: Mahasiswa(nama: 'Budi', usia: 20). Inilah gaya penulisan 100% widget Flutter!"
    ],
    """class ProdukKatalog {
  final String nama;
  final int harga;
  final bool isTersedia;

  // Constructor modern dengan named parameters
  ProdukKatalog({
    required this.nama,
    required this.harga,
    this.isTersedia = true, // default value
  });
}

void main() {
  // Sangat mudah dibaca & parameter tidak mungkin tertukar!
  final kopi = ProdukKatalog(nama: 'Kopi Espresso', harga: 22000);
  print('${kopi.nama} - Rp ${kopi.harga} (Ready: ${kopi.isTersedia})');
}""",
    filename="oop_named_params.dart",
    tip="Semua widget seperti Text(data), Container(padding: ...), Row(children: ...) memakai named parameters!",
    tag_color=COLOR_CYAN,
    full_code_file="slide_08_oop_named_parameters.dart"
)

# ---------------------------------------------------------------------
# Slide 9: OOP Modern 2: Mixins (with)
# ---------------------------------------------------------------------
deck2.add_concept_with_code(
    "OOP LANJUTAN 1",
    "Mixins ('with'): Menambah Kemampuan Tanpa Warisan Kaku",
    [
        "Masalah Pewarisan Klasik: Bahasa Dart tidak mendukung *multiple inheritance* (1 anak punya 2 bapak class).",
        "Solusi Cerdas: Gunakan 'mixin'.",
        "Mixin adalah sekeranjang kemampuan/fitur tambahan yang bisa ditempelkan ke class mana pun menggunakan kata kunci 'with'.",
        "Di Flutter: Wajib dipakai saat membuat animasi (SingleTickerProviderStateMixin)."
    ],
    """// Sekeranjang kemampuan mencatat log:
mixin PencatatLog {
  void rekam(String pesan) => print('📝 LOG AKTIVITAS: $pesan');
}

class KasirPembayaran with PencatatLog {
  void bayar(int nominal) {
    rekam('Transaksi berhasil senilai Rp $nominal');
  }
}

void main() {
  final kasir = KasirPembayaran();
  kasir.bayar(75000); // Memiliki method dari mixin!
}""",
    filename="mixins_demo.dart",
    tip="Anggap mixin seperti ransel perkakas: class Anda bisa memakai ransel itu kapan saja dibutuhkan!",
    tag_color=COLOR_PURPLE,
    full_code_file="slide_09_mixins_with_keyword.dart"
)

# ---------------------------------------------------------------------
# Slide 10: OOP Modern 3: Extension Methods
# ---------------------------------------------------------------------
deck2.add_concept_with_code(
    "OOP LANJUTAN 2",
    "Extension Methods: Menambah Fitur ke Class Orang Lain",
    [
        "Pernahkah Anda ingin tipe bawaan 'String' punya fungsi buatan Anda sendiri (misal: ubah ke format Rupiah)?",
        "Di Dart, kita bisa menambah method baru ke class yang sudah ada tanpa perlu mengubah kode sumber aslinya!",
        "Gunakan sintaks: extension NamaEkstensi on TipeTarget { ... }",
        "Sangat populer di Flutter untuk membuat shortcut seperti 'context.lebarLayar'."
    ],
    r"""// Menambah fungsi baru ke tipe data bawaan int:
extension FormatUang on int {
  String toRupiah() => 'Rp ${this.toString().replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
    (Match m) => '${m[1]}.',
  )}';
}

void main() {
  int saldo = 1500000;
  // Langsung panggil method ekstensi seolah milik int asli:
  print('Saldo rekening: ${saldo.toRupiah()}'); // Rp 1.500.000
}""",
    filename="extension_methods.dart",
    tip="Extension method membuat kode aplikasi Anda sangat rapi dan mudah dibaca!",
    tag_color=COLOR_CORAL,
    full_code_file="slide_10_extension_methods.dart"
)

# ---------------------------------------------------------------------
# Slide 11: Koleksi Data 1: List, Map, dan Set
# ---------------------------------------------------------------------
deck2.add_concept_with_code(
    "STRUKTUR DATA",
    "Tiga Koleksi Utama: List, Map, dan Set",
    [
        "1. List<T>: Daftar berurutan dan boleh ada duplikat (ibarat keranjang belanja atau riwayat chat).",
        "2. Map<K, V>: Pasangan Kunci & Nilai (Key-Value), format standar saat menerima data JSON dari server internet.",
        "3. Set<T>: Kumpulan data yang DIJAMIN UNIK tanpa duplikasi (sangat cocok untuk tag terpilih atau ID favorit)."
    ],
    """void main() {
  // 1. List (Berurutan)
  final List<String> hobi = ['Ngoding', 'Membaca', 'Ngoding'];
  print('List: $hobi (Panjang: ${hobi.length})'); // ada duplikat

  // 2. Set (Unik & Otomatis Buang Duplikat)
  final Set<String> tagUnik = {'Flutter', 'Dart', 'Flutter'};
  print('Set unik: $tagUnik'); // {'Flutter', 'Dart'}

  // 3. Map (Key-Value ala JSON)
  final Map<String, dynamic> user = {'nama': 'Rina', 'skor': 95};
  print('Pengguna: ${user["nama"]}, Nilai: ${user["skor"]}');
}""",
    filename="collections_demo.dart",
    tip="Gunakan Map untuk menampung respon JSON dari REST API!",
    tag_color=COLOR_YELLOW,
    full_code_file="slide_11_collections_list_map_set.dart"
)

# ---------------------------------------------------------------------
# Slide 12: Koleksi Data 2: Operasi Reaktif (.map & .where)
# ---------------------------------------------------------------------
deck2.add_concept_with_code(
    "MANIPULASI DATA",
    "Operasi Reaktif: .map() dan .where()",
    [
        "Tinggalkan perulangan for loop manual kuno!",
        "Metode .where(): Menyaring (filter) data sesuai kriteria kondisi (misal: hanya ambil produk diskon).",
        "Metode .map(): Mengubah setiap item menjadi bentuk baru secara instan.",
        "Di Pertemuan 3: Kita akan menggunakan .map() untuk mengubah daftar data menjadi daftar Widget visual di layar!"
    ],
    """void main() {
  final List<int> daftarHarga = [15000, 25000, 8000, 32000, 12000];

  // 1. Filter: Hanya yang murah (< Rp 20.000)
  final murah = daftarHarga.where((h) => h < 20000).toList();
  print('Menu hemat: $murah'); // [15000, 8000, 12000]

  // 2. Transformasi: Ubah angka menjadi teks berlabel
  final labelHarga = murah.map((h) => 'Rp $h,-').toList();
  print('Daftar label: $labelHarga');
}""",
    filename="reactive_collections.dart",
    tip="Rangkaian .where() dan .map() adalah teknik standar industri dalam mengolah data di Flutter!",
    tag_color=COLOR_MINT,
    full_code_file="slide_12_reactive_collections.dart"
)

# ---------------------------------------------------------------------
# Slide 13: Dilema Sinkron vs Asinkron (Analogi Kasir Kafe)
# ---------------------------------------------------------------------
deck2.add_concept_with_code(
    "PARADIGMA EKSEKUSI",
    "Sinkron vs Asinkron: Mengapa UI Tidak Boleh Beku?",
    [
        "Masalah Sinkron: Kasir melayani Pelanggan A, lalu kasir DIAM mematung selama 3 menit menunggu kopi matang.",
        "Akibat di HP: Layar ponsel macet total (*freeze*), tombol tidak bisa ditekan, dan OS memunculkan popup 'Application Not Responding' (ANR).",
        "Solusi Asinkron: Kasir mencatat pesanan, memberi karcis nomor antrean (di Dart disebut 'Future'), lalu langsung melayani pelanggan berikutnya.",
        "Pengguna HP tetap bisa scroll lancar selagi data diunduh di latar belakang!"
    ],
    """// EKSEKUSI SINKRON (MEMBEKUKAN LAYAR):
// kasirMelayani(); // Diam 3 detik -> Layar HP freeze!

// EKSEKUSI ASINKRON (APLIKASI TETAP 120 FPS):
void main() {
  print('1. Pelanggan pesan kopi');
  // Memproses di background tanpa membekukan thread utama:
  Future.delayed(const Duration(seconds: 2), () {
    print('3. Kopi matang di dapur!');
  });
  print('2. Kasir langsung melayani antrean berikutnya');
}""",
    filename="sync_vs_async.dart",
    tip="Semua proses jaringan internet, database, dan GPS di mobile WAJIB berjalan secara asinkron!",
    tag_color=COLOR_CYAN,
    full_code_file="slide_13_dilema_sync_vs_async.dart"
)

# ---------------------------------------------------------------------
# Slide 14: Asinkron 1: Future, async, await, & try-catch
# ---------------------------------------------------------------------
deck2.add_concept_with_code(
    "ASINKRON DASAR",
    "Mengambil Data Server: Future & async / await",
    [
        "Future<T>: Janji tertulis bahwa data bertipe T akan selesai dikirim beberapa detik ke depan.",
        "Kata kunci async: Menandai fungsi yang memuat proses jeda waktu tunggu.",
        "Kata kunci await: Menunggu proses Future selesai di latar belakang tanpa membekukan thread antarmuka.",
        "Blok try-catch: Wajib dipasang untuk menangkap galat jika koneksi internet tiba-tiba terputus."
    ],
    """// Simulasi mengambil status pesanan dari cloud server
Future<String> cekPesananServer(int id) async {
  // Simulasi latensi sinyal internet 2 detik
  await Future.delayed(const Duration(seconds: 2));
  return 'Pesanan #$id Selesai Dipanggang!';
}

Future<void> main() async {
  print('Mengirim permintaan ke cloud...');
  try {
    final status = await cekPesananServer(42);
    print('Hasil server: $status');
  } catch (e) {
    print('Koneksi internet terputus: $e');
  }
}""",
    filename="async_await_demo.dart",
    tip="Konsep 'async/await' adalah standar emas saat kita menghubungkan Flutter ke REST API di Minggu ke-9!",
    tag_color=COLOR_PURPLE,
    full_code_file="slide_14_future_async_await.dart"
)

# ---------------------------------------------------------------------
# Slide 15: Asinkron 2: Stream, async*, & yield
# ---------------------------------------------------------------------
deck2.add_concept_with_code(
    "ALIRAN DATA REAKTIF",
    "Stream: Aliran Data Tanpa Henti (Live Data)",
    [
        "Perbedaan Krusial Future vs Stream:",
        "Future (Kurir Paket): Datang 1 kali membawa data, lalu tugasnya selesai (misal: tombol login).",
        "Stream (Air Keran / Radio FM): Data mengalir terus-menerus berkali-kali sepanjang waktu (misal: sensor GPS mobil berjalan, chat masuk, atau detak jantung smartwatch).",
        "Kata kunci: Gunakan async* dan 'yield' untuk mengalirkan data."
    ],
    """// Fungsi penghitung mundur waktu secara reaktif (Stream):
Stream<int> hitungMundur(int mulai) async* {
  for (int i = mulai; i >= 1; i--) {
    await Future.delayed(const Duration(seconds: 1));
    yield i; // Alirkan data angka tiap 1 detik!
  }
}

Future<void> main() async {
  print('Roket meluncur dalam:');
  await for (int detik in hitungMundur(3)) {
    print('Hitungan: $detik...');
  }
  print('🚀 MELUNCUR!');
}""",
    filename="stream_demo.dart",
    tip="Stream adalah fondasi utama dari arsitektur reaktif BLoC yang akan kita pakai di aplikasi skala besar!",
    tag_color=COLOR_CORAL,
    full_code_file="slide_15_stream_reactive_data.dart"
)

# ---------------------------------------------------------------------
# Slide 16: Lab Quest Mandiri Pertemuan 02
# ---------------------------------------------------------------------
deck2.add_lab_quest(
    2,
    "Simulasi Antrean Cerdas Kafe Kampus & Stream Data",
    45,
    [
        "Buka browser dan akses DartPad (dartpad.dev) atau buat berkas 'tugas2.dart' di VS Code.",
        "Buat Class 'Pesanan' dengan named parameters: namaPemesan (String), namaKopi (String), harga (int), dan catatan (String? nullable).",
        "Terapkan operator fallback (??) agar jika catatan null, otomatis tertulis: 'Standar Normal'.",
        "Buat fungsi asinkron 'ambilResep(Pesanan p)' yang menggunakan Future.delayed selama 2 detik.",
        "Jika harga pesanan <= 0, lemparkan pesan galat (Exception: 'Harga tidak valid!') dan tangkap dengan blok try-catch.",
        "Tantangan Bonus: Buat fungsi Stream 'lacakPembuatan()' yang mengalirkan status: '1. Menggiling Biji' -> '2. Menyeduh Air' -> '3. Kopi Siap!'."
    ],
    "Tunjukkan hasil eksekusi terminal di DartPad/VS Code kepada Dosen atau Asisten Lab untuk mendapatkan checklist nilai modul 2."
)

# ---------------------------------------------------------------------
# Simpan berkas PPTX Pertemuan 02
# ---------------------------------------------------------------------
output_path = os.path.join(output_dir, "PERTEMUAN_02_Modern_Dart_Programming.pptx")
deck2.save(output_path)
