<h1>📚 Sekolah Kita</h1>

![Flutter](https://img.shields.io/badge/Flutter-3.9.2-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.9.2-0175C2?logo=dart)
![License](https://img.shields.io/badge/License-Private-red)
![Android](https://img.shields.io/badge/Platform-Android-3DDC84?logo=android&logoColor=white)
![BLoC](https://img.shields.io/badge/State%20Management-BLoC-5C2D91?logo=flutter&logoColor=white)
![SQLite](https://img.shields.io/badge/Database-SQLite-003B57?&logo=sqlite&logoColor=white)
![Material Design](https://img.shields.io/badge/UI-Material%20Design-757575?logo=materialdesign&logoColor=white)
![Clean Architecture](https://img.shields.io/badge/Architecture-Clean-4CAF50)

**Sekolah Kita** adalah aplikasi edukasi berbasis Android yang dirancang untuk membantu anak-anak belajar **membaca, menulis, dan berhitung** secara interaktif dan menyenangkan.
Aplikasi ini menggunakan pendekatan **lesson + quiz**, animasi menulis (writing trace), audio, serta sistem progres dan bintang untuk meningkatkan motivasi belajar.

---

## ✨ Fitur Utama

* 📖 **Materi Pembelajaran** (Lesson)
  * Literasi Membaca (huruf, suku kata, kata)
  * Literasi Menulis (latihan menulis huruf dengan tracing)
  * Numerasi Dasar (angka dan operasi dasar)
* 📝 **Kuis Interaktif**
  * Multiple choice
  * Multiple sound
  * Listening
  * Speech
  * Writing trace (menulis mengikuti pola)
* ⭐ **Sistem Bintang**
  * Mendapatkan bintang setelah menyelesaikan kuis dengan nilai >80
* 📊 **Progress Belajar**
  * Progress per course
  * Modul terkunci & terbuka bertahap
* ⏱️ **Waktu Belajar**
  * Akumulasi total waktu belajar pengguna
* 👶 **Profil Anak**
  * Avatar
  * Username

---

## 🧱 Tech Stack

* **Framework**: Flutter
* **Language**: Dart
* **State Management**: BLoC / Cubit
* **Local Database**: SQLite (sqflite)
* **Local Storage**: SharedPreferences
* **Architecture**: Feature-based & MVVM Architecture approach
* **Platform**: Android

---

## 🗂️ Project Structure (Simplified)

```
assets/                 # Tempat menyimpan assets aplikasi
├── animations/         # Animasi
├── fonts/              # Font
├── icons/              # Custom icon
└── images/             # Gambar

lib/
├── core/               # Core configuration
│   ├── bloc/           # Global BLoC provider
│   ├── constant/       # Global variable
│   ├── database/       # Data 
│   ├── theme/          # Konfigurasi tema
│   ├── utils/          # App utility
│   └── widgets/        # Global widgets
│
├── features/           # Fitur-fitur aplikasi
│   ├── course/         # Kursus
│   ├── home/           # Home
│   ├── introduction/   # Introduction
│   ├── lesson/         # Materi
│   ├── navigation/     # Bottom Navigation
│   ├── profile/        # Profil
│   ├── quiz/           # Quiz
│   │   ├── bloc/           # State Management
│   │   ├── cubit/          # State Management (low maintain)
│   │   ├── service/        # Servis yang digunakan dalam fitur
│   │   └── views/          # Tampilan
│   │       ├── pages/      
│   │       └── widgets/ 
│   │
│   └── splashscreen/   # Splash Screen
└── main.dart
```

---

## ⚙️ Instalasi & Setup

### Prasyarat

* Flutter SDK (stable)
* Android Studio / VS Code
* Emulator atau perangkat Android

### Langkah Instalasi

```bash
git clone https://github.com/JavierGavra/SekolahKita.git
cd SekolahKita
flutter pub get
```

### Menjalankan Aplikasi

```bash
flutter run
```

Pastikan emulator atau device Android sudah aktif.

---

## 🧠 Arsitektur & Best Practices

* Pemisahan **UI – State – Logic - Model - Service**
* Menggunakan **Cubit/BLoC** untuk state management
* Modular & scalable (mudah menambah course / quiz baru)
* Reusable widgets
* Consistent naming & clean code
* Separation of Concern (SoC)

---

## 📝 Commit History

* Commit dibuat secara **bertahap & deskriptif**
* Setiap fitur utama diimplementasikan dalam commit terpisah
* Mudah ditelusuri untuk keperluan review

Contoh commit message:

```
feat: add writing trace quiz with stroke validation
fix: prevent duplicate star insertion in database
refactor: clean module card UI logic
```

---
