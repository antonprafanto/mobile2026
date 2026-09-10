"""
Generator Slide Pertemuan 07 (Edisi Masterpiece 18 Slide Lengkap & Komprehensif)
Mata Kuliah: Pemrograman Piranti Bergerak (Flutter & Dart 2026)
Topik: Clean Architecture & Enterprise Project Structure (Feature-First)
Standar Desain: Neo-Brutalism Murni (designprompts.dev/neo-brutalism)
- ZERO BORDER RADIUS: Sudut 90 derajat siku murni tanpa kelengkungan (MSO_SHAPE.RECTANGLE).
- BOLD SOLID BLACK BORDERS: Garis hitam tegas 2.5 Pt (#000000).
- HARD OFFSET BLOCK SHADOWS: Bayangan blok hitam solid +0.08 inch di belakang kartu.
- PALET NEO-BRUTALISM: Warm Cream (#FAF8F5), Canary Yellow (#FFE600), Electric Cyan (#38BDF8), Mint (#4ADE80), Coral (#FB7185), Lavender (#C084FC).
- FITUR UTAMA: 100% SLIDE PEMBAHASAN DISERTAI KODE NYATA FLUTTER, ANALOGI MEMBUMI, DAN TOMBOL TAUTAN GITHUB.
"""

import os
from pptx import Presentation
from pptx.util import Inches, Pt
from pptx.dml.color import RGBColor
from pptx.enum.shapes import MSO_SHAPE

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

