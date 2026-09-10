"""
Generator Slide Pertemuan 05 (Edisi Masterpiece 18 Slide Lengkap & Super Ramah Awam)
Mata Kuliah: Pemrograman Piranti Bergerak (Flutter & Dart 2026)
Topik: Material 3, Adaptive Layout, Breakpoints, & Dynamic Theming
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

GITHUB_BASE_URL = "https://github.com/antonprafanto/mobile2026/blob/main/07_contoh_kode_program/pertemuan_05_material3_dan_responsive"

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

    def _add_header(self, slide, tag_text, title_text, tag_color=COLOR_YELLOW):
        tb_meta = slide.shapes.add_textbox(Inches(0.9), Inches(0.4), Inches(11.533), Inches(0.35))
        p_meta = tb_meta.text_frame.paragraphs[0]
        p_meta.text = self.course_name
        p_meta.font.name = FONT_HEADING
        p_meta.font.size = Pt(9)
        p_meta.font.bold = True
        p_meta.font.color.rgb = RGBColor(100, 100, 100)

        # Tag Badge
        tag = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, Inches(0.9), Inches(0.72), Inches(3.2), Inches(0.42))
        tag.fill.solid()
        tag.fill.fore_color.rgb = tag_color
        tag.line.color.rgb = COLOR_BLACK
        tag.line.width = Pt(2.0)

        tb_tag = slide.shapes.add_textbox(Inches(0.95), Inches(0.72), Inches(3.1), Inches(0.42))
        p_tag = tb_tag.text_frame.paragraphs[0]
        p_tag.text = tag_text
        p_tag.font.name = FONT_HEADING
        p_tag.font.size = Pt(10)
        p_tag.font.bold = True
        p_tag.font.color.rgb = COLOR_BLACK

        # Slide Title
        tb_title = slide.shapes.add_textbox(Inches(0.9), Inches(1.15), Inches(11.533), Inches(0.55))
        p_title = tb_title.text_frame.paragraphs[0]
        p_title.text = title_text
        p_title.font.name = FONT_HEADING
        p_title.font.size = Pt(20)
        p_title.font.bold = True
        p_title.font.color.rgb = COLOR_BLACK

    # 1. Slide Cover
    def add_cover(self, meeting_num, title, subtitle, author):
        slide = self.prs.slides.add_slide(self.blank_layout)
        self._set_canvas_bg(slide)

        self._add_neobrutal_card(slide, Inches(1.2), Inches(1.0), Inches(10.933), Inches(5.5), fill_color=COLOR_WHITE)

        top_bar = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, Inches(1.2), Inches(1.0), Inches(10.933), Inches(0.6))
        top_bar.fill.solid()
        top_bar.fill.fore_color.rgb = COLOR_YELLOW
        top_bar.line.color.rgb = COLOR_BLACK
        top_bar.line.width = Pt(2.5)

        tb_tb = slide.shapes.add_textbox(Inches(1.5), Inches(1.1), Inches(10.3), Inches(0.4))
        p_tb = tb_tb.text_frame.paragraphs[0]
        p_tb.text = f"{self.course_name}  ■  MODUL AJAR STANDAR 2026"
        p_tb.font.name = FONT_HEADING
        p_tb.font.size = Pt(11)
        p_tb.font.bold = True
        p_tb.font.color.rgb = COLOR_BLACK

        badge = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, Inches(1.6), Inches(2.0), Inches(2.8), Inches(0.55))
        badge.fill.solid()
        badge.fill.fore_color.rgb = COLOR_CYAN
        badge.line.color.rgb = COLOR_BLACK
        badge.line.width = Pt(2.0)

        tb_badge = slide.shapes.add_textbox(Inches(1.6), Inches(2.05), Inches(2.8), Inches(0.5))
        p_badge = tb_badge.text_frame.paragraphs[0]
        p_badge.text = f"PERTEMUAN {meeting_num:02d}"
        p_badge.font.name = FONT_HEADING
        p_badge.font.size = Pt(14)
        p_badge.font.bold = True
        p_badge.font.color.rgb = COLOR_BLACK

        tb_main = slide.shapes.add_textbox(Inches(1.6), Inches(2.7), Inches(10.0), Inches(1.8))
        tf_main = tb_main.text_frame
        tf_main.word_wrap = True

        p_t = tf_main.paragraphs[0]
        p_t.text = title
        p_t.font.name = FONT_HEADING
        p_t.font.size = Pt(28)
        p_t.font.bold = True
        p_t.font.color.rgb = COLOR_BLACK

        p_s = tf_main.add_paragraph()
        p_s.text = subtitle
        p_s.font.name = FONT_BODY
        p_s.font.size = Pt(12.5)
        p_s.font.color.rgb = RGBColor(60, 60, 60)
        p_s.space_before = Pt(10)

        tb_auth = slide.shapes.add_textbox(Inches(1.6), Inches(5.4), Inches(10.0), Inches(0.5))
        p_a = tb_auth.text_frame.paragraphs[0]
        p_a.text = f"👨‍🏫 Pengampu: {author}  •  Teknik Informatika"
        p_a.font.name = FONT_HEADING
        p_a.font.size = Pt(11)
        p_a.font.bold = True
        p_a.font.color.rgb = COLOR_BLACK

    # 2. Slide Konsep dengan Kode
    def add_concept_with_code(self, tag, title, bullets, code_snippet, filename="example.dart", tip=None, tag_color=COLOR_CYAN, full_code_file=None):
        slide = self.prs.slides.add_slide(self.blank_layout)
        self._set_canvas_bg(slide)
        self._add_header(slide, tag, title, tag_color=tag_color)

        # Left White Card (4.8 Inches)
        self._add_neobrutal_card(slide, Inches(0.9), Inches(1.8), Inches(4.8), Inches(5.1), fill_color=COLOR_WHITE)

        h_bar = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, Inches(0.9), Inches(1.8), Inches(4.8), Inches(0.48))
        h_bar.fill.solid()
        h_bar.fill.fore_color.rgb = tag_color
        h_bar.line.color.rgb = COLOR_BLACK
        h_bar.line.width = Pt(2.5)

        tb_hb = slide.shapes.add_textbox(Inches(1.1), Inches(1.86), Inches(4.4), Inches(0.38))
        p_hb = tb_hb.text_frame.paragraphs[0]
        p_hb.text = "💡 KONSEP INTI & CARA KERJA"
        p_hb.font.name = FONT_HEADING
        p_hb.font.size = Pt(10.5)
        p_hb.font.bold = True
        p_hb.font.color.rgb = COLOR_BLACK

        content_h = Inches(3.2) if tip else Inches(4.3)
        tb_l = slide.shapes.add_textbox(Inches(1.1), Inches(2.38), Inches(4.4), content_h)
        tf_l = tb_l.text_frame
        tf_l.word_wrap = True

        for i, b in enumerate(bullets):
            p = tf_l.paragraphs[0] if i == 0 else tf_l.add_paragraph()
            p.text = f"■  {b}"
            p.font.name = FONT_BODY
            p.font.size = Pt(10.5)
            p.font.color.rgb = RGBColor(20, 20, 20)
            p.space_after = Pt(8)

        if tip:
            tip_box = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, Inches(1.05), Inches(5.55), Inches(4.5), Inches(1.1))
            tip_box.fill.solid()
            tip_box.fill.fore_color.rgb = COLOR_YELLOW
            tip_box.line.color.rgb = COLOR_BLACK
            tip_box.line.width = Pt(2.0)

            tb_tip = slide.shapes.add_textbox(Inches(1.1), Inches(5.58), Inches(4.4), Inches(1.0))
            tf_tip = tb_tip.text_frame
            tf_tip.word_wrap = True
            p_tip = tf_tip.paragraphs[0]
            p_tip.text = f"💡 TIPS PRAKTIKUM:\n{tip}"
            p_tip.font.name = FONT_BODY
            p_tip.font.size = Pt(9.5)
            p_tip.font.bold = True
            p_tip.font.color.rgb = COLOR_BLACK

        # Right Sharp Black Code Box (6.433 Inches)
        self._add_neobrutal_card(slide, Inches(6.0), Inches(1.8), Inches(6.433), Inches(5.1), fill_color=COLOR_CODE_BG)

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

        if full_code_file:
            btn_x = Inches(6.15)
            btn_y = Inches(6.16)
            btn_w = Inches(6.133)
            btn_h = Inches(0.60)

            btn_shadow = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, btn_x + Inches(0.04), btn_y + Inches(0.04), btn_w, btn_h)
            btn_shadow.fill.solid()
            btn_shadow.fill.fore_color.rgb = COLOR_BLACK
            btn_shadow.line.fill.background()

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
            p_btn_sub.text = "💡 Buka di browser / salin source code: github.com/antonprafanto/mobile2026"
            p_btn_sub.font.name = FONT_BODY
            p_btn_sub.font.size = Pt(7.6)
            p_btn_sub.font.color.rgb = RGBColor(60, 60, 60)

    # 3. Slide Lab Quest
    def add_lab_quest(self, meeting_num, title, time_minutes, goals, success_criteria, full_code_file="slide_18_lab_quest_dashboard_responsif.dart"):
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

        tb = slide.shapes.add_textbox(Inches(1.3), Inches(2.40), Inches(10.7), Inches(3.2))
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

        if full_code_file:
            btn_x = Inches(1.3)
            btn_y = Inches(5.8)
            btn_w = Inches(10.7)
            btn_h = Inches(0.85)

            btn_shadow = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, btn_x + Inches(0.06), btn_y + Inches(0.06), btn_w, btn_h)
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
            p_btn_sub.text = "💡 Buka di browser: Kode lengkap Dashboard Mahasiswa Adaptif (Mobile & Tablet) + Toggle Tema di GitHub"
            p_btn_sub.font.name = FONT_BODY
            p_btn_sub.font.size = Pt(8.3)
            p_btn_sub.font.color.rgb = RGBColor(50, 50, 50)

    def save(self, filepath):
        self.prs.save(filepath)
        print(f"Deck slide berhasil disimpan ke: {filepath}")

# =====================================================================
# INISIALISASI PEMBUATAN SLIDE PERTEMUAN 05 (18 SLIDES MASTERPIECE)
# =====================================================================
output_dir = r"c:\Users\anton\vibecoding\mobile2026_v2\03_slide_presentasi"
deck5 = NeoBrutalistDeckBuilder()

# ---------------------------------------------------------------------
# Slide 1: Cover
# ---------------------------------------------------------------------
deck5.add_cover(
    5,
    "Material Design 3 & Antarmuka Responsif Lintas Platform",
    "Membangun Desain Adaptif yang Menyesuaikan Diri Otomatis pada Ponsel, Tablet, dan Desktop Menggunakan ColorScheme Seed & Breakpoints Modern.",
    "TIM DOSEN PEMROGRAMAN PIRANTI BERGERAK"
)

# ---------------------------------------------------------------------
# Slide 2: Tools & Preview Responsif
# ---------------------------------------------------------------------
deck5.add_concept_with_code(
    "SETUP & ALAT UJI",
    "Menguji UI Responsif di Browser Chrome (Hemat RAM)",
    [
        "Tidak perlu membeli banyak perangkat fisik atau membuka emulator tablet yang sangat berat di PC lab.",
        "Cukup jalankan: 'flutter run -d chrome'. Peramban web Google Chrome memakan RAM < 150MB.",
        "Tarik sisi kanan jendela Chrome untuk menyimulasikan layar ponsel (lebar <600dp) hingga layar tablet/desktop (>840dp).",
        "Hot Reload (<1 detik) membuat iterasi desain responsif menjadi sangat instan dan menyenangkan."
    ],
    """// Membaca lebar layar peramban saat di-resize:
