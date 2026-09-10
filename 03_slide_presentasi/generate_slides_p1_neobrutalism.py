"""
Generator Slide Pertemuan 01 (Edisi Masterpiece 18 Slide Lengkap & Komprehensif)
Mata Kuliah: Pemrograman Piranti Bergerak (Flutter & Dart 2026)
Standar Desain: Neo-Brutalism Murni (designprompts.dev/neo-brutalism)
- ZERO BORDER RADIUS: Sudut 90 derajat siku murni tanpa kelengkungan (MSO_SHAPE.RECTANGLE).
- BOLD SOLID BLACK BORDERS: Garis hitam tegas 2.5 Pt (#000000).
- HARD OFFSET BLOCK SHADOWS: Bayangan blok hitam solid +0.08 inch di belakang kartu.
- PALET NEO-BRUTALISM: Warm Cream (#FAF8F5), Canary Yellow (#FFE600), Electric Cyan (#38BDF8), Mint (#4ADE80), Coral (#FB7185), Lavender (#C084FC).
- FITUR UTAMA: 100% SLIDE PEMBAHASAN DISERTAI CONTOH KODE / PERINTAH TERMINAL, ANALOGI MEMBUMI, DAN PANDUAN STEP-BY-STEP PEMULA.
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
GITHUB_BASE_URL = "https://github.com/antonprafanto/mobile2026/blob/main/07_contoh_kode_program/pertemuan_01_pengantar_flutter"

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

    # 2. Slide Split Screen: Konsep & Tips di Kiri + Kode / Terminal di Kanan
    def add_concept_with_code(self, tag, title, bullets, code_snippet, filename="terminal_commands.sh", tip=None, tag_color=COLOR_YELLOW, full_code_file=None):
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
    def add_lab_quest(self, meeting_num, title, time_minutes, goals, success_criteria, full_code_file="slide_17_lab_quest_tugas_01.dart"):
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
        p_b.text = f"⏱️ ALOKASI: {time_minutes} MENIT  ■  TARGET UJI: SMARTPHONE FISIK VIA USB / BROWSER CHROME"
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

    def save(self, filepath):
        self.prs.save(filepath)
        print(f"[OK] Slide Pertemuan 01 Berhasil Disimpan: {filepath}")


# =====================================================================
# PEMBUATAN 18 SLIDE MASTERPIECE PERTEMUAN 01
# =====================================================================

output_dir = os.path.dirname(os.path.abspath(__file__))
deck1 = NeoBrutalistDeckBuilder()

# ---------------------------------------------------------------------
# Slide 1: Cover
# ---------------------------------------------------------------------
deck1.add_cover(
    1,
    "Pengantar Pemrograman Piranti Bergerak\n& Ekosistem Flutter Modern",
    "Fondasi arsitektur mobile, revolusi single-codebase, konfigurasi alat kerja lab, dan langkah perdana menjadi mobile software engineer profesional.",
    "Program Studi Teknik Informatika"
)

# ---------------------------------------------------------------------
# Slide 2: Roadmap Semester 16 Minggu
# ---------------------------------------------------------------------
deck1.add_concept_with_code(
    "ROADMAP PERKULIAHAN",
    "Apa Saja yang Akan Kita Bangun Semester Ini?",
    [
        "Fase 1 (Minggu 1–5): Fondasi Dart, Rekayasa Layout UI, Navigasi GoRouter, & Standar Material 3.",
        "Fase 2 (Minggu 6–8): State Management BLoC/Cubit, Arsitektur Bersih (Clean Architecture), & Ujian Tengah Semester (UTS).",
        "Fase 3 (Minggu 9–12): Jaringan RESTful API (Dio), Database Luring (Offline-First), Cloud BaaS Firebase, & Fitur Hardware (Kamera/GPS).",
        "Fase 4 (Minggu 13–16): Keamanan Kunci Rahasia, AI On-Device, Pengujian Otomatis (Unit Testing), & Demo Day UAS Expo!"
    ],
    """// STRUKTUR TARGET CAPAIAN SEMESTER:
final roadmapSemester = {
  'Sprint 1': 'UI/UX & GoRouter Navigation',
  'Sprint 2': 'Cubit State & Clean Architecture (UTS)',
  'Sprint 3': 'Dio REST API & Offline Database',
  'Sprint 4': 'Hardware Sensor, Security & Cloud',
  'Final': 'Mobile App Expo / Demo Day (UAS)',
};

// Setiap mahasiswa akan memiliki portofolio
// aplikasi nyata di GitHub yang siap dipamerkan!""",
    filename="roadmap_overview.dart",
    full_code_file="slide_02_roadmap_semester.dart",
    tip="Fokuslah pada pemahaman pola arsitektur, bukan sekadar menghafal sintaks!",
    tag_color=COLOR_MINT
)

# ---------------------------------------------------------------------
# Slide 3: Mengapa Mobile Development di 2026?
# ---------------------------------------------------------------------
deck1.add_concept_with_code(
    "RELEVANSI INDUSTRI",
    "Mengapa Mempelajari Mobile App Development?",
    [
        "Era Mobile-First: Lebih dari 70% aktivitas internet global diakses melalui layar sentuh smartphone.",
        "Efisiensi Single Codebase: Satu tim rekayasa menghasilkan aplikasi Android, iOS, Web, dan Desktop sekaligus.",
        "Pemangkasan Biaya: Menghemat 50% waktu rilis dan anggaran pengembangan dibanding membangun dua aplikasi native terpisah.",
        "Karier Mobile Engineer: Kebutuhan konsisten tinggi di industri teknologi perbankan, e-commerce, dan startup unicorn."
    ],
    """// PERBANDINGAN BIAYA & SUMBER DAYA:
// ❌ CARA LAMA (2 Tim Terpisah):
// Tim Android (Kotlin) -> Butuh 3 Engineer
// Tim iOS (Swift)      -> Butuh 3 Engineer
// Total Biaya: 2x Lipat, Waktu Rilis Tidak Sinkron

// ✅ CARA MODERN (Flutter Single Codebase):
// 1 Tim Flutter (Dart) -> Cukup 3 Engineer
// Output: Rilis serentak di Android & App Store!""",
    filename="industri_komparasi.dart",
    full_code_file="slide_03_relevansi_mobile.dart",
    tip="Perusahaan startup lebih memilih Flutter karena 'Time-to-Market' yang sangat cepat!",
    tag_color=COLOR_YELLOW
)

# ---------------------------------------------------------------------
# Slide 4: Konsep Inti: Dart vs Flutter
# ---------------------------------------------------------------------
deck1.add_concept_with_code(
    "KONSEP DASAR",
    "Memahami Perbedaan: Apa Itu Dart & Flutter?",
    [
        "Banyak pemula mengira Dart dan Flutter adalah benda yang sama!",
        "Dart (Bahan Baku / Bahasa): Bahasa pemrograman OOP buatan Google dengan fitur Sound Null Safety untuk menulis logika.",
        "Flutter (Kotak Perkakas / Framework): Kumpulan komponen visual (tombol, teks, slider) dan mesin gambar kanvas.",
        "Analogi: Dart adalah 'Mesin & Kabel Listrik Mobil', sedangkan Flutter adalah 'Bodi Mengkilap, Setir, & Dashboard-nya'."
    ],
    """// 1. DART (Bahasa & Logika Otak):
class Mobil {
  final String merk;
  Mobil({required this.merk});
  void klakson() => print('Tin tin!');
}

// 2. FLUTTER (Komponen Visual UI di Layar):
ElevatedButton(
  onPressed: () => Mobil(merk: 'Tesla').klakson(),
  child: const Text('Bunyikan Klakson'),
)""",
    filename="dart_vs_flutter.dart",
    full_code_file="slide_04_dart_vs_flutter.dart",
    tip="Anda mengetik kode menggunakan bahasa Dart, untuk memanggil widget buatan Flutter!",
    tag_color=COLOR_CYAN
)

