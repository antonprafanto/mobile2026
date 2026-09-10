"""
Script Generator Presentasi PPTX untuk Mata Kuliah Pemrograman Piranti Bergerak (Flutter 2026)
Menggunakan python-pptx dengan format 16:9 Widescreen dan tema Modern Dark Technical Aesthetic.
"""

import os
from pptx import Presentation
from pptx.util import Inches, Pt
from pptx.dml.color import RGBColor
from pptx.enum.shapes import MSO_SHAPE

# --- PALET WARNA MODERN SLATE & CYAN ---
COLOR_BG = RGBColor(15, 23, 42)          # #0F172A (Deep Slate)
COLOR_CARD = RGBColor(30, 41, 59)        # #1E293B (Card Slate)
COLOR_CARD_BORDER = RGBColor(51, 65, 85) # #334155
COLOR_CYAN = RGBColor(14, 165, 233)       # #0EA5E9 (Primary Accent)
COLOR_INDIGO = RGBColor(99, 102, 241)     # #6366F1
COLOR_GREEN = RGBColor(16, 185, 129)      # #10B981 (Success/Good Code)
COLOR_RED = RGBColor(244, 63, 94)         # #F43F5E (Problem/Bad Code)
COLOR_AMBER = RGBColor(245, 158, 11)      # #F59E0B (Warning)
COLOR_TEXT_WHITE = RGBColor(248, 250, 252)# #F8FAFC
COLOR_TEXT_MUTED = RGBColor(148, 163, 184)# #94A3B8
COLOR_CODE_BG = RGBColor(2, 6, 23)        # #020617 (Deep Black-Blue)
COLOR_CODE_TEXT = RGBColor(167, 243, 208) # #A7F3D0 (Mint Green Code)

FONT_HEADING = "Segoe UI"
FONT_BODY = "Segoe UI"
FONT_CODE = "Consolas"