GITHUB_BASE_URL = "https://github.com/antonprafanto/mobile2026/blob/main/07_contoh_kode_program/pertemuan_07_clean_architecture"

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
        p1.font.size = Pt(30)
        p1.font.bold = True
        p1.font.color.rgb = COLOR_BLACK
        p1.space_after = Pt(14)

        p2 = tf.add_paragraph()
        p2.text = subtitle
        p2.font.name = FONT_BODY
        p2.font.size = Pt(15)
        p2.font.color.rgb = RGBColor(60, 60, 60)
        p2.space_after = Pt(38)

        p3 = tf.add_paragraph()
        p3.text = f"■  {presenter_info}  ■  OUTCOME-BASED EDUCATION (OBE) • SUB-CPMK {meeting_num}"
        p3.font.name = FONT_HEADING
        p3.font.size = Pt(12)
        p3.font.bold = True
        p3.font.color.rgb = COLOR_BLACK

    # 2. Slide Split Screen: Konsep & Tips di Kiri + Kode Sederhana di Kanan
    def add_concept_with_code(self, tag, title, bullets, code_snippet, filename="example.dart", tip=None, tag_color=COLOR_YELLOW, full_code_file=None):
        slide = self.prs.slides.add_slide(self.blank_layout)
        self._set_canvas_bg(slide)
        self._add_header(slide, tag, title, tag_color=tag_color)

        # Left Explanations Card (4.9 Inches)
        self._add_neobrutal_card(slide, Inches(0.9), Inches(1.8), Inches(4.9), Inches(5.1), fill_color=COLOR_WHITE)

        tb_l = slide.shapes.add_textbox(Inches(1.15), Inches(1.95), Inches(4.4), Inches(4.8))
        tf_l = tb_l.text_frame
        tf_l.word_wrap = True

        p_lt = tf_l.paragraphs[0]
        p_lt.text = "KONSEP & ALUR KERJA"
        p_lt.font.name = FONT_HEADING
        p_lt.font.size = Pt(11.5)
        p_lt.font.bold = True
        p_lt.font.color.rgb = COLOR_BLACK
        p_lt.space_after = Pt(8)

        for b in bullets:
            p = tf_l.add_paragraph()
            p.text = f"■  {b}"
            p.font.name = FONT_BODY
            p.font.size = Pt(10.6)
            p.font.color.rgb = RGBColor(20, 20, 20)
            p.space_after = Pt(5)

        if tip:
            p_tip = tf_l.add_paragraph()
            p_tip.text = f"💡 Tips Praktis: {tip}"
            p_tip.font.name = FONT_HEADING
            p_tip.font.size = Pt(10.2)
            p_tip.font.bold = True
            p_tip.font.color.rgb = COLOR_BLACK

        # Right Sharp Black Code Box (6.433 Inches)
        self._add_neobrutal_card(slide, Inches(6.0), Inches(1.8), Inches(6.433), Inches(5.1), fill_color=COLOR_CODE_BG)

        # Header Code Strip
        c_bar = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, Inches(6.0), Inches(1.8), Inches(6.433), Inches(0.48))
        c_bar.fill.solid()
        c_bar.fill.fore_color.rgb = tag_color
        c_bar.line.color.rgb = COLOR_BLACK
        c_bar.line.width = Pt(2.5)

        tb_cb = slide.shapes.add_textbox(Inches(6.2), Inches(1.86), Inches(6.0), Inches(0.38))
        p_cb = tb_cb.text_frame.paragraphs[0]
        p_cb.text = f"{filename}  |  KODE IMPLEMENTASI"
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
        p_code.font.size = Pt(9.1)
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
    def add_lab_quest(self, meeting_num, title, time_minutes, goals, success_criteria, full_code_file="slide_18_lab_quest_clean_architecture.dart"):
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
        p_b.text = f"⏱️ ALOKASI: {time_minutes} MENIT  ■  TARGET UJI: BROWSER CHROME ATAU SMARTPHONE FISIK"
        p_b.font.name = FONT_HEADING
        p_b.font.size = Pt(11.5)
        p_b.font.bold = True
        p_b.font.color.rgb = COLOR_BLACK

        tb = slide.shapes.add_textbox(Inches(1.3), Inches(2.40), Inches(10.7), Inches(3.6))
        tf = tb.text_frame
        tf.word_wrap = True

        p_g = tf.paragraphs[0]
        p_g.text = "LANGKAH KERJA & SPESIFIKASI TUGAS:"
        p_g.font.name = FONT_HEADING
        p_g.font.size = Pt(12)
        p_g.font.bold = True
        p_g.font.color.rgb = COLOR_BLACK
        p_g.space_after = Pt(6)

        for g in goals:
            p = tf.add_paragraph()
            p.text = f"✔  {g}"
            p.font.name = FONT_BODY
            p.font.size = Pt(10.4)
            p.font.color.rgb = RGBColor(30, 30, 30)
            p.space_after = Pt(4)

        if success_criteria:
            p_sc = tf.add_paragraph()
            p_sc.text = f"🎯 TARGET SELESAI: {success_criteria}"
            p_sc.font.name = FONT_HEADING
            p_sc.font.size = Pt(10.8)
            p_sc.font.bold = True
            p_sc.font.color.rgb = RGBColor(10, 100, 40)

        # Button for Lab Quest Source Code
        if full_code_file:
            btn_x = Inches(1.3)
            btn_y = Inches(6.12)
            btn_w = Inches(10.7)
            btn_h = Inches(0.62)

            btn_shadow = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, btn_x + Inches(0.04), btn_y + Inches(0.04), btn_w, btn_h)
            btn_shadow.fill.solid()
            btn_shadow.fill.fore_color.rgb = COLOR_BLACK
            btn_shadow.line.fill.background()

            btn = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, btn_x, btn_y, btn_w, btn_h)
            btn.fill.solid()
            btn.fill.fore_color.rgb = COLOR_YELLOW
            btn.line.color.rgb = COLOR_BLACK
            btn.line.width = Pt(2.0)

            tb_btn = slide.shapes.add_textbox(btn_x + Inches(0.12), btn_y + Inches(0.03), btn_w - Inches(0.24), btn_h - Inches(0.06))
            tf_btn = tb_btn.text_frame
            tf_btn.word_wrap = True

            p_btn = tf_btn.paragraphs[0]
            run_btn = p_btn.add_run()
            run_btn.text = f"▶ BUKA KODE LENGKAP LAB QUEST DI GITHUB ({full_code_file})"
            run_btn.font.name = FONT_HEADING
            run_btn.font.size = Pt(11)
            run_btn.font.bold = True
            run_btn.font.color.rgb = COLOR_BLACK
            run_btn.hyperlink.address = f"{GITHUB_BASE_URL}/{full_code_file}"

            p_btn_sub = tf_btn.add_paragraph()
            p_btn_sub.text = "💡 Buka di browser / salin source code: github.com/antonprafanto/mobile2026"
            p_btn_sub.font.name = FONT_BODY
            p_btn_sub.font.size = Pt(8.3)
            p_btn_sub.font.color.rgb = RGBColor(50, 50, 50)

    def save(self, filepath):
        self.prs.save(filepath)
        print(f"Deck slide berhasil disimpan ke: {filepath}")

