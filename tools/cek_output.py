#!/usr/bin/env python3
"""
Menjalankan setiap contoh Dart murni (berkas yang memiliki blok "// OUTPUT")
dengan perintah `dart`, lalu mencocokkan hasilnya dengan blok OUTPUT tersebut.

Dipakai oleh GitHub Actions (quality-gate.yml) agar output yang tertulis di
modul, slide, dan kode contoh selalu sesuai dengan hasil sebenarnya.

Pemakaian (dari folder utama repositori, setelah `flutter pub get`):
    python3 tools/cek_output.py                  # semua pertemuan
    python3 tools/cek_output.py pertemuan_03_dart_lanjutan/kode/contoh_10_future_async_await.dart

Aturan pencocokan:
- Baris OUTPUT diambil dari baris komentar setelah "// OUTPUT".
  Baris "//" saja berarti baris kosong.
- Baris yang diakhiri "<abaikan>" tidak dicocokkan (untuk hasil yang memang
  berbeda-beda, misalnya jam).
- Angka tahun (20xx) dianggap sama, karena beberapa contoh mencetak tahun
  berjalan.
- Baris berakhiran "(di terminal `dart run`: X)" berarti tampilan DartPad dan
  terminal berbeda; ekor baris boleh berupa X (misalnya 100 vs 100.0).
- Contoh aplikasi Flutter (mengimpor package:flutter) dilewati.
- Contoh yang tidak mengimpor paket apa pun dijalankan dari salinannya di
  folder sementara (di luar repositori). Dengan begitu `dart` tidak ikut
  menyiapkan paket berkode native milik repositori (misalnya sqlite3 yang
  terbawa paket SQLite di Pertemuan 11), yang memang tidak dibutuhkan contoh
  Dart murni.
"""
import os
import re
import shutil
import subprocess
import sys
import tempfile

BATAS_DETIK = 90


def blok_output(teks):
    baris = teks.split('\n')
    for i, b in enumerate(baris):
        if re.match(r'^// OUTPUT', b):
            hasil = []
            for b2 in baris[i + 1:]:
                if not b2.startswith('//'):
                    break
                hasil.append(re.sub(r'^// ?', '', b2))
            return i + 1, hasil
    return None, None


def normalkan(baris):
    return re.sub(r'\b20\d\d\b', '<TAHUN>', baris.rstrip())


POLA_TERMINAL = re.compile(r'^(.*?)\s+\(di terminal `dart run`: (.*)\)$')


def cocok(harapan, aktual):
    if harapan is None or aktual is None:
        return False
    if normalkan(harapan) == normalkan(aktual):
        return True
    m = POLA_TERMINAL.match(harapan.rstrip())
    if not m:
        return False
    dasar, versi_terminal = m.group(1), m.group(2)
    if normalkan(dasar) == normalkan(aktual):
        return True
    # Ganti ekor baris (dimulai di awal sebuah kata) dengan versi terminal.
    for i in range(len(dasar)):
        if (i == 0 or dasar[i - 1] == ' ') and normalkan(dasar[:i] + versi_terminal) == normalkan(aktual):
            return True
    return False


def jalankan(berkas, teks):
    if "import 'package:" in teks:
        return subprocess.run(
            ['dart', berkas],
            capture_output=True, text=True, timeout=BATAS_DETIK,
        )
    with tempfile.TemporaryDirectory(prefix='cek_output_') as folder:
        salinan = os.path.join(folder, os.path.basename(berkas))
        shutil.copyfile(berkas, salinan)
        return subprocess.run(
            ['dart', salinan],
            capture_output=True, text=True, timeout=BATAS_DETIK, cwd=folder,
        )


def periksa(berkas):
    teks = open(berkas, encoding='utf-8').read()
    if 'package:flutter/' in teks:
        return None
    nomor_baris, harapan = blok_output(teks)
    if harapan is None:
        return None
    try:
        proses = jalankan(berkas, teks)
    except subprocess.TimeoutExpired:
        return [f'{berkas}: program tidak selesai dalam {BATAS_DETIK} detik']
    if proses.returncode != 0:
        pesan = (proses.stderr or proses.stdout).strip().splitlines()
        return [f'{berkas}: program berhenti dengan kode {proses.returncode}: '
                + ' | '.join(pesan[:3])]
    aktual = proses.stdout.rstrip('\n').split('\n') if proses.stdout else []
    while harapan and harapan[-1] == '':
        harapan.pop()
    masalah = []
    for k in range(max(len(harapan), len(aktual))):
        h = harapan[k] if k < len(harapan) else None
        a = aktual[k] if k < len(aktual) else None
        if h is not None and h.rstrip().endswith('<abaikan>'):
            continue
        if not cocok(h, a):
            baris_ke = nomor_baris + 1 + k
            masalah.append(
                f'{berkas}:{baris_ke}: output baris {k + 1} berbeda. '
                f'Seharusnya {h!r}, hasil sebenarnya {a!r}'
            )
    return masalah


def main():
    if len(sys.argv) > 1:
        daftar = sys.argv[1:]
    else:
        daftar = []
        for folder in sorted(os.listdir('.')):
            kode = os.path.join(folder, 'kode')
            if folder.startswith('pertemuan_') and os.path.isdir(kode):
                daftar += sorted(
                    os.path.join(kode, f) for f in os.listdir(kode) if f.endswith('.dart')
                )
    diperiksa = 0
    semua_masalah = []
    for berkas in daftar:
        masalah = periksa(berkas)
        if masalah is None:
            continue
        diperiksa += 1
        status = 'OK   ' if not masalah else 'GAGAL'
        print(f'{status} {berkas}')
        semua_masalah += masalah
    print(f'\n{diperiksa} contoh dijalankan, {len(semua_masalah)} perbedaan output.')
    for m in semua_masalah:
        print(m)
        if os.environ.get('GITHUB_ACTIONS'):
            cocok = re.match(r'^([^:]+):(\d+): (.*)$', m)
            if cocok:
                pesan = cocok.group(3).replace('%', '%25')
                print(f'::error file={cocok.group(1)},line={cocok.group(2)}::{pesan}')
            else:
                print(f"::error::{m.replace('%', '%25')}")
    sys.exit(1 if semua_masalah else 0)


if __name__ == '__main__':
    main()