class SlideDeckBuilder:
    def __init__(self, title, subtitle):
        self.prs = Presentation()
        # Set 16:9 Widescreen (13.333 x 7.5 Inches)
        self.prs.slide_width = Inches(13.333)
        self.prs.slide_height = Inches(7.5)
        self.blank_layout = self.prs.slide_layouts[6]
        self.title = title
        self.subtitle = subtitle

    def _set_slide_bg(self, slide):
        bg = slide.shapes.add_shape(
            MSO_SHAPE.RECTANGLE, 0, 0, self.prs.slide_width, self.prs.slide_height
        )
        bg.fill.solid()
        bg.fill.fore_color.rgb = COLOR_BG
        bg.line.fill.background()
        return bg

    def _add_header(self, slide, category_tag, slide_title):
        tag_box = slide.shapes.add_textbox(Inches(0.8), Inches(0.45), Inches(10), Inches(0.4))
        tf_tag = tag_box.text_frame
        tf_tag.word_wrap = True
        p_tag = tf_tag.paragraphs[0]
        p_tag.text = category_tag.upper()
        p_tag.font.name = FONT_HEADING
        p_tag.font.size = Pt(11)
        p_tag.font.bold = True
        p_tag.font.color.rgb = COLOR_CYAN

        title_box = slide.shapes.add_textbox(Inches(0.8), Inches(0.75), Inches(11.5), Inches(0.8))
        tf_title = title_box.text_frame
        tf_title.word_wrap = True
        p_title = tf_title.paragraphs[0]
        p_title.text = slide_title
        p_title.font.name = FONT_HEADING
        p_title.font.size = Pt(24)
        p_title.font.bold = True
        p_title.font.color.rgb = COLOR_TEXT_WHITE

    def add_cover(self, meeting_num, topic_title, description):
        slide = self.prs.slides.add_slide(self.blank_layout)
        self._set_slide_bg(slide)

        card = slide.shapes.add_shape(
            MSO_SHAPE.ROUNDED_RECTANGLE, Inches(0.8), Inches(1.0), Inches(11.733), Inches(5.5)
        )
        card.fill.solid()
        card.fill.fore_color.rgb = COLOR_CARD
        card.line.color.rgb = COLOR_CARD_BORDER
        card.line.width = Pt(1.5)

        tb = slide.shapes.add_textbox(Inches(1.5), Inches(1.6), Inches(10.3), Inches(4.2))
        tf = tb.text_frame
        tf.word_wrap = True

        p0 = tf.paragraphs[0]
        p0.text = f"IF3205 • PEMROGRAMAN PIRANTI BERGERAK • PERTEMUAN {meeting_num:02d}"
        p0.font.name = FONT_HEADING
        p0.font.size = Pt(13)
        p0.font.bold = True
        p0.font.color.rgb = COLOR_CYAN
        p0.space_after = Pt(14)

        p1 = tf.add_paragraph()
        p1.text = topic_title
        p1.font.name = FONT_HEADING
        p1.font.size = Pt(36)
        p1.font.bold = True
        p1.font.color.rgb = COLOR_TEXT_WHITE
        p1.space_after = Pt(16)

        p2 = tf.add_paragraph()
        p2.text = description
        p2.font.name = FONT_BODY
        p2.font.size = Pt(16)
        p2.font.color.rgb = COLOR_TEXT_MUTED
        p2.space_after = Pt(36)

        p3 = tf.add_paragraph()
        p3.text = "Teknik Informatika • Outcome-Based Education • Standar Rekayasa Industri 2026"
        p3.font.name = FONT_BODY
        p3.font.size = Pt(12)
        p3.font.color.rgb = COLOR_INDIGO

    def add_problem_slide(self, category, title, hook_question, problem_points, real_case):
        slide = self.prs.slides.add_slide(self.blank_layout)
        self._set_slide_bg(slide)
        self._add_header(slide, category, title)

        left_card = slide.shapes.add_shape(
            MSO_SHAPE.ROUNDED_RECTANGLE, Inches(0.8), Inches(1.8), Inches(6.8), Inches(5.0)
        )
        left_card.fill.solid()
        left_card.fill.fore_color.rgb = COLOR_CARD
        left_card.line.color.rgb = COLOR_RED
        left_card.line.width = Pt(1.5)

        tb_left = slide.shapes.add_textbox(Inches(1.1), Inches(2.0), Inches(6.2), Inches(4.5))
        tf_l = tb_left.text_frame
        tf_l.word_wrap = True

        p_hook = tf_l.paragraphs[0]
        p_hook.text = f"🔥 Masalah Nyata: {hook_question}"
        p_hook.font.name = FONT_HEADING
        p_hook.font.size = Pt(16)
        p_hook.font.bold = True
        p_hook.font.color.rgb = COLOR_RED
        p_hook.space_after = Pt(14)

        for pt in problem_points:
            p = tf_l.add_paragraph()
            p.text = f"• {pt}"
            p.font.name = FONT_BODY
            p.font.size = Pt(14)
            p.font.color.rgb = COLOR_TEXT_WHITE
            p.space_after = Pt(10)

        right_card = slide.shapes.add_shape(
            MSO_SHAPE.ROUNDED_RECTANGLE, Inches(7.9), Inches(1.8), Inches(4.6), Inches(5.0)
        )
        right_card.fill.solid()
        right_card.fill.fore_color.rgb = COLOR_CARD
        right_card.line.color.rgb = COLOR_CARD_BORDER
        right_card.line.width = Pt(1)

        tb_right = slide.shapes.add_textbox(Inches(8.2), Inches(2.0), Inches(4.0), Inches(4.5))
        tf_r = tb_right.text_frame
        tf_r.word_wrap = True

        p_rc_title = tf_r.paragraphs[0]
        p_rc_title.text = "💡 Studi Kasus Industri"
        p_rc_title.font.name = FONT_HEADING
        p_rc_title.font.size = Pt(16)
        p_rc_title.font.bold = True
        p_rc_title.font.color.rgb = COLOR_CYAN
        p_rc_title.space_after = Pt(12)

        p_rc = tf_r.add_paragraph()
        p_rc.text = real_case
        p_rc.font.name = FONT_BODY
        p_rc.font.size = Pt(13)
        p_rc.font.color.rgb = COLOR_TEXT_MUTED

    def add_three_columns(self, category, title, col1, col2, col3):
        slide = self.prs.slides.add_slide(self.blank_layout)
        self._set_slide_bg(slide)
        self._add_header(slide, category, title)

        cols = [col1, col2, col3]
        col_width = Inches(3.64)
        col_gap = Inches(0.4)
        start_x = Inches(0.8)

        for i, col in enumerate(cols):
            x = start_x + i * (col_width + col_gap)
            card = slide.shapes.add_shape(
                MSO_SHAPE.ROUNDED_RECTANGLE, x, Inches(1.8), col_width, Inches(5.0)
            )
            card.fill.solid()
            card.fill.fore_color.rgb = COLOR_CARD
            card.line.color.rgb = COLOR_CARD_BORDER
            card.line.width = Pt(1)

            tb = slide.shapes.add_textbox(x + Inches(0.25), Inches(2.0), col_width - Inches(0.5), Inches(4.5))
            tf = tb.text_frame
            tf.word_wrap = True

            p_icon = tf.paragraphs[0]
            p_icon.text = col.get("tag", "KONSEP")
            p_icon.font.name = FONT_HEADING
            p_icon.font.size = Pt(11)
            p_icon.font.bold = True
            p_icon.font.color.rgb = COLOR_CYAN
            p_icon.space_after = Pt(6)

            p_h = tf.add_paragraph()
            p_h.text = col["title"]
            p_h.font.name = FONT_HEADING
            p_h.font.size = Pt(18)
            p_h.font.bold = True
            p_h.font.color.rgb = COLOR_TEXT_WHITE
            p_h.space_after = Pt(12)

            for pt in col["points"]:
                p = tf.add_paragraph()
                p.text = f"• {pt}"
                p.font.name = FONT_BODY
                p.font.size = Pt(13)
                p.font.color.rgb = COLOR_TEXT_MUTED
                p.space_after = Pt(8)

    def add_comparison_slide(self, category, title, bad_title, bad_code, good_title, good_code, explanation):
        slide = self.prs.slides.add_slide(self.blank_layout)
        self._set_slide_bg(slide)
        self._add_header(slide, category, title)

        exp_box = slide.shapes.add_textbox(Inches(0.8), Inches(1.55), Inches(11.733), Inches(0.4))
        p_exp = exp_box.text_frame.paragraphs[0]
        p_exp.text = f"📌 {explanation}"
        p_exp.font.name = FONT_BODY
        p_exp.font.size = Pt(13)
        p_exp.font.color.rgb = COLOR_AMBER

        col_width = Inches(5.66)
        gap = Inches(0.4)

        x_left = Inches(0.8)
        card_bad = slide.shapes.add_shape(
            MSO_SHAPE.ROUNDED_RECTANGLE, x_left, Inches(2.1), col_width, Inches(4.7)
        )
        card_bad.fill.solid()
        card_bad.fill.fore_color.rgb = COLOR_CODE_BG
        card_bad.line.color.rgb = COLOR_RED
        card_bad.line.width = Pt(1.5)

        tb_b = slide.shapes.add_textbox(x_left + Inches(0.3), Inches(2.25), col_width - Inches(0.6), Inches(4.3))
        tf_b = tb_b.text_frame
        tf_b.word_wrap = True
        p_bt = tf_b.paragraphs[0]
        p_bt.text = f"❌ {bad_title}"
        p_bt.font.name = FONT_HEADING
        p_bt.font.size = Pt(15)
        p_bt.font.bold = True
        p_bt.font.color.rgb = COLOR_RED
        p_bt.space_after = Pt(10)

        p_bc = tf_b.add_paragraph()
        p_bc.text = bad_code
        p_bc.font.name = FONT_CODE
        p_bc.font.size = Pt(11)
        p_bc.font.color.rgb = COLOR_TEXT_MUTED

        x_right = x_left + col_width + gap
        card_good = slide.shapes.add_shape(
            MSO_SHAPE.ROUNDED_RECTANGLE, x_right, Inches(2.1), col_width, Inches(4.7)
        )
        card_good.fill.solid()
        card_good.fill.fore_color.rgb = COLOR_CODE_BG
        card_good.line.color.rgb = COLOR_GREEN
        card_good.line.width = Pt(1.5)

        tb_g = slide.shapes.add_textbox(x_right + Inches(0.3), Inches(2.25), col_width - Inches(0.6), Inches(4.3))
        tf_g = tb_g.text_frame
        tf_g.word_wrap = True
        p_gt = tf_g.paragraphs[0]
        p_gt.text = f"✅ {good_title}"
        p_gt.font.name = FONT_HEADING
        p_gt.font.size = Pt(15)
        p_gt.font.bold = True
        p_gt.font.color.rgb = COLOR_GREEN
        p_gt.space_after = Pt(10)

        p_gc = tf_g.add_paragraph()
        p_gc.text = good_code
        p_gc.font.name = FONT_CODE
        p_gc.font.size = Pt(11)
        p_gc.font.color.rgb = COLOR_CODE_TEXT

    def add_code_walkthrough(self, category, title, bullet_points, code_snippet, snippet_title="Implementation"):
        slide = self.prs.slides.add_slide(self.blank_layout)
        self._set_slide_bg(slide)
        self._add_header(slide, category, title)

        left_card = slide.shapes.add_shape(
            MSO_SHAPE.ROUNDED_RECTANGLE, Inches(0.8), Inches(1.8), Inches(5.0), Inches(5.0)
        )
        left_card.fill.solid()
        left_card.fill.fore_color.rgb = COLOR_CARD
        left_card.line.color.rgb = COLOR_CARD_BORDER
        left_card.line.width = Pt(1)

        tb_l = slide.shapes.add_textbox(Inches(1.1), Inches(2.0), Inches(4.4), Inches(4.5))
        tf_l = tb_l.text_frame
        tf_l.word_wrap = True
        p_lt = tf_l.paragraphs[0]
        p_lt.text = "🎯 Panduan Arsitektur"
        p_lt.font.name = FONT_HEADING
        p_lt.font.size = Pt(16)
        p_lt.font.bold = True
        p_lt.font.color.rgb = COLOR_CYAN
        p_lt.space_after = Pt(14)

        for pt in bullet_points:
            p = tf_l.add_paragraph()
            p.text = f"• {pt}"
            p.font.name = FONT_BODY
            p.font.size = Pt(13)
            p.font.color.rgb = COLOR_TEXT_WHITE
            p.space_after = Pt(10)

        right_card = slide.shapes.add_shape(
            MSO_SHAPE.ROUNDED_RECTANGLE, Inches(6.1), Inches(1.8), Inches(6.433), Inches(5.0)
        )
        right_card.fill.solid()
        right_card.fill.fore_color.rgb = COLOR_CODE_BG
        right_card.line.color.rgb = COLOR_CYAN
        right_card.line.width = Pt(1)

        tb_r = slide.shapes.add_textbox(Inches(6.4), Inches(2.0), Inches(5.8), Inches(4.5))
        tf_r = tb_r.text_frame
        tf_r.word_wrap = True
        p_rt = tf_r.paragraphs[0]
        p_rt.text = f"💻 {snippet_title}"
        p_rt.font.name = FONT_HEADING
        p_rt.font.size = Pt(14)
        p_rt.font.bold = True
        p_rt.font.color.rgb = COLOR_AMBER
        p_rt.space_after = Pt(8)

        p_code = tf_r.add_paragraph()
        p_code.text = code_snippet
        p_code.font.name = FONT_CODE
        p_code.font.size = Pt(10.5)
        p_code.font.color.rgb = COLOR_CODE_TEXT

    def add_lab_quest(self, meeting_num, quest_title, time_minutes, requirements, submission_info):
        slide = self.prs.slides.add_slide(self.blank_layout)
        self._set_slide_bg(slide)
        self._add_header(slide, "HANDS-ON LAB CHALLENGE", f"Lab Quest Pertemuan {meeting_num:02d}: {quest_title}")

        card = slide.shapes.add_shape(
            MSO_SHAPE.ROUNDED_RECTANGLE, Inches(0.8), Inches(1.8), Inches(11.733), Inches(5.0)
        )
        card.fill.solid()
        card.fill.fore_color.rgb = COLOR_CARD
        card.line.color.rgb = COLOR_AMBER
        card.line.width = Pt(2)

        tb = slide.shapes.add_textbox(Inches(1.2), Inches(2.1), Inches(10.9), Inches(4.3))
        tf = tb.text_frame
        tf.word_wrap = True

        p_badge = tf.paragraphs[0]
        p_badge.text = f"⏱️ ESTIMASI WAKTU: {time_minutes} MENIT • KERJAKAN DI SMARTPHONE / LAB PC"
        p_badge.font.name = FONT_HEADING
        p_badge.font.size = Pt(13)
        p_badge.font.bold = True
        p_badge.font.color.rgb = COLOR_AMBER
        p_badge.space_after = Pt(12)

        p_req_title = tf.add_paragraph()
        p_req_title.text = "Spesifikasi Tugas Mandiri:"
        p_req_title.font.name = FONT_HEADING
        p_req_title.font.size = Pt(16)
        p_req_title.font.bold = True
        p_req_title.font.color.rgb = COLOR_TEXT_WHITE
        p_req_title.space_after = Pt(8)

        for req in requirements:
            p = tf.add_paragraph()
            p.text = f"  [ ]  {req}"
            p.font.name = FONT_BODY
            p.font.size = Pt(13)
            p.font.color.rgb = COLOR_TEXT_MUTED
            p.space_after = Pt(6)

        p_sub = tf.add_paragraph()
        p_sub.text = f"\n📦 Pengumpulan Git: {submission_info}"
        p_sub.font.name = FONT_CODE
        p_sub.font.size = Pt(12)
        p_sub.font.bold = True
        p_sub.font.color.rgb = COLOR_GREEN

    def save(self, filepath):
        self.prs.save(filepath)
        print(f"[OK] Slide Deck Berhasil Disimpan: {filepath}")


