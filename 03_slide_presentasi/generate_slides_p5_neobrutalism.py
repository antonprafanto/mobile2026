"""
Generator Slide Pertemuan 05 (Edisi Masterpiece 18 Slide Lengkap & Komprehensif)
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
    "Menguji UI Responsif di Chrome (Hemat RAM & Anti-Lag)",
    [
        "💡 Analogi Simulator: Emulator Android Studio di PC lab sering berat seperti helikopter. Gunakan Chrome sebagai simulator super ringan!",
        "🚀 Cukup jalankan: 'flutter run -d chrome'. Konsumsi RAM di bawah 150MB sehingga perangkat laboratorium dengan spesifikasi standar tetap bekerja optimal.",
        "↔️ Efek Karet Gelang: Cukup tarik tepi jendela Chrome untuk menyimulasikan layar ponsel (<600dp), tablet (600-840dp), hingga laptop (>840dp).",
        "⚡ Fitur Hot Reload instan (<1 detik) membuat Anda bisa melihat adaptasi tata letak secara langsung tanpa perlu restart."
    ],
    """// Membaca lebar layar peramban saat di-resize:
final screenWidth = MediaQuery.sizeOf(context).width;

// Deteksi sederhana jenis perangkat:
final isMobile = screenWidth < 600;

print(isMobile ? 'Tampilan: Ponsel' : 'Tampilan: Tablet/PC');""",
    filename="responsive_tools.dart",
    tip="Tarik pinggir jendela Chrome untuk menguji responsivitas tanpa perlu emulator berat!",
    tag_color=COLOR_YELLOW,
    full_code_file="slide_02_tools_dan_preview_responsif.dart"
)

# -------------------------------------------------------------
# Slide 3: Filosofi Desain Material 3 (M3)
# -------------------------------------------------------------
deck5.add_concept_with_code(
    "DESAIN SISTEM M3",
    "Filosofi Material 3: Sudut Alami, Tombol, & 3 Varian Kartu",
    [
        "🛋️ Analogi Furnitur Modern: M3 hadir layaknya sofa Skandinavia minimalis—tanpa sudut tajam menusuk, bayangan lembut, dan warna menyejukkan.",
        "🔘 Tombol Modern: Gunakan 'FilledButton' (aksi utama kontras), 'FilledButton.tonal' (aksi sekunder lembut), dan 'OutlinedButton'.",
        "🃏 3 Varian Kartu M3: 'Card()' (elevated/melayang halus), 'Card.filled()' (rata warna tonal), dan 'Card.outlined()' (garis tepi halus).",
        "⚙️ Syarat Wajib: Selalu pasang 'useMaterial3: true' di dalam ThemeData agar komponen otomatis beralih ke standar modern 2026."
    ],
    """MaterialApp(
  theme: ThemeData(
    useMaterial3: true, // Wajib diaktifkan!
    colorSchemeSeed: Colors.indigo,
  ),
  home: Scaffold(
    body: Column(
      children: [
        FilledButton(onPressed: (){}, child: Text('Aksi')),
        Card(child: Text('Card Elevated')),
        Card.outlined(child: Text('Card Outlined')),
      ],
    ),
  ),
);""",
    filename="material3_philosophy.dart",
    tip="Gunakan Card.outlined untuk tampilan bersih dan FilledButton untuk tombol aksi utama!",
    tag_color=COLOR_CYAN,
    full_code_file="slide_03_filosofi_material3.dart"
)

# -------------------------------------------------------------
# Slide 4: Sistem Warna & ColorScheme Seed
# -------------------------------------------------------------
deck5.add_concept_with_code(
    "PALET WARNA DINAMIS",
    "ColorScheme Seed: Pohon Warna Harmonis & Aturan Kaus-Sablon",
    [
        "🌱 Analogi Pohon Warna: Anda tanam 1 biji benih ('colorSchemeSeed: Colors.teal'), Google menumbuhkan 30+ warna daun & bunga harmonis otomatis!",
        "👕 Aturan Kaus & Sablon (Prefix 'on'): Jika kaus berwarna gelap ('primary'), tinta tulisan di atasnya wajib ('onPrimary'). Jangan sablon gelap di atas gelap!",
        "📦 Pasangan Kontainer: Gunakan 'primaryContainer' (warna wadah kotak) dipadukan dengan 'onPrimaryContainer' (warna teks di dalamnya).",
        "🎯 Cara Memanggil: Ambil seluruh palet warna aktif di widget mana saja melalui: 'Theme.of(context).colorScheme'."
    ],
    """// Mengambil palet warna aktif di widget:
