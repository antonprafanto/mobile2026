"""
Generator Slide Pertemuan 06 (Edisi Minimalis Profesional: Hitam, Abu-abu, Putih)
Mata Kuliah: Pemrograman Piranti Bergerak (Flutter & Dart 2026)
Topik: State Management Reaktif (Cubit & BLoC Pattern Standar Industri 2026)

Standar Desain: Minimalist Technical Architecture (Black, Grey, White)
- Kanvas Bersih: Off-White / Studio Light Neutral (#F8F9FA)
- Kartu Konten: Pure White (#FFFFFF) dengan garis tepi halus 1.0 Pt (#E5E7EB)
- Tipografi: Segoe UI & Consolas, kontras tinggi tanpa dekorasi berlebihan (#111827 & #4B5563)
- Editor Box: Dark Zinc Slate (#18181B) dengan header minimalis (#27272A)
- Diagram Box: Deep Slate Canvas (#0F172A) membingkai diagram teknis Chrome 4K
- Zero Emojis: Bebas dari ikon/emoji dekoratif AI agar tampil matang, elegan, dan akademis.
"""

import os
from pptx import Presentation
from pptx.util import Inches, Pt
from pptx.dml.color import RGBColor
from pptx.enum.shapes import MSO_SHAPE
from PIL import Image

# --- PALET WARNA MINIMALIS (HITAM, ABU-ABU, PUTIH) ---
COLOR_BG = RGBColor(248, 249, 250)             # #F8F9FA (Studio Off-White Canvas)
COLOR_CARD = RGBColor(255, 255, 255)           # #FFFFFF (Pure White Card)
COLOR_CARD_MUTED = RGBColor(243, 244, 246)     # #F3F4F6 (Light Neutral Grey)
COLOR_BORDER = RGBColor(229, 231, 235)         # #E5E7EB (Subtle 1pt Border)
COLOR_BORDER_STRONG = RGBColor(209, 213, 219)  # #D1D5DB (Muted Border)

COLOR_TEXT_PRIMARY = RGBColor(17, 24, 39)      # #111827 (Deep Charcoal Black)
COLOR_TEXT_SECONDARY = RGBColor(75, 85, 99)    # #4B5563 (Balanced Neutral Grey)
COLOR_TEXT_MUTED = RGBColor(107, 114, 128)     # #6B7280 (Subtle Muted Grey)

COLOR_TAG_BG = RGBColor(243, 244, 246)         # #F3F4F6 (Pill Background)
COLOR_TAG_TEXT = RGBColor(31, 41, 55)          # #1F2937 (Dark Pill Text)
COLOR_TAG_BORDER = RGBColor(229, 231, 235)     # #E5E7EB (Pill Border)

COLOR_CODE_BG = RGBColor(24, 24, 27)           # #18181B (Dark Zinc Editor)
COLOR_CODE_BAR = RGBColor(39, 39, 42)          # #27272A (Editor Header Strip)
COLOR_CODE_BORDER = RGBColor(63, 63, 70)       # #3F3F46 (Editor Border)
COLOR_CODE_TEXT = RGBColor(244, 244, 245)      # #F4F4F5 (Crisp Monospace)

COLOR_DIAGRAM_BG = RGBColor(255, 255, 255)        # #FFFFFF (Pure White Card)
COLOR_DIAGRAM_BORDER = RGBColor(229, 231, 235)    # #E5E7EB (Subtle 1pt Border)

COLOR_BUTTON_BG = RGBColor(24, 24, 27)         # #18181B (Clean Black/Charcoal Button)
COLOR_BUTTON_TEXT = RGBColor(255, 255, 255)    # #FFFFFF (White Text)
COLOR_BUTTON_BORDER = RGBColor(63, 63, 70)     # #3F3F46 (Refined Button Border)

FONT_HEADING = "Segoe UI"
FONT_BODY = "Segoe UI"
FONT_CODE = "Consolas"

GITHUB_BASE_URL = "https://github.com/antonprafanto/mobile2026/blob/main/07_contoh_kode_program/pertemuan_06_state_management_cubit"

