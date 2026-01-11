# 🎨 SmartVow - Design & Color Guide

## Overview

SmartVow adalah DAPP (Decentralized Application) untuk penengah pernikahan yang menangani masalah sensitif seperti perceraian, kekerasan dalam rumah tangga, perselingkuhan, dan masalah keuangan. Design system dirancang untuk menciptakan lingkungan yang:

- ✅ **Profesional & Terpercaya** - User harus merasa aman dan yakin
- ✅ **Tenang & Menenangkan** - Mengurangi stress dalam situasi emosional
- ✅ **Modern & Inovatif** - Mencerminkan teknologi blockchain
- ✅ **Accessible** - Mudah digunakan untuk semua orang

---

## 🎯 Color Strategy

### Primary Color: Deep Blue (#1E3A5F)

**Psikologi**: Trust, stability, professionalism, security

**Kapan Menggunakan**:
- ✅ AppBar dan navigation bar
- ✅ Primary buttons (CTA utama)
- ✅ Headers dan judul penting
- ✅ Links dan interactive elements
- ✅ Logo dan branding elements

**Jangan Gunakan untuk**:
- ❌ Background besar (terlalu gelap)
- ❌ Error messages
- ❌ Body text (readability issues)

**Contoh**:
```dart
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
  ),
  onPressed: () {},
  child: Text('Submit Case'),
)
```

---

### Secondary Color: Teal (#14B8A6)

**Psikologi**: Technology, innovation, blockchain, freshness

**Kapan Menggunakan**:
- ✅ Floating Action Buttons
- ✅ Toggle switches dan checkboxes
- ✅ Blockchain verification badges
- ✅ Progress indicators
- ✅ Interactive highlights

**Jangan Gunakan untuk**:
- ❌ Warning atau error states
- ❌ Text yang panjang
- ❌ Primary navigation

**Contoh**:
```dart
// Blockchain verified badge
Container(
  decoration: BoxDecoration(
    gradient: AppColors.blockchainGradient,
  ),
  child: Row(
    children: [
      Icon(Icons.verified, color: Colors.white),
      Text('Verified on Blockchain'),
    ],
  ),
)
```

---

### Accent Color: Amber Gold (#F59E0B)

**Psikologi**: Value, premium, importance, attention

**Kapan Menggunakan**:
- ✅ Premium features badge
- ✅ Important highlights
- ✅ Smart contract indicators
- ✅ Reward/achievement badges
- ✅ Special notifications

**Jangan Gunakan untuk**:
- ❌ Backgrounds (terlalu mencolok)
- ❌ Large text areas
- ❌ Regular buttons

**Contoh**:
```dart
// Premium badge
Container(
  decoration: BoxDecoration(
    gradient: AppColors.accentGradient,
  ),
  child: Row(
    children: [
      Icon(Icons.stars, color: Colors.white),
      Text('Premium Mediation'),
    ],
  ),
)
```

---

## 🔖 Semantic Colors Guide

### Success Green (#10B981)

**Kapan Menggunakan**:
- ✅ Mediasi berhasil diselesaikan
- ✅ Dokumen berhasil diupload ke blockchain
- ✅ Persetujuan kedua pihak
- ✅ Payment confirmed
- ✅ Case closed successfully

**Contoh Use Case**:
```dart
// Success message
Container(
  color: AppColors.success.withValues(alpha: 0.1),
  child: Row(
    children: [
      Icon(Icons.check_circle, color: AppColors.success),
      Text('Mediasi berhasil diselesaikan'),
    ],
  ),
)
```

---

### Warning Amber (#F59E0B)

**Kapan Menggunakan**:
- ✅ Pending approval
- ✅ Action required
- ✅ Missing documents
- ✅ Payment pending
- ✅ Review needed

**Contoh Use Case**:
```dart
// Warning banner
Container(
  color: AppColors.warning.withValues(alpha: 0.1),
  child: Row(
    children: [
      Icon(Icons.warning_amber, color: AppColors.warning),
      Text('Dokumen perlu dilengkapi'),
    ],
  ),
)
```

---

### Error Red (#EF4444)

**Kapan Menggunakan**:
- ✅ Case rejected
- ✅ Payment failed
- ✅ Form validation errors
- ✅ System errors
- ✅ Critical alerts
- ✅ Violence/urgent cases

**Contoh Use Case**:
```dart
// Error message
Container(
  color: AppColors.error.withValues(alpha: 0.1),
  child: Row(
    children: [
      Icon(Icons.error, color: AppColors.error),
      Text('Pembayaran gagal diproses'),
    ],
  ),
)
```