# =====================================================================
# INISIALISASI PEMBUATAN SLIDE PERTEMUAN 07 (18 SLIDES MASTERPIECE)
# =====================================================================
output_dir = r"c:\Users\anton\vibecoding\mobile2026_v2\03_slide_presentasi"
deck7 = NeoBrutalistDeckBuilder()

# Slide 1: Cover
deck7.add_cover(
    7,
    "Clean Architecture & Enterprise Project Structure",
    "Membangun Fondasi Perangkat Lunak Skala Besar: Separation of Concerns, Domain-Driven Design, dan Dependency Injection dengan GetIt.",
    "TIM DOSEN PEMROGRAMAN PIRANTI BERGERAK"
)

# Slide 2: Setup & Alat Bantu DI
deck7.add_concept_with_code(
    "SETUP & ALAT BANTU",
    "Menyiapkan Fondasi Arsitektur: get_it & Equatable",
    [
        "💡 Analogi Kotak Perkakas: Menyiapkan kotak perkakas mekanik standar agar seluruh tim tahu di mana mengambil obeng dan kunci pas.",
        "📦 Perintah Terminal: Jalankan 'flutter pub add get_it equatable flutter_bloc' di root proyek Anda.",
        "⚡ Peran GetIt: Service Locator resmi Flutter untuk menyediakan instance kelas secara terpusat tanpa 'Prop Drilling'.",
        "🚫 Aturan Emas: Widget UI dilarang keras membuat objek Repository atau Data Source dengan kata kunci 'new / ()'!"
    ],
    """// Menambahkan paket resmi di pubspec.yaml:
dependencies:
  flutter:
    sdk: flutter
  get_it: ^7.7.0
  equatable: ^2.0.5
  flutter_bloc: ^8.1.6

// Impor resmi Service Locator:
import 'package:get_it/get_it.dart';""",
    filename="setup_di_tools.dart",
    tip="Gunakan get_it sebagai Service Locator terpusat agar kode Anda sangat mudah diuji (testable)!",
    tag_color=COLOR_YELLOW,
    full_code_file="slide_02_tools_dan_setup_di.dart"
)

# Slide 3: Separation of Concerns (SoC)
deck7.add_concept_with_code(
    "PRINSIP UTAMA",
    "Separation of Concerns: Pabrik Mobil dengan Departemen Mandiri",
    [
        "🚗 Analogi Pabrik Mobil: Departemen Desain Bodi (UI) tidak boleh mencampur tugasnya dengan Divisi Perakitan Mesin (Bisnis) atau Pemasok Baut (Data).",
        "🍝 Bahaya Spaghetti Code: Menulis pemanggilan API Dio langsung di dalam tombol `onPressed` membuat kode mustahil di-test.",
        "🛡️ Tanggung Jawab Tunggal: Pisahkan kode ke dalam tugas murni: Menggambar Antarmuka, Mengolah Aturan Bisnis, dan Mengambil Data.",
        "✨ Keuntungan: Sekali tim backend mengganti database dari Firebase ke PostgreSQL, kode UI Anda 0% berubah!"
    ],
    """// SEBELUM (Campur Aduk):
onPressed: () async {
  final res = await dio.get('https://api.com/tax');
  setState(() => _tax = res.data * 0.11);
}

// SESUDAH (Separation of Concerns):
// UI hanya meminta hasil ke kalkulator terpisah:
final ppn = taxCalculator.hitungPpn(hargaBarang);""",
    filename="separation_of_concerns.dart",
    tip="Jangan pernah meletakkan rumus perhitungan bisnis rumit di dalam widget build()!",
    tag_color=COLOR_CYAN,
    full_code_file="slide_03_separation_of_concerns.dart"
)