class MinimalistDeckBuilder:
    def __init__(self, course_name="IF3205 • PEMROGRAMAN PIRANTI BERGERAK", diagram_assets_dir=None):
        self.prs = Presentation()
        self.prs.slide_width = Inches(13.333)
        self.prs.slide_height = Inches(7.5)
        self.blank_layout = self.prs.slide_layouts[6]
        self.course_name = course_name
        self.diagram_assets_dir = diagram_assets_dir or os.path.join(os.path.dirname(__file__), "diagram_assets")

    def _set_canvas_bg(self, slide):
        bg = slide.shapes.add_shape(
            MSO_SHAPE.RECTANGLE, 0, 0, self.prs.slide_width, self.prs.slide_height
        )
        bg.fill.solid()
        bg.fill.fore_color.rgb = COLOR_BG
        bg.line.fill.background()
        return bg

    def _add_clean_card(self, slide, x, y, w, h, fill_color=COLOR_CARD, border_color=COLOR_BORDER, border_width=Pt(1.0)):
        card = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, x, y, w, h)
        card.fill.solid()
        card.fill.fore_color.rgb = fill_color
        if border_color:
            card.line.color.rgb = border_color
            card.line.width = border_width
        else:
            card.line.fill.background()
        return card

    def _add_header(self, slide, tag, title):
        # Minimalist Pill Tag
        tag_w = Inches(len(tag) * 0.11 + 0.5)
        pill = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, Inches(0.9), Inches(0.42), tag_w, Inches(0.36))
        pill.fill.solid()
        pill.fill.fore_color.rgb = COLOR_TAG_BG
        pill.line.color.rgb = COLOR_TAG_BORDER
        pill.line.width = Pt(1.0)

        tb_tag = slide.shapes.add_textbox(Inches(0.9), Inches(0.42), tag_w, Inches(0.36))
        p_tag = tb_tag.text_frame.paragraphs[0]
        p_tag.text = tag.upper()
        p_tag.font.name = FONT_HEADING
        p_tag.font.size = Pt(10)
        p_tag.font.bold = True
        p_tag.font.color.rgb = COLOR_TAG_TEXT

        # Slide Title
        tb_title = slide.shapes.add_textbox(Inches(0.9), Inches(0.86), Inches(11.533), Inches(0.65))
        p_title = tb_title.text_frame.paragraphs[0]
        p_title.text = title
        p_title.font.name = FONT_HEADING
        p_title.font.size = Pt(20)
        p_title.font.bold = True
        p_title.font.color.rgb = COLOR_TEXT_PRIMARY

        # Subtle Horizontal Divider Line
        divider = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, Inches(0.9), Inches(1.52), Inches(11.533), Pt(1))
        divider.fill.solid()
        divider.fill.fore_color.rgb = COLOR_BORDER
        divider.line.fill.background()

    # 1. Slide Cover Minimalis
    def add_cover(self, meeting_num, title, subtitle, presenter_info):
        slide = self.prs.slides.add_slide(self.blank_layout)
        self._set_canvas_bg(slide)

        # Main Clean Card
        self._add_clean_card(slide, Inches(0.9), Inches(0.9), Inches(11.533), Inches(5.7), fill_color=COLOR_CARD, border_color=COLOR_BORDER)

        tb = slide.shapes.add_textbox(Inches(1.5), Inches(1.4), Inches(10.3), Inches(4.5))
        tf = tb.text_frame
        tf.word_wrap = True

        p0 = tf.paragraphs[0]
        p0.text = f"{self.course_name.upper()}  •  PERTEMUAN {meeting_num:02d}"
        p0.font.name = FONT_HEADING
        p0.font.size = Pt(11)
        p0.font.bold = True
        p0.font.color.rgb = COLOR_TEXT_MUTED
        p0.space_after = Pt(14)

        p1 = tf.add_paragraph()
        p1.text = title
        p1.font.name = FONT_HEADING
        p1.font.size = Pt(30)
        p1.font.bold = True
        p1.font.color.rgb = COLOR_TEXT_PRIMARY
        p1.space_after = Pt(12)

        p2 = tf.add_paragraph()
        p2.text = subtitle
        p2.font.name = FONT_BODY
        p2.font.size = Pt(14)
        p2.font.color.rgb = COLOR_TEXT_SECONDARY
        p2.space_after = Pt(40)

        # 3 Metadata Columns at bottom
        col_w = Inches(3.2)
        meta_items = [
            ("MODUL PERKULIAHAN", f"Pertemuan {meeting_num:02d} • State Management"),
            ("CAPAIAN PEMBELAJARAN", f"Sub-CPMK 06: Reactive Architecture"),
            ("PENGAMPU", presenter_info)
        ]
        
        for idx, (m_label, m_val) in enumerate(meta_items):
            mx = Inches(1.5) + idx * Inches(3.6)
            my = Inches(5.15)
            
            tb_m = slide.shapes.add_textbox(mx, my, col_w, Inches(1.1))
            tf_m = tb_m.text_frame
            tf_m.word_wrap = True
            
            p_lbl = tf_m.paragraphs[0]
            p_lbl.text = m_label
            p_lbl.font.name = FONT_HEADING
            p_lbl.font.size = Pt(9.5)
            p_lbl.font.bold = True
            p_lbl.font.color.rgb = COLOR_TEXT_MUTED
            
            p_val = tf_m.add_paragraph()
            p_val.text = m_val
            p_val.font.name = FONT_BODY
            p_val.font.size = Pt(11)
            p_val.font.bold = True
            p_val.font.color.rgb = COLOR_TEXT_PRIMARY

    # 2. Slide Split Screen: Konsep & Catatan Teknis di Kiri + Editor Kode di Kanan
    def add_concept_with_code(self, tag, title, bullets, code_snippet, filename="example.dart", tip=None, full_code_file=None):
        slide = self.prs.slides.add_slide(self.blank_layout)
        self._set_canvas_bg(slide)
        self._add_header(slide, tag, title)

        # Left Column Card (Concept & Takeaways)
        left_w = Inches(5.4)
        self._add_clean_card(slide, Inches(0.9), Inches(1.72), left_w, Inches(5.35), fill_color=COLOR_CARD, border_color=COLOR_BORDER)

        tb_l = slide.shapes.add_textbox(Inches(1.15), Inches(1.9), left_w - Inches(0.5), Inches(3.3))
        tf_l = tb_l.text_frame
        tf_l.word_wrap = True

        for i, b in enumerate(bullets):
            p = tf_l.paragraphs[0] if i == 0 else tf_l.add_paragraph()
            
            # Split bold lead-in if contains ':'
            if ":" in b:
                parts = b.split(":", 1)
                r_lead = p.add_run()
                r_lead.text = parts[0] + ":"
                r_lead.font.name = FONT_HEADING
                r_lead.font.size = Pt(10.2)
                r_lead.font.bold = True
                r_lead.font.color.rgb = COLOR_TEXT_PRIMARY

                r_body = p.add_run()
                r_body.text = parts[1]
                r_body.font.name = FONT_BODY
                r_body.font.size = Pt(10.0)
                r_body.font.color.rgb = COLOR_TEXT_SECONDARY
            else:
                p.text = b
                p.font.name = FONT_BODY
                p.font.size = Pt(10.0)
                p.font.color.rgb = COLOR_TEXT_SECONDARY
            p.space_after = Pt(9)

        # Bottom Technical Note Card
        if tip:
            tip_y = Inches(5.45)
            tip_h = Inches(1.45)
            self._add_clean_card(slide, Inches(1.1), tip_y, left_w - Inches(0.4), tip_h, fill_color=COLOR_CARD_MUTED, border_color=COLOR_BORDER)

            tb_tip = slide.shapes.add_textbox(Inches(1.25), tip_y + Inches(0.1), left_w - Inches(0.7), tip_h - Inches(0.2))
            tf_tip = tb_tip.text_frame
            tf_tip.word_wrap = True

            p_hdr = tf_tip.paragraphs[0]
            p_hdr.text = "CATATAN TEKNIS"
            p_hdr.font.name = FONT_HEADING
            p_hdr.font.size = Pt(8.8)
            p_hdr.font.bold = True
            p_hdr.font.color.rgb = COLOR_TEXT_MUTED
            p_hdr.space_after = Pt(2)

            p_tip = tf_tip.add_paragraph()
            p_tip.text = tip
            p_tip.font.name = FONT_BODY
            p_tip.font.size = Pt(9.3)
            p_tip.font.color.rgb = COLOR_TEXT_PRIMARY

        # Right Column Card (Terminal / Code Box)
        right_x = Inches(6.55)
        right_w = Inches(5.883)
        self._add_clean_card(slide, right_x, Inches(1.72), right_w, Inches(5.35), fill_color=COLOR_CODE_BG, border_color=COLOR_CODE_BORDER)

        # Terminal Header Bar
        c_bar = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, right_x, Inches(1.72), right_w, Inches(0.42))
        c_bar.fill.solid()
        c_bar.fill.fore_color.rgb = COLOR_CODE_BAR
        c_bar.line.fill.background()

        # Window Controls (3 subtle dots)
        dot_colors = [RGBColor(113, 113, 122), RGBColor(82, 82, 91), RGBColor(63, 63, 70)]
        for idx, dc in enumerate(dot_colors):
            dot = slide.shapes.add_shape(MSO_SHAPE.OVAL, right_x + Inches(0.18 + idx * 0.16), Inches(1.85), Inches(0.09), Inches(0.09))
            dot.fill.solid()
            dot.fill.fore_color.rgb = dc
            dot.line.fill.background()

        tb_cb = slide.shapes.add_textbox(right_x + Inches(0.8), Inches(1.75), right_w - Inches(0.9), Inches(0.35))
        p_cb = tb_cb.text_frame.paragraphs[0]
        p_cb.text = f"{filename}  •  Dart 3.x"
        p_cb.font.name = FONT_CODE
        p_cb.font.size = Pt(9.5)
        p_cb.font.bold = True
        p_cb.font.color.rgb = RGBColor(212, 212, 216)

        # Code Content
        code_box_h = Inches(3.9) if full_code_file else Inches(4.5)
        tb_r = slide.shapes.add_textbox(right_x + Inches(0.2), Inches(2.24), right_w - Inches(0.4), code_box_h)
        tf_r = tb_r.text_frame
        tf_r.word_wrap = True

        p_code = tf_r.paragraphs[0]
        p_code.text = code_snippet
        p_code.font.name = FONT_CODE
        p_code.font.size = Pt(9.0)
        p_code.font.color.rgb = COLOR_CODE_TEXT

        # Minimalist Dark Link Button
        if full_code_file:
            btn_x = right_x + Inches(0.2)
            btn_y = Inches(6.32)
            btn_w = right_w - Inches(0.4)
            btn_h = Inches(0.55)

            btn = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, btn_x, btn_y, btn_w, btn_h)
            btn.fill.solid()
            btn.fill.fore_color.rgb = COLOR_BUTTON_BG
            btn.line.color.rgb = COLOR_BUTTON_BORDER
            btn.line.width = Pt(1.0)
            btn.click_action.hyperlink.address = f"{GITHUB_BASE_URL}/{full_code_file}"

            tf_btn = btn.text_frame
            tf_btn.word_wrap = True
            tf_btn.margin_left = Inches(0.18)
            tf_btn.margin_top = Inches(0.06)
            tf_btn.margin_right = Inches(0.18)
            tf_btn.margin_bottom = Inches(0.06)

            p_btn = tf_btn.paragraphs[0]
            run_btn = p_btn.add_run()
            run_btn.text = f"Buka Kode Lengkap di GitHub ({full_code_file})"
            run_btn.font.name = FONT_HEADING
            run_btn.font.size = Pt(9.5)
            run_btn.font.bold = True
            run_btn.font.color.rgb = RGBColor(255, 255, 255)

            p_btn_sub = tf_btn.add_paragraph()
            run_sub = p_btn_sub.add_run()
            run_sub.text = "Repositori: github.com/antonprafanto/mobile2026"
            run_sub.font.name = FONT_BODY
            run_sub.font.size = Pt(7.5)
            run_sub.font.color.rgb = RGBColor(161, 161, 170)

    # 3. Slide Flowchart / Diagram Visual Penuh
    def add_flowchart_slide(self, tag, title, image_filename, takeaways, rule_of_thumb="PANDUAN ARSITEKTUR"):
        slide = self.prs.slides.add_slide(self.blank_layout)
        self._set_canvas_bg(slide)
        self._add_header(slide, tag, title)

        img_path = os.path.join(self.diagram_assets_dir, image_filename)
        if not os.path.exists(img_path):
            raise FileNotFoundError(f"Diagram image not found: {img_path}")

        # Main Diagram Panoramic Frame
        c_x, c_y, c_w, c_h = Inches(0.9), Inches(1.72), Inches(11.533), Inches(4.18)
        self._add_clean_card(slide, c_x, c_y, c_w, c_h, fill_color=COLOR_DIAGRAM_BG, border_color=COLOR_DIAGRAM_BORDER)

        with Image.open(img_path) as im:
            iw, ih = im.size
        aspect = iw / ih

        max_w = c_w - Inches(0.24)
        max_h = c_h - Inches(0.24)
        if (max_w / max_h) > aspect:
            fit_h = max_h
            fit_w = fit_h * aspect
        else:
            fit_w = max_w
            fit_h = fit_w / aspect

        px = c_x + (c_w - fit_w) / 2
        py = c_y + (c_h - fit_h) / 2
        slide.shapes.add_picture(img_path, px, py, width=fit_w, height=fit_h)

        # Bottom Takeaway Card
        b_x, b_y, b_w, b_h = Inches(0.9), Inches(6.05), Inches(11.533), Inches(1.05)
        self._add_clean_card(slide, b_x, b_y, b_w, b_h, fill_color=COLOR_CARD, border_color=COLOR_BORDER)

        # Left Label Badge
        badge_w = Inches(2.4)
        badge = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, b_x, b_y, badge_w, b_h)
        badge.fill.solid()
        badge.fill.fore_color.rgb = COLOR_CARD_MUTED
        badge.line.color.rgb = COLOR_BORDER
        badge.line.width = Pt(1.0)

        tb_badge = slide.shapes.add_textbox(b_x + Inches(0.12), b_y + Inches(0.25), badge_w - Inches(0.24), b_h - Inches(0.4))
        tf_badge = tb_badge.text_frame
        tf_badge.word_wrap = True

        p_b = tf_badge.paragraphs[0]
        p_b.text = rule_of_thumb.replace("\n", " ").strip()
        p_b.font.name = FONT_HEADING
        p_b.font.size = Pt(10)
        p_b.font.bold = True
        p_b.font.color.rgb = COLOR_TEXT_PRIMARY

        # Right Text inside Bottom Card
        tb_text = slide.shapes.add_textbox(b_x + badge_w + Inches(0.25), b_y + Inches(0.08), b_w - badge_w - Inches(0.4), b_h - Inches(0.16))
        tf_text = tb_text.text_frame
        tf_text.word_wrap = True

        for i, b in enumerate(takeaways):
            p = tf_text.paragraphs[0] if i == 0 else tf_text.add_paragraph()
            p.text = f"•  {b}"
            p.font.name = FONT_BODY
            p.font.size = Pt(9.5)
            p.font.color.rgb = COLOR_TEXT_SECONDARY
            p.space_after = Pt(2)

    # 4. Slide Lab Quest Mandiri Minimalis
    def add_lab_quest(self, meeting_num, title, duration_minutes, goals, success_criteria, full_code_file=None):
        slide = self.prs.slides.add_slide(self.blank_layout)
        self._set_canvas_bg(slide)
        self._add_header(slide, "STUDI KASUS PRAKTIKUM", f"Lab Quest {meeting_num:02d}: {title}")

        # Main White Card
        self._add_clean_card(slide, Inches(0.9), Inches(1.72), Inches(11.533), Inches(5.35), fill_color=COLOR_CARD, border_color=COLOR_BORDER)

        # Header Badge Inside Card
        h_strip = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, Inches(0.9), Inches(1.72), Inches(11.533), Inches(0.5))
        h_strip.fill.solid()
        h_strip.fill.fore_color.rgb = COLOR_CARD_MUTED
        h_strip.line.fill.background()

        tb_strip = slide.shapes.add_textbox(Inches(1.2), Inches(1.78), Inches(10.8), Inches(0.38))
        p_strip = tb_strip.text_frame.paragraphs[0]
        p_strip.text = f"TARGET WAKTU PENYELESAIAN: {duration_minutes} MENIT  •  PENILAIAN BERBASIS OUTPUT"
        p_strip.font.name = FONT_HEADING
        p_strip.font.size = Pt(10)
        p_strip.font.bold = True
        p_strip.font.color.rgb = COLOR_TEXT_MUTED

        tb = slide.shapes.add_textbox(Inches(1.3), Inches(2.35), Inches(10.7), Inches(3.6))
        tf = tb.text_frame
        tf.word_wrap = True

        p_g = tf.paragraphs[0]
        p_g.text = "SPESIFIKASI DAN KEBUTUHAN SISTEM:"
        p_g.font.name = FONT_HEADING
        p_g.font.size = Pt(11.5)
        p_g.font.bold = True
        p_g.font.color.rgb = COLOR_TEXT_PRIMARY
        p_g.space_after = Pt(6)

        for idx, g in enumerate(goals, 1):
            p = tf.add_paragraph()
            p.text = f"{idx}.  {g}"
            p.font.name = FONT_BODY
            p.font.size = Pt(10)
            p.font.color.rgb = COLOR_TEXT_SECONDARY
            p.space_after = Pt(4)

        if success_criteria:
            p_sc = tf.add_paragraph()
            p_sc.text = f"Kriteria Evaluasi: {success_criteria}"
            p_sc.font.name = FONT_HEADING
            p_sc.font.size = Pt(10.2)
            p_sc.font.bold = True
            p_sc.font.color.rgb = COLOR_TEXT_PRIMARY

        # Button for Lab Quest Source Code
        if full_code_file:
            btn_x = Inches(1.3)
            btn_y = Inches(6.25)
            btn_w = Inches(10.7)
            btn_h = Inches(0.55)

            btn = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, btn_x, btn_y, btn_w, btn_h)
            btn.fill.solid()
            btn.fill.fore_color.rgb = COLOR_BUTTON_BG
            btn.line.color.rgb = COLOR_BUTTON_BORDER
            btn.line.width = Pt(1.0)
            btn.click_action.hyperlink.address = f"{GITHUB_BASE_URL}/{full_code_file}"

            tf_btn = btn.text_frame
            tf_btn.word_wrap = True
            tf_btn.margin_left = Inches(0.2)
            tf_btn.margin_top = Inches(0.06)
            tf_btn.margin_right = Inches(0.2)
            tf_btn.margin_bottom = Inches(0.06)

            p_btn = tf_btn.paragraphs[0]
            run_btn = p_btn.add_run()
            run_btn.text = f"Buka Solusi Lengkap Lab Quest di GitHub ({full_code_file})"
            run_btn.font.name = FONT_HEADING
            run_btn.font.size = Pt(10)
            run_btn.font.bold = True
            run_btn.font.color.rgb = RGBColor(255, 255, 255)

            p_btn_sub = tf_btn.add_paragraph()
            run_sub = p_btn_sub.add_run()
            run_sub.text = "Repositori Resmi: github.com/antonprafanto/mobile2026"
            run_sub.font.name = FONT_BODY
            run_sub.font.size = Pt(7.8)
            run_sub.font.color.rgb = RGBColor(161, 161, 170)

    def save(self, filepath):
        self.prs.save(filepath)
        print(f"Deck slide berhasil disimpan ke: {filepath}")