final colors = Theme.of(context).colorScheme;

Card(
  color: colors.primaryContainer, // Warna kotak kaus
  child: Text(
    'Teks Kontras Otomatis',
    style: TextStyle(color: colors.onPrimaryContainer), // Warna sablon
  ),
);""",
    filename="color_scheme_seed.dart",
    tip="Hukum Emas Kontras: Wadah 'xyzContainer' WAJIB dipasangkan dengan teks 'onXyzContainer'!",
    tag_color=COLOR_CORAL,
    full_code_file="slide_04_color_scheme_seed.dart"
)

# -------------------------------------------------------------
# Slide 5: Tipografi & TextTheme M3
# -------------------------------------------------------------
deck5.add_concept_with_code(
    "HIRARKI TIPOGRAFI",
    "Skala Tipografi M3: Hirarki Koran & Majalah (Anti-Hardcode)",
    [
        "📰 Analogi Koran & Majalah: Desain punya susunan rapi—Display (baliho), Headline (judul bab), Title (judul kartu), Body (isi bacaan).",
        "🚫 Dilarang Keras: Hindari menulis 'fontSize: 24' manual! Ukuran kaku membuat teks tidak fleksibel terhadap setelan HP pengguna.",
        "👓 Peduli Lansia: Saat kakek/nenek memperbesar ukuran huruf sistem di HP (150%), 'TextTheme' otomatis menyesuaikan diri tanpa merusak mata.",
        "📖 Standar Default: Standar paragraf utama aplikasi Flutter adalah 'bodyMedium' (14sp), nyaman dibaca di segala kerapatan layar."
    ],
    """final textTheme = Theme.of(context).textTheme;

Text('Judul Halaman', style: textTheme.titleLarge);
Text('Judul Kartu', style: textTheme.titleMedium);
Text('Paragraf Artikel', style: textTheme.bodyMedium);
Text('Keterangan Kecil', style: textTheme.labelSmall);""",
    filename="typography_hierarchy.dart",
    tip="Gunakan TextTheme agar aplikasi Anda otomatis mematuhi aksesibilitas pembesaran font!",
    tag_color=COLOR_PURPLE,
    full_code_file="slide_05_typography_text_theme.dart"
)

# -------------------------------------------------------------
# Slide 6: Dynamic Theming (Light vs Dark Mode)
# -------------------------------------------------------------
deck5.add_concept_with_code(
    "THEME MODE",
    "Tema Dinamis: Kacamata Hitam Transitions (Light, Dark, System)",
    [
        "🕶️ Analogi Lensa Transitions: Bening saat di dalam ruangan, otomatis gelap sejuk saat di luar terik matahari. Begitu pula tema terang dan gelap.",
        "🌙 Manfaat Mode Gelap: Mengistirahatkan mata pengguna di malam hari dan menghemat baterai layar OLED/AMOLED smartphone secara signifikan.",
        "⚙️ Tiga Pasak Utama: MaterialApp memiliki properti 'theme' (terang), 'darkTheme' (gelap), dan pengatur saklar 'themeMode'.",
        "🔄 Ikut Setelan HP: 'ThemeMode.system' akan otomatis mendeteksi apakah smartphone pengguna sedang mode gelap tanpa perlu tombol manual."
    ],
    """MaterialApp(
  theme: ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.indigo,
    brightness: Brightness.light, // Terang
  ),
  darkTheme: ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.indigo,
    brightness: Brightness.dark,  // Gelap
  ),
  themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
);""",
    filename="dynamic_theme.dart",
    tip="Gunakan SegmentedButton untuk memberi opsi ganti tema Terang, Gelap, atau Ikut Sistem!",
    tag_color=COLOR_MINT,
    full_code_file="slide_06_dynamic_theme_light_dark.dart"
)

# -------------------------------------------------------------
# Slide 7: MediaQuery (Dimensi Layar Global)
# -------------------------------------------------------------
deck5.add_concept_with_code(
    "RESPONSIF 1",
    "MediaQuery: Sertifikat Luas Tanah Seluruh Layar HP",
    [
        "📐 Analogi Luas Tanah Rumah: MediaQuery mengukur luas total seluruh bentang kaca layar HP dari ujung kiri atas ke kanan bawah.",
        "📏 Membaca Dimensi: 'MediaQuery.sizeOf(context).width' dan '.height' mengembalikan lebar & tinggi total dalam satuan dp.",
        "📱 Deteksi Poni & Keyboard: MediaQuery juga mengetahui area terpotong kamera depan (Safe Area / paddingOf) dan munculnya keyboard.",
        "⚠️ Batasan: MediaQuery mengukur SELURUH layar fisik, bukan ruang sempit di dalam kartu atau dialog pop-up split-view."
    ],
    """// Membaca ukuran layar total:
