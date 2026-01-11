# Bottom Navigation Bar Documentation

## Overview

SmartVow menggunakan custom bottom navigation bar yang dirancang khusus dengan color palette dan theme yang sudah dibuat. Navigation bar mendukung 5 halaman utama aplikasi.

---

## 🎯 Fitur-Fitur yang Tersedia

### 1. **Dashboard** 🏠
- **Icon**: `dashboard_rounded`
- **Color**: Primary Blue
- **Fungsi**: Halaman utama dengan overview, statistik, dan recent activity
- **Fitur**:
  - Welcome card dengan blockchain badge
  - Quick stats (Active Cases, Documents, Resolved, Pending)
  - Recent activity timeline

### 2. **History** 📜
- **Icon**: `history_rounded`
- **Color**: Primary Blue
- **Fungsi**: Riwayat semua transaksi dan kasus
- **Fitur**:
  - Filter chips (All, Resolved, Pending, Rejected)
  - History items dengan category indicator
  - Status badges dengan warna semantic
  - Blockchain verification indicator

### 3. **Shared Vault** 🗂️
- **Icon**: `folder_shared_rounded`
- **Color**: Secondary Teal (Center item)
- **Fungsi**: Vault dokumen terenkripsi
- **Fitur**:
  - Vault statistics (Documents, Storage, Shared)
  - Quick actions (Upload, Create Folder)
  - Folder browsing dengan color coding
  - Recent files dengan verification status

### 4. **Smart Prenup** 📝
- **Icon**: `description_rounded`
- **Color**: Primary Blue
- **Fungsi**: Smart contract prenuptial agreements
- **Fitur**:
  - Agreement statistics
  - Template library (Standard, Asset Protection, Business Owner, Custom)
  - Existing agreements dengan progress indicator
  - Blockchain verification badge

### 5. **Marriage Certificate** 🎖️
- **Icon**: `card_membership_rounded`
- **Color**: Primary Blue
- **Fungsi**: Digital marriage certificate management
- **Fitur**:
  - Certificate preview dengan blockchain badge
  - Quick actions (Upload, Verify, Share)
  - Certificate details
  - Verification history timeline
  - QR code untuk verifikasi

---

## 🎨 Design Features

### Active State Indicators
1. **Background Color**: Color dengan alpha 0.1
2. **Icon Size**: 26px (inactive: 24px)
3. **Top Border**: 3px solid line di atas icon
4. **Font Weight**: Semi-bold (600)
5. **Smooth Animation**: 200ms ease-in-out

### Color Scheme
- **Active Item**: Primary color (Dashboard, History, Prenup, Certificate)
- **Center Item Active**: Secondary color (Shared Vault)
- **Inactive Items**: Neutral gray (400/500)

### Responsive Design
- **Height**: 72px total
- **Safe Area**: Automatically handled
- **Touch Target**: Optimized for mobile (minimum 44x44)
- **Shadow**: Subtle elevation dengan shadow

---

## 📱 Implementasi

### Basic Navigation
```dart
import 'package:flutter/material.dart';
import 'core/navigation/main_navigation.dart';

void main() {
  runApp(MaterialApp(
    home: MainNavigation(),
  ));
}
```

### Alternative: Navigation dengan FAB di Tengah
```dart
import 'package:flutter/material.dart';
import 'core/navigation/main_navigation.dart';

void main() {
  runApp(MaterialApp(
    home: MainNavigationWithFAB(), // FAB di tengah untuk Vault
  ));
}
```

---

## 🔧 Customization

### Mengganti Icon
Edit file: `lib/core/widgets/custom_bottom_nav.dart`

```dart
_buildNavItem(
  context,
  index: 0,
  icon: Icons.home_rounded, // Ganti icon di sini
  label: 'Dashboard',
  isActive: currentIndex == 0,
),
```

### Mengganti Warna Active State
```dart
final Color activeColor = isCenter
    ? AppColors.secondary  // Warna untuk center item
    : AppColors.primary;   // Warna untuk item lainnya
```

### Menambah/Mengurangi Item
1. Edit `_MainNavigationState` di `main_navigation.dart`
2. Tambah/kurangi page di `_pages` list
3. Update `CustomBottomNav` widget dengan item baru

---

## 🎭 Animations

### Transition Effects
- **Duration**: 200ms
- **Curve**: `Curves.easeInOut`
- **Properties Animated**:
  - Background color
  - Icon size
  - Font size & weight
  - Border appearance