# Slide 4: Tiga Lapisan Clean Architecture
deck7.add_concept_with_code(
    "ARSITEKTUR BAWANG",
    "Model 3 Lapisan: Kulit Luar, Daging Buah, & Biji Inti",
    [
        "🧅 Analogi Bawang Bombay: Berlapis-lapis rapi. Kulit luar melindungi daging, dan daging membungkus biji inti di tengah.",
        "🎨 1. Presentation Layer (Luar): UI Screens, Widgets, BLoC/Cubit, State. Sangat bergantung pada Flutter framework.",
        "🧠 2. Domain Layer (Inti Paling Dalam): Entities, Use Cases, Repository Contracts. 100% Pure Dart tanpa embel-embel Flutter!",
        "💾 3. Data Layer (Infrastruktur): Data Sources (Dio API, SharedPreferences, Isar), Models (DTO), Repository Impl."
    ],
    """// Arah Ketergantungan (Dependency Rule):
// Presentation Layer ──► Domain Layer ◄── Data Layer
//
// Domain Layer adalah RAJA! 
// Domain sama sekali TIDAK BOLEH mengimpor
// package:flutter atau package:dio!""",
    filename="three_layers_clean_arch.dart",
    tip="Hukum Utama: Lapisan dalam sama sekali tidak boleh mengenal atau mengimpor lapisan luar!",
    tag_color=COLOR_CORAL,
    full_code_file="slide_04_tiga_lapisan_clean_arch.dart"
)

# Slide 5: Feature-First vs Layer-First
deck7.add_concept_with_code(
    "STRUKTUR FOLDER",
    "Feature-First Structure: Kamar Kos Mandiri vs Lemari Sekompleks",
    [
        "🏢 Analogi Kamar Kos: Kamar kos mandiri memiliki kasur, meja, dan kamar mandi di dalam 1 kamar (Feature-First).",
        "🚫 Masalah Layer-First: Menaruh semua file Screen di satu folder raksasa, semua BLoC di folder lain. Sangat sulit mencari berkas terkait!",
        "⚡ Feature-First Enterprise: Setiap fitur (`features/auth/`, `features/product/`, `features/cart/`) memiliki 3 lapisannya sendiri.",
        "🤝 Anti-Merge Conflict: Anggota kelompok proyek bisa bekerja di fitur berbeda tanpa pernah bertabrakan di Git!"
    ],
    """lib/
├── core/              # Util, Network, DI Terpusat
└── features/
    ├── auth/          # Fitur Autentikasi Mandiri
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    └── product/       # Fitur Katalog Mandiri
        ├── data/
        ├── domain/
        └── presentation/""",
    filename="feature_first_structure.dart",
    tip="Gunakan struktur Feature-First pada proyek kelompok UTS Anda agar pembagian tugas tim berjalan mulus!",
    tag_color=COLOR_PURPLE,
    full_code_file="slide_05_feature_first_structure.dart"
)

# Slide 6: Domain Layer - Entity
deck7.add_concept_with_code(
    "DOMAIN LAYER 1",
    "Entity: Emas Murni 24 Karat Tanpa Campuran Karat",
    [
        "🥇 Analogi Emas Murni: Batangan emas murni yang bernilai tetap, tidak peduli dimasukkan ke dalam brankas besi atau tas kain.",
        "🛡️ Objek Bisnis Murni: Entity mewakili model data sesungguhnya yang dibutuhkan oleh sistem (misal: `ProductEntity`).",
        "🚫 Bersih dari JSON: Entity dilarang keras memiliki method `fromJson` atau `toJson`! Itu adalah urusan Data Layer.",
        "⚖️ Warisi Equatable: Memastikan dua objek entity dengan isi ID dan data yang sama dianggap identik."
    ],
    """class ProductEntity extends Equatable {
  final String id;
  final String name;
  final int price;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.price,
  });

  bool get isPremium => price >= 1000000;

  @override
  List<Object?> get props => [id, name, price];
}""",
    filename="domain_entity.dart",
    tip="Entity adalah jantung aplikasi. Jika backend API mengubah format JSON dari snake_case ke camelCase, Entity Anda tetap utuh!",
    tag_color=COLOR_MINT,
    full_code_file="slide_06_domain_entity.dart"
)

# Slide 7: Domain Layer - Repository Contract
deck7.add_concept_with_code(
    "DOMAIN LAYER 2",
    "Repository Interface: Surat Perjanjian Kontrak Notaris",
    [
        "📜 Analogi Surat Kontrak: Notaris menulis pasal: 'Pihak kedua wajib menyerahkan daftar produk'. Notaris tidak peduli produk dikirim naik truk atau kapal laut.",
        "🏛️ Kelas Abstrak: Domain mendefinisikan apa yang dibutuhkan oleh aplikasi lewat `abstract class BookRepository`.",
        "🔒 Perlindungan Domain: Domain tidak peduli apakah data diambil dari server AWS, Firebase, atau sekadar data palsu (mock testing).",
        "✨ Fleksibilitas Tinggi: Memungkinkan developer mengerjakan tampilan UI secara paralel meskipun server API backend belum selesai dibuat!"
    ],
    """// Kontrak murni di Domain Layer:
abstract class BookRepository {
  Future<List<BookEntity>> getBooks();
}

// Data Layer yang WAJIB tunduk pada kontrak ini:
class BookRepositoryImpl implements BookRepository {
  @override
  Future<List<BookEntity>> getBooks() async { ... }
}""",
    filename="domain_repo_contract.dart",
    tip="Gunakan abstract class pada Domain Layer agar Anda bisa melakukan mocking data instan saat presentasi!",
    tag_color=COLOR_YELLOW,
    full_code_file="slide_07_domain_repository_contract.dart"
)