final size = MediaQuery.sizeOf(context);

// Deteksi orientasi tegak vs miring:
final isPortrait = MediaQuery.orientationOf(context) 
    == Orientation.portrait;

print('Lebar Layar Total: ${size.width} dp');""",
    filename="mediaquery_screen.dart",
    tip="Gunakan MediaQuery.sizeOf(context) alih-alih MediaQuery.of(context).size untuk efisiensi rebuild!",
    tag_color=COLOR_YELLOW,
    full_code_file="slide_07_mediaquery_dimensions.dart"
)

# -------------------------------------------------------------
# Slide 8: LayoutBuilder (Batasan Widget Lokal)
# -------------------------------------------------------------
deck5.add_concept_with_code(
    "RESPONSIF 2",
    "LayoutBuilder: Ruang Kosong Sudut Kamar untuk Lemari",
    [
        "🚪 Analogi Lemari Sudut Kamar: Lemari tidak peduli luas seluruh rumah (MediaQuery), yang penting berapa ruang kosong di sudut kamar!",
        "📦 BoxConstraints: LayoutBuilder memberikan 'constraints.maxWidth'—lebar maksimum yang disiapkan oleh widget induk (*parent*).",
        "🧩 Senjata Komponen Modular: Satu kartu yang sama bisa otomatis tampil vertikal (Column) jika sempit, atau horizontal (Row) jika lapang.",
        "👑 Hukum Emas Widget: Jika Anda membangun widget modular/reusable, selalu gunakan LayoutBuilder, BUKAN MediaQuery!"
    ],
    """LayoutBuilder(
  builder: (context, constraints) {
    // Membaca ruang yang diizinkan oleh parent:
    if (constraints.maxWidth < 500) {
      return const Column(children: [...]); // Vertikal
    } else {
      return const Row(children: [...]);    // Horizontal
    }
  },
);""",
    filename="layout_builder_demo.dart",
    tip="LayoutBuilder membuat widget Anda fleksibel tampil di HP penuh, tablet split-pane, maupun pop-up!",
    tag_color=COLOR_CYAN,
    full_code_file="slide_08_layoutbuilder_constraints.dart"
)

# -------------------------------------------------------------
# Slide 9: Standar Breakpoints Industri
# -------------------------------------------------------------
deck5.add_concept_with_code(
    "BREAKPOINTS",
    "Standar Breakpoints Google: Ukuran Baju S, M, L Layar Digital",
    [
        "👕 Analogi Ukuran Baju: Tubuh punya ukuran baju S, M, L. Layar digital pun memiliki 3 klasifikasi standar industri resmi Google:",
        "📱 S - Compact (< 600 dp): Mayoritas smartphone posisi tegak (*portrait*). Tata letak 1 kolom sederhana.",
        "📖 M - Medium (600 s.d. 840 dp): Tablet kecil, HP lipat (*foldable*), atau HP miring (*landscape*). Tata letak 2 kolom.",
        "🖥️ L - Expanded (> 840 dp): Tablet besar, laptop, dan monitor desktop. Tata letak multi-kolom berdampingan."
    ],
    """enum WindowSize { compact, medium, expanded }