### Smooth Page Transitions
Menggunakan `IndexedStack` untuk:
- ✅ Preserve state saat pindah halaman
- ✅ Instant switching tanpa rebuild
- ✅ Smooth transitions

---

## 🌓 Dark Mode Support

Bottom navigation automatically adapts:
- **Background**: Surface color (white/dark surface)
- **Active Color**: Tetap sama (primary/secondary)
- **Inactive Color**: Neutral 400 (light) / Neutral 500 (dark)
- **Shadow**: Adjusted untuk dark mode

---

## ♿ Accessibility

- ✅ Touch targets >= 44x44 pixels
- ✅ Clear visual feedback on selection
- ✅ High contrast ratio untuk readability
- ✅ Icon + Label untuk clarity
- ✅ Smooth animations (tidak terlalu cepat)

---

## 📊 Navigation Flow

```
┌─────────────────────────────────────────┐
│          Main Navigation                │
├─────────────────────────────────────────┤
│                                         │
│  ┌──────┐  ┌──────┐  ┌──────┐         │
│  │ Dash │  │ Hist │  │Vault │  ...    │
│  └──────┘  └──────┘  └──────┘         │
│                                         │
│  IndexedStack preserves all states     │
│                                         │
└─────────────────────────────────────────┘
```

---

## 🚀 Best Practices

### DO ✅
- Gunakan `IndexedStack` untuk preserve state
- Keep navigation items 5 atau kurang
- Use clear, descriptive labels
- Maintain consistent icon style
- Test pada berbagai screen sizes

### DON'T ❌
- Jangan lebih dari 5 navigation items
- Jangan gunakan label yang terlalu panjang
- Jangan skip animations (UX important)
- Jangan hardcode colors (use AppColors)

---

## 🎯 Future Enhancements

### Planned Features
- [ ] Badge notifications di navigation items
- [ ] Haptic feedback on tap
- [ ] Long press untuk quick actions
- [ ] Swipe gestures antar pages
- [ ] Custom page transitions

### Possible Improvements
- [ ] Animated icons saat active
- [ ] Micro-interactions (ripple, scale)
- [ ] Navigation history tracking
- [ ] Deep linking support

---

## 📝 Code Example

### Custom Bottom Nav Usage
```dart
CustomBottomNav(
  currentIndex: _currentIndex,
  onTap: (index) {
    setState(() {
      _currentIndex = index;
    });
  },
)
```

### With FAB (Floating Action Button)
```dart
CustomBottomNavWithFAB(
  currentIndex: _currentIndex,
  onTap: (index) {
    setState(() {
      _currentIndex = index;
    });
  },
  onCenterTap: () {
    setState(() {
      _currentIndex = 2; // Vault
    });
  },
)

// Plus FAB widget:
floatingActionButton: Container(
  decoration: BoxDecoration(
    gradient: AppColors.blockchainGradient,
  ),
  child: FloatingActionButton(
    onPressed: onCenterTap,
    child: Icon(Icons.folder_shared_rounded),
  ),
),
```

---

## 🎨 Visual Preview

```
┌───────────────────────────────────────────────┐
│                                               │
│              PAGE CONTENT                     │
│                                               │
└───────────────────────────────────────────────┘
┌───────────────────────────────────────────────┐
│  [🏠]    [📜]    [🗂️]    [📝]    [🎖️]       │
│  Dash    Hist    Vault   Prenup  Cert        │
│  ====                                         │ ← Active indicator
│ (Active)                                      │
└───────────────────────────────────────────────┘
```

---

## 🐛 Troubleshooting

### Issue: Navigation tidak muncul
**Solution**: Pastikan `MainNavigation` digunakan sebagai `home` di `MaterialApp`

### Issue: Warna tidak sesuai
**Solution**: Check import `color_constant.dart` dan pastikan menggunakan `AppColors`

### Issue: State hilang saat pindah page
**Solution**: Gunakan `IndexedStack` bukan `PageView` atau conditional rendering

### Issue: Animation patah-patah
**Solution**: Pastikan menggunakan `AnimatedContainer` dengan curve yang tepat

---

## 📚 Related Files

- `lib/core/widgets/custom_bottom_nav.dart` - Bottom nav widget
- `lib/core/navigation/main_navigation.dart` - Main navigation wrapper
- `lib/core/constants/color_constant.dart` - Color definitions
- `lib/core/theme/app_theme.dart` - Theme configuration

---

Selamat menggunakan Bottom Navigation! 🎉
