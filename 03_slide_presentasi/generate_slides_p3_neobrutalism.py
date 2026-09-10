"""
Generator Slide Pertemuan 03 (Edisi Masterpiece 24 Slide Lengkap & Super Ramah Awam)
Mata Kuliah: Pemrograman Piranti Bergerak (Flutter & Dart 2026)
Standar Desain: Neo-Brutalism Murni (designprompts.dev/neo-brutalism)
- ZERO BORDER RADIUS: Sudut 90 derajat siku murni tanpa kelengkungan (MSO_SHAPE.RECTANGLE).
- BOLD SOLID BLACK BORDERS: Garis hitam tegas 2.5 Pt (#000000).
- HARD OFFSET BLOCK SHADOWS: Bayangan blok hitam solid +0.08 inch di belakang kartu.
- PALET NEO-BRUTALISM: Warm Cream (#FAF8F5), Canary Yellow (#FFE600), Electric Cyan (#38BDF8), Mint (#4ADE80), Coral (#FB7185), Lavender (#C084FC).
- FITUR UTAMA: 100% SLIDE PEMBAHASAN DISERTAI KODE NYATA, ANALOGI MEMBUMI, DAN TIPS AWAM.
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
GITHUB_BASE_URL = "https://github.com/antonprafanto/mobile2026/blob/main/07_contoh_kode_program/pertemuan_03_widget_dan_layouting"

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
    def add_concept_with_code(self, tag, title, bullets, code_snippet, filename="contoh_widget.dart", tip=None, tag_color=COLOR_YELLOW, full_code_file=None):
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
        p_cb.text = f"{filename}  |  CONTOH KODE BERSIH"
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
    def add_lab_quest(self, meeting_num, title, time_minutes, goals, success_criteria, full_code_file="slide_24_lab_quest_dashboard_profil.dart"):
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
        print(f"[OK] Slide Pertemuan 03 Berhasil Disimpan: {filepath}")


# =====================================================================
# PEMBUATAN 24 SLIDE MASTERPIECE PERTEMUAN 03
# =====================================================================

output_dir = os.path.dirname(os.path.abspath(__file__))
deck3 = NeoBrutalistDeckBuilder()

# ---------------------------------------------------------------------
# Slide 1: Cover
# ---------------------------------------------------------------------
deck3.add_cover(
    3,
    "Everything is a Widget:\nMastering Layout & Tiga Pohon Flutter",
    "Membedah anatomi kanvas mobile, hierarki widget, box constraints, dan jurus membasmi galat overflow selamanya demi aplikasi responsif 120 FPS.",
    "Program Studi Teknik Informatika"
)

# ---------------------------------------------------------------------
# Slide 2: Panduan Alat Pengujian (Tools)
# ---------------------------------------------------------------------
deck3.add_concept_with_code(
    "PANDUAN PRAKTIK",
    "Di Mana Kita Menguji Tampilan Hari Ini?",
    [
        "Opsi Terbaik Lab (Hemat RAM): Gunakan browser Chrome. Kompilasi kilat 5-10 detik tanpa beban emulator berat!",
        "Opsi Smartphone Fisik: Hubungkan kabel data USB dan jalankan Scrcpy untuk interaksi sentuhan jari nyata.",
        "Sihir Hot Reload: Cukup ubah angka atau warna di file kode, lalu simpan (Ctrl+S). Layar langsung ter-update seketika!"
    ],
    """# 1. Buka Terminal terintegrasi di VS Code (Ctrl + `)

# 2. Opsi A: Jalankan di Google Chrome (Ringan)
flutter run -d chrome

# 3. Opsi B: Jalankan di Smartphone Fisik via USB
scrcpy
flutter run

# 4. Saat kode diubah:
# Cukup simpan file (Ctrl + S) atau
# tekan huruf 'r' pada terminal untuk Hot Reload!""",
    filename="terminal_workflow.sh",
    tip="Gunakan Chrome saat mendesain tampilan awal agar laptop tidak panas dan baterai awet!",
    tag_color=COLOR_MINT,
    full_code_file="slide_02_panduan_tools_dan_workflow.dart"
)