# ---------------------------------------------------------------------
# Slide 5: Evolusi Arsitektur Mobile
# ---------------------------------------------------------------------
deck1.add_concept_with_code(
    "EVOLUSI TEKNOLOGI",
    "Tiga Cara Membangun Aplikasi Mobile Modern",
    [
        "1. Native Murni (Kotlin / Swift): Sangat cepat, namun wajib menulis kode dua kali secara terpisah.",
        "2. Hybrid WebView (Cordova / Ionic): Membungkus website HTML/CSS ke dalam aplikasi HP. Terasa berat dan patah-patah.",
        "3. Canvas Engine (Flutter): Menggambar setiap piksel langsung ke layar GPU menggunakan mesin grafis mandiri.",
        "Hasil Flutter: Tampilan 100% identik di semua merek HP dengan performa mulus 60–120 FPS!"
    ],
    """// MENGAPA FLUTTER BEGITU MULUS?
// Pendekatan Lain (React Native / Hybrid):
// Dart/JS Code -> [JavaScript Bridge] -> Native OS OEM Widget
// (Jembatan penerjemah sering memicu bottleneck)

// Pendekatan Flutter:
// Dart Code -> Flutter Engine (Impeller) -> Skia/GPU Canvas
// (Bebas jembatan, digambar langsung ke GPU layar!)""",
    filename="arsitektur_grafis.dart",
    full_code_file="slide_05_arsitektur_grafis.dart",
    tip="Karena menggambar sendiri pikselnya, Flutter bebas dari bug perbedaan OS Android antar vendor!",
    tag_color=COLOR_PURPLE
)

# ---------------------------------------------------------------------
# Slide 6: Di Balik Layar: Engine Impeller & Skia
# ---------------------------------------------------------------------
deck1.add_concept_with_code(
    "ARSITEKTUR ENGINE",
    "Impeller: Rahasia Bebas Patah-Patah (Shader Jank)",
    [
        "Flutter bekerja layaknya Game Engine modern (seperti Unity).",
        "Dulu (Mesin Skia): Animasi pertama kali kadang tersendat (*jank*) karena shader grafis baru dikompilasi saat aplikasi berjalan.",
        "Sekarang (Mesin Impeller 2026): Semua efek grafis di-precompile sebelum aplikasi dibuka pengguna.",
        "Hasil: Scroll super licin, transisi bayangan mulus, dan konsumsi daya baterai jauh lebih hemat!"
    ],
    """# Memeriksa engine grafis yang aktif di terminal:
flutter doctor -v

# Impeller kini aktif secara default pada:
# - iOS & iPadOS (Metal backend)
# - Android modern (Vulkan backend)

# Menghasilkan pengalaman pengguna (UX) 120 FPS
# setara dengan aplikasi native kelas atas!""",
    filename="impeller_status.sh",
    full_code_file="slide_06_impeller_engine_demo.dart",
    tip="Impeller adalah alasan mengapa aplikasi perbankan modern beralih ke Flutter!",
    tag_color=COLOR_CORAL
)

# ---------------------------------------------------------------------
# Slide 7: Diagnostik Instalasi: Membedah 'flutter doctor'
# ---------------------------------------------------------------------
deck1.add_concept_with_code(
    "DIAGNOSTIK LAB",
    "Langkah Awal: Membaca Hasil 'flutter doctor'",
    [
        "Perintah Wajib: Jalankan 'flutter doctor -v' untuk memeriksa kesehatan instalasi SDK di komputer Anda.",
        "Tanda [✓]: Komponen terpasang sempurna dan siap digunakan.",
        "Tanda [!]: Ada lisensi Android yang belum disetujui (cukup jalankan perintah lisensi).",
        "Tanda [✗]: SDK atau ekstensi belum terpasang (harus diinstal terlebih dahulu)."
    ],
    """# 1. Jalankan diagnosa kesehatan Flutter:
flutter doctor

# 2. Jika muncul peringatan lisensi Android:
flutter doctor --android-licenses
# (Ketik huruf 'y' lalu tekan Enter untuk setiap persetujuan)

# 3. Target minimal praktikum lab hari ini:
# [✓] Flutter SDK (Channel stable)
# [✓] Chrome - develop for the web
# [✓] VS Code (version 1.9x)""",
    filename="flutter_doctor.sh",
    full_code_file="slide_07_diagnostik_flutter_doctor.dart",
    tip="Jangan panik jika Android Studio silang merah, asalkan Chrome dan VS Code bertanda centang hijau!",
    tag_color=COLOR_MINT
)

