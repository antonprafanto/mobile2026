# Modul 03: Navigasi Deklaratif (go_router), Deep Linking, & Form System

Selamat datang di **Modul 03**! Di modul ini, Anda akan menguasai arsitektur navigasi modern standar industri menggunakan **`go_router`**, mengimplementasikan **Nested Navigation (`StatefulShellRoute`)** untuk mempertahankan state tab aplikasi, mengaktifkan **Deep Linking (App Links & Universal Links)**, animasi transisi kustom (*Custom Transitions*), pelacakan analitik navigasi (*NavigatorObserver*), hingga membangun sistem formulir interaktif (*Form System*) yang aman, tervalidasi, mendukung Autofill OS, Dialogs/Pickers, dan dilengkapi format otomatis (seperti format mata uang Rupiah).

---

## 🧭 1. Analogi: GPS Satelit & Resepsionis Gedung Bertingkat

Untuk memahami navigasi deklaratif dan validasi form di aplikasi modern:

| Konsep Flutter | Analogi Kehidupan Nyata | Penjelasan Teknis |
|---|---|---|
| **Imperative Navigation (1.0)** | **Buku Tumpukan Kertas Resepsionis** | Anda menumpuk lembaran halaman di atas meja (`push`) dan mencabutnya (`pop`). Sangat rapuh ketika pengguna membuka link langsung dari luar (Deep Link) atau me-refresh browser. |
| **Declarative Routing (`go_router`)** | **Sistem GPS Alamat Satelit (URL-Driven)** | Navigasi diarahkan berdasarkan alamat URI yang jelas (misal: `/katalog/detail/45`). Kapan pun alamat diketik atau diklik dari luar, aplikasi langsung tahu halaman mana yang harus dibuka. |
| **`StatefulShellRoute`** | **Gedung dengan 3 Ruangan Terpisah yang Lampunya Tetap Menyala** | Pindah antar Tab (Beranda, Katalog, Profil) tanpa me-reset isi form atau posisi scroll di ruangan sebelumnya. |
| **Form System & Validation** | **Mesin Teller Bank dengan Scanner Otomatis** | Memeriksa format rekening, saldo minimal, dan nomor telepon secara otomatis sebelum uang/data dikirim ke server. |

---

## 🚀 2. Evolusi Navigasi: Dari Imperative (1.0) ke Deklaratif (`go_router`)

<p align="center">
  <img src="images/routing-comparison.svg" alt="Perbandingan Navigasi Imperative vs Deklaratif" width="700">
</p>

### 2.1 Mengapa `go_router` Menjadi Standar Resmi di 2026?

1. **Sinkronisasi URL Alami**: Bekerja mulus di Android, iOS, Web, macOS, Windows, dan Linux.
2. **Deep Linking Out-of-the-Box**: Menangani tautan eksternal dari WhatsApp/Email langsung ke halaman spesifik tanpa konfigurasi manual yang rumit.
3. **Route Guards / Redirection**: Mengecek autentikasi (apakah user sudah login) secara terpusat sebelum layar dibuka.

---

### 2.2 Perbedaan `context.go()`, `context.push()`, dan `context.pop()`

```dart
// 1. context.go(): Mengganti seluruh tumpukan rute sesuai URI deklaratif (Ideal untuk perpindahan menu utama/tab)
context.go('/katalog/produk/102');

// 2. context.push(): Menumpuk halaman baru di atas halaman saat ini (Mendukung tombol kembali bawaan)
context.push('/pembayaran-sukses');

// 3. context.pop(): Menutup halaman saat ini dan kembali ke halaman sebelumnya
context.pop();

// 4. context.pop(hasil): Menutup halaman sambil mengembalikan data hasil ke halaman pemanggil
context.pop(true);
```

---

## 📦 3. Parameter Rute & Pengiriman Data

Ada tiga cara mengirimkan data antar halaman di `go_router`:

```dart
final router = GoRouter(
  initialLocation: '/home',
  routes: [
    // 1. Path Parameters: Nilai dinamis di dalam pola URL (/produk/:id)
    GoRoute(
      path: '/produk/:id',
      builder: (context, state) {
        final produkId = state.pathParameters['id']!;
        return DetailProdukPage(id: produkId);
      },
    ),

    // 2. Query Parameters: Parameter opsional/filter (/cari?kategori=buku&sort=termurah)
    GoRoute(
      path: '/cari',
      builder: (context, state) {
        final kategori = state.uri.queryParameters['kategori'] ?? 'semua';
        final sort = state.uri.queryParameters['sort'] ?? 'terpopuler';
        return PencarianPage(kategori: kategori, urutan: sort);
      },
    ),

    // 3. Extra Object: Mengirim objek model kompleks langsung di memori
    GoRoute(
      path: '/checkout',
      builder: (context, state) {
        final keranjang = state.extra as KeranjangBelanja;
        return CheckoutPage(keranjang: keranjang);
      },
    ),
  ],
);
```

---

## 📱 4. Nested Navigation dengan `StatefulShellRoute.indexedStack`

Pada aplikasi dengan Bottom Navigation Bar (seperti Tokopedia/Spotify), kita ingin ketika pengguna berada di Tab **Katalog** (sedang scroll di baris ke-50), lalu pindah ke Tab **Profil**, dan kembali lagi ke Tab **Katalog**, posisi scroll dan state datanya **tidak hilang / tidak di-reset**.

<p align="center">
  <img src="images/shell-route-architecture.svg" alt="Arsitektur StatefulShellRoute" width="700">
</p>

### Implementasi `StatefulShellRoute`:

```dart
final appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScaffoldPage(navigationShell: navigationShell);
      },
      branches: [
        // Cabang 1: Beranda
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        // Cabang 2: Katalog
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/katalog',
              builder: (context, state) => const KatalogPage(),
              routes: [
                GoRoute(
                  path: 'detail/:id',
                  builder: (context, state) => DetailPage(id: state.pathParameters['id']!),
                ),
              ],
            ),
          ],
        ),
        // Cabang 3: Profil
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profil',
              builder: (context, state) => const ProfilPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
```

---

## 🎬 5. Animasi Transisi Halaman Kustom (*Custom Transitions*)

Secara bawaan Flutter menggunakan transisi standar OS. Anda bisa membuat animasi kustom menggunakan `CustomTransitionPage`:

```dart
GoRoute(
  path: '/detail-spesial',
  pageBuilder: (context, state) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: const DetailSpesialPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;
        final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      transitionDuration: const Duration(milliseconds: 350),
    );
  },
);
```

---

## 🚫 6. Halaman 404 Kustom (*Error Page Builder*)

```dart
final router = GoRouter(
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Halaman Tidak Ditemukan')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 80, color: Colors.red),
          const SizedBox(height: 16),
          Text('404: Rute ${state.uri.path} Tidak Ditemukan ⚠️', style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.go('/home'),
            child: const Text('Kembali ke Beranda'),
          ),
        ],
      ),
    ),
  ),
  routes: [...],
);
```

---

## 🔒 7. Route Guards & Otentikasi Dinamis (Redirect Logic)

```dart
class AuthService extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}

final authService = AuthService();

final protectedRouter = GoRouter(
  refreshListenable: authService,
  redirect: (BuildContext context, GoRouterState state) {
    final bool loggedIn = authService.isLoggedIn;
    final bool isGoingToLogin = state.matchedLocation == '/login';

    if (!loggedIn && !isGoingToLogin) return '/login';
    if (loggedIn && isGoingToLogin) return '/home';
    return null;
  },
  routes: [
    GoRoute(path: '/login', builder: (c, s) => const LoginPage()),
    GoRoute(path: '/home', builder: (c, s) => const HomePage()),
  ],
);
```

---

## 📊 8. Navigation Observer: Pelacakan Analitik Layar

```dart
class AnalyticsRouteObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    print('📊 [Analytics Log]: Masuk ke Layar -> ${route.settings.name ?? route.settings}');
  }
}

final router = GoRouter(
  observers: [AnalyticsRouteObserver()],
  routes: [...],
);
```