# =====================================================================
# GENERASI 3 SLIDE DECK UNGGULAN KELAS MOBILE
# =====================================================================

output_dir = os.path.dirname(os.path.abspath(__file__))

# ---------------------------------------------------------------------
# DECK 1: PERTEMUAN 01 - PENGANTAR FLUTTER & EKOSISTEM MOBILE
# ---------------------------------------------------------------------
d1 = SlideDeckBuilder("Pertemuan 01", "Pengantar Ekosistem Mobile & Mengapa Flutter")
d1.add_cover(
    1,
    "The Evolution of Mobile Development:\nWhy Flutter in 2026?",
    "Membedah evolusi rekayasa perangkat lunak bergerak dari Native Silos, Hybrid WebView, hingga Canvas Rendering Engine modern."
)
d1.add_problem_slide(
    "PARADIGMA & TANTANGAN INDUSTRI",
    "Dilema Klasik: 'The Two Silos Problem' di Industri Mobile",
    "Mengapa perusahaan unicorn menghabiskan biaya 2x lipat untuk aplikasi mobile?",
    [
        "Membangun tim Kotlin (Android) dan Swift (iOS) secara terpisah sangat mahal.",
        "Rilis fitur sering tidak sinkron (Android rilis hari ini, iOS tertunda 2 minggu).",
        "Pola arsitektur dan bug tidak sama di kedua platform.",
        "Solusi Hybrid lawas (Cordova/WebView) sangat lambat karena adanya jembatan DOM."
    ],
    "Perusahaan seperti Grab, BMW, dan Alibaba beralih ke Flutter untuk memangkas 'time-to-market' sebesar 50% dengan satu basis kode (single codebase) tanpa mengorbankan performa render 120 fps."
)
d1.add_three_columns(
    "ARSITEKTUR & KOMPARASI",
    "Perbandingan Tiga Generasi Pendekatan Mobile",
    {
        "tag": "GENERASI 1",
        "title": "Native Murni",
        "points": [
            "Android (Kotlin) + iOS (Swift).",
            "Akses hardware 100% langsung.",
            "Performa maksimal.",
            "Kelemahan: Biaya 2x lipat dan codebase terpisah."
        ]
    },
    {
        "tag": "GENERASI 2",
        "title": "Hybrid WebView",
        "points": [
            "Cordova, Ionic, PhoneGap.",
            "Bungkus HTML/CSS/JS di web view.",
            "Murah dan cepat dibuat.",
            "Kelemahan: UI patah-patah (Jank) dan UX terasa seperti website."
        ]
    },
    {
        "tag": "GENERASI 3 (MODERN)",
        "title": "Canvas Engine (Flutter)",
        "points": [
            "Impeller / Skia Graphics Engine.",
            "Menggambar piksel langsung ke layar.",
            "Bebas Jembatan JavaScript.",
            "Performa native 60/120 fps di Android & iOS."
        ]
    }
)
d1.add_code_walkthrough(
    "ARSITEKTUR ENGINE",
    "Bagaimana Flutter Bekerja di Balik Layar (Under the Hood)",
    [
        "Framework Layer (Dart): Kumpulan widget, gesture, animasi, dan theme yang kita ketik setiap hari.",
        "Engine Layer (C/C++): Impeller merender grafis langsung ke GPU hardware.",
        "Dart VM: Menggunakan JIT (Just-In-Time) saat debugging untuk Hot Reload, dan AOT (Ahead-Of-Time) saat kompilasi rilis produksi."
    ],
    """// main.dart: Entry Point Minimalis
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello Flutter 2026!'),
        ),
      ),
    );
  }
}""",
    "Minimal Flutter App Anatomy"
)
d1.add_comparison_slide(
    "PARADIGMA PEMROGRAMAN",
    "Pergeseran Paradigma: Imperatif vs Deklaratif",
    "Paradigma Imperatif (Lawas)",
    """// Android Native (Java/Kotlin) Lawas
View v = findViewById(R.id.text_view);
v.setText("Status Berubah");
v.setColor(Color.RED);
// Rawan NullPointer jika ID salah!
// State UI tercecer di banyak tempat.""",
    "Paradigma Deklaratif (Flutter)",
    """// Flutter: UI = f(State)
// Antarmuka adalah cerminan langsung
// dari kondisi data saat ini:
Text(
  state.statusText,
  style: TextStyle(
    color: state.isError ? Colors.red : Colors.green,
  ),
)""",
    "Di Flutter, kita tidak mengubah elemen UI secara manual. Kita mengubah datanya (State), dan Flutter otomatis merender ulang layarnya."
)
d1.add_lab_quest(
    1,
    "Verifikasi Environment & Stateful Hot Reload",
    45,
    [
        "Jalankan 'flutter doctor -v' dan pastikan Android Toolchain tercentang hijau.",
        "Hubungkan smartphone fisik ke laptop/PC lab menggunakan kabel USB Debugging.",
        "Buka Scrcpy di terminal untuk memproyeksikan layar HP ke monitor komputer.",
        "Ubah warna primer dan teks pada template counter default.",
        "Tekan tombol 'r' di terminal dan buktikan Hot Reload berjalan dalam < 1 detik tanpa kehilangan nilai hitungan angka!"
    ],
    "git commit -m 'feat: verify flutter environment and hot reload on real device'"
)
d1.save(os.path.join(output_dir, "PERTEMUAN_01_Pengantar_Flutter_dan_Ekosistem.pptx"))