# Slide 8: Domain Layer - Use Case
deck7.add_concept_with_code(
    "DOMAIN LAYER 3",
    "Use Case: Satu Tombol Khusus Pada Mesin ATM Pintar",
    [
        "🏧 Analogi Tombol ATM: Satu tombol khusus 'Tarik Tunai 100rb', tombol lain 'Cek Saldo'. Setiap tombol hanya memiliki satu tugas spesifik.",
        "🎯 Single Responsibility Principle (SRP): Satu kelas Use Case hanya menjalankan satu aksi bisnis spesifik (misal: `GetLuckyNumberUseCase`).",
        "🧩 Dapat Digunakan Kembali: Satu Use Case yang sama bisa dipanggil oleh Mobile App, Tablet View, maupun Web tanpa duplikasi kode.",
        "🧪 Uji Cepat: Logika bisnis di Use Case dapat diuji secara terisolasi via Unit Test murni tanpa perlu menyalakan emulator."
    ],
    """class GetLuckyNumberUseCase {
  final NumberRepository repository;

  GetLuckyNumberUseCase(this.repository);

  int execute() {
    // Sisipkan aturan bisnis validasi di sini jika perlu:
    return repository.getRandomNumber();
  }
}""",
    filename="domain_usecase.dart",
    tip="Beri nama Use Case dengan kata kerja aktif spesifik: LoginUser, GetCartItems, CheckoutOrder!",
    tag_color=COLOR_CYAN,
    full_code_file="slide_08_domain_usecase.dart"
)

# Slide 9: Data Layer - Model / DTO vs Entity
deck7.add_concept_with_code(
    "DATA LAYER 1",
    "Model DTO: Paket Pembungkus Data Ekspedisi",
    [
        "📦 Analogi Paket Ekspedisi: Data dibungkus lapisan pembungkus transfer (DTO) selama transmisi jaringan, lalu dikonversi menjadi entitas murni (Entity) untuk dipakai oleh logika domain.",
        "🚚 Data Transfer Object (DTO): Kelas Model di Data Layer bertugas mem-parsing format mentah API lewat `fromJson` dan `toJson`.",
        "🧬 Pewarisan Hubungan: `class UserModel extends UserEntity`. Model adalah turunan dari Entity yang diberi keahlian membaca JSON.",
        "🛡️ Tameng Pelindung: Jika API backend mengirim data `null` atau tipe string aneh, konversi dilakukan di Model tanpa mencemari Entity."
    ],
    """// Model di Data Layer mewarisi Entity di Domain:
class UserModel extends UserEntity {
  const UserModel({required super.id, required super.name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}""",
    filename="data_model_dto.dart",
    tip="Jangan pernah menggunakan UserModel di Presentation Layer; gunakan tipe UserEntity agar arsitektur tetap bersih!",
    tag_color=COLOR_CORAL,
    full_code_file="slide_09_data_model_dto.dart"
)

# Slide 10: Data Layer - Data Sources
deck7.add_concept_with_code(
    "DATA LAYER 2",
    "Data Sources: Kran Air PAM vs Sumur Bor Pribadi",
    [
        "🚰 Analogi Kran Air: Remote Data Source seperti air PAM pipa pusat (Internet). Local Data Source seperti sumur cadangan di rumah (Cache/SQLite).",
        "🌐 RemoteDataSource: Tempat resmi memanggil HTTP client (Dio / HTTP) dan menerima respon status kode 200, 404, atau 500.",
        "💾 LocalDataSource: Tempat resmi membaca dan menulis data ke SharedPreferences, SecureStorage, atau Isar Database luring.",
        "🧱 Pemisahan Tingkat Rendah: Mengisolasi komunikasi mentah perangkat keras agar tidak menyentuh logika Repository."
    ],
    """abstract class UserRemoteDataSource {
  Future<Map<String, dynamic>> fetchUserRaw(int id);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  @override
  Future<Map<String, dynamic>> fetchUserRaw(int id) async {
    // Memanggil Dio client atau REST API:
    return {'id': id, 'name': 'Siti Aminah', 'role': 'Engineer'};
  }
}""",
    filename="data_sources.dart",
    tip="Data Source hanya mengembalikan Map<String, dynamic> atau melemparkan ServerException jika jaringan gagal!",
    tag_color=COLOR_PURPLE,
    full_code_file="slide_10_data_sources.dart"
)