---

### Info Blue (#3B82F6)

**Kapan Menggunakan**:
- ✅ Informational messages
- ✅ Tips dan panduan
- ✅ System notifications
- ✅ Help text
- ✅ Announcements

---

## 📋 Category-Specific Colors

### Perceraian (Divorce) - Purple (#8B5CF6)

**Penggunaan**:
- Badge untuk kasus perceraian
- Category indicator
- Filter tags

```dart
// Category badge
Container(
  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  decoration: BoxDecoration(
    color: AppColors.divorce,
    borderRadius: BorderRadius.circular(4),
  ),
  child: Text(
    'Perceraian',
    style: TextStyle(color: Colors.white, fontSize: 12),
  ),
)
```

---

### Kekerasan (Violence) - Red (#DC2626)

**Penggunaan**:
- Urgent case markers
- High priority indicators
- Emergency alerts

**Catatan**: Gunakan dengan hati-hati, hanya untuk kasus yang benar-benar urgent.

---

### Perselingkuhan (Infidelity) - Pink (#EC4899)

**Penggunaan**:
- Category tag
- Case type indicator

---

### Keuangan (Finance) - Green (#10B981)

**Penggunaan**:
- Financial dispute cases
- Payment-related issues
- Asset division cases

---

### Mediasi (Mediation) - Teal (#14B8A6)

**Penggunaan**:
- Active mediation status
- Mediator assignment
- Mediation progress

---

## 🎭 Design Patterns

### 1. Card Design untuk Cases

```dart
Card(
  child: Column(
    children: [
      // Category indicator (colored top border)
      Container(
        height: 4,
        color: getCategoryColor(caseType), // AppColors.divorce, etc.
      ),

      Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Header dengan status badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Case #12345'),
                StatusBadge(status: 'pending'),
              ],
            ),

            // Content
            SizedBox(height: 12),
            Text('Case description...'),

            // Footer dengan blockchain badge (jika verified)
            if (isVerified)
              BlockchainBadge(),
          ],
        ),
      ),
    ],
  ),
)
```

---

### 2. Status Badge Pattern

```dart
enum CaseStatus { submitted, reviewing, mediation, resolved, rejected }

Widget buildStatusBadge(CaseStatus status) {
  Color color;
  IconData icon;
  String text;

  switch (status) {
    case CaseStatus.submitted:
      color = AppColors.info;
      icon = Icons.upload_file;
      text = 'Submitted';
      break;
    case CaseStatus.reviewing:
      color = AppColors.warning;
      icon = Icons.rate_review;
      text = 'Under Review';
      break;
    case CaseStatus.mediation:
      color = AppColors.mediation;
      icon = Icons.people;
      text = 'In Mediation';
      break;
    case CaseStatus.resolved:
      color = AppColors.success;
      icon = Icons.check_circle;
      text = 'Resolved';
      break;
    case CaseStatus.rejected:
      color = AppColors.error;
      icon = Icons.cancel;
      text = 'Rejected';
      break;
  }

  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      border: Border.all(color: color),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        SizedBox(width: 4),
        Text(text, style: TextStyle(color: color, fontSize: 12)),
      ],
    ),
  );
}
```

---

### 3. Timeline/Progress Pattern

```dart
// Untuk menampilkan progress case
Row(
  children: [
    TimelineStep(
      label: 'Submitted',
      isComplete: true,
      color: AppColors.success,
    ),
    TimelineLine(isActive: true),
    TimelineStep(
      label: 'Review',
      isComplete: true,
      color: AppColors.success,
    ),
    TimelineLine(isActive: true),
    TimelineStep(
      label: 'Mediation',
      isComplete: false,
      isCurrent: true,
      color: AppColors.warning,
    ),
    TimelineLine(isActive: false),
    TimelineStep(
      label: 'Resolution',
      isComplete: false,
      color: AppColors.neutral300,
    ),
  ],
)
```

---

### 4. Blockchain Verification Badge

```dart
// Untuk menandai data yang sudah di-verify di blockchain
Container(
  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  decoration: BoxDecoration(
    gradient: AppColors.blockchainGradient,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: AppColors.blockchain.withValues(alpha: 0.3),
        blurRadius: 8,
        offset: Offset(0, 2),
      ),
    ],
  ),
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.verified_outlined, size: 16, color: Colors.white),
      SizedBox(width: 6),
      Text(
        'Verified on Blockchain',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  ),
)
```

