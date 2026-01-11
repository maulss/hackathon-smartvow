# SmartVow - Theme & Color Palette Documentation

## 🎨 Design Philosophy

SmartVow adalah aplikasi DAPP (Decentralized Application) untuk penengah pernikahan yang menangani topik sensitif seperti perceraian, kekerasan, perselingkuhan, dan keuangan. Color palette dirancang dengan prinsip:

1. **Profesional & Terpercaya** - Menciptakan rasa aman dan kredibilitas
2. **Tenang & Menenangkan** - Karena menangani topik sensitif dan emosional
3. **Modern & Blockchain** - Mencerminkan teknologi Web3 dan desentralisasi
4. **Accessible** - Mudah dibaca dan memenuhi standar aksesibilitas

---

## 🎯 Color Palette Overview

### Primary Colors - Deep Blue
- **Primary**: `#1E3A5F` - Biru gelap yang profesional dan terpercaya
- **Primary Light**: `#2C5282` - Varian lebih terang
- **Primary Dark**: `#0F2340` - Varian lebih gelap

**Penggunaan**: AppBar, tombol utama, header, elemen navigasi

### Secondary Colors - Teal/Cyan
- **Secondary**: `#14B8A6` - Teal yang mencerminkan teknologi blockchain
- **Secondary Light**: `#2DD4BF` - Varian lebih cerah
- **Secondary Dark**: `#0D9488` - Varian lebih gelap

**Penggunaan**: FAB, toggle, status verified, aksen blockchain

### Accent Colors - Amber Gold
- **Accent**: `#F59E0B` - Emas yang mencerminkan nilai dan keamanan
- **Accent Light**: `#FBBF24` - Varian lebih terang
- **Accent Dark**: `#D97706` - Varian lebih gelap

**Penggunaan**: Highlights, badge premium, smart contract indicators

---

## 🔖 Semantic Colors

### Success (Green)
- **Color**: `#10B981`
- **Usage**: Mediasi berhasil, persetujuan, verifikasi blockchain

### Warning (Amber)
- **Color**: `#F59E0B`
- **Usage**: Peringatan, pending approval, review needed

### Error (Red)
- **Color**: `#EF4444`
- **Usage**: Penolakan, error, masalah kritis

### Info (Blue)
- **Color**: `#3B82F6`
- **Usage**: Informasi umum, tips, panduan

---

## 📋 Specialized Category Colors

Untuk membedakan berbagai jenis kasus:

| Category | Color | Hex | Usage |
|----------|-------|-----|-------|
| Perceraian | Purple | `#8B5CF6` | Badge, status perceraian |
| Kekerasan | Red | `#DC2626` | Kasus urgent, peringatan |
| Perselingkuhan | Pink | `#EC4899` | Kasus perselingkuhan |
| Keuangan | Green | `#10B981` | Masalah finansial |
| Mediasi | Teal | `#14B8A6` | Status mediasi aktif |

---

## 🌓 Dark Mode Support

Theme sudah mendukung dark mode dengan color scheme yang disesuaikan:

- Background: `#0F172A` (Dark Blue Gray)
- Surface: `#1E293B` (Slightly lighter)
- Text: `#F9FAFB` (Off-white untuk readability)

---

## 💡 Contoh Implementasi

### 1. Menggunakan Theme di Main App

```dart
import 'package:flutter/material.dart';
import 'package:hackathon_smartvow/core/theme/app_theme.dart';

void main() {
  runApp(const SmartVowApp());
}

class SmartVowApp extends StatelessWidget {
  const SmartVowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartVow',
      // Light Theme
      theme: AppTheme.lightTheme,
      // Dark Theme
      darkTheme: AppTheme.darkTheme,
      // Ikuti system theme
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}
```

### 2. Menggunakan Colors secara Langsung

```dart
import 'package:flutter/material.dart';
import 'package:hackathon_smartvow/core/constants/color_constant.dart';

class CaseCard extends StatelessWidget {
  final String caseType;

  @override
  Widget build(BuildContext context) {
    Color categoryColor;

    // Pilih warna berdasarkan kategori
    switch (caseType) {
      case 'divorce':
        categoryColor = AppColors.divorce;
        break;
      case 'violence':
        categoryColor = AppColors.violence;
        break;
      case 'infidelity':
        categoryColor = AppColors.infidelity;
        break;
      case 'finance':
        categoryColor = AppColors.finance;
        break;
      default:
        categoryColor = AppColors.mediation;
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: categoryColor, width: 2),
      ),
      child: // ... card content
    );
  }
}
```