final screenWidth = MediaQuery.sizeOf(context).width;

// Deteksi sederhana jenis perangkat:
final isMobile = screenWidth < 600;

print(isMobile ? 'Tampilan: Ponsel' : 'Tampilan: Tablet/PC');""",
    filename="responsive_tools.dart",
    tip="Gunakan 'flutter run -d chrome' untuk menghemat memori PC laboratorium Anda!",
    tag_color=COLOR_YELLOW,
    full_code_file="slide_02_tools_dan_preview_responsif.dart"
)

# -------------------------------------------------------------
# Slide 3: Filosofi Desain Material 3 (M3)
# -------------------------------------------------------------
deck5.add_concept_with_code(
    "DESAIN SISTEM M3",
    "Filosofi Material 3: Sudut Alami & Komponen Modern",
    [
        "Material 3 adalah evolusi desain antarmuka resmi Google untuk Android 12 ke atas dan lintas platform.",
        "Ciri khas utama: Sudut membulat alami (12dp s.d. 16dp), bayangan elevasi halus, dan tombol hierarki tonal.",
        "Komponen tombol standar M3: 'FilledButton' (aksi utama), 'FilledButton.tonal' (aksi sekunder), dan 'OutlinedButton'.",
        "Wajib diaktifkan di Flutter dengan menetapkan: 'useMaterial3: true' di dalam ThemeData."
    ],
    """MaterialApp(
  theme: ThemeData(
    useMaterial3: true, // Wajib diaktifkan!
    colorSchemeSeed: Colors.indigo,
  ),
  home: const Scaffold(
    body: Center(
      child: FilledButton(
        onPressed: null,
        child: Text('Tombol Material 3'),
      ),
    ),
  ),
);""",
    filename="material3_philosophy.dart",
    tip="Gunakan FilledButton sebagai pengganti ElevatedButton lama untuk standar UI 2026!",
    tag_color=COLOR_CYAN,
    full_code_file="slide_03_filosofi_material3.dart"
)

# -------------------------------------------------------------
# Slide 4: Sistem Warna & ColorScheme Seed
# -------------------------------------------------------------
deck5.add_concept_with_code(
    "PALET WARNA DINAMIS",
    "ColorScheme Seed: Satu Warna Menghasilkan Seluruh Tema",
    [
        "Di era Material 3, Anda tidak perlu lagi menentukan puluhan kode warna heksadesimal secara manual!",
        "Cukup sediakan satu warna benih: 'colorSchemeSeed: Colors.teal'.",
        "Flutter otomatis menghitung palet harmonis: 'primary', 'primaryContainer', 'secondary', 'surface', dsb.",
        "Dapat dibaca di mana saja melalui: 'Theme.of(context).colorScheme'."
    ],
    """// Mengambil palet warna aktif di widget:
final colors = Theme.of(context).colorScheme;

Card(
  color: colors.primaryContainer,
  child: Text(
    'Teks Kontras Otomatis',
    style: TextStyle(color: colors.onPrimaryContainer),
  ),
);""",
    filename="color_scheme_seed.dart",
    tip="Selalu pasangkan wadah warna (primaryContainer) dengan teks pasangannya (onPrimaryContainer)!",
    tag_color=COLOR_CORAL,
    full_code_file="slide_04_color_scheme_seed.dart"
)

# -------------------------------------------------------------
# Slide 5: Tipografi & TextTheme M3
# -------------------------------------------------------------
deck5.add_concept_with_code(
    "HIRARKI TIPOGRAFI",
    "Skala Tipografi M3: Display, Headline, Title, Body",
    [
        "Hindari melakukan hardcode 'fontSize: 24' pada widget Text Anda!",
        "Gunakan skala teks resmi Google: Display (sangat besar), Headline (judul bab), Title (judul kartu), Body (paragraf isi).",
        "Standar default teks aplikasi adalah 'bodyMedium' (14sp).",
        "Keuntungan: Otomatis mematuhi pengaturan aksesibilitas pembesaran huruf di smartphone pengguna tunanetra."
    ],
    """final textTheme = Theme.of(context).textTheme;