# ---------------------------------------------------------------------
# Slide 3: Filosofi "Everything is a Widget"
# ---------------------------------------------------------------------
deck3.add_concept_with_code(
    "FILOSOFI DESAIN",
    "Konsep Inti: 'Everything is a Widget'",
    [
        "Di Flutter, hampir SEMUA hal adalah WIDGET: teks, tombol, gambar, bahkan jarak spasi dan perataan layar.",
        "Widget Kasat Mata: Text, ElevatedButton, Icon, Image.",
        "Widget Tata Letak: Padding (jarak tepi), Center (ke tengah), SizedBox (kotak jarak).",
        "Analogi Lego: Antarmuka aplikasi dirakit dengan menumpuk dan membungkus balok-balok kecil secara hierarkis."
    ],
    """// Contoh menyusun balok widget bertingkat:
Widget build(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {},
        child: const Text('Saya Adalah Balok Widget!'),
      ),
    ),
  );
}""",
    filename="balok_widget.dart",
    tip="Perhatikan bagaimana Center membungkus Padding, dan Padding membungkus Tombol!",
    tag_color=COLOR_YELLOW,
    full_code_file="slide_03_filosofi_everything_is_widget.dart"
)

# ---------------------------------------------------------------------
# Slide 4: Pondasi Kanvas: Mengapa Butuh MaterialApp & Scaffold?
# ---------------------------------------------------------------------
deck3.add_concept_with_code(
    "PONDASI KANVAS",
    "Mengapa Wajib Ada MaterialApp & Scaffold?",
    [
        "Bencana Pemula: Jika langsung menulis Text() tanpa Scaffold, layar akan hitam legam dengan teks bergaris bawah kuning ganda!",
        "MaterialApp: Widget gerbang utama penyetel tema Material Design, arah teks (LTR), dan rute navigasi.",
        "Scaffold: Kanvas dasar putih standar HP yang menyediakan slot AppBar, Body, FloatingActionButton, dan Drawer."
    ],
    """import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Beranda Kampus')),
        body: const Center(child: Text('Halo Mahasiswa!')),
      ),
    );
  }
}""",
    filename="main_scaffold.dart",
    tip="Anggap Scaffold seperti tiang tenda. Tanpa Scaffold, atap antarmuka Anda akan roboh!",
    tag_color=COLOR_CORAL,
    full_code_file="slide_04_materialapp_dan_scaffold.dart"
)

# ---------------------------------------------------------------------
# Slide 5: Di Balik Layar: The Three Trees
# ---------------------------------------------------------------------
deck3.add_concept_with_code(
    "ARSITEKTUR RESMI",
    "The Three Trees: Mengapa Hot Reload Sangat Cepat?",
    [
        "1. Widget Tree (Cetak Biru): Struktur konfigurasi deklaratif yang kita ketik. Sangat murah dan ringan dibuat ulang.",
        "2. Element Tree (Manajer): Mempertahankan struktur pohon di memori dan mengikat state ke layar fisik.",
        "3. RenderObject Tree (Tukang Gambar): Menghitung ukuran piksel fisik (layout) dan melukis warna ke kanvas GPU (paint).",
        "Sitasi Resmi: flutter.dev/docs/resources/architectural-overview"
    ],
    """// 1. Yang kita tulis (Widget Tree - Sangat Ringan):
Container(
  width: 100,
  height: 100,
  color: Colors.amber,
)

// 2. Di belakang layar (Element Tree):
// SingleChildRenderObjectElement menjaga siklus hidup.

// 3. Di GPU fisik (RenderObject Tree):
// RenderBox mengukur koordinat piksel & melukis warna.""",
    filename="arsitektur_tiga_pohon.dart",
    tip="Flutter hanya melukis ulang piksel yang berubah, bukan merombak seluruh layar ponsel!",
    tag_color=COLOR_CYAN,
    full_code_file="slide_05_arsitektur_the_three_trees.dart"
)

# ---------------------------------------------------------------------
# Slide 6: StatelessWidget vs StatefulWidget
# ---------------------------------------------------------------------
deck3.add_concept_with_code(
    "KLASIFIKASI WIDGET",
    "Kapan Pakai Stateless vs Stateful?",
    [
        "StatelessWidget (Komponen Diam / Statis):",
        "TIDAK PERNAH berubah tampilan setelah selesai digambar. Contoh: kartu profil statis, judul label, ikon. Sangat hemat baterai & RAM!",
        "StatefulWidget (Komponen Interaktif / Dinamis):",
        "Bisa berubah wujud ketika pengguna menekan tombol, mengetik teks, atau data tiba dari server internet. Menggunakan setState()."
    ],
    """// Contoh StatelessWidget (Statis & Ringan):
class KartuMahasiswa extends StatelessWidget {
  final String nama;
  final String nim;
  const KartuMahasiswa({super.key, required this.nama, required this.nim});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.badge),
        title: Text(nama),
        subtitle: Text(nim),
      ),
    );
  }
}""",
    filename="stateless_demo.dart",
    tip="Gunakan StatelessWidget secara default. Ubah ke Stateful HANYA jika datanya berubah di layar!",
    tag_color=COLOR_PURPLE,
    full_code_file="slide_06_stateless_vs_stateful.dart"
)