# =====================================================================
# EKSEKUSI PEMBUATAN 26 SLIDE PERTEMUAN 06 (EDISI MINIMALIS PROFESIONAL)
# =====================================================================
output_dir = r"c:\Users\anton\vibecoding\mobile2026_v2\03_slide_presentasi"
diagram_dir = os.path.join(output_dir, "diagram_assets")
deck6 = MinimalistDeckBuilder(diagram_assets_dir=diagram_dir)

# ---------------------------------------------------------------------
# Slide 01: Cover Utama
# ---------------------------------------------------------------------
deck6.add_cover(
    6,
    "State Management Reaktif: Cubit & BLoC Pattern",
    "Pemisahan Logika Bisnis, Immutability, dan Pola Arsitektur Terkelola pada Flutter 2026.",
    "Tim Dosen Pemrograman Piranti Bergerak"
)

# ---------------------------------------------------------------------
# Slide 02: Tools & Setup flutter_bloc
# ---------------------------------------------------------------------
deck6.add_concept_with_code(
    "SETUP & ALAT BANTU",
    "Konfigurasi Dependensi: flutter_bloc & Ekstensi IDE",
    [
        "Analogi Sistem: Memasang mesin terintegrasi di bengkel agar tidak merakit komponen mekanis secara manual.",
        "Perintah Terminal: Jalankan 'flutter pub add flutter_bloc equatable' di direktori proyek Flutter.",
        "Ekstensi VS Code: Pasang ekstensi 'Bloc' oleh Felix Angelov untuk membuat class Cubit dan State secara otomatis.",
        "Pintasan IDE: Tekan Alt + Enter pada widget, lalu pilih 'Wrap with BlocBuilder' atau 'Wrap with BlocListener'."
    ],
    """// Menambahkan dependensi di pubspec.yaml:
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.6
  equatable: ^2.0.5

// Impor resmi di berkas Dart:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';""",
    filename="setup_bloc_tools.dart",
    tip="Ekstensi Bloc mengotomatisasi pembuatan berkas boilerplate dan struktur folder fitur dalam hitungan detik.",
    full_code_file="slide_02_tools_dan_setup_bloc.dart"
)