# ---------------------------------------------------------------------
# Slide 8: Membuat Proyek Perdana: 'flutter create'
# ---------------------------------------------------------------------
deck1.add_concept_with_code(
    "MEMBUAT PROYEK",
    "Perintah 'flutter create' & Aturan Penamaan",
    [
        "Buka Terminal di folder kerja Anda (misal: C:\\KuliahMobile\\).",
        "Aturan Penamaan Proyek Flutter:",
        "HANYA boleh menggunakan huruf kecil (lowercase), angka, dan garis bawah (_).",
        "DILARANG memakai spasi, huruf kapital, atau strip (-)! Contoh salah: 'Tugas-1', contoh benar: 'tugas_pertemuan_01'."
    ],
    """# 1. Buka folder kerja di terminal:
cd C:\\Users\\Mahasiswa\\FlutterProjects

# 2. Buat proyek Flutter perdana:
flutter create halo_flutter

# 3. Masuk ke dalam folder proyek:
cd halo_flutter

# 4. Buka proyek tersebut di VS Code:
code .""",
    filename="create_project.sh",
    full_code_file="slide_08_aturan_penamaan_proyek.dart",
    tip="Selalu gunakan huruf kecil dan underscore agar tidak memicu galat kompilator Dart!",
    tag_color=COLOR_YELLOW
)

# ---------------------------------------------------------------------
# Slide 9: Membedah Struktur Folder Proyek
# ---------------------------------------------------------------------
deck1.add_concept_with_code(
    "STRUKTUR PROYEK",
    "Struktur Folder Proyek: 3 Direktori Utama",
    [
        "Saat proyek dibuat, ada puluhan folder otomatis. Bagi pemula, abaikan yang tidak perlu!",
        "1. folder 'lib/' (RUMAH UTAMA): pusat seluruh kode logika dan tampilan aplikasi. Berkas gerbang utama adalah 'lib/main.dart'.",
        "2. berkas 'pubspec.yaml': 'KTP' aplikasi dan daftar belanja pustaka/aset gambar.",
        "3. folder 'android/' & 'ios/': Pembungkus native (jangan diubah-ubah jika belum mahir)."
    ],
    """halo_flutter/
├── android/          <- Folder native Android (jangan diubah)
├── ios/              <- Folder native iOS (jangan diubah)
├── web/              <- Folder untuk target browser
├── lib/              <- 🌟 PUSAT PENULISAN KODE SUMBER UTAMA APLIKASI!
│   └── main.dart     <- Titik awal aplikasi dimulai
├── test/             <- Berkas pengujian unit testing
└── pubspec.yaml      <- 📜 KTP & Daftar paket pustaka/gambar""",
    filename="struktur_folder.txt",
    full_code_file="slide_09_struktur_folder_proyek.dart",
    tip="Fokuskan perhatian Anda 100% hanya pada folder 'lib/' dan berkas 'pubspec.yaml'!",
    tag_color=COLOR_CYAN
)

# ---------------------------------------------------------------------
# Slide 10: Membedah Berkas 'pubspec.yaml'
# ---------------------------------------------------------------------
deck1.add_concept_with_code(
    "MANAJEMEN PAKET",
    "pubspec.yaml: KTP & Daftar Belanja Aplikasi",
    [
        "Fungsi Berkas: Menyimpan identitas nama aplikasi, versi rilis, pustaka eksternal (packages), dan aset gambar/font.",
        "Catatan Kritis: Format YAML SANGAT SENSITIF terhadap indentasi spasi!",
        "Gunakan TEPAT 2 SPASI untuk indentasi. Jangan pernah memakai tombol TAB, karena akan membuat kompilasi error."
    ],
    """name: halo_flutter
description: "Aplikasi mobile perdana mahasiswa Informatika"
version: 1.0.0+1

environment:
  sdk: ^3.5.0

dependencies:
  flutter:
    sdk: flutter
  # Tambahkan paket baru dengan indentasi 2 spasi:
  google_fonts: ^6.2.1

flutter:
  uses-material-design: true
  # Daftarkan gambar lokal di sini:
  # assets:
  #   - assets/images/logo.png""",
    filename="pubspec.yaml",
    full_code_file="slide_10_pubspec_yaml_simulator.dart",
    tip="Jika pubspec error merah, periksa apakah Anda tidak sengaja menekan tombol Tab!",
    tag_color=COLOR_CORAL
)