# Slide 11: Data Layer - Repository Implementation
deck7.add_concept_with_code(
    "DATA LAYER 3",
    "Repository Implementation: Manajer Logistik Cerdas",
    [
        "📋 Analogi Manajer Logistik: Manajer yang memutuskan: 'Cek stok gudang lokal dulu. Jika kosong, baru pesan ke pabrik pusat via kurir.'",
        "🤝 Menepati Kontrak Domain: Kelas ini wajib mengimplementasikan interface `ProfileRepository` yang sudah disepakati di Domain Layer.",
        "🔄 Orkestrasi Data: Memanggil `RemoteDataSource`, mem-parsing ke `ProfileModel`, lalu mengembalikannya sebagai `Profile` Entity murni.",
        "🚨 Penanganan Galat: Tempat resmi menangkap `ServerException` jaringan dan menerjemahkannya menjadi kegagalan yang dipahami pengguna."
    ],
    """class ProfileRepositoryImpl implements ProfileRepository {
  @override
  Future<Profile> getProfile() async {
    // 1. Panggil Remote Data Source
    final raw = await remoteDataSource.fetchRaw();
    // 2. Parse ke Model DTO
    final model = ProfileModel.fromJson(raw);
    // 3. Kembalikan sebagai Entity Domain murni:
    return model;
  }
}""",
    filename="repo_implementation.dart",
    tip="Repository Implementation adalah satu-satunya jembatan penghubung antara dunia luar (Data) dengan dunia inti (Domain)!",
    tag_color=COLOR_MINT,
    full_code_file="slide_11_data_repository_impl.dart"
)

# Slide 12: Dependency Inversion Principle (DIP)
deck7.add_concept_with_code(
    "PRINSIP SOLID",
    "Dependency Inversion: Steker Listrik Standar Stopkontak",
    [
        "🔌 Analogi Steker Standar: Kipas angin tidak boleh disolder mati ke kabel tiang listrik PLN; kipas angin dan PLN sama-sama sepakat memakai stopkontak.",
        "🏛️ Aturan DIP: Modul tingkat tinggi (Presentation/Domain) tidak boleh bergantung langsung pada modul tingkat rendah (Data/API).",
        "🎯 Keduanya Bergantung pada Abstraksi: Baik Presenter maupun Repository Impl sama-sama bergantung pada interface kontrak abstrak.",
        "🧪 Kekuatan Mocking: Anda bisa mengganti pengiriman SMS dengan WhatsApp Notifier dalam 1 detik tanpa mengubah 1 baris pun kode pemanggil!"
    ],
    """// NotifierService adalah colokan standar universal:
abstract class NotifierService {
  String send(String message);
}

// Konsumen hanya kenal colokan, tidak peduli merk kabelnya:
class OrderManager {
  final NotifierService service;
  OrderManager(this.service); // Injeksi lewat konstruktor
  void finish() => service.send('Pesanan Siap!');
}""",
    filename="dependency_inversion.dart",
    tip="DIP adalah rahasia terbesar mengapa aplikasi enterprise dunia bisa diuji otomatis tanpa internet!",
    tag_color=COLOR_YELLOW,
    full_code_file="slide_12_dependency_inversion.dart"
)