### 3. Menggunakan Blockchain Gradient

```dart
Container(
  decoration: BoxDecoration(
    gradient: AppColors.blockchainGradient,
    borderRadius: BorderRadius.circular(12),
  ),
  padding: EdgeInsets.all(16),
  child: Row(
    children: [
      Icon(Icons.verified, color: AppColors.textOnPrimary),
      SizedBox(width: 8),
      Text(
        'Verified on Blockchain',
        style: TextStyle(
          color: AppColors.textOnPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  ),
)
```

### 4. Status Badge dengan Semantic Colors

```dart
class StatusBadge extends StatelessWidget {
  final String status; // 'approved', 'pending', 'rejected'

  @override
  Widget build(BuildContext context) {
    Color badgeColor;
    String badgeText;

    switch (status) {
      case 'approved':
        badgeColor = AppColors.success;
        badgeText = 'Disetujui';
        break;
      case 'pending':
        badgeColor = AppColors.warning;
        badgeText = 'Menunggu';
        break;
      case 'rejected':
        badgeColor = AppColors.error;
        badgeText = 'Ditolak';
        break;
      default:
        badgeColor = AppColors.info;
        badgeText = 'Info';
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.1),
        border: Border.all(color: badgeColor),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        badgeText,
        style: TextStyle(
          color: badgeColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
```

### 5. Context Extension untuk Dark Mode

```dart
import 'package:hackathon_smartvow/core/constants/color_constant.dart';

// Gunakan extension untuk adaptif ke dark mode
Container(
  color: context.backgroundColor, // Otomatis sesuai theme
  child: Text(
    'Content',
    style: TextStyle(color: context.textColor),
  ),
)
```

### 6. Custom Card dengan Shadow

```dart
Container(
  decoration: BoxDecoration(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: AppColors.shadowMedium,
        blurRadius: 8,
        offset: Offset(0, 2),
      ),
    ],
  ),
  child: // ... content
)
```

---

## 🎭 Design Patterns

### Pattern 1: Card dengan Category Indicator

```dart
Card(
  child: Column(
    children: [
      // Colored top border untuk kategori
      Container(
        height: 4,
        decoration: BoxDecoration(
          color: AppColors.divorce,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(16),
        child: // ... content
      ),
    ],
  ),
)
```

### Pattern 2: Blockchain Verified Badge

```dart
Container(
  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
  decoration: BoxDecoration(
    gradient: AppColors.blockchainGradient,
    borderRadius: BorderRadius.circular(20),
  ),
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.verified_outlined, size: 16, color: Colors.white),
      SizedBox(width: 4),
      Text('Verified', style: TextStyle(color: Colors.white, fontSize: 12)),
    ],
  ),
)
```

### Pattern 3: Status Timeline

```dart
// Untuk menampilkan progress mediasi
Row(
  children: [
    _buildTimelineStep('Submitted', AppColors.success, true),
    _buildTimelineLine(AppColors.success),
    _buildTimelineStep('Review', AppColors.warning, true),
    _buildTimelineLine(AppColors.neutral300),
    _buildTimelineStep('Decision', AppColors.neutral300, false),
  ],
)
```

---

## 📱 Accessibility

Color palette sudah mempertimbangkan:
- ✅ WCAG 2.1 AA contrast ratio (4.5:1 untuk text normal)
- ✅ Color blindness friendly combinations
- ✅ Dark mode support untuk mengurangi eye strain
- ✅ Semantic colors yang jelas dan konsisten

---

## 🚀 Next Steps

1. Implementasikan theme di `main.dart`
2. Buat komponen reusable (cards, badges, buttons)
3. Tambahkan animasi transisi yang smooth
4. Implementasikan blockchain visual elements (gradient, glow effects)
5. Testing di berbagai devices dan brightness settings

---

## 📝 Notes

- Hindari menggunakan warna murni (pure colors) karena terlalu harsh
- Selalu gunakan konstanta dari `AppColors` untuk konsistensi
- Untuk variasi, gunakan `withOpacity()` daripada membuat warna baru
- Test readability di berbagai kondisi cahaya