# ---------------------------------------------------------------------
# Slide 7: Siklus Hidup StatefulWidget
# ---------------------------------------------------------------------
deck3.add_concept_with_code(
    "SIKLUS HIDUP",
    "Tiga Fase Krusial Siklus Hidup StatefulWidget",
    [
        "1. initState(): Berjalan tepat 1 kali saat widget lahir. Tempat inisialisasi controller, timer, atau fetch data awal.",
        "2. build(): Berjalan berulang kali setiap kali setState() dipanggil. Tugasnya murni merender tampilan visual.",
        "3. dispose(): Berjalan saat halaman ditutup. Wajib membersihkan controller agar RAM HP tidak bocor (memory leak)!"
    ],
    """class _FormPageState extends State<FormPage> {
  late TextEditingController _namaCtrl;

  @override
  void initState() {
    super.initState();
    _namaCtrl = TextEditingController(); // 1. Lahir
  }

  @override
  Widget build(BuildContext context) {
    return TextField(controller: _namaCtrl); // 2. Tampil
  }

  @override
  void dispose() {
    _namaCtrl.dispose(); // 3. Bersihkan memori!
    super.dispose();
  }
}""",
    filename="lifecycle_demo.dart",
    tip="Jangan pernah memanggil request API di method build(), selalu taruh di initState()!",
    tag_color=COLOR_YELLOW,
    full_code_file="slide_07_siklus_hidup_stateful.dart"
)

# ---------------------------------------------------------------------
# Slide 8: Hukum Emas Box Constraints
# ---------------------------------------------------------------------
deck3.add_concept_with_code(
    "HUKUM TATA LETAK",
    "Hukum Emas: 'Constraints Down, Sizes Up'",
    [
        "Aturan Baku Mesin Tata Letak Flutter:",
        "1. Batasan (Constraints) turun dari Induk ke Anak: Induk memberi tahu batas min/max lebar dan tinggi.",
        "2. Ukuran (Sizes) naik dari Anak ke Induk: Anak memutuskan ukuran dirinya sendiri dalam koridor batas tersebut.",
        "3. Induk menentukan Posisi (Position) Anak di bidang layar."
    ],
    """// Induk (SizedBox) membatasi lebar MAKSIMAL 220px:
SizedBox(
  width: 220,
  height: 50,
  child: ElevatedButton(
    onPressed: () {},
    // Anak otomatis menyesuaikan ukuran dengan batas induk:
    child: const Text('Tombol Pas 220px'),
  ),
)""",
    filename="box_constraints.dart",
    tip="Jika sebuah tombol melebar memenuhi layar, periksa batasan yang diberikan oleh induknya!",
    tag_color=COLOR_MINT,
    full_code_file="slide_08_hukum_box_constraints.dart"
)

# ---------------------------------------------------------------------
# Slide 9: Penyelamat Layar Berponi: SafeArea
# ---------------------------------------------------------------------
deck3.add_concept_with_code(
    "ADAPTASI PERANGKAT",
    "Penyelamat Layar Berponi: Widget 'SafeArea'",
    [
        "Smartphone modern memiliki kamera tompel (punch-hole), poni atas (notch), dan bilah navigasi gesture di bagian bawah.",
        "Tanpa SafeArea, teks judul di pojok atas akan tertembus lensa kamera depan atau tertutup jam OS!",
        "SafeArea secara pintar mendeteksi batas fisik layar ponsel dan otomatis menyisipkan bantalan (padding) pelindung."
    ],
    """class LayarUtama extends StatelessWidget {
  const LayarUtama({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // Bungkus body dengan SafeArea agar aman dari poni HP:
      body: SafeArea(
        child: Text(
          'Teks ini aman dari lubang kamera!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}""",
    filename="safe_area_demo.dart",
    tip="Selalu bungkus konten body dengan SafeArea jika Anda tidak menggunakan AppBar bawaan!",
    tag_color=COLOR_CYAN,
    full_code_file="slide_09_penyelamat_layar_safearea.dart"
)