# ---------------------------------------------------------------------
# Slide 03: The State Problem (Ephemeral vs App State)
# ---------------------------------------------------------------------
deck6.add_concept_with_code(
    "THE STATE PROBLEM",
    "Klasifikasi State: Ephemeral State vs App State",
    [
        "Karakteristik Data: Ephemeral State hanya digunakan oleh 1 widget lokal; App State dibagikan ke banyak layar.",
        "Ephemeral State: Data sementara lokal widget (contoh: status ekspansi accordion, visibilitas input password).",
        "App State: Data global aplikasi yang persisten (contoh: item keranjang belanja, token sesi pengguna, tema).",
        "Aturan Rekayasa: Gunakan setState() untuk Ephemeral State, dan gunakan Cubit/BLoC untuk App State."
    ],
    """// 1. Ephemeral State: Cukup setState lokal
bool _isCardExpanded = false;

// 2. App State: Wajib dikelola Cubit
class CartCubit extends Cubit<int> {
  CartCubit() : super(0);
  void tambahBarang() => emit(state + 1);
}""",
    filename="state_category.dart",
    tip="Hindari over-engineering menggunakan BLoC untuk status lokal sederhana seperti animasi tombol; gunakan BLoC untuk data lintas halaman.",
    full_code_file="slide_03_ephemeral_vs_app_state.dart"
)

# ---------------------------------------------------------------------
# Slide 04: [DIAGRAM 1] Spektrum State Management
# ---------------------------------------------------------------------
deck6.add_flowchart_slide(
    "DIAGRAM ARSITEKTUR 01",
    "Spektrum Pengelolaan State: Ephemeral State vs App State",
    "state-spectrum.png",
    [
        "Kapan menggunakan setState()? Cukup untuk status lokal sementara di dalam 1 widget (misal: toggle password, animasi kursor).",
        "Kapan menggunakan Cubit/BLoC? Wajib untuk data lintas halaman yang digunakan bersama (misal: keranjang, sesi login, tema).",
        "Pedoman Praktikum: Jangan membagikan setState() melewati lebih dari 2 level widget turunan; beralihlah ke Cubit."
    ],
    rule_of_thumb="PANDUAN ARSITEKTUR"
)