# Slide 13: Service Locator GetIt
deck7.add_concept_with_code(
    "INJEKSI DEPENDENSI 1",
    "GetIt: Meja Resepsionis Hotel Bintang Lima Terpusat",
    [
        "🛎️ Analogi Resepsionis Hotel: Tamu tidak perlu keliling mencari sopir taksi atau koki; cukup hubungi meja resepsionis 'sl<T>()' di lobi.",
        "🌐 Service Locator Global: `final sl = GetIt.instance` menyimpan seluruh resep pembuatan objek di satu titik terpusat.",
        "🚫 Bebas Oper Parameter: Widget anak tidak perlu lagi mengoper variabel `repository` melewati 10 anak tangga widget tree.",
        "📍 File Registrasi: Seluruh dependensi didaftarkan di satu berkas resmi: `core/di/injection_container.dart`."
    ],
    """final sl = GetIt.instance; // Service Locator Global

void setupLocator() {
  // Daftarkan layanan ke resepsionis:
  sl.registerSingleton<AppConfigService>(AppConfigService());
}

// Ambil kapan saja di mana saja:
final config = sl<AppConfigService>();""",
    filename="get_it_service_locator.dart",
    tip="Panggil setupLocator() di dalam void main() sebelum fungsi runApp() dijalankan!",
    tag_color=COLOR_CYAN,
    full_code_file="slide_13_get_it_service_locator.dart"
)

# Slide 14: Factory vs Singleton di GetIt
deck7.add_concept_with_code(
    "INJEKSI DEPENDENSI 2",
    "Factory vs Singleton: Karcis Parkir vs Generator Listrik",
    [
        "🎫 Analogi Karcis Parkir: Setiap mobil masuk dicetak karcis baru (Factory). Generator listrik gedung hanya ada satu dipakai bersama (Singleton).",
        "🏢 registerLazySingleton: Objek dibuat HANYA 1 kali saat pertama kali diminta, lalu dipakai bersama selamanya (Cocok untuk Repository, Dio, Database).",
        "🔄 registerFactory: Objek baru selalu dicetak ulang setiap kali dipanggil (Cocok untuk Cubit / BLoC agar state kembali segar saat buka halaman baru).",
        "⚡ Hemat Memori: 'Lazy' berarti objek tidak memakan RAM sebelum ada halaman yang benar-benar memanggilnya."
    ],
    """void initDI() {
  // 1. Repository: Singleton (1 objek untuk seluruh aplikasi)
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(),
  );

  // 2. Cubit: Factory (Objek baru setiap kali halaman dibuka)
  sl.registerFactory<ProductCubit>(
    () => ProductCubit(sl()),
  );
}""",
    filename="factory_vs_singleton.dart",
    tip="Aturan Emas GetIt: Repository & Data Source daftar sebagai LazySingleton, sedangkan Cubit daftar sebagai Factory!",
    tag_color=COLOR_CORAL,
    full_code_file="slide_14_factory_vs_singleton.dart"
)

# Slide 15: Presentation Layer: Use Case ke Cubit
deck7.add_concept_with_code(
    "KONSUMSI UI",
    "Presentation Layer: Kasir Meneruskan Pesanan ke Koki",
    [
        "👨‍🍳 Analogi Dapur Restoran: Kasir di depan (Cubit) menerima pesanan pembeli, lalu meneruskannya ke koki spesialis soto (Use Case).",
        "🎯 Cubit Tidak Boleh Sentuh Repo: Cubit hanya boleh memanggil Use Case, bukan memanggil Repository secara langsung!",
        "🧱 Modularitas Tinggi: Jika alur verifikasi login berubah, perubahannya cukup di `LoginUseCase`, file Cubit dan UI tidak perlu disentuh.",
        "✨ State Reaktif: Cubit menerima hasil kembalian dari Use Case, lalu memancarkan status `ProductLoaded` ke widget tampilan."
    ],
    """class GreetingCubit extends Cubit<String> {
  final GetGreetingUseCase useCase; // Panggil Use Case!
  GreetingCubit(this.useCase) : super('Menunggu');

  void greet(String name) {
    // Menjalankan tugas bisnis murni:
    final pesan = useCase.execute(name);
    emit(pesan);
  }
}""",
    filename="cubit_usecase.dart",
    tip="Injeksi Use Case ke dalam konstruktor Cubit menggunakan GetIt: sl<MyCubit>() otomatis mengisi Use Case-nya!",
    tag_color=COLOR_PURPLE,
    full_code_file="slide_15_presentation_cubit_usecase.dart"
)