# ---------------------------------------------------------------------
# Slide 10: Single-Child Layout: Container, Padding, Center
# ---------------------------------------------------------------------
deck3.add_concept_with_code(
    "SINGLE-CHILD LAYOUT",
    "Container, Padding, & Center: Kapan Dipakai?",
    [
        "Center: Menaruh widget anak tepat di titik tengah ruang yang tersedia.",
        "Padding: Hanya memberi jarak rongga tepi tanpa dekorasi tambahan (lebih hemat komputasi dibanding Container).",
        "Container: Kotak bungkus multifungsi untuk memberi margin, padding, warna latar, border tebal, dan bayangan."
    ],
    """// Gunakan Padding jika hanya butuh jarak tepi:
const Padding(
  padding: EdgeInsets.symmetric(horizontal: 16.0),
  child: Text('Teks dengan margin samping'),
);

// Gunakan Container jika butuh dekorasi fisik:
Container(
  padding: const EdgeInsets.all(12),
  decoration: BoxDecoration(
    color: Colors.white,
    border: Border.all(color: Colors.black, width: 2),
  ),
  child: const Text('Kotak Berbingkai'),
);""",
    filename="single_child_demo.dart",
    tip="Jangan gunakan Container jika Anda hanya butuh jarak spasi kosong, gunakan Padding atau SizedBox!",
    tag_color=COLOR_YELLOW,
    full_code_file="slide_10_single_child_layout.dart"
)

# ---------------------------------------------------------------------
# Slide 11: Jebakan Klasik Lab: Error 'color' vs 'decoration'
# ---------------------------------------------------------------------
deck3.add_concept_with_code(
    "JEBAKAN MAUT LAB",
    "Jebakan: 'Cannot provide both a color and a decoration'",
    [
        "Penyebab Galat #1 Mahasiswa Pemula di Minggu ke-3!",
        "Penyebab: Menulis properti 'color:' langsung di Container SEKALIGUS memakai 'decoration: BoxDecoration()'.",
        "Aturan Emas: Jika Anda menggunakan BoxDecoration, properti warna WAJIB dipindahkan ke dalam BoxDecoration(color: ...)."
    ],
    """// ❌ SALAH (CRASH LAYAR MERAH):
// Container(
//   color: Colors.amber,
//   decoration: BoxDecoration(border: Border.all()),
// )

// ✅ BENAR (GAYA NEO-BRUTALISM RAPI):
Container(
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: const Color(0xFFFFE600), // Warna DI DALAM!
    border: Border.all(color: Colors.black, width: 2.5),
  ),
  child: const Text('Kotak Siku Neo-Brutalism Bersih!'),
)""",
    filename="box_decoration_fix.dart",
    tip="Ingat rumusnya: Begitu ada BoxDecoration, warna di luar wajib dicoret dan dipindah ke dalam!",
    tag_color=COLOR_CORAL,
    full_code_file="slide_11_jebakan_color_vs_decoration.dart"
)

# ---------------------------------------------------------------------
# Slide 12: Multi-Child Layout: Row & Column
# ---------------------------------------------------------------------
deck3.add_concept_with_code(
    "MULTI-CHILD LAYOUT",
    "Row (Mendatar) vs Column (Menurun)",
    [
        "Row: Menyusun daftar widget secara mendatar ke samping (sumbu utama = X horizontal).",
        "Column: Menyusun daftar widget secara menurun ke bawah (sumbu utama = Y vertikal).",
        "MainAxisAlignment: Mengatur jarak distribusi di sumbu utama (start, center, spaceBetween).",
        "CrossAxisAlignment: Mengatur perataan di sumbu silang (start, center, stretch)."
    ],
    """// Baris profil: Ikon di kiri, Teks di tengah, Tombol di kanan
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: const [
    Icon(Icons.account_circle, size: 40),
    Text('Ahmad Fauzi', style: TextStyle(fontSize: 16)),
    Icon(Icons.chevron_right),
  ],
)""",
    filename="row_column_demo.dart",
    tip="Gunakan MainAxisAlignment.spaceBetween untuk memisahkan judul di kiri dan aksi di kanan!",
    tag_color=COLOR_PURPLE,
    full_code_file="slide_12_multi_child_row_column.dart"
)

