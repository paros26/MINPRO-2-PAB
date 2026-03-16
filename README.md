# MINPRO-2-PAB

# MUHAMMAD FARROS ANAND | 2409116085

# Aplikasi Penjualan LPG 3 Kg

## Deskripsi Aplikasi

Aplikasi Penjualan LPG 3 Kg adalah aplikasi mobile yang dibuat menggunakan **Flutter** untuk membantu proses pencatatan distribusi dan penjualan tabung LPG kepada pelanggan.

Aplikasi ini memungkinkan pengguna untuk mengelola data pelanggan, mencatat transaksi penjualan, serta memantau stok tabung LPG secara digital. Semua data yang digunakan dalam aplikasi ini disimpan secara online menggunakan database **Supabase**, sehingga data dapat diakses dengan lebih aman dan terstruktur.

Aplikasi ini dibuat sebagai pengembangan dari Mini Project 1 dengan menambahkan integrasi database, sistem autentikasi, serta struktur aplikasi yang lebih baik.

---

# Fitur Aplikasi

## 1. Sistem Login dan Register

Aplikasi menyediakan fitur autentikasi pengguna menggunakan Supabase Auth.


Fitur ini memungkinkan pengguna untuk:

* Mendaftar akun baru
* Login ke dalam aplikasi
* Mengakses data sesuai dengan akun masing-masing

Setiap akun pengguna memiliki data stok yang berbeda sehingga data antar pengguna tidak saling tercampur.

---

## 2. Manajemen Data Pelanggan (CRUD)

### Create (Tambah Data Pelanggan)

Pengguna dapat menambahkan pelanggan baru dengan mengisi beberapa informasi seperti:

* NIK
* Nama pelanggan
* Kategori pelanggan (Rumah Tangga / Usaha Mikro)

Data pelanggan kemudian disimpan ke database Supabase.

### Read (Menampilkan Data Pelanggan)

Aplikasi menampilkan daftar pelanggan yang telah terdaftar dalam sistem.

Pengguna dapat melihat informasi pelanggan yang tersimpan di database.

### Update (Edit Data Pelanggan)

Pengguna dapat memperbarui data pelanggan apabila terdapat kesalahan atau perubahan data.

Contohnya:

* Mengubah nama pelanggan
* Mengubah kategori pelanggan

### Delete (Hapus Data Pelanggan)

Data pelanggan yang sudah tidak digunakan dapat dihapus dari sistem.

---

## 3. Manajemen Stok LPG

### Tambah Stok

Pengguna dapat menambahkan stok LPG ketika terdapat pengiriman tabung baru.

Stok akan bertambah sesuai dengan jumlah tabung yang dimasukkan oleh pengguna.

### Monitoring Stok

Aplikasi menampilkan jumlah stok LPG yang tersedia sehingga pengguna dapat mengetahui kondisi stok saat ini.

---

## 4. Pencatatan Penjualan LPG

### Create Penjualan

Pengguna dapat mencatat transaksi penjualan dengan langkah berikut:

1. Memasukkan NIK pelanggan
2. Sistem akan mengecek apakah pelanggan sudah terdaftar
3. Jika pelanggan ditemukan, pengguna dapat memasukkan jumlah tabung yang dibeli

Data transaksi kemudian disimpan ke database Supabase.

### Update Penjualan

Jika terjadi kesalahan pencatatan transaksi, pengguna dapat memperbarui jumlah tabung yang telah dicatat.

### Delete Penjualan

Data transaksi yang salah dapat dihapus dari sistem.

Jika data penjualan dihapus, maka stok LPG akan otomatis bertambah kembali sesuai jumlah tabung pada transaksi tersebut.

---

## 5. Validasi Pembelian Berdasarkan Kategori

Aplikasi memiliki aturan pembelian LPG sesuai kategori pelanggan:

| Kategori     | Maksimal Pembelian |
| ------------ | ------------------ |
| Rumah Tangga | 3 Tabung           |
| Usaha Mikro  | 5 Tabung           |

Jika pelanggan membeli melebihi batas tersebut, aplikasi akan menampilkan peringatan.

---

## 6. Validasi Stok LPG

Aplikasi juga melakukan pengecekan stok sebelum transaksi dilakukan.

Jika stok tidak mencukupi atau habis, maka aplikasi akan menampilkan notifikasi dan transaksi tidak dapat diproses.

---

# Widget yang Digunakan

Beberapa widget utama Flutter yang digunakan dalam aplikasi ini antara lain:

### MaterialApp

Digunakan sebagai root widget untuk menjalankan aplikasi berbasis Material Design.

### Scaffold

Digunakan sebagai struktur dasar halaman aplikasi yang berisi AppBar dan body.

### AppBar

Digunakan untuk menampilkan judul halaman aplikasi.

### TextField

Digunakan untuk menerima input dari pengguna seperti:

* NIK pelanggan
* Nama pelanggan
* Jumlah tabung LPG

### ElevatedButton

Digunakan sebagai tombol aksi seperti:

* Cek pelanggan
* Simpan data
* Tambah stok

### Container

Digunakan untuk mengatur tata letak dan dekorasi komponen.

### Column

Digunakan untuk menyusun widget secara vertikal.

### Row

Digunakan untuk menyusun widget secara horizontal.

### Icon

Digunakan untuk menampilkan ikon pada tampilan aplikasi.

### ListView

Digunakan untuk menampilkan daftar data seperti daftar pelanggan atau riwayat penjualan.

### SnackBar

Digunakan untuk menampilkan notifikasi kepada pengguna.

### AlertDialog

Digunakan untuk menampilkan pesan peringatan atau konfirmasi.

---

# Alur Aplikasi

Berikut adalah alur penggunaan aplikasi:

1. **Login**

   Pengguna melakukan login menggunakan akun yang telah terdaftar.

2. **Mengelola Data Pelanggan**

   Pengguna dapat menambahkan pelanggan baru dengan memasukkan data seperti NIK, nama, dan kategori pelanggan.

3. **Cek Data Pelanggan**

   Saat mencatat penjualan, pengguna memasukkan NIK pelanggan untuk memastikan pelanggan sudah terdaftar.

4. **Mencatat Penjualan**

   Setelah pelanggan ditemukan, pengguna memasukkan jumlah tabung LPG yang dibeli.

5. **Validasi Transaksi**

   Aplikasi akan melakukan pengecekan:

   * apakah stok tersedia
   * apakah jumlah pembelian sesuai dengan kategori pelanggan

6. **Penyimpanan Data**

   Jika semua validasi berhasil, data penjualan akan disimpan ke database Supabase.

7. **Pengurangan Stok**

   Stok LPG akan otomatis berkurang sesuai jumlah tabung yang dibeli.

8. **Menampilkan Notifikasi**

   Aplikasi akan menampilkan notifikasi jika transaksi berhasil atau jika terjadi kesalahan seperti stok habis.

---

# Teknologi yang Digunakan

* Flutter
* Dart
* Supabase (Database dan Authentication)
* Material UI

---

# Catatan

Supabase URL dan API Key tidak dimasukkan langsung ke dalam repository GitHub untuk menjaga keamanan. Informasi tersebut disimpan menggunakan file `.env`.
