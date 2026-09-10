# STRATEGI PENYEDIAAN PAKET OFFLINE & MITIGASI BANDWIDTH LAB
## Mencegah "Bandwidth Choke" pada Jaringan Laboratorium Komputer

---

## 1. Fenomena "Bandwidth Choke" di Kelas Praktikum

Dalam kelas berkapasitas 40 mahasiswa:
* Saat mahasiswa baru pertama kali menjalankan `flutter create app` dan `flutter run`, Gradle akan mengunduh dependensi Android (Kotlin stdlib, AndroidX, Gradle wrapper) sebesar **~500 MB – 1.2 GB per komputer**.
* $40 \text{ mahasiswa} \times 1 \text{ GB} = \mathbf{40\text{ GB}}$ unduhan data secara serentak dalam rentang waktu 15 menit.
* **Hasil:** Koneksi internet laboratorium mengalami *bottleneck*, terjadi galat *SocketException / Connection Timed Out*, dan sesi praktikum 2 jam habis hanya untuk menunggu proses unduhan gagal.

---

## 2. Solusi: Paket Master Offline (Lab Flashdisk / Local LAN Shared Folder)

Sebelum semester dimulai, Tim Dosen & Asisten Laboratorium menyiapkan **1 buah Master Flashdisk USB 3.0 / Server LAN Lokal** yang berisi 3 komponen pra-unduh (*pre-warmed*):

```
📂 Lab_Master_Package_Mobile2026/
├── 📁 flutter_sdk_stable/       # Flutter SDK yang sudah menjalankan flutter precache
├── 📁 gradle_offline_cache/      # Folder cache Gradle AndroidX & Wrapper
├── 📁 pub_offline_cache/         # Folder pub-cache berisi 50+ library semester ini
└── 📄 setup_offline_lab.ps1      # Skrip instalasi otomatis untuk Windows
```

---

## 3. Daftar Library Resmi Semester (Pre-Cached Dependencies)

Daftar paket yang wajib di-cache di flashdisk master:

1. **State & Routing:** `flutter_bloc`, `bloc`, `equatable`, `go_router`
2. **Network & Serializer:** `dio`, `json_annotation`, `freezed_annotation`, `flutter_dotenv`
3. **Penyimpanan Lokal:** `shared_preferences`, `isar`, `isar_flutter_libs`, `path_provider`, `flutter_secure_storage`
4. **BaaS & Hardware:** `firebase_core`, `firebase_auth`, `cloud_firestore`, `image_picker`, `geolocator`, `permission_handler`
5. **UI & Fonts:** `google_fonts`, `flutter_svg`, `intl`
6. **AI & Cerdas:** `google_mlkit_text_recognition`, `google_mlkit_barcode_scanning`
7. **Testing & QA:** `mocktail`, `bloc_test`, `flutter_lints`

---

## 4. Skrip Otomasi Pemasangan Cache Offline (PowerShell)

Asisten Lab dapat mendistribusikan berkas `setup_offline_lab.ps1` ke setiap PC laboratorium untuk mendistribusikan cache secara instan dalam 30 detik tanpa memakai kuota internet kampus:

```powershell
<#
  setup_offline_lab.ps1
  Skrip deployment cache offline laboratorium Pemrograman Piranti Bergerak
#>

$SourceDir = $PSScriptRoot
$UserHome = $env:USERPROFILE
$LocalAppData = $env:LOCALAPPDATA

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "   SETUP OFFLINE CACHE LAB PEMROGRAMAN MOBILE 2026       " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

# 1. Salin Cache Gradle (Android Dependencies)
$GradleDest = "$UserHome\.gradle"
Write-Host "[1/3] Menyalin Android Gradle Cache ke $GradleDest..." -ForegroundColor Yellow
if (!(Test-Path $GradleDest)) { New-Item -ItemType Directory -Path $GradleDest -Force | Out-Null }
Copy-Item -Path "$SourceDir\gradle_offline_cache\*" -Destination $GradleDest -Recurse -Force
Write-Host "      -> Gradle Cache berhasil disalin!" -ForegroundColor Green

# 2. Salin Pub Cache (Dart & Flutter Packages)
$PubDest = "$LocalAppData\Pub\Cache"
Write-Host "[2/3] Menyalin Dart Pub Cache ke $PubDest..." -ForegroundColor Yellow
if (!(Test-Path $PubDest)) { New-Item -ItemType Directory -Path $PubDest -Force | Out-Null }
Copy-Item -Path "$SourceDir\pub_offline_cache\*" -Destination $PubDest -Recurse -Force
Write-Host "      -> Pub Cache berhasil disalin!" -ForegroundColor Green

# 3. Verifikasi Flutter Precache
Write-Host "[3/3] Melakukan verifikasi Flutter SDK..." -ForegroundColor Yellow
flutter doctor
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "   SETUP SELESAI! PC Lab Siap Digunakan Tanpa Download   " -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Cyan
```

---

## 5. Cara Menjalankan Flutter secara Offline

Setelah cache terpasang, mahasiswa dapat membuat proyek dan mengunduh package dari cache lokal tanpa koneksi internet dengan perintah:

```bash
# Mengambil dependensi murni dari pub-cache lokal komputer
flutter pub get --offline
```
Perintah ini selesai dalam **2–3 detik**, menjamin seluruh kelas dapat langsung mulai mengetik kode tanpa hambatan jaringan.