# ---------------------------------------------------------------------
# Slide 13: Trik Spasi: SizedBox vs Spacer vs Expanded
# ---------------------------------------------------------------------
deck3.add_concept_with_code(
    "MANAJEMEN SPASI",
    "Tiga Saudara Spasi: Kapan Memakai yang Mana?",
    [
        "1. SizedBox(width/height: 12): Memberikan jarak renggang statis tetap (ibarat ketukan spasi biasa).",
        "2. Spacer(): Pegas pendorong kosong yang memisahkan widget hingga ke ujung berlawanan.",
        "3. Expanded(child: ...): BUKAN ruang kosong, melainkan MEMBUNGKUS WIDGET agar ukurannya lentur mengisi sisa ruang."
    ],
    """Row(
  children: const [
    Text('Saldo Dompet'),
    SizedBox(width: 8), // 1. Jarak statis 8px
    Icon(Icons.wallet, color: Colors.green),
    Spacer(),           // 2. Pegas dorong ke ujung kanan!
    Text('Rp 150.000', style: TextStyle(fontWeight: FontWeight.bold)),
  ],
)""",
    filename="spasi_demo.dart",
    tip="Gunakan Spacer() saat Anda butuh tombol 'Lihat Semua' menempel tepat di pojok kanan layar!",
    tag_color=COLOR_MINT,
    full_code_file="slide_13_trik_spasi_sizedbox_spacer.dart"
)

# ---------------------------------------------------------------------
# Slide 14: Flexible vs Expanded: Kapan Pakai yang Mana?
# ---------------------------------------------------------------------
deck3.add_concept_with_code(
    "FLEKSIBILITAS UKURAN",
    "Flexible vs Expanded: Ketat vs Longgar",
    [
        "Banyak mahasiswa bingung membedakan Flexible dan Expanded.",
        "Expanded (Ketat / Tight): Memaksa widget anak MENGISI SELURUH sisa ruang yang ada tanpa ampun.",
        "Flexible (Longgar / Loose): Mengizinkan widget anak menyesuaikan diri sesuai ukuran aslinya, maksimal sebesar sisa ruang.",
        "Fakta Menarik: Expanded sejatinya adalah Flexible(fit: FlexFit.tight)."
    ],
    """Row(
  children: [
    // 1. Flexible: Kotak hanya selebar teksnya saja
    Flexible(
      fit: FlexFit.loose,
      child: Container(color: Colors.blue, child: const Text('Pendek')),
    ),
    // 2. Expanded: Kotak mengisi seluruh sisa layar yang ada!
    Expanded(
      child: Container(color: Colors.green, child: const Text('Penuh')),
    ),
  ],
)""",
    filename="flexible_vs_expanded.dart",
    tip="Gunakan Expanded jika Anda ingin tombol atau kartu memenuhi seluruh lebar yang tersisa!",
    tag_color=COLOR_YELLOW,
    full_code_file="slide_14_flexible_vs_expanded.dart"
)

# ---------------------------------------------------------------------
# Slide 15: Tata Letak Menumpuk: Stack & Positioned
# ---------------------------------------------------------------------
deck3.add_concept_with_code(
    "TATA LETAK MENUMPUK",
    "Stack & Positioned: Layering Ala Photoshop",
    [
        "Row dan Column menyusun elemen bersebelahan (tidak bisa saling menindih).",
        "Stack menyusun widget secara bertumpuk dari lapisan paling belakang ke paling depan.",
        "Widget Positioned: Menempelkan elemen anak persis pada koordinat piksel tertentu (top, right, bottom, left) di dalam Stack."
    ],
    """Stack(
  children: [
    // Lapisan 1 (Bawah): Ikon Lonceng
    IconButton(icon: const Icon(Icons.notifications, size: 36), onPressed: () {}),
    // Lapisan 2 (Atas): Stiker Merah Menempel di Pojok Kanan
    Positioned(
      top: 4,
      right: 4,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        color: Colors.red,
        child: const Text('9+', style: TextStyle(color: Colors.white, fontSize: 10)),
      ),
    ),
  ],
)""",
    filename="stack_positioned_demo.dart",
    tip="Sangat ideal untuk membuat badge diskon toko online atau avatar dengan lampu hijau status online!",
    tag_color=COLOR_CYAN,
    full_code_file="slide_15_layout_menumpuk_stack.dart"
)