# ---------------------------------------------------------------------
# Slide 05: Keterbatasan setState & Prop Drilling
# ---------------------------------------------------------------------
deck6.add_concept_with_code(
    "LIMITASI SETSTATE",
    "Keterbatasan setState(): Masalah Prop Drilling & Rebuild Mubazir",
    [
        "Analogi Distribusi: Menitipkan paket melalui banyak kurir perantara yang sebenarnya tidak memerlukan paket tersebut.",
        "Prop Drilling: Mengoper variabel data dan callback function melewati ranting widget bertingkat.",
        "Efisiensi Performa: Memanggil setState() di widget induk memaksa seluruh sub-pohon widget di-rebuild.",
        "Testabilitas Logika: Logika perhitungan bisnis terkunci di dalam komponen UI sehingga sulit diuji unit test."
    ],
    """// Prop drilling: Mengoper parameter melewati perantara
LevelKakek(
  child: LevelAyah(
    counter: _counter,       // Parameter titipan
    onIncrement: _increment, // Callback titipan
    child: LevelCucu(...),
  ),
);""",
    filename="prop_drilling_problem.dart",
    tip="Prop drilling membuat struktur kode rapuh; perubahan tanda tangan konstruktor perantara akan merusak rantai data.",
    full_code_file="slide_05_keterbatasan_setstate.dart"
)

# ---------------------------------------------------------------------
# Slide 06: [DIAGRAM 2] Bahaya Prop Drilling vs BlocProvider
# ---------------------------------------------------------------------
deck6.add_flowchart_slide(
    "DIAGRAM ARSITEKTUR 02",
    "Bahaya Prop Drilling vs Distribusi Terpusat (BlocProvider)",
    "prop-drilling-vs-provider.png",
    [
        "Masalah Prop Drilling: Parameter dititipkan paksa melewati widget perantara yang tidak berkepentingan pada data tersebut.",
        "Solusi BlocProvider: Menyediakan state secara terpusat di atas pohon widget; widget target langsung membaca via context.read().",
        "Pedoman Praktikum: Jika parameter yang sama diteruskan melewati 2 widget atau lebih, segera refactor menggunakan Cubit."
    ],
    rule_of_thumb="PANDUAN ARSITEKTUR"
)

# ---------------------------------------------------------------------
# Slide 07: Mental Model Cubit: Stream Reaktif
# ---------------------------------------------------------------------
deck6.add_concept_with_code(
    "ARSITEKTUR LOGIKA",
    "Mental Model Cubit: Pemancar Data & Stream Reaktif",
    [
        "Analogi Sistem: Cubit bertindak sebagai pemancar data; widget UI berfungsi sebagai penerima yang mendengarkan siaran.",
        "Konsep Stream: Di balik layar, Cubit memanfaatkan Stream. Setiap emit() mengalirkan state baru ke UI secara reaktif.",
        "Cubit vs BLoC: Cubit menggunakan pemanggilan method langsung (ringkas untuk 90% kasus); BLoC berbasis Event.",
        "Pemisahan Tanggung Jawab: Cubit murni berisi logika Dart tanpa widget; UI murni bertugas merender antarmuka."
    ],
    """// Logika bisnis terisolasi tanpa dependensi UI Flutter:
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0); // State awal

  void tambah() => emit(state + 1); // Memancarkan state baru
  void kurang() => emit(state - 1);
}""",
    filename="mental_model_cubit.dart",
    tip="Gunakan Cubit untuk sebagian besar kebutuhan aplikasi; beralihlah ke BLoC penuh hanya jika memerlukan transformer event seperti debounce.",
    full_code_file="slide_07_mental_model_cubit.dart"
)

# ---------------------------------------------------------------------
# Slide 08: [DIAGRAM 3] Komparasi Alur Kerja: Cubit vs BLoC
# ---------------------------------------------------------------------
deck6.add_flowchart_slide(
    "DIAGRAM ARSITEKTUR 03",
    "Perbandingan Alur Kerja: Cubit (Method-Driven) vs BLoC (Event-Driven)",
    "cubit-vs-bloc.png",
    [
        "Alur Cubit: UI memanggil fungsi cubit.tambah() -> emit(state baru) -> UI me-rebuild tampilan. Ringkas dan minim boilerplate.",
        "Alur BLoC: UI mengirimkan Event add(SearchEvent) -> transformer memproses konkurensi -> emit(State) -> UI me-rebuild tampilan.",
        "Pedoman Praktikum: Mulailah perancangan fitur dengan Cubit; gunakan BLoC hanya jika ada kebutuhan kontrol antrean event."
    ],
    rule_of_thumb="PANDUAN ARSITEKTUR"
)

# ---------------------------------------------------------------------
# Slide 09: Immutability & Equatable
# ---------------------------------------------------------------------
deck6.add_concept_with_code(
    "IMMUTABLE STATE",
    "Prinsip Immutability & Peran Library Equatable",
    [
        "Konsep Immutability: Objek state tidak boleh dimutasi secara langsung; selalu buat instansiasi objek baru.",
        "Larangan Mutasi: Mengubah 'state.poin = 100' secara langsung tidak akan memicu re-render karena referensi memori tidak berubah.",
        "Method copyWith(): Standar pembuatan salinan objek baru dengan memperbarui properti yang ditentukan.",
        "Peran Equatable: Membandingkan kesamaan nilai properti objek (value equality), bukan referensi memori (reference equality)."
    ],
    """class UserState extends Equatable {
  final String nama;
  final int poin;

  const UserState({required this.nama, required this.poin});

  UserState copyWith({String? nama, int? poin}) {
    return UserState(
      nama: nama ?? this.nama,
      poin: poin ?? this.poin,
    );
  }

  @override
  List<Object?> get props => [nama, poin];
}""",
    filename="equatable_state.dart",
    tip="Selalu extends Equatable pada class State agar BLoC dapat mendeteksi perubahan nilai secara presisi dan mencegah rebuild redundant.",
    full_code_file="slide_09_immutability_equatable.dart"
)

# ---------------------------------------------------------------------
# Slide 10: Anatomi Kelas Cubit & emit()
# ---------------------------------------------------------------------
deck6.add_concept_with_code(
    "ANATOMI CUBIT",
    "Anatomi Kelas Cubit: Inisialisasi State & Mekanisme emit()",
    [
        "Pewarisan Kelas: Kelas Cubit meng-extends 'Cubit<TState>' dan menginisialisasi 'super(initialState)'.",
        "Mekanisme emit(): Method internal untuk memperbarui state dan mengalirkan data baru ke subscriber.",
        "Proteksi Method: Method emit() berstatus protected dan hanya boleh dipanggil dari dalam method internal Cubit.",
        "Operasi Asinkron: Selalu lakukan validasi 'if (!isClosed)' sebelum memanggil emit() pada operasi asynchronous."
    ],
    """class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState(total: 0));

  void beliBarang(int harga) {
    // Memancarkan state baru ke subscriber:
    emit(state.copyWith(total: state.total + harga));
  }
}""",
    filename="anatomi_cubit.dart",
    tip="Jangan memanggil emit() dengan nilai yang identik, dan selalu pastikan Cubit belum di-close sebelum emit pada operasi async.",
    full_code_file="slide_10_anatomi_cubit_emit.dart"
)