WindowSize getSizeClass(double width) {
  if (width < 600) return WindowSize.compact;  // Ukuran S (HP)
  if (width < 840) return WindowSize.medium;   // Ukuran M (Tablet)
  return WindowSize.expanded;                  // Ukuran L (Desktop)
}""",
    filename="breakpoints_helper.dart",
    tip="Nilai ambang batas (threshold) standar: 600 dp adalah garis pemisah antara tata letak Ponsel dan Tablet!",
    tag_color=COLOR_CORAL,
    full_code_file="slide_09_breakpoints_helper.dart"
)

# -------------------------------------------------------------
# Slide 10: OrientationBuilder (Portrait vs Landscape)
# -------------------------------------------------------------
deck5.add_concept_with_code(
    "ORIENTASI LAYAR",
    "OrientationBuilder: Memutar Buku Sketsa (Tegak vs Miring)",
    [
        "🎨 Analogi Buku Gambar: Saat buku tegak kita menggambar ke bawah; saat dimiringkan kita menggambar melebar ke samping.",
        "🔄 Reaksi Rotasi Layar: 'OrientationBuilder' mendengarkan perputaran HP secara instan dan membangun ulang antarmuka yang cocok.",
        "📊 Adaptasi Grid Cerdas: Ubah daftar dari 2 kolom (saat portrait) menjadi 4 kolom (saat landscape) agar ruang tidak terbuang sia-sia.",
        "⌨️ Anti-Terpotong Keyboard: Pada posisi landscape, tinggi layar sangat terbatas, pastikan elemen formulir dapat di-scroll vertikal."
    ],
    """OrientationBuilder(
  builder: (context, orientation) {
    final isPortrait = orientation == Orientation.portrait;
    return GridView.count(
      // 2 kolom saat tegak, 4 kolom saat miring:
      crossAxisCount: isPortrait ? 2 : 4,
      children: [...],
    );
  },
);""",
    filename="orientation_builder.dart",
    tip="Uji rotasi layar dengan shortcut Ctrl+F11 di emulator atau ubah rasio jendela Chrome!",
    tag_color=COLOR_PURPLE,
    full_code_file="slide_10_orientation_builder.dart"
)

# -------------------------------------------------------------
# Slide 11: Navigasi Adaptif: NavigationBar vs NavigationRail
# -------------------------------------------------------------
deck5.add_concept_with_code(
    "NAVIGASI ADAPTIF",
    "Navigasi Adaptif: Ergonomi Jangkauan Jempol Tangan Manusia",
    [
        "👍 Analogi Jangkauan Jempol: Saat memegang HP satu tangan, jempol berada di bawah. Saat pegang tablet dua tangan di pinggir, jempol berada di sisi layar!",
        "📱 Layar Ponsel (<600dp): Gunakan 'NavigationBar' di dasar layar agar navigasi mudah dijangkau satu tangan pengguna.",
        "🖥️ Layar Tablet (>=600dp): Pindahkan ke 'NavigationRail' di sisi kiri layar untuk menghemat ruang vertikal yang sangat berharga.",
        "🤝 Berbagi Halaman: Keduanya berbagi 'selectedIndex' dan daftar tujuan yang sama sehingga logika navigasi tidak perlu ditulis ulang."
    ],
    """Scaffold(
  body: Row(
    children: [
      if (isTablet)
        NavigationRail( // Samping kiri di tablet
          selectedIndex: _idx,
          destinations: [...],
        ),
      Expanded(child: _pages[_idx]),
    ],
  ),
  bottomNavigationBar: isTablet ? null : NavigationBar(...), // Bawah di HP
);""",
    filename="adaptive_navigation.dart",
    tip="NavigationRail di sisi kiri membuat antarmuka tablet terlihat elegan dan berkelas profesional!",
    tag_color=COLOR_MINT,
    full_code_file="slide_11_adaptive_navigation.dart"
)

# -------------------------------------------------------------
# Slide 12: Grid Responsif Dinamis
# -------------------------------------------------------------
deck5.add_concept_with_code(
    "LAYOUT GRID",
    "Grid Responsif Dinamis: Rak Pajangan Toko Fleksibel",
    [
        "🏪 Analogi Rak Toko: Rak sempit memuat 2 produk, rak lebar memuat 4 hingga 6 produk tanpa membuat kemasan produk melar gepeng.",
        "🚫 Jebakan Desain (Anti-Pattern): Menulis 'crossAxisCount: 2' statis. Pada layar tablet yang lebar, kartu produk akan meregang secara tidak proporsional!",
        "🧮 Solusi Rumus Adaptif: Tentukan jumlah kolom lewat rumus lebar: lebar <600 (1-2 kolom), <900 (3 kolom), >900 (4-6 kolom).",
        "✨ Opsi Otomatis: Atau gunakan 'SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 220)'—Flutter yang menghitungkan kolomnya!"
    ],
    """int calculateColumns(double width) {
  if (width < 600) return 1; // Ponsel (1 kolom)
  if (width < 900) return 2; // Tablet (2 kolom)
  return 3;                  // Desktop (3 kolom)
}

GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: calculateColumns(constraints.maxWidth),
  ),
  itemBuilder: (ctx, i) => Card(...),
);""",
    filename="responsive_grid.dart",
    tip="Gunakan maxCrossAxisExtent jika Anda ingin ukuran kartu selalu konsisten di segala resolusi layar!",
    tag_color=COLOR_YELLOW,
    full_code_file="slide_12_responsive_grid_layout.dart"
)

# -------------------------------------------------------------
# Slide 13: Pola Arsitektur UI: Master-Detail Pattern
# -------------------------------------------------------------
deck5.add_concept_with_code(
    "POLA ARSITEKTUR UI",
    "Pola Master-Detail: WhatsApp di HP vs WhatsApp Web di Komputer",
    [
        "💬 Analogi WhatsApp & Gmail: Di HP, kita ketuk kontak -> tumpukan layar ganti ke chat -> tekan tombol Back untuk kembali.",
        "💻 Di Laptop/Tablet: Daftar kontak (Master) di sisi kiri dan obrolan pesan (Detail) di sisi kanan tampil berdampingan dalam satu layar.",
        "⚡ Efisiensi 2x Lipat: Pengguna tablet tidak perlu lelah bolak-balik menekan tombol 'Back' hanya untuk membaca rincian data.",
        "🏛️ Standar Industri: Pola arsitektur wajib untuk aplikasi e-commerce, portal berita, email, dan catatan medis rumah sakit."
    ],
    """if (isTablet)
  Row(
    children: [
      SizedBox(width: 300, child: MasterList()), // Kiri: Daftar
      Expanded(child: DetailView(selectedItem)),  // Kanan: Rincian
    ],
  )
else
  MasterList(); // Di ponsel: push() ke layar rincian baru""",
    filename="master_detail_pattern.dart",
    tip="Pola Master-Detail meningkatkan produktivitas pengguna tablet hingga dua kali lipat!",
    tag_color=COLOR_CYAN,
    full_code_file="slide_13_master_detail_pattern.dart"
)

# -------------------------------------------------------------
# Slide 14: Widget Adaptif Bawaan Flutter
# -------------------------------------------------------------
deck5.add_concept_with_code(
    "WIDGET ADAPTIF",
    "Widget Adaptif: Colokan Adaptor Universal Internasional",
    [
        "🔌 Analogi Steker Adaptor: Satu colokan charger yang otomatis cocok di stopkontak Indonesia maupun stopkontak luar negeri tanpa adaptor tambahan.",
        "🔄 Konstruktor '.adaptive()': Flutter menyediakan komponen yang otomatis berubah bentuk mengikuti gaya asli sistem operasi perangkat.",
        "🟢 Switch.adaptive(): Tampil saklar Material 3 di Android/Web, dan saklar bulat hijau lonjong khas iOS di perangkat iPhone/iPad.",
        "⏳ CircularProgressIndicator.adaptive(): Berputar gaya Material di Android dan animasi pemintal abu-abu khas Cupertino di iOS."
    ],
    """// Saklar otomatis menyesuaikan Android / iOS:
Switch.adaptive(
  value: _isActive,
  onChanged: (val) => setState(() => _isActive = val),
);

// Loading spinner otomatis bergaya native OS:
CircularProgressIndicator.adaptive();""",
    filename="adaptive_widgets.dart",
    tip="Gunakan Switch.adaptive() dan Slider.adaptive() agar aplikasi Anda berasa native di Android dan iPhone!",
    tag_color=COLOR_CORAL,
    full_code_file="slide_14_adaptive_widgets_native.dart"
)