# ---------------------------------------------------------------------
# Slide 11: Sihir Hot Reload vs Hot Restart vs Full Build
# ---------------------------------------------------------------------
deck1.add_concept_with_code(
    "PRODUKTIVITAS KODING",
    "Sihir: Hot Reload vs Hot Restart vs Full Build",
    [
        "1. Hot Reload (Tekan 'Ctrl+S' atau huruf 'r'): Memperbarui antarmuka visual dalam hitungan milidetik (<1 detik) tanpa mereset data angka di layar.",
        "2. Hot Restart (Tekan huruf 'R'): Menyetel ulang aplikasi dari nol dalam 1–2 detik (mereset state).",
        "3. Full Build (Hentikan & jalankan ulang): Hanya diperlukan jika Anda mengubah berkas 'pubspec.yaml' atau kode native Android."
    ],
    """// TABEL PERBANDINGAN TIGA AKSI:
// --------------------------------------------------------
// AKSI          | WAKTU       | RESET STATE? | KAPAN PAKAI?
// --------------------------------------------------------
// Hot Reload    | < 1 Detik   | TIDAK        | Ganti warna, teks, layout
// Hot Restart   | 1-2 Detik   | YA           | Ubah initState/logika
// Full Build    | 1-2 Menit   | DARI AWAL    | Tambah paket pubspec

// Di terminal VS Code yang sedang berjalan:
// Tekan 'r' -> Hot Reload
// Tekan 'R' -> Hot Restart
// Tekan 'q' -> Keluar (Quit)""",
    filename="cheat_sheet_reload.txt",
    full_code_file="slide_11_hot_reload_vs_restart.dart",
    tip="Hot Reload adalah fitur terbaik Flutter yang membuat siklus pengembangan antarmuka berjalan sangat cepat!",
    tag_color=COLOR_MINT
)

# ---------------------------------------------------------------------
# Slide 12: Anatomi Kode Perdana: 'lib/main.dart'
# ---------------------------------------------------------------------
deck1.add_concept_with_code(
    "ANATOMI KODE DASAR",
    "Membaca Berkas 'lib/main.dart' Pertama Anda",
    [
        "void main(): Fungsi pertama yang dieksekusi komputer saat aplikasi menyala.",
        "runApp(): Menempelkan widget utama ke layar smartphone.",
        "MaterialApp: Membungkus aplikasi dengan tema Material Design standar Google.",
        "Scaffold: Kanvas dasar penyedia struktur AppBar dan Body.",
        "Center & Text: Meletakkan tulisan tepat di tengah layar."
    ],
    """import 'package:flutter/material.dart';

// 1. Titik masuk utama program
void main() {
  runApp(const AplikasiPerdana());
}

// 2. Widget induk aplikasi kita
class AplikasiPerdana extends StatelessWidget {
  const AplikasiPerdana({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            'Halo Teknik Informatika 2026!',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}""",
    filename="main_minimal.dart",
    full_code_file="slide_12_hello_flutter_minimal.dart",
    tip="Setiap tampilan di Flutter tersusun dari widget yang saling membungkus!",
    tag_color=COLOR_YELLOW
)