# ---------------------------------------------------------------------
# DECK 2: PERTEMUAN 03 - WIDGET TREE & MASTERING LAYOUTING
# ---------------------------------------------------------------------
d3 = SlideDeckBuilder("Pertemuan 03", "Widget Fundamentals & Mastering Layouts")
d3.add_cover(
    3,
    "Everything is a Widget:\nMastering Layouts & The Three Trees",
    "Membedah prinsip dasar hierarki antarmuka, siklus hidup widget, dan strategi membasmi RenderFlex Overflow selamanya."
)
d3.add_problem_slide(
    "LAYOUT & UI REKAYASA",
    "Bencana Klasik: 'RenderFlex Overflowed by X Pixels'",
    "Kenapa garis belang kuning-hitam selalu muncul di layar smartphone mahasiswa?",
    [
        "Ukuran layar pengguna sangat bervariasi (rasio 16:9, 19:9, 21:9).",
        "Teks dinamis dari API sering lebih panjang dari perkiraan desain mock-up.",
        "Menaruh widget Row/Column di dalam container tanpa batas constraint yang jelas.",
        "Lupa menggunakan SingleChildScrollView saat keyboard virtual muncul menutupi form."
    ],
    "Di industri e-commerce, jika harga atau nama barang terpotong (overflow), konversi transaksi turun hingga 18%. Aplikasi mobile profesional wajib 100% responsif terhadap segala resolusi."
)
d3.add_three_columns(
    "UNDER THE HOOD",
    "Tiga Pohon Internal Flutter (The Three Trees Architecture)",
    {
        "tag": "POHON 1",
        "title": "Widget Tree",
        "points": [
            "Konfigurasi blueprint immutabel.",
            "Sangat ringan dan murah dibuat.",
            "Dibuat ulang setiap kali build() dipanggil.",
            "Menjawab: 'Bagaimana UI ingin ditampilkan?'"
        ]
    },
    {
        "tag": "POHON 2",
        "title": "Element Tree",
        "points": [
            "Pengelola siklus hidup memori.",
            "Menghubungkan Widget ke RenderObject.",
            "Mempertahankan identitas state.",
            "Menjawab rahasia efisiensi Hot Reload."
        ]
    },
    {
        "tag": "POHON 3",
        "title": "RenderObject Tree",
        "points": [
            "Menghitung ukuran fisik layar (Layout).",
            "Menggambar piksel warna (Paint).",
            "Mendeteksi sentuhan jari (Hit Testing).",
            "Sangat berat jika dibuat ulang terus-menerus."
        ]
    }
)
d3.add_comparison_slide(
    "CLEAN CODE WIDGET",
    "Anti-Pattern: Widget Monolitik vs Reusable Component",
    "Ugly Spaghetti Widget Tree",
    """// Anti-pattern: 200 baris dalam 1 file!
Widget build(BuildContext context) {
  return Container(
    child: Column(
      children: [
        Container(
          child: Row(
            children: [
              Container( /* nested 10 level */ )
            ],
          ),
        ),
      ],
    ),
  );
}""",
    "Modular & Clean Extracted Widget",
    """// Best practice: Ekstrak ke StatelessWidget
class UserProfileHeader extends StatelessWidget {
  final String name;
  const UserProfileHeader({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(),
      title: Text(name),
    );
  }
}""",
    "Memecah widget besar menjadi widget kecil mandiri mempercepat kalkulasi rendering dan membuat kode mudah diuji dengan Widget Testing."
)
d3.add_code_walkthrough(
    "LAYOUT RECIPE",
    "Solusi Anti-Overflow: Kombinasi Row, Expanded, & Stack",
    [
        "Row/Column: Menentukan arah tata letak linear (horizontal / vertikal).",
        "Expanded: Memaksa widget anak mengambil sisa ruang yang tersedia tanpa memicu overflow.",
        "Stack & Positioned: Menumpuk widget di atas widget lain (seperti Photoshop layer / badge notifikasi)."
    ],
    """Widget buildProductItem(String title, String price) {
  return Card(
    child: Row(
      children: [
        // 1. Gambar produk tetap 80x80
        Image.network('https://picsum.photos/80', width: 80, height: 80),
        const SizedBox(width: 12),
        // 2. Expanded mencegah judul panjang overflow
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
              Text(price, style: const TextStyle(color: Colors.green)),
            ],
          ),
        ),
        // 3. Tombol aksi
        IconButton(icon: const Icon(Icons.add_shopping_cart), onPressed: () {}),
      ],
    ),
  );
}""",
    "Responsive Product Card Pattern"
)
d3.add_lab_quest(
    3,
    "Membangun Katalog Responsif & Detail Page",
    60,
    [
        "Bangun ListView.builder yang menampilkan minimal 6 item katalog dengan gambar, judul, rating bintang, dan harga.",
        "Pastikan judul panjang dipotong elegan dengan 'TextOverflow.ellipsis' tanpa garis overflow kuning-hitam.",
        "Uji aplikasi pada mode Landscape dan pastikan antarmuka tidak rusak.",
        "Terapkan Material 3 dengan palet warna ColorScheme.fromSeed()."
    ],
    "git commit -m 'feat: build responsive catalog layout with no overflow'"
)
d3.save(os.path.join(output_dir, "PERTEMUAN_03_Widget_Tree_dan_Layouting.pptx"))


