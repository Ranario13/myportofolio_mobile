# myportofolio_mobile

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Tugas 7

1. Apa yang dimaksud dengan widget tree pada Flutter dan bagaimana hubungan induk-anak bekerja antar-widget?
Widget tree adalah struktur hierarki widget yang membentuk tampilan dan perilaku aplikasi Flutter. Widget dapat memiliki widget lain sebagai child, sehingga widget induk mengatur posisi, konfigurasi, atau konteks bagi widget anak. Contohnya, MaterialApp menjadi induk bagi halaman utama, Scaffold menjadi induk bagi AppBar dan body, sedangkan Column menjadi induk bagi beberapa widget yang disusun secara vertikal.

2. Sebutkan semua widget yang digunakan dalam proyek ini dan jelaskan fungsinya masing-masing.
Widget utama yang digunakan adalah MaterialApp untuk konfigurasi aplikasi dan tema, Scaffold untuk struktur halaman, AppBar untuk bilah aplikasi, Padding untuk memberi jarak, Column dan Row untuk menyusun widget, Center untuk memusatkan konten, Text untuk menampilkan teks, Card untuk kartu informasi, Container untuk mengatur ukuran dan padding, SizedBox untuk jarak, GridView.count untuk kisi kartu aksi, Material untuk permukaan kartu berwarna, InkWell untuk menerima interaksi sentuh, Icon untuk ikon, serta SnackBar untuk memberi umpan balik setelah tombol ditekan.

3. Apa fungsi MaterialApp dan mengapa widget ini umumnya digunakan sebagai root widget?
MaterialApp menyediakan konfigurasi dasar aplikasi berbasis Material Design, seperti tema, warna, navigasi, dan konteks aplikasi. Widget ini umum digunakan sebagai root karena menyediakan ThemeData dan layanan dasar yang dapat diwarisi oleh widget-widget di bawahnya.

4. Apa perbedaan StatelessWidget dan StatefulWidget? Kapan sebaiknya memilih masing-masing?
StatelessWidget tidak menyimpan state internal yang berubah selama widget digunakan. Widget ini sesuai untuk tampilan yang ditentukan langsung oleh input dan konfigurasi, seperti InfoCard dan ItemCard pada proyek ini. StatefulWidget memiliki objek State yang dapat berubah dan memicu pembangunan ulang tampilan, sehingga sesuai untuk fitur seperti form input, penghitung, animasi, atau data yang berubah selama aplikasi berjalan.

5. Apa itu BuildContext dan mengapa penting di Flutter?
BuildContext adalah referensi terhadap lokasi sebuah widget di dalam widget tree. Flutter menggunakannya untuk menemukan informasi dari widget induk, misalnya tema melalui Theme.of(context) dan ScaffoldMessenger untuk menampilkan SnackBar. Karena itu, BuildContext penting ketika sebuah widget perlu mengakses konfigurasi atau layanan yang disediakan oleh ancestor-nya.

6. Apa itu hot reload dan apa perbedaannya dengan hot restart?
Hot reload memasukkan perubahan kode ke aplikasi yang sedang berjalan sambil mempertahankan state aplikasi jika memungkinkan. Hot restart menjalankan ulang aplikasi dari awal dan menghapus state yang sedang tersimpan. Hot reload tidak dapat digunakan untuk semua perubahan, misalnya perubahan tertentu pada konfigurasi native, perubahan yang memerlukan inisialisasi ulang, atau kondisi ketika state lama mengganggu hasil pengujian. Dalam kondisi tersebut, gunakan hot restart atau full restart.

AI Disclosure

Dalam pengerjaan Tugas 7, saya menggunakan Codex sebagai asisten diskusi dan pengerjaan untuk membantu memahami penerapan dasar Flutter, penggunaan widget, penyusunan widget tree, serta penerapan warna pada kartu tombol.

Bagian yang dibantu:

- Analisis struktur proyek Flutter dan pencocokan implementasi dengan checklist tugas.
- Penerapan atribut Color pada model ItemHomepage dan penggunaan warna berbeda pada setiap ItemCard.
- Pembaruan widget test untuk memverifikasi informasi pemilik, tombol portfolio, dan pesan SnackBar.