# ---------------------------------------------------------------------
# Slide 16: Penyelamat Kategori: Widget Wrap
# ---------------------------------------------------------------------
deck3.add_concept_with_code(
    "PEMECAH BARIS OTOMATIS",
    "Widget 'Wrap': Penyelamat Tag & Kategori",
    [
        "Masalah: Anda memiliki 6 tombol filter kategori. Jika ditaruh di dalam Row, layar pasti overflow ke kanan!",
        "Solusi: Gunakan widget Wrap.",
        "Wrap otomatis menurunkan elemen ke baris baru di bawahnya jika sudah tidak muat di layar (seperti teks di Word).",
        "spacing: Jarak mendatar antar chip. runSpacing: Jarak vertikal antar baris."
    ],
    """Wrap(
  spacing: 8.0,     // Jarak horizontal antar tag
  runSpacing: 4.0,  // Jarak vertikal jika ganti baris
  children: const [
    Chip(label: Text('Flutter')),
    Chip(label: Text('Dart')),
    Chip(label: Text('Clean Architecture')),
    Chip(label: Text('State Management')),
    Chip(label: Text('Material 3')),
  ],
)""",
    filename="wrap_chip_demo.dart",
    tip="Gunakan Wrap saat membuat tag topik, hashtag, atau filter kategori yang jumlahnya tidak pasti!",
    tag_color=COLOR_CORAL,
    full_code_file="slide_16_penyelamat_kategori_wrap.dart"
)

# ---------------------------------------------------------------------
# Slide 17: Scrollable 1: SingleChildScrollView
# ---------------------------------------------------------------------
deck3.add_concept_with_code(
    "HALAMAN GULIR 1",
    "SingleChildScrollView: Anti Layar Macet",
    [
        "Secara bawaan, Column TIDAK BISA DIGULIR (statis). Jika isi formulir melebihi panjang layar, aplikasi akan langsung error!",
        "Saat keyboard virtual HP muncul untuk mengetik, tinggi layar menyusut drastis.",
        "Solusi Mudah: Bungkus Column Anda dengan SingleChildScrollView agar layar dapat digeser naik-turun dengan mulus."
    ],
    """class FormPendaftaran extends StatelessWidget {
  const FormPendaftaran({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Bungkus Column agar aman saat keyboard HP muncul:
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            TextField(decoration: InputDecoration(labelText: 'Nama')),
            SizedBox(height: 16),
            TextField(decoration: InputDecoration(labelText: 'NIM')),
            SizedBox(height: 16),
            TextField(decoration: InputDecoration(labelText: 'Alamat')),
          ],
        ),
      ),
    );
  }
}""",
    filename="scrollview_form.dart",
    tip="Selalu bungkus halaman formulir input dengan SingleChildScrollView!",
    tag_color=COLOR_YELLOW,
    full_code_file="slide_17_scrollable_singlechildscrollview.dart"
)

# ---------------------------------------------------------------------
# Slide 18: Scrollable 2: ListView.builder
# ---------------------------------------------------------------------
deck3.add_concept_with_code(
    "HALAMAN GULIR 2",
    "ListView.builder: Rahasia Performa 10.000 Data",
    [
        "Bahaya Column / ListView biasa: Me-render SEMUA data sekaligus ke memori RAM -> HP panas dan seketika crash (Out Of Memory)!",
        "ListView.builder menerapkan 'Lazy Loading' (Hanya Menggambar yang Tampak).",
        "Item yang digulir keluar layar akan dihancurkan, dan widget baru dirakit secara *on-demand*. RAM tetap dingin di 60-120 FPS!"
    ],
    """// Ringan dan hemat memori meski ada 10.000 baris data:
ListView.builder(
  itemCount: 10000,
  itemBuilder: (context, index) {
    return ListTile(
      leading: CircleAvatar(child: Text('${index + 1}')),
      title: Text('Data Mahasiswa #${index + 1}'),
      subtitle: const Text('Teknik Informatika angkatan 2026'),
      trailing: const Icon(Icons.verified, color: Colors.blue),
    );
  },
)""",
    filename="listview_builder_demo.dart",
    tip="Gunakan ListTile di dalam ListView.builder untuk membuat baris daftar berstandar industri!",
    tag_color=COLOR_MINT,
    full_code_file="slide_18_scrollable_listview_builder.dart"
)