# ---------------------------------------------------------------------
# Slide 11: [DIAGRAM 4] Flowchart Siklus Tertutup UDF
# ---------------------------------------------------------------------
deck6.add_flowchart_slide(
    "DIAGRAM ARSITEKTUR 04",
    "Siklus Tertutup Unidirectional Data Flow (UDF)",
    "bloc-udf-flow.png",
    [
        "Alur Satu Arah: UI menembakkan Event/Method -> BLoC/Cubit memproses logika bisnis -> emit(State) -> Widget merender ulang.",
        "Pemisahan Ketat: UI dilarang melakukan kalkulasi bisnis; Cubit dilarang mengimpor library UI (misal: package:flutter/material.dart).",
        "Pedoman Praktikum: Siklus satu arah menjamin integritas data dan mempermudah pelacakan sumber perubahan state."
    ],
    rule_of_thumb="PANDUAN ARSITEKTUR"
)

# ---------------------------------------------------------------------
# Slide 12: BlocProvider & context.read()
# ---------------------------------------------------------------------
deck6.add_concept_with_code(
    "INJEKSI DEPENDENSI",
    "Injeksi Dependensi: BlocProvider, context.read, & context.watch",
    [
        "Peran BlocProvider: Menyediakan instansiasi Cubit ke widget sub-pohon melalui mekanisme InheritedWidget.",
        "Manajemen Lifecycle: BlocProvider otomatis membuat Cubit (create) dan membersihkannya dari memori saat widget di-dispose.",
        "context.read<T>(): Digunakan di dalam callback event (seperti onPressed) untuk memanggil method Cubit tanpa me-rebuild.",
        "context.watch<T>(): Digunakan di dalam method build() untuk mendengarkan perubahan state dan me-rebuild tampilan."
    ],
    """// 1. Menyediakan Cubit ke sub-pohon widget:
BlocProvider(
  create: (context) => CounterCubit(),
  child: const CounterPage(),
);

// 2. Mengeksekusi aksi dari tombol:
FilledButton(
  onPressed: () => context.read<CounterCubit>().tambah(),
  child: const Icon(Icons.add),
);""",
    filename="bloc_provider_usage.dart",
    tip="Gunakan context.read() di dalam callback event, dan gunakan context.watch() hanya di dalam method build().",
    full_code_file="slide_12_bloc_provider_context.dart"
)

# ---------------------------------------------------------------------
# Slide 13: [DIAGRAM 5] Kuadran Keputusan 4 Widget BLoC
# ---------------------------------------------------------------------
deck6.add_flowchart_slide(
    "DIAGRAM ARSITEKTUR 05",
    "Kuadran Keputusan 4 Widget Konsumsi Utama BLoC",
    "bloc-widgets-quadrant.png",
    [
        "BlocBuilder vs BlocListener: Builder HANYA untuk merender antarmuka; Listener HANYA untuk efek samping 1 kali (SnackBar, Dialog, Navigasi).",
        "BlocConsumer & BlocSelector: Consumer menggabungkan render dan aksi; Selector menyaring perubahan properti spesifik.",
        "Pedoman Praktikum: Jangan pernah memicu SnackBar atau dialog navigasi di dalam BlocBuilder; gunakan BlocListener."
    ],
    rule_of_thumb="PANDUAN ARSITEKTUR"
)

# ---------------------------------------------------------------------
# Slide 14: BlocBuilder & buildWhen
# ---------------------------------------------------------------------
deck6.add_concept_with_code(
    "KONSUMSI UI 1",
    "BlocBuilder: Rendering Reaktif & Filter Optimasi buildWhen",
    [
        "Fungsi BlocBuilder: Menangani penggambaran ulang komponen visual setiap kali Cubit memancarkan state baru.",
        "Filter buildWhen: Menerima callback '(previous, current)' untuk menentukan apakah widget perlu di-rebuild.",
        "Efisiensi Render: Mencegah rebuild yang tidak perlu jika perubahan state tidak memengaruhi bagian tampilan terkait.",
        "Batasan Desain: Dilarang memicu dialog, notifikasi, atau navigasi rute di dalam builder."
    ],
    """BlocBuilder<StepCubit, int>(
  // Rebuild hanya jika nilai step merupakan kelipatan 5:
  buildWhen: (previous, current) => current % 5 == 0,
  builder: (context, step) {
    return Text(
      'Milestone: $step',
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  },
);""",
    filename="bloc_builder_filter.dart",
    tip="Bungkus hanya komponen widget terkecil yang memerlukan pembaruan data, bukan seluruh Scaffold.",
    full_code_file="slide_14_bloc_builder_buildwhen.dart"
)

# ---------------------------------------------------------------------
# Slide 15: BlocListener & listenWhen
# ---------------------------------------------------------------------
deck6.add_concept_with_code(
    "KONSUMSI UI 2",
    "BlocListener: Manajemen Efek Samping (Side Effects)",
    [
        "Fungsi BlocListener: Menangani aksi satu kali seperti menampilkan SnackBar, AlertDialog, atau navigasi halaman.",
        "Bebas Duplikasi: Berbeda dari builder yang dapat dipanggil berkali-kali oleh framework, listener dieksekusi tepat 1 kali per transisi.",
        "Filter listenWhen: Mengontrol kapan listener harus dipicu berdasarkan perbandingan state sebelumnya dan state saat ini.",
        "Pemisahan Logika UI: Memisahkan tampilan pasif dari aksi interaktif pengguna secara terstruktur."
    ],
    """BlocListener<FormCubit, int>(
  listenWhen: (prev, curr) => curr == 200,
  listener: (context, code) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Operasi Berhasil Diproses')),
    );
  },
  child: const MyFormWidget(),
);""",
    filename="bloc_listener_side_effects.dart",
    tip="Gunakan BlocListener untuk penanganan respon API sukses/gagal dan perpindahan rute navigasi (context.go).",
    full_code_file="slide_15_bloc_listener_side_effects.dart"
)

# ---------------------------------------------------------------------
# Slide 16: BlocConsumer
# ---------------------------------------------------------------------
deck6.add_concept_with_code(
    "KONSUMSI UI 3",
    "BlocConsumer: Integrasi Builder dan Listener dalam Satu Widget",
    [
        "Fungsi Terpadu: Menggabungkan BlocBuilder dan BlocListener untuk menyederhanakan widget tree tanpa nesting berlebihan.",
        "Parameter 'listener': Menangani aksi umpan balik visual seperti SnackBar atau perpindahan halaman.",
        "Parameter 'builder': Mengembalikan widget tree untuk penggambaran antarmuka pengguna.",
        "Penggunaan Ideal: Sangat cocok untuk komponen formulir login, transaksi pembayaran, atau tombol submit."
    ],
    """BlocConsumer<LoginCubit, bool>(
  listener: (context, isLoggedIn) {
    if (isLoggedIn) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Autentikasi Berhasil')),
      );
    }
  },
  builder: (context, isLoggedIn) {
    return FilledButton(
      onPressed: () => context.read<LoginCubit>().toggle(),
      child: Text(isLoggedIn ? 'Keluar' : 'Masuk'),
    );
  },
);""",
    filename="bloc_consumer_duo.dart",
    tip="Gunakan BlocConsumer untuk menyederhanakan kode saat sebuah widget membutuhkan rendering visual sekaligus umpan balik notifikasi.",
    full_code_file="slide_16_bloc_consumer_duo.dart"
)