---

## 🌓 Dark Mode Considerations

### Background Hierarchy

**Light Mode**:
- Level 0 (Page background): `#F8FAFC`
- Level 1 (Cards/Surface): `#FFFFFF`
- Level 2 (Elevated elements): `#FFFFFF` + shadow

**Dark Mode**:
- Level 0 (Page background): `#0F172A`
- Level 1 (Cards/Surface): `#1E293B`
- Level 2 (Elevated elements): `#1E293B` + stronger shadow

### Text Hierarchy

**Light Mode**:
- Primary text: `#111827` (near black)
- Secondary text: `#6B7280` (gray)
- Tertiary text: `#9CA3AF` (light gray)

**Dark Mode**:
- Primary text: `#F9FAFB` (off-white)
- Secondary text: `#9CA3AF` (gray)
- Tertiary text: `#6B7280` (dark gray)

---

## 📱 Responsive Design Tips

### Mobile (< 600px)
- Gunakan full-width cards
- Stack elements vertically
- Larger touch targets (min 44x44)

### Tablet (600-1024px)
- 2-column grid untuk case list
- Side-by-side layout untuk detail pages

### Desktop (> 1024px)
- 3-column grid
- Fixed sidebar navigation
- Hover states untuk interactive elements

---

## ♿ Accessibility Checklist

- ✅ Contrast ratio minimal 4.5:1 untuk text
- ✅ Contrast ratio minimal 3:1 untuk UI elements
- ✅ Jangan hanya mengandalkan warna untuk informasi (gunakan icon + text)
- ✅ Support dark mode
- ✅ Touch targets minimal 44x44 pixels
- ✅ Support keyboard navigation
- ✅ Semantic HTML/Widget structure

---

## 🚀 Implementation Priority

### Phase 1: Core Theme
- [x] Color constants
- [x] Theme configuration
- [x] Basic components (buttons, cards, inputs)

### Phase 2: Custom Components
- [ ] Status badges
- [ ] Category tags
- [ ] Blockchain verification badge
- [ ] Timeline/Progress indicator
- [ ] Case cards

### Phase 3: Screens
- [ ] Login/Register
- [ ] Dashboard
- [ ] Case List
- [ ] Case Detail
- [ ] Mediation Room
- [ ] Profile

### Phase 4: Polish
- [ ] Animations & transitions
- [ ] Loading states
- [ ] Empty states
- [ ] Error states
- [ ] Dark mode refinement

---

## 📚 Resources

### Fonts Recommendation
- **Primary**: Inter, SF Pro, Roboto
- **Display**: Poppins (untuk headers)
- **Mono**: JetBrains Mono (untuk blockchain addresses)

### Icons
- Material Icons (built-in Flutter)
- Custom icons untuk blockchain elements

### Animations
- Duration: 200-300ms untuk micro-interactions
- Easing: Curves.easeInOut untuk smooth transitions

---

## 🎯 Brand Values Reflection

| Value | Visual Expression |
|-------|------------------|
| **Trust** | Deep blue primary, solid shadows, consistent spacing |
| **Security** | Blockchain gradients, verification badges, lock icons |
| **Compassion** | Soft rounded corners, calming colors, gentle animations |
| **Innovation** | Modern gradient, teal accents, clean typography |
| **Transparency** | Clear status indicators, visible progress, open communication |

---

## 💡 Do's and Don'ts

### ✅ DO
- Gunakan color constants dari `AppColors`
- Maintain consistency across screens
- Test di light dan dark mode
- Consider accessibility
- Use semantic colors for status
- Add proper spacing (8px grid system)

### ❌ DON'T
- Hardcode color values
- Use too many colors in one screen
- Ignore contrast ratios
- Rely only on color for information
- Use pure black (#000000) or pure white (#FFFFFF)
- Mix different border radius values randomly

---

## 🎨 Quick Reference

```dart
// Import
import 'package:hackathon_smartvow/core/constants/color_constant.dart';
import 'package:hackathon_smartvow/core/theme/app_theme.dart';

// Primary action
AppColors.primary

// Secondary/Blockchain action
AppColors.secondary

// Status
AppColors.success / warning / error / info

// Categories
AppColors.divorce / violence / infidelity / finance / mediation

// Gradients
AppColors.primaryGradient
AppColors.blockchainGradient
AppColors.accentGradient

// Dark mode aware
context.backgroundColor
context.surfaceColor
context.textColor
```

---

Selamat mengembangkan SmartVow! 🚀