# ---------------------------------------------------------------------
# Slide 19: Scrollable 3: GridView.builder
# ---------------------------------------------------------------------
deck3.add_concept_with_code(
    "HALAMAN GULIR 3",
    "GridView.builder: Katalog Produk Multi-Kolom",
    [
        "Bagaimana membuat katalog produk atau menu ubin 2 kolom ala e-commerce?",
        "Gunakan GridView.builder dengan SliverGridDelegateWithFixedCrossAxisCount.",
        "crossAxisCount: Jumlah kolom (misal: 2 kolom).",
        "crossAxisSpacing & mainAxisSpacing: Jarak celah antar ubin kotak.",
        "childAspectRatio: Rasio lebar banding tinggi (misal 0.85 untuk proporsi kartu rapi)."
    ],
    """GridView.builder(
  itemCount: 20,
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,        // 2 Kolom sejajar
    crossAxisSpacing: 10,     // Celah horizontal
    mainAxisSpacing: 10,      // Celah vertikal
    childAspectRatio: 0.85,   // Proporsi kartu
  ),
  itemBuilder: (context, index) {
    return Card(
      color: Colors.amber[100],
      child: Center(child: Text('Produk #${index + 1}')),
    );
  },
)""",
    filename="gridview_builder_demo.dart",
    tip="Jangan menghitung lebar kotak secara manual dengan MediaQuery jika bisa pakai GridView!",
    tag_color=COLOR_PURPLE,
    full_code_file="slide_19_scrollable_gridview_builder.dart"
)

# ---------------------------------------------------------------------
# Slide 20: Pemecahan Masalah 1: RenderFlex Overflow
# ---------------------------------------------------------------------
deck3.add_concept_with_code(
    "PEMECAHAN MASALAH 1",
    "Membasmi Bencana Garis Kuning-Hitam (Overflow)",
    [
        "Pernah melihat garis polisi belang kuning-hitam bertuliskan 'A RenderFlex overflowed by 48 pixels'?",
        "Penyebab: Teks atau gambar di dalam Row/Column melebihi batas piksel fisik layar ponsel pengguna.",
        "Jurus Penyelamat: Bungkus widget teks dengan Expanded() dan pasang overflow: TextOverflow.ellipsis."
    ],
    """Row(
  children: const [
    Icon(Icons.announcement, color: Colors.red),
    SizedBox(width: 8),
    // Expanded memastikan teks panjang tidak menabrak batas layar:
    Expanded(
      child: Text(
        'Pengumuman Beasiswa Prestasi Mahasiswa Informatika 2026',
        maxLines: 1,
        overflow: TextOverflow.ellipsis, // Terpotong anggun '...'
      ),
    ),
  ],
)""",
    filename="solusi_overflow.dart",
    tip="Di dalam Row, jangan biarkan Text berdiri sendiri tanpa perlindungan Expanded jika isinya dinamis!",
    tag_color=COLOR_CORAL,
    full_code_file="slide_20_solusi_renderflex_overflow.dart"
)

# ---------------------------------------------------------------------
# Slide 21: Pemecahan Masalah 2: Unbounded Height Error
# ---------------------------------------------------------------------
deck3.add_concept_with_code(
    "PEMECAHAN MASALAH 2",
    "Bencana: 'Vertical viewport was given unbounded height'",
    [
        "Penyebab: Memasukkan ListView langsung ke dalam Column tanpa batas tinggi yang jelas.",
        "Mengapa Crash? Column ingin tahu tinggi pasti anaknya, sedangkan ListView ingin memanjang tanpa batas hingga tak terhingga!",
        "Solusi Jurus 1: Bungkus ListView dengan Expanded() agar ia mengisi sisa ruang yang tersedia di layar.",
        "Solusi Jurus 2: Tambahkan shrinkWrap: true jika datanya hanya sedikit."
    ],
    """Column(
  children: [
    const Text('Daftar Mahasiswa Berprestasi', style: TextStyle(fontSize: 20)),
    const Divider(),
    // ❌ ListView tanpa pembungkus di dalam Column = CRASH!
    // ✅ BUNGKUS DENGAN EXPANDED:
    Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, i) => ListTile(title: Text('Juara ${i + 1}')),
      ),
    ),
  ],
)""",
    filename="unbounded_height_fix.dart",
    tip="Ingat rumusnya: ListView di dalam Column WAJIB dibungkus Expanded!",
    tag_color=COLOR_CYAN,
    full_code_file="slide_21_solusi_unbounded_height.dart"
)