# ---------------------------------------------------------------------
# Slide 17: BlocSelector
# ---------------------------------------------------------------------
deck6.add_concept_with_code(
    "OPTIMASI REBUILD",
    "BlocSelector: Isolasi Rebuild Berdasarkan Nilai Properti Spesifik",
    [
        "Tujuan Optimasi: Memilih satu properti tertentu dari objek state yang kompleks untuk dipantau secara terisolasi.",
        "Eliminasi Rebuild: Widget hanya akan me-rebuild jika nilai properti yang dipilih (selected) mengalami perubahan.",
        "Efisiensi Aplikasi Skala Besar: Mencegah penurunan frame rate (jank) pada form formulir berukuran besar.",
        "Kepatuhan Arsitektur: Menjaga konsistensi performa pada tingkat 60-120 FPS di perangkat mobile."
    ],
    """BlocSelector<ProfilCubit, ProfilData, String>(
  selector: (state) => state.nama, // Hanya memantau field 'nama'
  builder: (context, nama) {
    return Text('Pengguna: $nama');
    // Tidak akan di-rebuild jika field lain (misal: umur) berubah!
  },
);""",
    filename="bloc_selector_opt.dart",
    tip="BlocSelector adalah solusi optimal saat satu state object memuat banyak data namun widget hanya memerlukan satu field spesifik.",
    full_code_file="slide_17_bloc_selector_opt.dart"
)

# ---------------------------------------------------------------------
# Slide 18: Arsitektur 4 Status UI
# ---------------------------------------------------------------------
deck6.add_concept_with_code(
    "POLA STATUS UI",
    "Pemodelan 4 Status UI: Initial, Loading, Success, dan Error",
    [
        "Standar Industri: Setiap alur interaksi data asinkron wajib dimodelkan ke dalam 4 status state yang tegas.",
        "Pemanfaatan Sealed Class: Memastikan seluruh status tertangani secara komprehensif saat menggunakan switch pattern matching.",
        "Initial & Loading: Menampilkan panduan awal atau indikator progres tanpa menampilkan layar kosong.",
        "Success & Error: Menyajikan data hasil pemrosesan atau pesan galat yang informatif kepada pengguna."
    ],
    """sealed class DataState extends Equatable {}

class DataInitial extends DataState { ... }
class DataLoading extends DataState { ... }
class DataSuccess extends DataState { final List items; ... }
class DataError extends DataState { final String pesan; ... }

// Penanganan di antarmuka menggunakan pattern matching:
return switch (state) {
  DataInitial() => const Text('Tekan Tombol untuk Memuat'),
  DataLoading() => const CircularProgressIndicator.adaptive(),
  DataSuccess(:final items) => ListView(...),
  DataError(:final pesan) => Text('Terjadi Galat: $pesan'),
};""",
    filename="four_ui_states.dart",
    tip="Pola sealed class dengan pattern matching switch memastikan kompilator memvalidasi seluruh status ter-handle tanpa celah bug.",
    full_code_file="slide_18_arsitektur_4_status_ui.dart"
)

# ---------------------------------------------------------------------
# Slide 19: Mode Konkurensi: Menjinakkan Spam Klik dengan bloc_concurrency
# ---------------------------------------------------------------------
deck6.add_concept_with_code(
    "MODE KONKURENSI",
    "Manajemen Konkurensi Event: Proteksi Dobel Klik & Debounce",
    [
        "Masalah Konkurensi: Pengguna menekan tombol transaksi berkali-kali secara cepat, berpotensi memicu request duplikat.",
        "Transformer droppable(): Mengabaikan event baru yang masuk selama event sebelumnya masih dalam proses pengerjaan.",
        "Transformer restartable(): Membatalkan proses yang sedang berjalan dan segera memulai proses terbaru (debounce live search).",
        "Paket Resmi: Tersedia melalui pustaka resmi 'bloc_concurrency' oleh tim pengembang BLoC."
    ],
    """import 'package:bloc_concurrency/bloc_concurrency.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    // 1. Debounce live search: batalkan proses sebelumnya
    on<QueryChanged>(_onSearch, transformer: restartable());

    // 2. Proteksi transaksi pembayaran: abaikan klik kedua
    on<PayPressed>(_onCheckout, transformer: droppable());
  }
}""",
    filename="bloc_concurrency_modes.dart",
    tip="Terapkan transformer droppable() pada operasi transaksi keuangan untuk menjamin integritas data dan mencegah duplikasi order.",
    full_code_file="slide_19_bloc_concurrency.dart"
)

# ---------------------------------------------------------------------
# Slide 20: [DIAGRAM 6] Diagram Mode Konkurensi Event
# ---------------------------------------------------------------------
deck6.add_flowchart_slide(
    "DIAGRAM ARSITEKTUR 06",
    "Mode Konkurensi Event: Perilaku droppable() vs restartable()",
    "bloc-concurrency-modes.png",
    [
        "droppable() (Proteksi Transaksi): Mengabaikan event susulan jika proses aktif belum tuntas. Wajib untuk checkout dan transfer bank.",
        "restartable() (Live Search): Membatalkan event yang sedang berjalan dan segera memproses input karakter terakhir dari pengguna.",
        "Pedoman Praktikum: Pengelolaan konkurensi adalah standar kualitas wajib pada aplikasi berskala enterprise."
    ],
    rule_of_thumb="PANDUAN ARSITEKTUR"
)

# ---------------------------------------------------------------------
# Slide 21: MultiBlocProvider
# ---------------------------------------------------------------------
deck6.add_concept_with_code(
    "MULTI-PROVIDER",
    "MultiBlocProvider: Manajemen Banyak State Provider pada Root",
    [
        "Kebutuhan Aplikasi Skala Menengah: Aplikasi riil membutuhkan banyak instansiasi Cubit (Auth, Cart, Theme, Notification).",
        "Eliminasi Nesting: Menghindari piramida hierarki bersarang (BlocProvider di dalam BlocProvider bertingkat).",
        "Penempatan Terpusat: Ditempatkan di root aplikasi (di atas MaterialApp) untuk menyediakan state global secara terorganisir.",
        "Keterbacaan Kode: Memudahkan pemeliharaan daftar provider yang aktif di seluruh siklus hidup aplikasi."
    ],
    """MultiBlocProvider(
  providers: [
    BlocProvider<AuthCubit>(create: (ctx) => AuthCubit()),
    BlocProvider<CartCubit>(create: (ctx) => CartCubit()),
    BlocProvider<ThemeCubit>(create: (ctx) => ThemeCubit()),
  ],
  child: const MainApp(),
);""",
    filename="multi_bloc_provider.dart",
    tip="Daftarkan seluruh Cubit global di MultiBlocProvider pada file main.dart untuk aksesibilitas lintas rute aplikasi.",
    full_code_file="slide_21_multi_bloc_provider.dart"
)