# ---------------------------------------------------------------------
# DECK 3: PERTEMUAN 06 - STATE MANAGEMENT CUBIT & BLOC
# ---------------------------------------------------------------------
d6 = SlideDeckBuilder("Pertemuan 06", "State Management: The Core Problem & Cubit/BLoC")
d6.add_cover(
    6,
    "Mastering State in Flutter:\nFrom setState to Scalable Cubit Architecture",
    "Membedah kelemahan prop-drilling, konsep pemrograman reaktif, dan implementasi state management standar enterprise."
)
d6.add_problem_slide(
    "STATE DILEMA",
    "Mengapa 'setState()' Menjadi Musuh Utama Aplikasi Berskala Besar?",
    "Bagaimana mengupdate angka badge keranjang belanja di AppBar saat tombol ditekan di halaman detail?",
    [
        "Prop Drilling: Harus mengoper fungsi callback melewati 6 tingkatan widget pohon.",
        "Performance Degradation: Memanggil setState() di parent widget me-rebuild seluruh layar secara boros.",
        "Spaghetti Logic: Kalkulasi diskon dan validasi transaksi bercampur baur di file UI.",
        "Zero Testability: Logika bisnis tidak bisa diuji dengan Unit Test karena terikat erat ke BuildContext."
    ],
    "Di aplikasi e-commerce seperti Tokopedia atau Shopee, keranjang belanja, status saldo wallet, dan notifikasi harus tersinkronisasi seketika di puluhan halaman tanpa harus me-rebuild seluruh antarmuka."
)
d6.add_three_columns(
    "TAKSONOMI STATE",
    "Membedakan Ephemeral State vs Application State",
    {
        "tag": "LOCAL / EPHEMERAL",
        "title": "Ephemeral State",
        "points": [
            "State yang hanya hidup di 1 widget.",
            "Contoh: Status tab aktif, animasi form berputar.",
            "Cukup dikelola dengan StatefulWidget / setState lokal sederhana."
        ]
    },
    {
        "tag": "GLOBAL / SHARED",
        "title": "Application State",
        "points": [
            "Data yang dipakai bersama di banyak halaman.",
            "Contoh: Status login user, isi keranjang belanja, preferensi dark mode.",
            "Wajib menggunakan State Manager (BLoC / Cubit)."
        ]
    },
    {
        "tag": "REACTIVE STREAMS",
        "title": "Aliran Reaktif (BLoC)",
        "points": [
            "Single Source of Truth.",
            "UI hanya menjadi konsumen pasif.",
            "State berubah -> UI otomatis render.",
            "Arsitektur terprediksi & mudah di-debug."
        ]
    }
)
d6.add_comparison_slide(
    "ARSITEKTUR PERBANDINGAN",
    "Side-by-Side: setState() vs Clean Cubit Separation",
    "Tightly-Coupled (setState)",
    """// Logika dan UI tercampur baur!
class _CartPageState extends State<CartPage> {
  int total = 0;
  void addItem() {
    setState(() {
      total += 50000;
    });
  }
  // Tidak bisa diuji dengan Unit Test!
}""",
    "Clean Separation (Cubit + BlocConsumer)",
    """// 1. Logika murni Dart (100% testable)
class CartCubit extends Cubit<int> {
  CartCubit() : super(0);
  void addItem() => emit(state + 50000);
}

// 2. UI hanya mendengarkan state
BlocBuilder<CartCubit, int>(
  builder: (context, total) => Text('Rp $total'),
)""",
    "Dengan Cubit, logika penambahan harga tidak tahu apa-apa tentang tombol atau teks. Logika dapat diuji dalam 5 milidetik di Unit Test."
)
d6.add_code_walkthrough(
    "BLOC COMPONENT TRIO",
    "Tiga Serangkai Komponen UI: Builder, Listener, & Consumer",
    [
        "BlocBuilder: KHUSUS menggambar ulang widget visual. Dilarang memicu dialog atau SnackBar di sini!",
        "BlocListener: KHUSUS menangani efek samping (Side Effects) satu kali, seperti navigasi rute atau popup notifikasi error.",
        "BlocConsumer: Menggabungkan Builder dan Listener dalam satu tempat yang bersih dan efisien."
    ],
    """BlocConsumer<CartCubit, CartState>(
  listener: (context, state) {
    if (state.status == CartStatus.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.errorMessage!)),
      );
    }
  },
  builder: (context, state) {
    if (state.status == CartStatus.loading) {
      return const CircularProgressIndicator();
    }
    return Text('Total Belanja: Rp ${state.totalPrice}');
  },
)""",
    "BlocConsumer Production Pattern"
)
d6.add_lab_quest(
    6,
    "Refactoring Counter/Cart Menjadi Reactive Cubit",
    60,
    [
        "Buat CartState menggunakan package Equatable dengan field: items, totalPrice, dan status.",
        "Buat CartCubit dengan method addItem(), removeItem(), dan applyPromoCode().",
        "Pasang AppBlocObserver untuk mencatat seluruh mutasi transisi state di konsol debug.",
        "Buktikan bahwa tombol Add to Cart di halaman Detail dapat memperbarui angka badge di AppBar halaman Home secara reaktif!"
    ],
    "git commit -m 'feat: implement reactive cart cubit with bloc consumer'"
)
d6.save(os.path.join(output_dir, "PERTEMUAN_06_State_Management_Cubit_dan_BLoC.pptx"))