# ---------------------------------------------------------------------
# Slide 22: Rahasia Koding Cepat 1: Trik Koma Ajaib (Trailing Comma)
# ---------------------------------------------------------------------
deck3.add_concept_with_code(
    "RAHASIA KODING CEPAT 1",
    "Trik Koma Ajaib: 'Trailing Comma' & Auto-Format",
    [
        "Pusing melihat kode Flutter memanjang ke kanan hingga 300 karakter dalam satu baris?",
        "Rahasia Senior Flutter: Selalu akhiri setiap kurung tutup dengan TANDA KOMA ','.",
        "Setelah pasang koma, cukup tekan Ctrl + S (Save). VS Code akan seketika merapikan kode secara vertikal berjenjang yang sangat indah!",
        "Tidak perlu lagi pusing mencari pasangan kurung secara manual."
    ],
    """// ❌ KODE KOTOR TANPA KOMA (SULIT DIBACA):
// Center(child: Padding(padding: EdgeInsets.all(8), child: Text('Halo')));

// ✅ DENGAN KOMA DI SETIAP UJUNG + SIMPAN (Ctrl + S):
Center(
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: const Text(
      'Halo Mahasiswa Informatika!',
      style: TextStyle(fontSize: 16),
    ), // <- Ada koma
  ), // <- Ada koma
) // <- Ada koma""",
    filename="trailing_comma_demo.dart",
    tip="Pasang koma di ujung widget, lalu tekan Ctrl + S. Kode Anda langsung rapi otomatis!",
    tag_color=COLOR_YELLOW,
    full_code_file="slide_22_trik_koma_ajaib_trailing.dart"
)

# ---------------------------------------------------------------------
# Slide 23: Rahasia Koding Cepat 2: Alt + Enter & Flutter Inspector
# ---------------------------------------------------------------------
deck3.add_concept_with_code(
    "RAHASIA KODING CEPAT 2",
    "Shortcut Sakti: Alt + Enter & Flutter Inspector",
    [
        "1. Shortcut 'Alt + Enter' (Quick Assist): Klik nama widget, tekan Alt + Enter, pilih 'Wrap with Padding' atau 'Wrap with Column'.",
        "2. Flutter Inspector (Penglihatan X-Ray): Buka tab Flutter Inspector di VS Code.",
        "Klik tombol 'Toggle Debug Paint' untuk melihat garis tepi biru dan padding hijau langsung di layar smartphone Anda!",
        "Klik elemen di layar HP, VS Code akan otomatis melompat ke baris kode terkait."
    ],
    """// Sebelum refactor:
Text('Halo Mahasiswa Informatika');

// Langkah:
// 1. Klik kata 'Text'
// 2. Tekan Alt + Enter (atau Cmd + . di MacOS)
// 3. Pilih 'Wrap with Padding'

// Hasil instan dalam 0.2 detik tanpa salah kurung:
Padding(
  padding: const EdgeInsets.all(8.0),
  child: Text('Halo Mahasiswa Informatika'),
)""",
    filename="shortcut_refactor.dart",
    tip="Gunakan 'Toggle Debug Paint' di Flutter Inspector saat mencari letak sumber overflow!",
    tag_color=COLOR_MINT,
    full_code_file="slide_23_shortcut_refactor_inspector.dart"
)

# ---------------------------------------------------------------------
# Slide 24: Lab Quest Mandiri Pertemuan 3
# ---------------------------------------------------------------------
deck3.add_lab_quest(
    3,
    "Membangun KTM Digital & Grid Menu Kampus",
    60,
    [
        "Buka proyek Flutter di VS Code dan jalankan target Google Chrome ('flutter run -d chrome') atau smartphone via USB.",
        "Gunakan 'SafeArea' pada body Scaffold agar antarmuka tidak terpotong lubang kamera ponsel.",
        "Buat Kartu KTM Digital menggunakan Container berlatar warna kuning (#FFE600), border hitam 2.5px siku-siku, dan avatar foto.",
        "Gunakan 'Stack & Positioned' untuk menaruh badge stiker: 'AKTIF 2026' di pojok kanan atas kartu KTM.",
        "Bungkus nama mahasiswa dengan 'Expanded' + 'TextOverflow.ellipsis' agar nama panjang tidak memicu garis belang overflow!",
        "Gunakan 'Wrap' untuk menampilkan daftar 3 keahlian minat (Skill Chips) di bawah nama mahasiswa.",
        "Di bawah KTM, gunakan 'GridView.builder' (2 kolom) untuk menampilkan 4 ubin menu: KHS, KRS, Jadwal, dan Presensi.",
        "Praktikkan trik 'Trailing Comma' dan shortcut 'Alt + Enter' di VS Code agar kode bersih tanpa bracket hell."
    ],
    "Tunjukkan kartu KTM Digital + Grid Menu di layar monitor/HP. Bebas 100% dari garis belang overflow dan rapi di bawah SafeArea!"
)

# ---------------------------------------------------------------------
# Simpan berkas PPTX Pertemuan 3
# ---------------------------------------------------------------------
output_path = os.path.join(output_dir, "PERTEMUAN_03_Widget_Tree_dan_Layouting.pptx")
deck3.save(output_path)
