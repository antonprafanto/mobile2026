# MODUL PRAKTIKUM 02: REKAYASA ANTARMUKA & NAVIGASI DEKLARATIF
## Laboratorium Rekayasa Perangkat Lunak - Teknik Informatika

---

## 1. Tujuan Pembelajaran
1. Mahasiswa mampu membedah mock-up desain UI dan merekonstruksinya menggunakan kombinasi widget `Row`, `Column`, `Stack`, dan `Expanded`.
2. Mahasiswa mampu membuat form interaktif dengan validasi masukan menggunakan `TextFormField` dan `GlobalKey<FormState>`.
3. Mahasiswa mampu mengimplementasikan sistem routing deklaratif menggunakan package **GoRouter**.

---

## 2. Langkah Kerja Terpandu

### Bagian A: Menghindari "RenderFlex Overflow Error"
Saat menyusun elemen horizontal atau vertikal yang dinamis, sering kali terjadi error batas layar (*yellow-black striped overflow*). Gunakan widget `Expanded` atau `Flexible` untuk memberi ruang fleksibel:

```dart
// CONTOH KODE ANTI-OVERFLOW PADA LIST ITEM
Widget buildCardItem(String title, String description) {
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 24,
            child: Icon(Icons.person),
          ),
          const SizedBox(width: 12),
          // Expanded mencegah teks panjang memicu overflow
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(color: Colors.grey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, size: 16),
            onPressed: () {},
          ),
        ],
      ),
    ),
  );
}
```

---

### Bagian B: Validasi Form Pendaftaran
Implementasikan form dengan validasi regex:

```dart
class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pendaftaran Akun ${_emailCtrl.text} Berhasil!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailCtrl,
            decoration: const InputDecoration(labelText: 'Email Kampus'),
            validator: (val) {
              if (val == null || !val.contains('@')) return 'Gunakan format email yang valid';
              return null;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _passwordCtrl,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Password'),
            validator: (val) {
              if (val == null || val.length < 8) return 'Password minimal 8 karakter';
              return null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitForm,
            child: const Text('Daftar Sekarang'),
          ),
        ],
      ),
    );
  }
}
```

---

## 3. Tugas Latihan Mandiri (Graded Lab Task)

> **Tantangan Praktikum 2:**
> 1. Buat aplikasi sederhana berisi 2 layar:
>    * **Halaman Katalog Buku:** Menampilkan daftar minimal 5 buku dalam `ListView.builder` dengan gambar sampul, judul, pengarang, dan rating.
>    * **Halaman Detail Buku:** Menampilkan data detail buku yang diklik dari halaman katalog.
> 2. Hubungkan kedua halaman menggunakan **GoRouter** dengan mengirimkan parameter `bookId` melalui rute `/book/:id`.
> 3. Terapkan Material 3 dengan *Dark Theme* adaptif.
> 4. Pastikan tidak ada satupun *RenderFlex overflow* saat orientasi layar diubah ke *Landscape*.