# ---------------------------------------------------------------------
# DECK 4: PERTEMUAN 09 - NETWORKING REST API DENGAN DIO
# ---------------------------------------------------------------------
d9 = SlideDeckBuilder("Pertemuan 09", "Networking & RESTful API Integration with Dio")
d9.add_cover(
    9,
    "Connecting to the Real World:\nRESTful API & Network Architecture with Dio",
    "Membangun arsitektur komunikasi data client-server yang tangguh, interceptors token, dan serialisasi JSON type-safe."
)
d9.add_problem_slide(
    "NETWORKING FRICTION",
    "Mengapa 'http' Bawaan Kurang Cukup untuk Skala Enterprise?",
    "Bagaimana menyisipkan token Bearer JWT otomatis di 40 endpoint tanpa duplikasi kode?",
    [
        "Menulis headers Authorization manual di setiap pemanggilan API rawan human-error.",
        "Penanganan timeout koneksi lambat sangat berbelit-belit.",
        "Typo pada parsing json['user_name'] memicu NoSuchMethodError saat runtime.",
        "Sulit membatalkan request saat pengguna cepat-cepat menekan tombol Back."
    ],
    "Di perbankan dan fintech, library Dio menjadi standar wajib karena mendukung Interceptors, auto-retry saat koneksi putus, dan SSL pinning protection."
)
d9.add_three_columns(
    "ARSITEKTUR CLIENT",
    "Komponen Inti Dio Networking",
    {
        "tag": "SECURITY & AUTH",
        "title": "Interceptors",
        "points": [
            "Menyadap request & response.",
            "Otomatis menyuntikkan JWT token.",
            "Logging request ke konsol debug.",
            "Refresh token otomatis jika 401."
        ]
    },
    {
        "tag": "TYPE SAFETY",
        "title": "JSON Serialization",
        "points": [
            "Memakai json_serializable / freezed.",
            "Model immutable dengan fromJson.",
            "Mencegah typo field JSON.",
            "Menjamin compile-time safety."
        ]
    },
    {
        "tag": "RESILIENCE",
        "title": "Error Handling",
        "points": [
            "Batas waktu connect & receive.",
            "Peta error ramah pengguna.",
            "Handling 404, 500, & offline.",
            "Tombol Retry terstandarisasi."
        ]
    }
)
d9.add_code_walkthrough(
    "INTERCEPTOR PATTERN",
    "Injeksi Token JWT Otomatis Menggunakan Dio Interceptors",
    [
        "onRequest: Membaca token dari FlutterSecureStorage dan menyuntikkan ke Header Authorization.",
        "onError: Jika menerima 401 Unauthorized, otomatis redirect ke halaman Login."
    ],
    """dio.interceptors.add(
  InterceptorsWrapper(
    onRequest: (options, handler) async {
      final token = await storage.read(key: 'jwt_token');
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      return handler.next(options);
    },
    onError: (DioException e, handler) {
      if (e.response?.statusCode == 401) {
        // Sesi habis, alihkan user ke login
        router.go('/login');
      }
      return handler.next(e);
    },
  ),
);""",
    "Dio Auth Interceptor Snippet"
)
d9.add_lab_quest(
    9,
    "Integrasi API Publik & Pola 4 UI States",
    60,
    [
        "Konsumsi API produk publik menggunakan Dio BaseOptions.",
        "Buat model Produk dengan factory fromJson.",
        "Terapkan 4 UI States: Initial, Loading (Shimmer), Success (Grid Produk), dan Error (Tombol Coba Lagi).",
        "Pasang Pull-to-Refresh menggunakan RefreshIndicator."
    ],
    "git commit -m 'feat: implement dio api client with 4 ui states'"
)
d9.save(os.path.join(output_dir, "PERTEMUAN_09_Networking_REST_API_dan_Dio.pptx"))


