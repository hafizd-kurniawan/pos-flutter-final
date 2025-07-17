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

## 🎯 Keunggulan

1. **Fokus dan Sederhana** - Hanya fitur essential bengkel
2. **Profesional** - UI/UX sesuai konteks otomotif
3. **Mudah Digunakan** - Navigasi intuitif untuk kasir dan mekanik
4. **Bahasa Lokal** - Interface lengkap bahasa Indonesia
5. **Responsive** - Bekerja di mobile dan tablet
6. **Siap Produksi** - Code quality production-ready

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code

### Installation
1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the application:
   ```bash
   flutter run
   ```

### Connecting to Real Backend
1. Update `Variables.baseUrl` in `lib/core/constants/variables.dart`
2. Replace dummy datasources with real API calls
3. Update authentication flow as needed

## 📱 Features Overview

### POS System
- Product catalog management
- Category organization
- Order processing
- Payment handling
- Transaction history
- Sales reporting

### Workshop Management
- **Service Jobs**: Create, track, and manage repair jobs
- **Customer Management**: Customer profiles with vehicle details
- **Service Management**: Define services with categories and pricing
- **Outlet Management**: Manage multiple workshop locations

### Technical Features
- **Dummy API Integration**: Complete dummy data for testing
- **BLoC State Management**: Scalable state management
- **Responsive Design**: Mobile and tablet support
- **Error Handling**: Comprehensive error handling
- **Loading States**: Proper loading indicators
- **Search & Filter**: Advanced search capabilities

## 🔧 Technical Stack

- **Frontend**: Flutter/Dart
- **State Management**: BLoC
- **HTTP Client**: Dart HTTP package
- **Local Storage**: SharedPreferences
- **UI Components**: Material Design
- **Architecture**: Clean Architecture

## 📂 Project Structure

```
lib/
├── core/                 # Core utilities and constants
├── data/                # Data layer (models, datasources)
├── presentation/        # UI layer (pages, widgets, blocs)
├── main.dart           # Application entry point
```

## 🎨 UI/UX Features

- **Modern Design**: Clean and professional interface
- **Intuitive Navigation**: Easy-to-use navigation system
- **Responsive Layout**: Adapts to different screen sizes
- **Loading States**: Proper loading indicators
- **Error Messages**: User-friendly error messages
- **Search Functionality**: Quick search across all modules

## 🛠️ Development Notes

The application is built with production-ready standards:
- Clean code architecture
- Proper error handling
- Comprehensive state management
- Modular component structure
- Ready for real API integration

## 🔮 Future Enhancements

- Real-time notifications
- Advanced reporting
- Inventory management
- Employee management
- Payment gateway integration
- Cloud synchronization

## 📝 License

This project is developed for educational and demonstration purposes.

---

**Note**: This enhanced POS system provides a complete foundation for a professional workshop management solution with dummy API integration, ready to be connected to a real Golang backend.