# -------------------------------------------------------------
# Slide 15: Komponen Desain Reusable (Component Kit)
# -------------------------------------------------------------
deck5.add_concept_with_code(
    "REUSABLE COMPONENT",
    "Reusable Component Kit: Balok LEGO Standar Berkualitas",
    [
        "🧱 Analogi Balok LEGO: Membangun istana megah dari balok LEGO standar yang rapi, bukan mencetak ulang cetakan plastik dari nol setiap saat!",
        "🚫 Prinsip DRY (Don't Repeat Yourself): Jangan menduplikasi kode kartu statistik berulang kali di berbagai berkas layar.",
        "📦 Buat Widget Kustom: Bungkus pola UI yang sering dipakai ke dalam StatelessWidget tersendiri (misal: 'StatCard').",
        "🎨 Desain Token Terpusat: Selalu ambil warna dari 'Theme.of(context).colorScheme' agar kartu otomatis berubah saat tema berganti."
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
    "FittedBox Scaling: Koper Pakaian Berkemasan Vakum",
    [
        "🧳 Analogi Koper Vakum: Saat baju terlalu tebal, kantong vakum mengempiskannya agar tetap muat rapi di dalam koper tanpa merusak resleting.",
        "💥 Masalah Nyata: Kakek/nenek menyetel pembesaran font HP 150% -> angka saldo bank 'Rp 999.999.999,-' meledak memicu overflow garis kuning-hitam!",
        "🛡️ Solusi Anggun: Bungkus teks dengan widget protektif: 'FittedBox(fit: BoxFit.scaleDown)'.",
        "✨ Menyusut Otomatis: Teks akan otomatis menyusut anggun jika ruang terbatas, dan tetap berukuran normal jika ruang tersedia cukup."
    ],
    """Container(
  width: 200,
  child: FittedBox(
    fit: BoxFit.scaleDown, // Otomatis menyusut jika kepanjangan
    child: Text(
      'Rp 999.999.999,-',
      style: TextStyle(fontSize: 32),
    ),
  ),
);""",
    filename="fitted_box_scaling.dart",
    tip="Wajib pasang FittedBox pada label harga, saldo dompet, nomor rekening, dan kartu identitas!",
    tag_color=COLOR_MINT,
    full_code_file="slide_16_fittedbox_scaling.dart"
)

# -------------------------------------------------------------
# Slide 17: Rangkuman Checklist UI Responsif Standar 2026
# -------------------------------------------------------------
deck5.add_concept_with_code(
    "CHECKLIST PRODUKSI",
    "5 Aturan Emas Desain UI Responsif (Checklist Penilaian UTS)",
    [
        "1. Dilarang Hardcode Dimensi: Hindari menulis 'width: 380', gunakan Expanded, Flexible, atau LayoutBuilder.",
        "2. Hormati Breakpoint Sakral 600dp: Bedakan tata letak 1 kolom untuk ponsel dan multi-kolom untuk tablet.",
        "3. Navigasi Adaptif Ergonomis: Bottom NavigationBar di ponsel, Side NavigationRail di tablet.",
        "4. Lolos Uji Rotasi Layar: Pastikan antarmuka tidak terpotong saat layar dimiringkan horizontal.",
        "5. Kontras Warna Sempurna: Pastikan teks terbaca jelas di Tema Terang maupun Tema Gelap."
    ],
    """// Checklist Uji Praktikum Responsif Standar 2026:
// [✓] Tampilan bebas dari overflow garis kuning-hitam
// [✓] Navigasi pindah ke samping saat layar melebihi 600dp
// [✓] Tombol dan kartu menggunakan token warna Material 3
// [✓] Berjalan mulus di Chrome Web & Smartphone Fisik""",
    filename="checklist_responsive.dart",
    tip="Jadikan kelima checklist ini sebagai acuan penilaian proyek UTS kelompok Anda agar meraih nilai A!",
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
