import 'package:flutter/material.dart';
import '../constants/color_constant.dart';

/// Widget untuk menampilkan showcase color palette SmartVow
/// Berguna untuk development dan design reference
class ColorShowcase extends StatelessWidget {
  const ColorShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SmartVow Color Palette'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            'Primary Colors',
            'Warna utama untuk branding dan elemen penting',
            [
              _ColorItem('Primary', AppColors.primary),
              _ColorItem('Primary Light', AppColors.primaryLight),
              _ColorItem('Primary Dark', AppColors.primaryDark),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            'Secondary Colors',
            'Warna sekunder untuk aksen blockchain dan teknologi',
            [
              _ColorItem('Secondary', AppColors.secondary),
              _ColorItem('Secondary Light', AppColors.secondaryLight),
              _ColorItem('Secondary Dark', AppColors.secondaryDark),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            'Accent Colors',
            'Warna aksen untuk highlights dan badge premium',
            [
              _ColorItem('Accent', AppColors.accent),
              _ColorItem('Accent Light', AppColors.accentLight),
              _ColorItem('Accent Dark', AppColors.accentDark),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            'Semantic Colors',
            'Warna untuk status dan feedback',
            [
              _ColorItem('Success', AppColors.success),
              _ColorItem('Warning', AppColors.warning),
              _ColorItem('Error', AppColors.error),
              _ColorItem('Info', AppColors.info),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            'Category Colors',
            'Warna untuk berbagai kategori kasus',
            [
              _ColorItem('Perceraian', AppColors.divorce),
              _ColorItem('Kekerasan', AppColors.violence),
              _ColorItem('Perselingkuhan', AppColors.infidelity),
              _ColorItem('Keuangan', AppColors.finance),
              _ColorItem('Mediasi', AppColors.mediation),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            'Blockchain Colors',
            'Warna khusus untuk elemen blockchain',
            [
              _ColorItem('Blockchain', AppColors.blockchain),
              _ColorItem('Smart Contract', AppColors.smartContract),
              _ColorItem('Verified', AppColors.verified),
              _ColorItem('Pending', AppColors.pending),
            ],
          ),
          const SizedBox(height: 24),
          _buildGradientSection(),
          const SizedBox(height: 24),
          _buildComponentExamples(),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String description, List<_ColorItem> colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: colors,
        ),
      ],
    );
  }

  Widget _buildGradientSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gradients',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Gradient untuk elemen blockchain dan premium',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 12),
        _GradientBox('Primary Gradient', AppColors.primaryGradient),
        const SizedBox(height: 8),
        _GradientBox('Blockchain Gradient', AppColors.blockchainGradient),
        const SizedBox(height: 8),
        _GradientBox('Accent Gradient', AppColors.accentGradient),
      ],
    );
  }

  Widget _buildComponentExamples() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Component Examples',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),

        // Status Badges
        const Text('Status Badges:', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _StatusBadge('Disetujui', AppColors.success),
            _StatusBadge('Menunggu', AppColors.warning),
            _StatusBadge('Ditolak', AppColors.error),
            _StatusBadge('Informasi', AppColors.info),
          ],
        ),
        const SizedBox(height: 16),

        // Category Tags
        const Text('Category Tags:', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _CategoryTag('Perceraian', AppColors.divorce),
            _CategoryTag('Kekerasan', AppColors.violence),
            _CategoryTag('Perselingkuhan', AppColors.infidelity),
            _CategoryTag('Keuangan', AppColors.finance),
            _CategoryTag('Mediasi', AppColors.mediation),
          ],
        ),
        const SizedBox(height: 16),

        // Blockchain Badge
        const Text('Blockchain Badge:', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            gradient: AppColors.blockchainGradient,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.verified_outlined, size: 18, color: Colors.white),
              SizedBox(width: 6),
              Text(
                'Verified on Blockchain',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ColorItem extends StatelessWidget {
  final String name;
  final Color color;

  const _ColorItem(this.name, this.color);

  @override
  Widget build(BuildContext context) {
    final bool isDark = _isColorDark(color);
    final String hexColor = '#${color.toARGB32().toRadixString(16).substring(2).toUpperCase()}';

    return Container(
      width: 140,
      height: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              name,
              style: TextStyle(
                color: isDark ? Colors.white : AppColors.textPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              hexColor,
              style: TextStyle(
                color: isDark ? Colors.white70 : AppColors.textSecondary,
                fontSize: 10,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isColorDark(Color color) {
    final luminance = color.computeLuminance();
    return luminance < 0.5;
  }
}

class _GradientBox extends StatelessWidget {
  final String name;
  final LinearGradient gradient;

  const _GradientBox(this.name, this.gradient);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusBadge(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: color, width: 1.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _CategoryTag extends StatelessWidget {
  final String label;
  final Color color;

  const _CategoryTag(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
