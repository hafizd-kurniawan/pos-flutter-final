# Sistem Bengkel Otomotif - Professional Workshop Management System

Sistem manajemen bengkel otomotif yang fokus dan profesional, dibangun dengan Flutter untuk memenuhi kebutuhan kasir dan mekanik bengkel.

## 🚀 Fitur Utama

### 1. **Kasir Sparepart**
- Katalog sparepart otomotif lengkap
- Sistem penjualan yang mudah digunakan
- Pencarian sparepart dengan barcode scanner
- Laporan penjualan real-time
- Manajemen transaksi dan pembayaran

### 2. **Manajemen Service Mekanik**
- Tracking pekerjaan service kendaraan
- Status progress perbaikan real-time
- Manajemen antrian service
- Riwayat pekerjaan lengkap

## 🎯 Fokus Aplikasi

Aplikasi ini dirancang khusus untuk:
- **Kasir** - Penjualan sparepart dan aksesoris otomotif
- **Mekanik** - Manajemen dan tracking pekerjaan service

Tidak ada fitur yang tidak perlu - hanya yang essential untuk operasional bengkel otomotif.

## 📊 Data Sparepart

Aplikasi dilengkapi dengan data sparepart otomotif seperti:
- Oli Mesin Shell Helix
- Ban Michelin berbagai ukuran  
- Filter udara dan oli
- Aksesoris kendaraan
- Komponen mesin

## 🏗️ Arsitektur

- **State Management**: BLoC pattern untuk skalabilitas
- **API Integration**: Dummy API siap untuk backend real
- **Design Pattern**: Clean architecture
- **Error Handling**: Comprehensive error handling
- **Responsive Design**: Mobile dan tablet support

## 🚀 Memulai

### Prerequisites
- Flutter SDK (3.8.1 atau lebih tinggi)
- Dart SDK
- Android Studio / VS Code

### Instalasi
1. Clone repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Jalankan aplikasi:
   ```bash
   flutter run
   ```

### Mode Testing
Aplikasi dilengkapi mode testing untuk demonstrasi:
- Tidak perlu login
- Data dummy tersedia
- Semua fitur dapat diakses
- Simulasi real bengkel otomotif

## 📱 Antarmuka Pengguna

### Kasir (Sparepart)
- Katalog produk yang mudah dicari
- Checkout yang simpel dan cepat
- Riwayat transaksi
- Laporan penjualan

### Mekanik (Service)
- Daftar pekerjaan service
- Update status progress
- Filter berdasarkan status
- Detail service job

## 🎨 Desain UI/UX

- **Warna Profesional**: Biru otomotif dengan aksen orange
- **Navigasi Sederhana**: Hanya 2 tab utama (Kasir & Mekanik)
- **Bahasa Indonesia**: Interface lengkap dalam bahasa Indonesia
- **Touch-Friendly**: Tombol besar untuk kemudahan penggunaan mobile
- **Visual Feedback**: Indikator loading dan status yang jelas

## 🔧 Stack Teknologi

- **Frontend**: Flutter/Dart
- **State Management**: BLoC
- **HTTP Client**: Dart HTTP package
- **Local Storage**: SharedPreferences
- **UI Framework**: Material Design
- **Architecture**: Clean Architecture

## 📂 Struktur Project

```
lib/
├── core/                 # Utilities dan constants
├── data/                # Data layer (models, datasources)
├── presentation/        # UI layer (pages, widgets, blocs)
├── main.dart           # Entry point aplikasi
```

## 🎯 Keunggulan

1. **Fokus dan Sederhana** - Hanya fitur essential bengkel
2. **Profesional** - UI/UX sesuai konteks otomotif
3. **Mudah Digunakan** - Navigasi intuitif untuk kasir dan mekanik
4. **Bahasa Lokal** - Interface lengkap bahasa Indonesia
5. **Responsive** - Bekerja di mobile dan tablet
6. **Siap Produksi** - Code quality production-ready

## 🔮 Pengembangan Selanjutnya

- Integrasi dengan backend real
- Notifikasi real-time
- Laporan advanced
- Manajemen inventory
- Integrasi payment gateway

## 📝 Lisensi

Proyek ini dikembangkan untuk keperluan edukasi dan demonstrasi sistem bengkel otomotif.

---

**Catatan**: Sistem bengkel otomotif ini menyediakan foundation lengkap untuk manajemen bengkel profesional dengan dummy API integration, siap untuk dihubungkan dengan backend Golang.