---

## 🔗 9. Deep Linking (Android App Links & iOS Universal Links)

<p align="center">
  <img src="images/deep-linking-flow.svg" alt="Alur Deep Linking" width="700">
</p>

### 9.1 Konfigurasi Android App Links
Buka `android/app/src/main/AndroidManifest.xml` dan tambahkan `intent-filter`:

```xml
<activity android:name=".MainActivity" ...>
    <intent-filter android:autoVerify="true">
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
        <data android:scheme="https" android:host="tokokita2026.com" />
    </intent-filter>
</activity>
```

Unggah berkas `https://tokokita2026.com/.well-known/assetlinks.json` di server web Anda.

---

### 9.2 Konfigurasi iOS Universal Links
1. Aktifkan **Associated Domains** di Xcode (`applinks:tokokita2026.com`).
2. Unggah berkas `apple-app-site-association` di `https://tokokita2026.com/.well-known/apple-app-site-association`:

```json
{
  "applinks": {
    "apps": [],
    "details": [
      {
        "appID": "TEAM_ID.com.tokokita2026.app",
        "paths": ["*"]
      }
    ]
  }
}
```

---

## 📝 10. Form System, Formatters, & Input Validation Lanjutan

<p align="center">
  <img src="images/form-lifecycle-focus.svg" alt="Pipeline Input Form" width="700">
</p>

### 10.1 Komponen Form Utama
* **`GlobalKey<FormState>()`**: Kunci kontrol untuk validasi (`_formKey.currentState!.validate()`).
* **`TextFormField`**: Widget input teks terintegrasi validasi Form.
* **`FocusNode`**: Mengatur perpindahan kursor keyboard antar input secara otomatis.
* **`AutofillGroup` & `AutofillHints`**: Integrasi pengisi sandi/alamat otomatis OS.

---

### 10.2 Custom TextInputFormatter: Format Mata Uang Rupiah

```dart
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.selection.baseOffset == 0) return newValue;

    final cleanText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanText.isEmpty) return newValue.copyWith(text: '');

    final double value = double.parse(cleanText);
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    final newFormattedString = formatter.format(value);

    return TextEditingValue(
      text: newFormattedString,
      selection: TextSelection.collapsed(offset: newFormattedString.length),
    );
  }
}
```

---

### 10.3 Feedback UI: Pickers, Sheets, & Dialogs

```dart
// 1. DatePicker & TimePicker
Future<void> pilihTanggal(BuildContext context) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2020),
    lastDate: DateTime(2030),
  );
  if (pickedDate != null && context.mounted) {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
  }
}

// 2. Modal Bottom Sheet
void bukaPilihanMetode(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    builder: (ctx) => Container(
      padding: const EdgeInsets.all(20),
      child: const Text('Pilih Metode Pengiriman: Instan, Same Day, Regular'),
    ),
  );
}
```

---

## 🛡️ 11. Intersepsi Tombol Back Modern dengan `PopScope`

Di Flutter modern (Flutter 3.16+), widget lama `WillPopScope` telah digantikan secara resmi oleh **`PopScope`**:

```dart
bool _isFormDirty = true;

@override
Widget build(BuildContext context) {
  return PopScope(
    canPop: !_isFormDirty,
    onPopInvokedWithResult: (bool didPop, dynamic result) async {
      if (didPop) return;

      final bool? confirmExit = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Batalkan Perubahan?'),
          content: const Text('Data formulir yang Anda isi belum disimpan.'),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Lanjut Mengisi')),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Ya, Keluar'),
            ),
          ],
        ),
      );

      if (confirmExit == true && context.mounted) {
        Navigator.of(context).pop();
      }
    },
    child: Scaffold(
      appBar: AppBar(title: const Text('Form Pengiriman')),
      body: const FormBody(),
    ),
  );
}
```

---

## 💻 12. Hands-on Project: Multi-Step Checkout & Form Wizard App

Mari kita satukan seluruh konsep: **`go_router`**, **`PopScope`**, **Format Rupiah**, **AutofillGroup**, dan **Validasi Form** ke dalam satu aplikasi nyata:

1. **Buat file baru** `lib/checkout_wizard_page.dart` di proyek Flutter Anda.
2. **Salin kode lengkap berikut**:

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const CheckoutSuperApp());
}

class CheckoutSuperApp extends StatelessWidget {
  const CheckoutSuperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const CheckoutFormPage(),
    );
  }
}

class CheckoutFormPage extends StatefulWidget {
  const CheckoutFormPage({super.key});

  @override
  State<CheckoutFormPage> createState() => _CheckoutFormPageState();
}

class _CheckoutFormPageState extends State<CheckoutFormPage> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _nominalController = TextEditingController();
  final _passwordController = TextEditingController();

  // FocusNodes untuk perpindahan kursor otomatis
  final _emailFocus = FocusNode();
  final _nominalFocus = FocusNode();
  final _passwordFocus = FocusNode();

  bool _isFormDirty = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _nominalController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _nominalFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isFormDirty = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green.shade700,
          content: Text('✅ Pembayaran ${_namaController.text} sejumlah ${_nominalController.text} Berhasil!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_isFormDirty,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldLeave = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Tinggalkan Halaman?'),
            content: const Text('Ada isian formulir yang belum disimpan.'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Batal')),
              ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Keluar')),
            ],
          ),
        );
        if (shouldLeave == true && context.mounted) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Checkout & Pembayaran 2026', style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: AutofillGroup(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: () {
                if (!_isFormDirty) setState(() => _isFormDirty = true);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Field 1: Nama Lengkap
                  TextFormField(
                    controller: _namaController,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.name],
                    decoration: const InputDecoration(
                      labelText: 'Nama Lengkap Penerima',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_emailFocus),
                    validator: (value) {
                      if (value == null || value.trim().length < 3) {
                        return 'Nama minimal harus 3 karakter';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Field 2: Email
                  TextFormField(
                    controller: _emailController,
                    focusNode: _emailFocus,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.email],
                    decoration: const InputDecoration(
                      labelText: 'Alamat Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_passwordFocus),
                    validator: (value) {
                      if (value == null || !value.contains('@') || !value.contains('.')) {
                        return 'Masukkan format email yang valid';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Field 3: Password / PIN Keamanan
                  TextFormField(
                    controller: _passwordController,
                    focusNode: _passwordFocus,
                    obscureText: _obscurePassword,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.password],
                    decoration: InputDecoration(
                      labelText: 'PIN / Password Keamanan',
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                    onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_nominalFocus),
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return 'Password minimal 6 karakter';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Field 4: Nominal Bayar dengan Filter Angka
                  TextFormField(
                    controller: _nominalController,
                    focusNode: _nominalFocus,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Nominal Transfer (Hanya Angka)',
                      prefixIcon: Icon(Icons.monetization_on),
                      prefixText: 'Rp ',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nominal wajib diisi';
                      }
                      final int? nominal = int.tryParse(value);
                      if (nominal == null || nominal < 10000) {
                        return 'Nominal minimal Rp 10.000';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 28),

                  // Submit Button
                  ElevatedButton.icon(
                    onPressed: _submitForm,
                    icon: const Icon(Icons.lock),
                    label: const Text('Proses Pembayaran Aman', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

3. **Jalankan Aplikasi**:
   ```bash
   flutter run
   ```
   *Coba tekan tombol Back di HP saat formulir sudah terisi sebagian, dialog konfirmasi PopScope akan langsung mengamankan data Anda!*

---

## ⚠️ 13. Jebakan Umum (*Common Pitfalls*) & Solusi Kilat

| Kesalahan Umum | Gejala Error | Solusi yang Benar |
|---|---|---|
| **1. Salah Pilih `go()` vs `push()`** | Tombol back HP langsung keluar dari app alih-alih kembali ke halaman sebelumnya. | Gunakan `context.push()` jika ingin menumpuk rute di atas rute saat ini, atau gunakan `context.go()` untuk navigasi menu utama. |
| **2. Masih Menggunakan `WillPopScope`** | Warning *'WillPopScope is deprecated and shouldn't be used'*. | Migrasi ke **`PopScope`** dengan parameter `canPop` dan `onPopInvokedWithResult`. |
| **3. Lupa `GlobalKey<FormState>()`** | Validasi form tidak berjalan atau throw error `Null check operator on null`. | Definisikan `final _formKey = GlobalKey<FormState>()` dan pasang di properti `key:` widget `Form`. |
| **4. State Tab Ter-reset Saat Pindah** | Scroll di tab Katalog kembali ke paling atas saat buka tab Profil. | Gunakan **`StatefulShellRoute.indexedStack`** alih-alih `ShellRoute` biasa. |
| **5. Tidak Melepas FocusNode & Controller** | Keyboard nyangkut atau terjadi memory leak. | Selalu panggil `.dispose()` pada seluruh `TextEditingController` dan `FocusNode` di method `dispose()`. |

---

## 📝 14. Kuis Pemahaman Modul 03

1. **Apa keuntungan utama `StatefulShellRoute.indexedStack` dibandingkan `ShellRoute` biasa?**  
   *Jawaban:* `StatefulShellRoute.indexedStack` mempertahankan state setiap tab (seperti posisi scroll, input form yang belum selesai, dan riwayat sub-halaman) di dalam memori saat pengguna berpindah-pindah tab navigasi bawah.
2. **Kapan kita harus menggunakan `context.push()` dibandingkan `context.go()`?**  
   *Jawaban:* Gunakan `context.push()` ketika ingin menambahkan layar baru di atas layar aktif (misal: membuka halaman detail produk atau modal) dengan tombol back yang tetap membawa user ke layar sebelumnya. Gunakan `context.go()` untuk mengganti seluruh hierarki rute berdasarkan URI (misal: navigasi bottom bar atau setelah login).
3. **Mengapa `PopScope` menggantikan `WillPopScope` di Flutter modern?**  
   *Jawaban:* `PopScope` dirancang untuk mendukung fitur *Predictive Back Gesture* modern di Android 14+ dan iOS dengan memisahkan status izin pop (`canPop`) dari aksi callback intersepsi (`onPopInvokedWithResult`).

---

## 🎯 Rangkuman & Checklist Kompetensi

- [x] Menguasai navigasi deklaratif `go_router` dan perbedaannya dengan Navigator 1.0.
- [x] Memahami penggunaan `context.go()`, `context.push()`, dan `context.pop()`.
- [x] Mampu mengekstrak Path Parameters, Query Parameters, dan Extra Objects.
- [x] Mengimplementasikan Bottom Navigation persisten dengan `StatefulShellRoute.indexedStack`.
- [x] Menerapkan animasi transisi halaman kustom dengan `CustomTransitionPage`.
- [x] Menangani rute tidak valid dengan halaman 404 kustom `errorBuilder`.
- [x] Memasang pelacak analitik navigasi menggunakan `NavigatorObserver`.
- [x] Membangun sistem proteksi rute (*Route Guards / Redirect*) berbasis status login.
- [x] Mengonfigurasi Deep Linking (Android App Links & iOS Universal Links).
- [x] Menguasai Form System: `Form`, `TextFormField`, `FocusNode`, `AutofillGroup`, dan `AutovalidateMode`.
- [x] Membuat kustom `TextInputFormatter` untuk format mata uang Rupiah otomatis.
- [x] Menguasai dialog & pickers: `showDatePicker`, `showTimePicker`, `showModalBottomSheet`.
- [x] Mengimplementasikan intersepsi tombol back modern menggunakan `PopScope`.
- [x] Berhasil menguji coba proyek mini Multi-Step Checkout & Form Wizard App.

---

👉 **Langkah Selanjutnya**: Alur navigasi dan pengelolaan form aplikasi Anda sudah terstandarisasi industri! Mari melangkah ke **[Modul 04: State Management Lanjutan (Provider, Riverpod 2+, BLoC/Cubit)](../modul-04-state-management/README.md)** untuk mengelola aliran data reaktif skala enterprise.