Text('Judul Halaman', style: textTheme.titleLarge);
Text('Judul Kartu', style: textTheme.titleMedium);
Text('Paragraf Artikel', style: textTheme.bodyMedium);
Text('Keterangan Kecil', style: textTheme.labelSmall);""",
    filename="typography_hierarchy.dart",
    tip="Memanfaatkan TextTheme menjamin aplikasi Anda ramah aksesibilitas tunanetra!",
    tag_color=COLOR_PURPLE,
    full_code_file="slide_05_typography_text_theme.dart"
)

# -------------------------------------------------------------
# Slide 6: Dynamic Theming (Light vs Dark Mode)
# -------------------------------------------------------------
deck5.add_concept_with_code(
    "THEME MODE",
    "Mendukung Tema Terang & Gelap (Light & Dark)",
    [
        "Aplikasi modern wajib mendukung mode gelap demi kenyamanan mata dan efisiensi baterai layar OLED.",
        "MaterialApp memiliki 3 properti kunci: 'theme' (terang), 'darkTheme' (gelap), dan 'themeMode'.",
        "'ThemeMode.system' akan otomatis mengikuti setelan tema di sistem operasi HP pengguna.",
        "Uji kontras teks Anda pada kedua mode sebelum mengumpulkan tugas praktikum."
    ],
    """MaterialApp(
  theme: ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.indigo,
    brightness: Brightness.light,
  ),
  darkTheme: ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.indigo,
    brightness: Brightness.dark,
  ),
  themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
);""",
    filename="dynamic_theme.dart",
    tip="Gunakan SegmentedButton untuk memberikan opsi ganti tema Terang/Gelap/Sistem.",
    tag_color=COLOR_MINT,
    full_code_file="slide_06_dynamic_theme_light_dark.dart"
)

# -------------------------------------------------------------
# Slide 7: MediaQuery (Dimensi Layar Global)
# -------------------------------------------------------------
deck5.add_concept_with_code(
    "RESPONSIF 1",
    "MediaQuery: Membaca Ukuran Layar Fisik Total",
    [
        "MediaQuery memberikan informasi menyeluruh tentang perangkat fisik tempat aplikasi berjalan.",
        "Membaca dimensi: 'MediaQuery.sizeOf(context).width' dan '.height'.",
        "Membaca orientasi: 'MediaQuery.orientationOf(context) == Orientation.portrait'.",
        "⚠️ Catatan Awam: MediaQuery mengukur SELURUH layar HP, bukan ruang sempit di dalam dialog atau split-view."
    ],
    """// Membaca ukuran layar total:
final size = MediaQuery.sizeOf(context);

// Deteksi orientasi:
final isPortrait = MediaQuery.orientationOf(context) 
    == Orientation.portrait;

print('Lebar Layar: ${size.width} dp');""",
    filename="mediaquery_screen.dart",
    tip="Gunakan MediaQuery.sizeOf(context) daripada MediaQuery.of(context).size untuk efisiensi rebuild!",
    tag_color=COLOR_YELLOW,
    full_code_file="slide_07_mediaquery_dimensions.dart"
)

# -------------------------------------------------------------
# Slide 8: LayoutBuilder (Batasan Widget Lokal)
# -------------------------------------------------------------
deck5.add_concept_with_code(
    "RESPONSIF 2",
    "LayoutBuilder: Mengetahui Ruang Tersedia dari Parent",
    [
        "Inilah senjata rahasia membangun komponen antarmuka yang benar-benar modular dan fleksibel.",
        "LayoutBuilder menyediakan objek 'BoxConstraints': memberi tahu lebar maksimum yang boleh digunakan widget anak.",
        "Sangat ideal untuk kartu yang bisa tampil di ponsel penuh (lebar 400dp) maupun di dalam tablet split-view (lebar 300dp).",
        "Hukum Emas: Jika membuat widget modular, gunakan LayoutBuilder, BUKAN MediaQuery!"
    ],
    """LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth < 500) {
      return const Column(children: [...]); // Vertikal
    } else {
      return const Row(children: [...]);    // Horizontal
    }
  },
);""",
    filename="layout_builder_demo.dart",
    tip="LayoutBuilder memungkinkan satu widget yang sama tampil rapi di HP, tablet, maupun dialog pop-up!",
    tag_color=COLOR_CYAN,
    full_code_file="slide_08_layoutbuilder_constraints.dart"
)

# -------------------------------------------------------------
# Slide 9: Standar Breakpoints Industri
# -------------------------------------------------------------
deck5.add_concept_with_code(
    "BREAKPOINTS",
    "Standar Ambang Layar Google (Compact, Medium, Expanded)",
    [
        "Compact (< 600 dp): Mayoritas smartphone dalam posisi tegak (portrait). Tata letak 1 kolom.",
        "Medium (600 dp s.d. 840 dp): Tablet kecil, ponsel lipat terbuka (*foldable*), atau ponsel miring (landscape).",
        "Expanded (> 840 dp): Tablet besar, laptop, dan layar monitor desktop. Tata letak multi-kolom.",
        "Gunakan enum atau helper class sederhana untuk mengklasifikasikan tampilan aplikasi Anda."
    ],
    """enum WindowSize { compact, medium, expanded }