# ---------------------------------------------------------------------
# Slide 13: Membedah Default Counter App bawaan Flutter
# ---------------------------------------------------------------------
deck1.add_concept_with_code(
    "BEDAH KODE DEMO",
    "Mengapa Tombol '+' Bisa Menambah Angka?",
    [
        "Saat proyek dibuat, Flutter menyediakan kode demo tombol hitung (+).",
        "Variabel State: 'int _counter = 0;' menyimpan angka hitungan.",
        "Fungsi setState(): Memberi tahu Flutter 'Eh, angkanya sudah berubah, tolong gambar ulang angka di layar!'",
        "FloatingActionButton: Tombol bundar yang melayang di pojok kanan bawah."
    ],
    """int _counter = 0;

void _incrementCounter() {
  setState(() {
    // 1. Naikkan angka hitungan
    _counter++;
  }); // 2. Layar otomatis ter-update seketika!
}

// Di bagian build():
Text(
  '$_counter',
  style: Theme.of(context).textTheme.headlineMedium,
);

// Tombol melayang di pojok:
FloatingActionButton(
  onPressed: _incrementCounter,
  child: const Icon(Icons.add),
);""",
    filename="counter_logic.dart",
    full_code_file="slide_13_counter_app_deepdive.dart",
    tip="Fungsi setState() adalah fondasi paling awal dari aplikasi yang interaktif dan dinamis!",
    tag_color=COLOR_CYAN
)

# ---------------------------------------------------------------------
# Slide 14: Solusi Kilat Lab: Kompilasi Chrome 5 Detik
# ---------------------------------------------------------------------
deck1.add_concept_with_code(
    "SOLUSI SPESIFIKASI LAB",
    "Kompilasi Kilat via Google Chrome (Hemat RAM)",
    [
        "Kendala Komputer Lab RAM 8GB: Menjalankan Android Emulator memakan 4–6GB RAM -> PC langsung macet/freeze!",
        "Solusi Cerdas: Arahkan target kompilasi ke browser Google Chrome.",
        "Kompilasi hanya butuh 5–10 detik, memori RAM yang dipakai hanya ~150MB, dan fitur Hot Reload tetap berfungsi 100% normal."
    ],
    """# 1. Pastikan Anda berada di folder proyek
cd halo_flutter

# 2. Jalankan target browser Chrome:
flutter run -d chrome

# Jendela browser akan terbuka otomatis menampilkan
# aplikasi mobile Anda dalam rasio responsif web!

# Tips Shortcut jika ingin memilih target interaktif:
# Tekan F5 di VS Code -> Pilih browser 'Chrome'""",
    filename="run_chrome.sh",
    full_code_file="slide_14_chrome_preview_frame.dart",
    tip="Gunakan Chrome untuk belajar tata letak UI agar laptop Anda tetap dingin dan baterai awet!",
    tag_color=COLOR_PURPLE
)

# ---------------------------------------------------------------------
# Slide 15: Solusi HP Fisik: USB Debugging & Scrcpy
# ---------------------------------------------------------------------
deck1.add_concept_with_code(
    "SMARTPHONE NYATA",
    "Uji Coba di HP Fisik Menggunakan Scrcpy",
    [
        "Sensasi Sentuhan Jari Nyata: Paling memuaskan menguji aplikasi langsung di smartphone fisik Anda.",
        "Langkah 1: Aktifkan 'USB Debugging' di Developer Options HP Anda.",
        "Langkah 2: Sambungkan kabel data USB ke PC lab/laptop.",
        "Langkah 3: Jalankan program gratis 'Scrcpy' di terminal untuk memproyeksikan layar HP ke monitor komputer (RAM < 80MB)."
    ],
    """# 1. Pastikan smartphone terdeteksi:
adb devices

# 2. Tampilkan cermin layar smartphone di monitor PC:
scrcpy

# 3. Jalankan aplikasi Flutter ke smartphone fisik:
flutter run

# Sekarang Anda bisa mengontrol HP menggunakan
# mouse & keyboard komputer sambil merasakan performa asli!""",
    filename="setup_scrcpy.sh",
    full_code_file="slide_15_device_info_hardware.dart",
    tip="Pastikan kabel USB adalah kabel data, bukan hanya kabel charger pengisi daya saja!",
    tag_color=COLOR_CORAL
)