# Slide 16: End-to-End Clean Flow
deck7.add_concept_with_code(
    "ALUR DATA UTUH",
    "Alur Data End-to-End: Ekspedisi Paket Pos Hingga Tangan Pembeli",
    [
        "🚚 Alur Distribusi: Pembeli klik tombol (UI) -> Kasir input resi (Cubit) -> Manajer gudang proses nota (Use Case) -> Kurir jemput paket (Repo) -> Pabrik kirim barang (API).",
        "1. UI: `context.read<ItemCubit>().load()` dipicu saat tombol diklik.",
        "2. Cubit: Memancarkan state `Loading`, lalu memanggil `getItemUseCase()`.",
        "3. Use Case: Meminta data ke `ItemRepository` (Kontrak Abstrak).",
        "4. Repo Impl: Mengambil data dari `RemoteDataSource`, parse Model, kembalikan Entity murni ke UI!"
    ],
    """// Rantai Pemanggilan Berkelas Enterprise:
UI (Screen / Button)
   ▼ context.read<ItemCubit>().load()
Presentation (Cubit)
   ▼ getItemUseCase()
Domain (Use Case)
   ▼ repository.fetchItem()
Data (Repository Impl)
   ▼ remoteDataSource.fetch()
Infrastructure (HTTP / API Server)""",
    filename="end_to_end_flow.dart",
    tip="Pahami rantai alur ini di luar kepala; ini adalah pertanyaan wajib saat wawancara kerja Mobile Engineer!",
    tag_color=COLOR_MINT,
    full_code_file="slide_16_end_to_end_clean_flow.dart"
)

# Slide 17: 5 Aturan Emas Clean Architecture 2026
deck7.add_concept_with_code(
    "CHECKLIST PRODUKSI",
    "5 Aturan Emas Clean Architecture (Pedoman Penilaian UTS)",
    [
        "1. Domain Layer Bebas dari Flutter: Folder domain murni berisi kode Dart murni tanpa `package:flutter`.",
        "2. Satu Use Case Satu Tugas: Gunakan kelas spesifik (LoginUseCase, GetProductsUseCase), bukan Use Case sapu jagat.",
        "3. Cubit Dilarang Sentuh Repository: Presentation Layer wajib memanggil Use Case sebagai perantara logika.",
        "4. Model Mewarisi Entity: `class ProductModel extends Product` di Data Layer untuk mengisolasi format JSON.",
        "5. Pendaftaran Terpusat di GetIt: Seluruh instansiasi objek dikumpulkan di `injection_container.dart`."
    ],
    """// Checklist Uji Praktikum Arsitektur Standar 2026:
// [✓] Struktur proyek tersusun rapi Feature-First
// [✓] Domain Layer 100% bebas error saat diuji tanpa Flutter UI
// [✓] Semua dependensi diinjeksi via Service Locator GetIt
// [✓] Lolos audit linting 'dart analyze' dengan 0 issue""",
    filename="checklist_clean_arch.dart",
    tip="Gunakan kelima checklist ini untuk memastikan repositori kelompok Anda meraih skor maksimal 100 pada UTS!",
    tag_color=COLOR_YELLOW,
    full_code_file="slide_17_checklist_clean_architecture.dart"
)

# Slide 18: Lab Quest 07
deck7.add_lab_quest(
    7,
    "Implementasi Penuh Katalog E-Commerce dengan Clean Architecture & GetIt",
    60,
    [
        "Bangun aplikasi Katalog Gadget 2026 menggunakan pemisahan 3 layer Clean Architecture murni.",
        "Definisikan 'Product' Entity di Domain Layer dan 'ProductModel' di Data Layer dengan fromJson parser.",
        "Buat 'GetProductsUseCase' yang memanggil interface abstrak 'ProductRepository'.",
        "Implementasikan 'ProductRepositoryImpl' yang mensimulasikan pemanggilan data asinkron dari server.",
        "Daftarkan Repository (LazySingleton), UseCase (LazySingleton), dan ProductCubit (Factory) di GetIt Service Locator.",
        "Terapkan 4 Status UI (Initial, Loading, Loaded, Error) secara reaktif dengan tombol muat ulang dan simulasi error server!",
        "Target Pengujian: Jalankan di browser Chrome ('flutter run -d chrome') dan buktikan seluruh alur terisolasi rapi!"
    ],
    "Seluruh lapisan terpisah sempurna, dependensi terinjeksi via GetIt, 4 status UI tertangani, dan data tampil mulus.",
    full_code_file="slide_18_lab_quest_clean_architecture.dart"
)

# Simpan berkas presentasi
output_pptx = os.path.join(output_dir, "PERTEMUAN_07_Clean_Architecture_dan_Design_Pattern.pptx")
deck7.save(output_pptx)