# ---------------------------------------------------------------------
# DECK 5: PERTEMUAN 11 - BACKEND AS A SERVICE (FIREBASE)
# ---------------------------------------------------------------------
d11 = SlideDeckBuilder("Pertemuan 11", "Backend-as-a-Service: Firebase Cloud Integration")
d11.add_cover(
    11,
    "Serverless Mobile Architecture:\nCloud Integration with Firebase & BaaS",
    "Mengintegrasikan autentikasi cloud, sinkronisasi data realtime NoSQL, dan penyimpanan berkas media tanpa memanage VPS."
)
d11.add_problem_slide(
    "SERVERLESS DILEMA",
    "Jebakan Kuota: Free-Tier Firestore Exhaustion",
    "Mengapa kuota 50.000 reads/hari bisa habis dalam 15 menit saat praktikum?",
    [
        "Menaruh listener Stream Firestore di dalam method build() widget.",
        "Widget dirender 60 kali per detik -> 3.600 read per menit per mahasiswa!",
        "Aplikasi crash mendadak saat demo ujian karena status Quota Exceeded.",
        "Firestore Security Rules dibiarkan 'allow read, write: if true;' yang sangat berbahaya."
    ],
    "Arsitek mobile profesional selalu mengisolasi stream cloud di dalam BLoC/Cubit, menerapkan query limit(20), dan memasang aturan keamanan data ketat."
)
d11.add_comparison_slide(
    "QUERY EFFICIENCY",
    "Query Berbahaya vs Query Teroptimasi",
    "Dangerous Unbounded Query",
    """// FATAL: Membaca seluruh koleksi!
// 10.000 dokumen terbaca sekaligus
FirebaseFirestore.instance
    .collection('transactions')
    .snapshots(); // Boros kuota & RAM!""",
    "Safe Paginated Query",
    """// AMAN: Batasi 15 dokumen terbaru
FirebaseFirestore.instance
    .collection('transactions')
    .where('userId', isEqualTo: currentUserId)
    .orderBy('createdAt', descending: true)
    .limit(15)
    .snapshots();""",
    "Selalu batasi query dengan .limit() dan filter .where() untuk menjaga kuota cloud dan kecepatan render aplikasi."
)
d11.add_code_walkthrough(
    "AUTH STREAM",
    "Autentikasi Reaktif Terhubung ke GoRouter",
    [
        "FirebaseAuth memancarkan stream User setiap kali status login berganti.",
        "GoRouter mendengarkan perubahan stream ini dan otomatis memindahkan rute halaman tanpa perlu navigasi manual."
    ],
    """// Di dalam Router Configuration:
redirect: (context, state) {
  final isLoggedIn = FirebaseAuth.instance.currentUser != null;
  final isLoggingIn = state.matchedLocation == '/login';

  if (!isLoggedIn && !isLoggingIn) return '/login';
  if (isLoggedIn && isLoggingIn) return '/home';
  return null; // Tidak perlu redirect
}""",
    "Reactive Auth Guard Router"
)
d11.add_lab_quest(
    11,
    "Autentikasi Cloud & Realtime Cloud Notes",
    60,
    [
        "Hubungkan proyek Flutter ke Firebase Console via 'flutterfire configure'.",
        "Implementasikan form Login & Register menggunakan FirebaseAuth.",
        "Buat fitur pencatatan realtime (CRUD) di Firestore dengan filter per userId.",
        "Kunci Security Rules agar mahasiswa hanya bisa membaca datanya sendiri."
    ],
    "git commit -m 'feat: complete firebase auth and firestore integration'"
)
d11.save(os.path.join(output_dir, "PERTEMUAN_11_Backend_as_a_Service_Firebase.pptx"))