# ---------------------------------------------------------------------
# Slide 16: Setup VS Code: Ekstensi & Shortcut Wajib
# ---------------------------------------------------------------------
deck1.add_concept_with_code(
    "ALAT KERJA PRODUKTIF",
    "Ekstensi & Shortcut Wajib di VS Code",
    [
        "Ekstensi Wajib 1: 'Flutter' & 'Dart' (resmi dari Dart Code).",
        "Ekstensi Pendukung: 'Material Icon Theme' & 'Error Lens' untuk melihat pesan galat langsung di baris kode.",
        "Pintasan Produktivitas: 'Ctrl + `' untuk buka terminal, 'Ctrl + P' untuk cari berkas kilat, dan 'Alt + Enter' untuk bantuan refactor kode otomatis."
    ],
    """// SETELAN TERBAIK VS CODE (settings.json):
{
  // Otomatis rapikan kode setiap kali menekan Ctrl + S:
  "editor.formatOnSave": true,
  
  // Tampilkan garis bantu hierarki pohon widget:
  "dart.previewFlutterUiGuides": true,
  
  // Rekomendasi otomatis penambahan koma:
  "editor.codeActionsOnSave": {
    "source.fixAll": "always"
  }
}""",
    filename="settings.json",
    full_code_file="slide_16_vscode_shortcuts_guide.dart",
    tip="Aktifkan formatOnSave agar kode Anda langsung rapi setiap kali menekan Ctrl + S!",
    tag_color=COLOR_MINT
)

# ---------------------------------------------------------------------
# Slide 17: Lab Quest Mandiri Pertemuan 01
# ---------------------------------------------------------------------
deck1.add_lab_quest(
    1,
    "Hello Flutter & The First Hot Reload",
    45,
    [
        "Buka terminal VS Code dan jalankan 'flutter doctor' untuk memverifikasi kesiapan lingkungan kerja.",
        "Buat proyek baru menggunakan perintah 'flutter create tugas_pertemuan_01'.",
        "Jalankan aplikasi ke target Google Chrome ('flutter run -d chrome') atau smartphone fisik via USB.",
        "Buka berkas 'lib/main.dart', lalu ubah teks judul AppBar menjadi: 'Praktikum Mobile - [Nama Anda]'.",
        "Ubah teks di tengah layar menampilkan: 'Nama Lengkap Mahasiswa' dan 'NIM'.",
        "Ganti warna tema utama (seedColor) menjadi warna favorit Anda (misal: Colors.teal atau Colors.amber).",
        "Tekan 'Ctrl + S' (Hot Reload) dan buktikan layar aplikasi langsung berubah dalam sekejap tanpa restart!"
    ],
    "Tunjukkan layar aplikasi yang menampilkan Nama, NIM, dan perubahan warna tema kepada Dosen atau Asisten Lab untuk mendapatkan checklist nilai modul 1."
)

# ---------------------------------------------------------------------
# Slide 18: Jembatan Menuju Pertemuan 02 (Deep Dive Dart)
# ---------------------------------------------------------------------
deck1.add_concept_with_code(
    "LANGKAH BERIKUTNYA",
    "Persiapan Pertemuan 02: Deep Dive Dart",
    [
        "Hari ini Anda telah sukses menyiapkan lingkungan kerja dan merasakan sihir Hot Reload pertama kali.",
        "Tantangan Minggu Depan (Pertemuan 02): Membedah mesin bahasa pemrograman modern Dart!",
        "Materi Inti: Sound Null Safety (bebas galat null pointer), Collections (List, Map), OOP Constructor, dan Asynchronous (Future, async/await, Streams)."
    ],
    """// BOCORAN MATERI PERTEMUAN 02 (SOUND NULL SAFETY):
String namaWajib = 'Ahmad';   // Wajib ada isinya
String? catatanOpsional;      // Boleh null / kosong

// Operator Penjinak Null:
String status = catatanOpsional ?? 'Tidak ada catatan';

// Asinkronus Masa Depan:
Future<String> ambilDataInternet() async {
  await Future.delayed(const Duration(seconds: 2));
  return 'Data Berhasil Diterima!';
}""",
    filename="preview_pertemuan_02.dart",
    full_code_file="slide_18_preview_modern_dart.dart",
    tip="Buka dartpad.dev di rumah untuk mulai mencicipi sintaks Dart tanpa perlu instalasi tambahan!",
    tag_color=COLOR_YELLOW
)

# ---------------------------------------------------------------------
# Simpan berkas PPTX Pertemuan 01
# ---------------------------------------------------------------------
output_path = os.path.join(output_dir, "PERTEMUAN_01_Pengantar_Flutter_dan_Ekosistem.pptx")
deck1.save(output_path)