WindowSize getSizeClass(double width) {
  if (width < 600) return WindowSize.compact;
  if (width < 840) return WindowSize.medium;
  return WindowSize.expanded;
}""",
    filename="breakpoints_helper.dart",
    tip="Angka sakti yang wajib Anda hafal: 600 dp adalah batas antara Ponsel dan Tablet!",
    tag_color=COLOR_CORAL,
    full_code_file="slide_09_breakpoints_helper.dart"
)

# -------------------------------------------------------------
# Slide 10: OrientationBuilder (Portrait vs Landscape)
# -------------------------------------------------------------
deck5.add_concept_with_code(
    "ORIENTASI LAYAR",
    "OrientationBuilder: Merespons Rotasi Layar Smartphone",
    [
        "Ketika pengguna memiringkan ponselnya, tinggi layar berkurang drastis sementara lebar bertambah.",
        "OrientationBuilder mendengarkan event rotasi dan membangun ulang UI secara reaktif.",
        "Pola umum: Mengubah GridView dari 2 kolom (portrait) menjadi 4 kolom (landscape).",
        "Mencegah elemen formulir terpotong oleh keyboard saat ponsel dalam posisi miring."
    ],
    """OrientationBuilder(
  builder: (context, orientation) {
    final isPortrait = orientation == Orientation.portrait;
    return GridView.count(
      crossAxisCount: isPortrait ? 2 : 4,
      children: [...],
    );
  },
);""",
    filename="orientation_builder.dart",
    tip="Uji rotasi layar di emulator atau Chrome dengan shortcut Ctrl + F11 / rotasi jendela!",
    tag_color=COLOR_PURPLE,
    full_code_file="slide_10_orientation_builder.dart"
)

# -------------------------------------------------------------
# Slide 11: Navigasi Adaptif: NavigationBar vs NavigationRail
# -------------------------------------------------------------
deck5.add_concept_with_code(
    "NAVIGASI ADAPTIF",
    "Navigasi Layar Lebar: NavigationBar vs NavigationRail",
    [
        "Di ponsel: Jempol pengguna mudah menjangkau bilah bawah -> Gunakan 'NavigationBar'.",
        "Di tablet/desktop: Layar terlalu lebar untuk menu bawah -> Pindahkan ke bilah samping kiri: 'NavigationRail'.",
        "Kedua widget ini memiliki properti 'destinations' dan 'selectedIndex' yang serupa sehingga mudah digabungkan.",
        "Standar baku pengalaman pengguna profesional di tahun 2026."
    ],
    """Scaffold(
  body: Row(
    children: [
      if (isTablet)
        NavigationRail(
          selectedIndex: _idx,
          destinations: [...],
        ),
      Expanded(child: _pages[_idx]),
    ],
  ),
  bottomNavigationBar: isTablet ? null : NavigationBar(...),
);""",
    filename="adaptive_navigation.dart",
    tip="NavigationRail di samping menghemat ruang vertikal tablet yang sangat berharga!",
    tag_color=COLOR_MINT,
    full_code_file="slide_11_adaptive_navigation.dart"
)

# -------------------------------------------------------------
# Slide 12: Grid Responsif Dinamis
# -------------------------------------------------------------
deck5.add_concept_with_code(
    "LAYOUT GRID",
    "Grid Responsif: Menyesuaikan Kolom Otomatis",
    [
        "Jangan mematok jumlah kolom grid secara kaku (misal: crossAxisCount: 2). Di tablet, kartu akan melar aneh!",
        "Gunakan rumus pembagi atau fungsi helper berdasarkan lebar ruang: width < 600 (1 kolom), < 900 (2 kolom), > 900 (3 kolom).",
        "Atau gunakan: 'SliverGridDelegateWithMaxCrossAxisExtent' dengan maxCrossAxisExtent: 250.",
        "Hasilnya: Berapa pun lebar layar yang ditarik pengguna, ukuran kartu tetap proporsional."
    ],
    """int calculateColumns(double width) {
  if (width < 600) return 1; // Ponsel
  if (width < 900) return 2; // Tablet
  return 3;                  // Desktop
}

GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: calculateColumns(constraints.maxWidth),
  ),
  itemBuilder: (ctx, i) => Card(...),
);""",
    filename="responsive_grid.dart",
    tip="Uji grid Anda pada resolusi tablet agar kartu tidak terlihat gepeng atau meregang.",
    tag_color=COLOR_YELLOW,
    full_code_file="slide_12_responsive_grid_layout.dart"
)

# -------------------------------------------------------------
# Slide 13: Pola Arsitektur UI: Master-Detail Pattern
# -------------------------------------------------------------
deck5.add_concept_with_code(
    "POLA ARSITEKTUR UI",
    "Pola Master-Detail: Tumpukan HP vs Split Pane Tablet",
    [
        "Di ponsel: Pengguna mengetuk item daftar -> Berpindah ke layar detail baru (Navigator.push).",
        "Di tablet: Daftar (Master) dan rincian (Detail) ditampilkan berdampingan dalam satu layar (Split Pane).",
        "Pengguna tablet tidak perlu bolak-balik menekan tombol 'Back' untuk membaca isi berkas.",
        "Merupakan pola desain antarmuka wajib pada aplikasi email, pesan chat, dan katalog e-commerce."
    ],
    """if (isTablet)
  Row(
    children: [
      SizedBox(width: 300, child: MasterList()),
      Expanded(child: DetailView(selectedItem)),
    ],
  )
else
  MasterList(); // Di ponsel: push() ke layar baru""",
    filename="master_detail_pattern.dart",
    tip="Pola Master-Detail meningkatkan produktivitas pengguna tablet hingga 2 kali lipat!",
    tag_color=COLOR_CYAN,
    full_code_file="slide_13_master_detail_pattern.dart"
)

# -------------------------------------------------------------
# Slide 14: Widget Adaptif Bawaan Flutter
# -------------------------------------------------------------
deck5.add_concept_with_code(
    "WIDGET ADAPTIF",
    "Komponen .adaptive(): Otomatis Rasa Android & iOS",
    [
        "Flutter menyediakan konstruktor khusus '.adaptive()' untuk komponen yang memiliki perbedaan gaya drastis.",
        "Contoh: 'Switch.adaptive()' akan bergaya Material 3 di Android/Web, dan bergaya saklar hijau lonjong di iPhone.",
        "'CircularProgressIndicator.adaptive()' menampilkan lingkaran putar di Android dan pemintal abu di iOS.",
        "Memberikan sensasi aplikasi asli (*native feel*) tanpa perlu menulis percabangan kode 'if (Platform.isIOS)' manual."
    ],
    """// Saklar otomatis menyesuaikan OS:
Switch.adaptive(
  value: _isActive,
  onChanged: (val) => setState(() => _isActive = val),
);

// Loading spinner otomatis:
CircularProgressIndicator.adaptive();""",
    filename="adaptive_widgets.dart",
    tip="Gunakan konstruktor .adaptive() untuk elemen kontrol formulir lintas platform!",
    tag_color=COLOR_CORAL,
    full_code_file="slide_14_adaptive_widgets_native.dart"
)

# -------------------------------------------------------------
# Slide 15: Komponen Desain Reusable (Component Kit)
# -------------------------------------------------------------
deck5.add_concept_with_code(
    "REUSABLE COMPONENT",
    "Membangun Komponen Kit: Kartu Statistik Kuliah",
    [
        "Aplikasi profesional tidak menduplikasi kode tata letak berulang-ulang (*Don't Repeat Yourself / DRY*).",
        "Bungkus pola UI yang sering dipakai ke dalam StatelessWidget tersendiri (misal: 'StatCard').",
        "Terapkan warna dari 'Theme.of(context).colorScheme' agar kartu otomatis berubah saat tema berganti gelap/terang.",
        "Mendukung konsistensi desain sistem di seluruh tim pengembang mahasiswa."
    ],
    """class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(child: ListTile(...));
  }
}""",
    filename="stat_card_component.dart",
    tip="Komponen reusable yang bersih memudahkan pembagian tugas antar anggota kelompok proyek!",
    tag_color=COLOR_PURPLE,
    full_code_file="slide_15_reusable_component_kit.dart"
)