# ---------------------------------------------------------------------
# DECK 6: PERTEMUAN 14 - TESTING, DEBUGGING, & PROFILING
# ---------------------------------------------------------------------
d14 = SlideDeckBuilder("Pertemuan 14", "Automated Testing, Debugging, & Profiling")
d14.add_cover(
    14,
    "Engineering Quality Assurance:\nUnit Testing, Widget Testing, & DevTools Profiling",
    "Menjamin reliabilitas kode, memverifikasi logika dengan mocktail, dan mendiagnosis frame jank menggunakan Flutter DevTools."
)
d14.add_problem_slide(
    "SOFTWARE RELIABILITY",
    "Mengapa Manual Testing adalah Mimpi Buruk Rekayasa?",
    "Apakah Anda rela mengklik ulang 15 tombol di aplikasi setiap kali ada perubahan kecil?",
    [
        "Manual testing memakan waktu berjam-jam dan tidak reliabel.",
        "Perbaikan bug di halaman A sering kali memicu bug baru di halaman B (Regression).",
        "Aplikasi terasa berat dan tersendat (Frame Drops) tanpa tahu widget mana biang keladinya.",
        "Memory leak akibat controller yang lupa di-dispose menguras baterai smartphone pengguna."
    ],
    "Perusahaan teknologi kelas atas mewajibkan code coverage minimal 75% sebelum kode diizinkan masuk ke server produksi melalui Continuous Integration (CI)."
)
d14.add_three_columns(
    "PIRAMIDA TESTING",
    "Tiga Tingkatan Pengujian di Flutter",
    {
        "tag": "SPEED & LOGIC",
        "title": "Unit Tests (70%)",
        "points": [
            "Menguji fungsi kalkulasi & Cubit.",
            "Eksekusi super cepat (< 10 ms).",
            "Menggunakan mocktail & bloc_test.",
            "Bebas dari UI & BuildContext."
        ]
    },
    {
        "tag": "COMPONENT UI",
        "title": "Widget Tests (20%)",
        "points": [
            "Menguji render tombol & input form.",
            "Menguji perilaku tap jari.",
            "Simulasi layar tanpa emulator.",
            "Memastikan teks & ikon muncul."
        ]
    },
    {
        "tag": "END-TO-END",
        "title": "Integration Tests (10%)",
        "points": [
            "Menguji alur pengguna utuh.",
            "Dijalankan di real device / emulator.",
            "Login -> Checkout -> Payment.",
            "Simulasi skenario pengguna nyata."
        ]
    }
)
d14.add_code_walkthrough(
    "UNIT TEST PATTERN",
    "Pengujian State Cubit Menggunakan 'bloc_test'",
    [
        "build: Menyiapkan instans Cubit.",
        "act: Memanggil fungsi atau aksi bisnis.",
        "expect: Memverifikasi urutan state yang dipancarkan secara eksak."
    ],
    """blocTest<CartCubit, CartState>(
  'Memancarkan success saat item ditambahkan ke keranjang',
  build: () => CartCubit(),
  act: (cubit) => cubit.addItem(sampleProduct),
  expect: () => [
    CartState(
      items: [sampleProduct],
      totalPrice: 25000,
      status: CartStatus.success,
    ),
  ],
);""",
    "Predictable BLoC Test Code"
)
d14.add_lab_quest(
    14,
    "Membuat Test Suite & Profiling DevTools",
    60,
    [
        "Tulis minimal 3 Unit Test untuk memverifikasi logika autentikasi dan validasi.",
        "Jalankan 'flutter test' dan pastikan semua test berstatus hijau lulus.",
        "Buka Flutter DevTools di browser dan pantau alokasi Memory tab.",
        "Pastikan tidak ada memory leak saat bolak-balik berpindah halaman 10 kali."
    ],
    "git commit -m 'test: add comprehensive unit tests for cart and auth cubit'"
)
d14.save(os.path.join(output_dir, "PERTEMUAN_14_Automated_Testing_dan_Profiling.pptx"))

print("\n[SUCCESS] SEMUA SLIDE DECK PPTX BERHASIL DIGENERATE DENGAN SUKSES!")
