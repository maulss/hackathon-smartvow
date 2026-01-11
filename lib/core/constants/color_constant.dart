import 'package:flutter/material.dart';

/// Color Palette untuk SmartVow - DAPP Penengah Pernikahan
/// Theme: Profesional, Terpercaya, dan Modern dengan sentuhan Blockchain
class AppColors {
  // ========== PRIMARY COLORS ==========
  // Biru gelap yang memancarkan kepercayaan, profesionalitas, dan keamanan
  static const Color primary = Color(0xFF1E3A5F); // Deep Blue
  static const Color primaryLight = Color(0xFF2C5282); // Lighter Blue
  static const Color primaryDark = Color(0xFF0F2340); // Darker Blue

  // ========== SECONDARY COLORS ==========
  // Teal/Cyan yang melambangkan teknologi blockchain dan inovasi
  static const Color secondary = Color(0xFF14B8A6); // Teal
  static const Color secondaryLight = Color(0xFF2DD4BF); // Light Teal
  static const Color secondaryDark = Color(0xFF0D9488); // Dark Teal

  // ========== ACCENT COLORS ==========
  // Emas untuk blockchain/crypto feel dan kemewahan
  static const Color accent = Color(0xFFF59E0B); // Amber Gold
  static const Color accentLight = Color(0xFFFBBF24); // Light Gold
  static const Color accentDark = Color(0xFFD97706); // Dark Gold

  // ========== BACKGROUND COLORS ==========
  static const Color background = Color(0xFFF8FAFC); // Very Light Blue Gray
  static const Color backgroundDark = Color(0xFF0F172A); // Dark Blue Gray (Dark Mode)
  static const Color surface = Color(0xFFFFFFFF); // White
  static const Color surfaceDark = Color(0xFF1E293B); // Dark Surface

  // ========== NEUTRAL COLORS ==========
  static const Color neutral50 = Color(0xFFF9FAFB);
  static const Color neutral100 = Color(0xFFF3F4F6);
  static const Color neutral200 = Color(0xFFE5E7EB);
  static const Color neutral300 = Color(0xFFD1D5DB);
  static const Color neutral400 = Color(0xFF9CA3AF);
  static const Color neutral500 = Color(0xFF6B7280);
  static const Color neutral600 = Color(0xFF4B5563);
  static const Color neutral700 = Color(0xFF374151);
  static const Color neutral800 = Color(0xFF1F2937);
  static const Color neutral900 = Color(0xFF111827);

  // ========== SEMANTIC COLORS ==========
  // Untuk status dan feedback
  static const Color success = Color(0xFF10B981); // Green - untuk keputusan positif
  static const Color successLight = Color(0xFF34D399);
  static const Color successDark = Color(0xFF059669);

  static const Color warning = Color(0xFFF59E0B); // Amber - untuk peringatan
  static const Color warningLight = Color(0xFFFBBF24);
  static const Color warningDark = Color(0xFFD97706);

  static const Color error = Color(0xFFEF4444); // Red - untuk masalah serius
  static const Color errorLight = Color(0xFFF87171);
  static const Color errorDark = Color(0xFFDC2626);

  static const Color info = Color(0xFF3B82F6); // Blue - untuk informasi
  static const Color infoLight = Color(0xFF60A5FA);
  static const Color infoDark = Color(0xFF2563EB);

  // ========== SPECIALIZED COLORS ==========
  // Untuk kategori masalah yang berbeda
  static const Color divorce = Color(0xFF8B5CF6); // Purple - Perceraian
  static const Color violence = Color(0xFFDC2626); // Red - Kekerasan
  static const Color infidelity = Color(0xFFEC4899); // Pink - Perselingkuhan
  static const Color finance = Color(0xFF10B981); // Green - Keuangan
  static const Color mediation = Color(0xFF14B8A6); // Teal - Mediasi

  // ========== TEXT COLORS ==========
  static const Color textPrimary = Color(0xFF111827); // Dark Gray
  static const Color textSecondary = Color(0xFF6B7280); // Medium Gray
  static const Color textTertiary = Color(0xFF9CA3AF); // Light Gray
  static const Color textOnPrimary = Color(0xFFFFFFFF); // White
  static const Color textOnSecondary = Color(0xFFFFFFFF); // White
  static const Color textOnDark = Color(0xFFF9FAFB); // Light

  // ========== BLOCKCHAIN SPECIFIC ==========
  // Warna khusus untuk elemen blockchain
  static const Color blockchain = Color(0xFF0EA5E9); // Sky Blue
  static const Color blockchainGradientStart = Color(0xFF0EA5E9);
  static const Color blockchainGradientEnd = Color(0xFF14B8A6);

  static const Color smartContract = Color(0xFF8B5CF6); // Purple
  static const Color verified = Color(0xFF10B981); // Green
  static const Color pending = Color(0xFFF59E0B); // Amber

  // ========== GRADIENTS ==========
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient blockchainGradient = LinearGradient(
    colors: [blockchainGradientStart, blockchainGradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [accent, accentLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ========== SHADOWS ==========
  static const Color shadowLight = Color(0x0F000000); // 6% opacity
  static const Color shadowMedium = Color(0x1A000000); // 10% opacity
  static const Color shadowDark = Color(0x33000000); // 20% opacity

  // ========== OVERLAYS ==========
  static const Color overlayLight = Color(0x0A000000); // 4% opacity
  static const Color overlayMedium = Color(0x14000000); // 8% opacity
  static const Color overlayDark = Color(0x29000000); // 16% opacity
  static const Color overlayHeavy = Color(0x52000000); // 32% opacity
}

/// Extension untuk memudahkan akses warna berdasarkan brightness
extension AppColorsExtension on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  Color get backgroundColor => isDarkMode ? AppColors.backgroundDark : AppColors.background;
  Color get surfaceColor => isDarkMode ? AppColors.surfaceDark : AppColors.surface;
  Color get textColor => isDarkMode ? AppColors.textOnDark : AppColors.textPrimary;
}
