# ✅ ToDo List App

Aplikasi ToDo List sederhana yang dibangun menggunakan Flutter sebagai proyek pembelajaran manajemen state dasar, CRUD, serta penyimpanan data lokal di perangkat.

## ✨ Fitur Utama

- Tambah tugas baru
- Edit nama tugas
- Hapus tugas (swipe to delete)
- Tandai tugas sebagai selesai atau belum selesai
- Data tersimpan di memori lokal menggunakan SharedPreferences
- Tampilan UI sederhana dan user friendly

## 🛠️ Teknologi dan Package

| Komponen | Teknologi |
|---------|-----------|
| Framework | Flutter |
| Bahasa | Dart |
| Local Storage | SharedPreferences |

## 📂 Struktur Folder
```
lib/
├─ models/
│ └─ todo.dart
├─ services/
│ └─ todo_service.dart
├─ screens/
│ └─ todo_page.dart
└─ main.dart
```


## 🚀 Cara Menjalankan

1. Clone repository
   ```sh
   git clone <repository-url>
2. Masuk ke direktori proyek
   ```sh
   cd todo_list
3. Install dependencies
   ```sh
   flutter pub get
4. Jalankan aplikasi di emulator atau device fisik
   ```sh
   flutter run

## 📌 Rencana Pengembangan (Next Update)

- Filter tugas (semua / selesai / belum selesai)
- Reorder tugas dengan drag & drop
- Notifikasi pengingat ✅
- Animasi transisi list
- Penyimpanan data menggunakan database (Hive / SQLite)
- Mode gelap (Dark Mode)