# -------------------------------------------------------------
# Slide 16: FittedBox Scaling (Anti-Teks Terpotong)
# -------------------------------------------------------------
deck5.add_concept_with_code(
    "AKSESIBILITAS & FONT",
    "FittedBox: Menangani Skala Teks Besar (Anti-Overflow)",
    [
        "Masalah nyata: Pengguna lanjut usia menyetel ukuran teks HP menjadi 150% (Font Scale) di setelan sistem.",
        "Akibatnya: Angka saldo bank 'Rp 10.000.000' meledak dan memicu error garis kuning-hitam (RenderFlex overflow).",
        "Solusi: Bungkus teks dengan widget 'FittedBox(fit: BoxFit.scaleDown)'.",
        "Teks akan otomatis menyusut anggun agar muat di dalam lebar kotak yang disediakan tanpa pernah terpotong."
    ],
    """Container(
  width: 200,
  child: FittedBox(
    fit: BoxFit.scaleDown, // Menyusut jika kepanjangan
    child: Text(
      'Rp 999.999.999,-',
      style: TextStyle(fontSize: 32),
    ),
  ),
);""",
    filename="fitted_box_scaling.dart",
    tip="Gunakan FittedBox pada label saldo, harga produk, dan nomor telepon penting!",
    tag_color=COLOR_MINT,
    full_code_file="slide_16_fittedbox_scaling.dart"
)

# -------------------------------------------------------------
# Slide 17: Rangkuman Checklist UI Responsif Standar 2026
# -------------------------------------------------------------
deck5.add_concept_with_code(
    "CHECKLIST PRODUKSI",
    "5 Aturan Emas Desain Antarmuka Mobile Responsif",
    [
        "1. Dilarang Hardcode Dimensi: Jangan menulis 'width: 360', gunakan Expanded, Flexible, atau MediaQuery.",
        "2. Hormati Breakpoint 600dp: Pisahkan tata letak 1 kolom ponsel vs multi-kolom tablet.",
        "3. Navigasi Adaptif: NavigationBar di bawah untuk ponsel, NavigationRail di samping untuk tablet.",
        "4. Uji Rotasi Landscape: Pastikan antarmuka tidak terpotong saat layar dimiringkan.",
        "5. Cek Uji Kontras Light/Dark: Pastikan teks terbaca jelas pada tema terang maupun gelap."
    ],
    """// Checklist Uji Praktikum Responsif:
// [✓] Tampilan tidak overflow saat jendela ditarik sempit
// [✓] Menu pindah ke samping saat layar melebihi 600dp
// [✓] Tombol dan kartu menggunakan token warna Material 3
// [✓] Berjalan mulus di Chrome Web & Ponsel Fisik""",
    filename="checklist_responsive.dart",
    tip="Jadikan kelima checklist ini sebagai acuan penilaian proyek UTS kelompok Anda!",
    tag_color=COLOR_YELLOW,
    full_code_file="slide_17_checklist_responsive_ui.dart"
)

# -------------------------------------------------------------
# Slide 18: Lab Quest Tugas 05: Dashboard Responsif
# -------------------------------------------------------------
deck5.add_lab_quest(
    5,
    "Dashboard Akademik Responsif Multi-Platform & Dynamic Theme",
    60,
    [
        "Bangun aplikasi Dashboard Mahasiswa yang adaptif terhadap perubahan ukuran layar ponsel (<600dp) dan tablet (>=600dp).",
        "Terapkan Navigasi Adaptif: Di layar ponsel tampilkan 'NavigationBar' di bawah, di layar tablet tampilkan 'NavigationRail' di samping kiri.",
        "Sediakan tombol di AppBar untuk beralih antara Tema Terang (Light Mode) dan Tema Gelap (Dark Mode) secara instan.",
        "Gunakan 'GridView' adaptif untuk menu akademik (KRS, Nilai, Jadwal, Presensi): 2 kolom di ponsel, 4 kolom di tablet.",
        "Tampilkan informasi dimensi layar saat ini (dalam dp) secara dinamis menggunakan 'MediaQuery.sizeOf(context)'.",
        "Target Pengujian: Jalankan di browser Chrome ('flutter run -d chrome') lalu tarik lebar jendela untuk membuktikan adaptasi antarmuka!"
    ],
    "Dashboard bertransisi otomatis antara BottomNav dan NavRail saat ditarik melintasi batas 600dp, dan warna tema berganti rapi.",
    full_code_file="slide_18_lab_quest_dashboard_responsif.dart"
)

# Simpan berkas presentasi
output_pptx = os.path.join(output_dir, "PERTEMUAN_05_Material3_dan_Responsive_UI.pptx")
deck5.save(output_pptx)