# ---------------------------------------------------------------------
# Slide 22: Pemantauan Global dengan BlocObserver
# ---------------------------------------------------------------------
deck6.add_concept_with_code(
    "GLOBAL MONITORING",
    "BlocObserver: Pemantauan Sentral Transisi State dan Logging",
    [
        "Fungsi Monitoring: Mengamati setiap transisi perubahan state dan event yang terjadi di seluruh aplikasi secara tersentral.",
        "Otomasi Audit Trail: Mencatat transisi state sebelumnya ke state berikutnya tanpa perlu menyisipkan debugPrint di setiap class.",
        "Penanganan Error Global: Method onError() menangkap unhandled exceptions sebelum menimbulkan crash pada aplikasi.",
        "Kemudahan Debugging: Mempercepat pelacakan sumber kesalahan logika bisnis selama masa pengembangan dan pengujian."
    ],
    """class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    debugPrint('[BLOC] ${bloc.runtimeType}: '
        '${change.currentState} -> ${change.nextState}');
  }
}

void main() {
  Bloc.observer = AppBlocObserver(); // Registrasi observer
  runApp(const MyApp());
}""",
    filename="bloc_observer_cctv.dart",
    tip="Manfaatkan BlocObserver untuk mencatat jejak transisi data dan mendiagnosis perubahan state yang tidak terduga.",
    full_code_file="slide_22_bloc_observer_cctv.dart"
)

# ---------------------------------------------------------------------
# Slide 23: Refactoring setState ke Cubit
# ---------------------------------------------------------------------
deck6.add_concept_with_code(
    "STUDI KASUS REFACTOR",
    "Refactoring Nyata: Migrasi dari setState() ke Cubit Modular",
    [
        "Pemisahan Kode: Mengisolasi variabel data dan fungsi manipulasi dari class widget ke class Cubit mandiri.",
        "Transformasi Widget: Mengubah StatefulWidget menjadi StatelessWidget yang bersih dan bertugas menggambar antarmuka.",
        "Enkapsulasi State: Memindahkan koleksi data (misal: Set<String> wishlist) dan method mutasi ke dalam WishlistCubit.",
        "Hasil Arsitektur: Komponen tampilan menjadi modular, mudah dipelihara, dan dapat diuji secara terpisah."
    ],
    """// SEBELUM (Logika bisnis tercampur di dalam UI):
void _toggle(String id) {
  setState(() => _items.contains(id) ? _items.remove(id) : _items.add(id));
}

// SESUDAH (Cubit terisolasi dan modular):
class WishlistCubit extends Cubit<Set<String>> {
  WishlistCubit() : super({});
  void toggle(String id) {
    final updated = Set<String>.from(state);
    updated.contains(id) ? updated.remove(id) : updated.add(id);
    emit(updated);
  }
}""",
    filename="refactoring_setstate_cubit.dart",
    tip="Proses refactoring memisahkan logika dari antarmuka adalah kompetensi utama evaluasi arsitektur perangkat lunak pada proyek UTS.",
    full_code_file="slide_23_refactoring_setstate_cubit.dart"
)

# ---------------------------------------------------------------------
# Slide 24: [DIAGRAM 7] Matriks Keputusan State Management 2026
# ---------------------------------------------------------------------
deck6.add_flowchart_slide(
    "DIAGRAM ARSITEKTUR 07",
    "Matriks Keputusan Industri: Provider vs Riverpod 2.x vs BLoC / Cubit",
    "comparison-matrix-state.png",
    [
        "Provider: Cocok untuk mempelajari fondasi InheritedWidget, namun rentan terhadap ketergantungan BuildContext.",
        "Riverpod 2.x: Pilihan modern untuk startup dengan fitur compile-safe, dependency caching, dan otomatisasi AsyncValue.",
        "BLoC / Cubit: Standar utama industri perbankan dan fintech berkat audit trail (BlocObserver) dan determinisme UDF."
    ],
    rule_of_thumb="PANDUAN ARSITEKTUR"
)

# ---------------------------------------------------------------------
# Slide 25: Checklist 5 Aturan Emas State Management 2026
# ---------------------------------------------------------------------
deck6.add_concept_with_code(
    "CHECKLIST PRODUKSI",
    "5 Aturan Emas Tata Kelola State Produksi",
    [
        "1. Immutability Mutlak: Selalu extends Equatable dan gunakan method copyWith() untuk memancarkan data baru.",
        "2. Larangan Efek Samping di Builder: Gunakan BlocListener secara khusus untuk SnackBar, dialog, dan navigasi.",
        "3. Penggunaan Context Tepat Guna: Gunakan context.read() pada callback tombol, dan context.watch() hanya pada builder.",
        "4. Implementasi BlocObserver: Pasang observer pada root main.dart untuk pemantauan jejak audit data.",
        "5. Pemisahan Berkas Modular: Satu fitur wajib memiliki berkas state dan cubit terisolasi dalam struktur direktori mandiri."
    ],
    """// Checklist Kepatuhan Arsitektur State Management 2026:
// [1] Seluruh App State dikelola Cubit (Bebas setState lintas widget)
// [2] BlocBuilder tidak memicu SnackBar atau dialog navigasi
// [3] Equatable mencegah proses rebuild jika nilai data tidak berubah
// [4] Log transisi tercatat rapi di konsol terminal via BlocObserver
// [5] Struktur berkas mematuhi pemisahan domain dan presentation""",
    filename="checklist_state_management.dart",
    tip="Gunakan kelima kriteria kepatuhan ini sebagai acuan evaluasi arsitektur pada pengerjaan proyek kelompok UTS.",
    full_code_file="slide_25_checklist_state_management.dart"
)

# ---------------------------------------------------------------------
# Slide 26: Lab Quest 06 - Cart & Wishlist dengan Cubit
# ---------------------------------------------------------------------
deck6.add_lab_quest(
    6,
    "Mini E-Commerce Multi-Bloc (Cart & Wishlist Reaktif)",
    60,
    [
        "Bangun aplikasi e-commerce dengan logika state management Cubit yang terpisah dari antarmuka UI.",
        "Definisikan class CartCubit dan CartItemState berbasis Equatable untuk mencatat daftar produk dan kuantitas.",
        "Implementasikan Badge reaktif pada AppBar yang menghitung jumlah total item belanjaan secara otomatis.",
        "Gunakan BlocListener untuk menampilkan SnackBar konfirmasi setiap kali item baru berhasil ditambahkan ke keranjang.",
        "Sediakan BottomBar yang menghitung kalkulasi total harga belanjaan secara reaktif serta tombol checkout.",
        "Verifikasi di browser: buktikan pembaruan data berjalan secara instan tanpa hambatan performa."
    ],
    "Keranjang belanja bertambah secara reaktif, badge AppBar terupdate otomatis, SnackBar terpicu via BlocListener, dan total harga akurat.",
    full_code_file="slide_26_lab_quest_cart_cubit.dart"
)

# Simpan berkas presentasi
output_pptx = os.path.join(output_dir, "PERTEMUAN_06_State_Management_Cubit_dan_BLoC.pptx")
deck6.save(output_pptx)
print("=== PERTEMUAN 06 MINIMALIST DECK GENERATION COMPLETE (26 SLIDES) ===")
