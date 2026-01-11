import 'package:flutter/material.dart';
import '../../../core/constants/color_constant.dart';

class SmartPrenupPage extends StatefulWidget {
  const SmartPrenupPage({super.key});

  @override
  State<SmartPrenupPage> createState() => _SmartPrenupPageState();
}

class _SmartPrenupPageState extends State<SmartPrenupPage> {
  int _currentStep = 0;
  String _selectedCategory = '';
  double _partnerAPercentage = 50.0;
  double _partnerBPercentage = 50.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Smart Prenup'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.auto_awesome, size: 14, color: Colors.white),
                SizedBox(width: 6),
                Text(
                  'Smart Prenup Generator',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  const Text(
                    'Buat Perjanjian Pranikah Digital',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Lindungi komitmen Anda dengan smart contract di blockchain Base',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Progress Steps
                  _buildProgressSteps(),

                  const SizedBox(height: 32),

                  // Step Content
                  if (_currentStep == 0) _buildStepKategori(),
                  if (_currentStep == 1) _buildStepKlausul(),
                  if (_currentStep == 2) _buildStepVerifikasi(),
                  if (_currentStep == 3) _buildStepSelesai(),

                  const SizedBox(height: 80), // Space for bottom nav
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSteps() {
    return Row(
      children: [
        _buildStepIndicator(1, 'Susun Klausul', _currentStep >= 0),
        _buildStepConnector(_currentStep >= 1),
        _buildStepIndicator(2, 'Verifikasi', _currentStep >= 1),
        _buildStepConnector(_currentStep >= 2),
        _buildStepIndicator(3, 'Selesai', _currentStep >= 2),
      ],
    );
  }

  Widget _buildStepIndicator(int step, String label, bool isActive) {
    final isCompleted = _currentStep > step - 1;
    final isCurrent = _currentStep == step - 1;

    return Expanded(
      child: Column(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isActive ? AppColors.primary : AppColors.neutral200,
              shape: BoxShape.circle,
              border: Border.all(
                color: isCurrent ? AppColors.primary : Colors.transparent,
                width: 2,
              ),
            ),
            child: Center(
              child:
                  isCompleted
                      ? const Icon(Icons.check, color: Colors.white, size: 18)
                      : Text(
                        '$step',
                        style: TextStyle(
                          color: isActive ? Colors.white : AppColors.neutral500,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isActive ? AppColors.primary : AppColors.textTertiary,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStepConnector(bool isActive) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 30),
        color: isActive ? AppColors.primary : AppColors.neutral200,
      ),
    );
  }

  // STEP 1: Pilih Kategori
  Widget _buildStepKategori() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pilih Kategori Perjanjian',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Klik untuk menambahkan klausul',
          style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 20),

        // Category Cards
        _buildCategoryCard(
          'Perceraian',
          'Pembagian harta jika terjadi perceraian',
          Icons.favorite_border,
          AppColors.divorce,
          'perceraian',
        ),
        const SizedBox(height: 12),
        _buildCategoryCard(
          'Perselingkuhan',
          'Kompensasi dan perselingkuhan',
          Icons.heart_broken,
          AppColors.infidelity,
          'perselingkuhan',
        ),
        const SizedBox(height: 12),
        _buildCategoryCard(
          'Kekerasan (KDRT)',
          'Perlindungan dari kekerasan rumah tangga',
          Icons.shield_outlined,
          AppColors.violence,
          'kdrt',
        ),
        const SizedBox(height: 12),
        _buildCategoryCard(
          'Keuangan',
          'Transparansi pengelolaan keuangan',
          Icons.account_balance_wallet_outlined,
          AppColors.finance,
          'keuangan',
        ),
        const SizedBox(height: 12),
        _buildCategoryCard(
          'Aset & Properti',
          'Pembagian dan perlindungan aset',
          Icons.home_outlined,
          AppColors.blockchain,
          'aset',
        ),
        const SizedBox(height: 12),
        _buildCategoryCard(
          'Anak & Keluarga',
          'Hak anak dan tanggung jawab keluarga',
          Icons.family_restroom,
          AppColors.smartContract,
          'anak',
        ),

        const SizedBox(height: 24),

        // Next Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed:
                _selectedCategory.isNotEmpty
                    ? () {
                      setState(() {
                        _currentStep = 1;
                      });
                    }
                    : null,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Lanjut ke Klausul'),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(
    String title,
    String description,
    IconData icon,
    Color color,
    String categoryId,
  ) {
    final isSelected = _selectedCategory == categoryId;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedCategory = categoryId;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.1) : AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : AppColors.neutral200,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? color : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: color, size: 24)
            else
              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.neutral400,
                size: 16,
              ),
          ],
        ),
      ),
    );
  }

  // STEP 2: Klausul Detail (Pembagian Harta)
  Widget _buildStepKlausul() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.warning.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.description,
                color: AppColors.warning,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Klausul #1',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Pembagian Harta Perceraian',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Info Box
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.info.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.info.withValues(alpha: 0.3)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, color: AppColors.info, size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Jika terjadi perceraian tanpa pelanggaran perjanjian, harta bersama akan dibagi sesuai kesepakatan.',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Asset Selection
        const Text(
          'PILIH ASET DARI BRANKAS *',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.neutral200),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.account_balance_wallet,
                  color: AppColors.warning,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Saldo ETH di Brankas',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
              const Icon(Icons.arrow_drop_down, size: 24),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Distribution Method
        const Text(
          'METODE PEMBAGIAN *',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 12),

        Row(
          children: [
            Expanded(
              child: _buildMethodCard('All-In (100%)', '100% ke seokor', false),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMethodCard('Custom %', 'Bagi pembagian', true),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Custom Percentage Slider
        _buildPercentageSlider(),

        const SizedBox(height: 24),

        // Warning Box
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.warning.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.check_circle, color: AppColors.success, size: 18),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Jika cerai Dibagi 50% : 50%',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.warning,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Action Buttons
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    _currentStep = 0;
                  });
                },
                child: const Text('Kembali'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _currentStep = 2;
                  });
                },
                child: const Text('Lanjut ke Verifikasi'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMethodCard(String title, String subtitle, bool isSelected) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:
            isSelected
                ? AppColors.warning.withValues(alpha: 0.1)
                : AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? AppColors.warning : AppColors.neutral200,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isSelected ? AppColors.warning : AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildPercentageSlider() {
    return Column(
      children: [
        // Slider Labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Partner A: ${_partnerAPercentage.toInt()}%',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.info,
              ),
            ),
            Text(
              'Partner B: ${_partnerBPercentage.toInt()}%',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.error,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Custom Slider
        Stack(
          children: [
            // Background Track
            Container(
              height: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                gradient: LinearGradient(
                  colors: [AppColors.info, AppColors.error],
                  stops: [_partnerAPercentage / 100, _partnerAPercentage / 100],
                ),
              ),
            ),
            // Slider
            SliderTheme(
              data: SliderThemeData(
                trackHeight: 8,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
                activeTrackColor: Colors.transparent,
                inactiveTrackColor: Colors.transparent,
              ),
              child: Slider(
                value: _partnerAPercentage,
                min: 0,
                max: 100,
                divisions: 100,
                onChanged: (value) {
                  setState(() {
                    _partnerAPercentage = value;
                    _partnerBPercentage = 100 - value;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  // STEP 3: Verifikasi
  Widget _buildStepVerifikasi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Verifikasi Perjanjian',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Review detail perjanjian sebelum ditandatangani',
          style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 24),

        // Summary Card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ringkasan Perjanjian',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildSummaryItem('Kategori', 'Perceraian'),
              _buildSummaryItem('Klausul', 'Pembagian Harta'),
              _buildSummaryItem('Aset', 'Saldo ETH di Brankas'),
              _buildSummaryItem('Pembagian', '50% : 50%'),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Action Buttons
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    _currentStep = 1;
                  });
                },
                child: const Text('Kembali'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _currentStep = 3;
                  });
                },
                child: const Text('Konfirmasi'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // STEP 4: Selesai
  Widget _buildStepSelesai() {
    return Column(
      children: [
        const SizedBox(height: 40),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.success.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check_circle,
            color: AppColors.success,
            size: 80,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Perjanjian Berhasil Dibuat!',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          'Perjanjian Anda telah tersimpan di blockchain dan menunggu tanda tangan partner',
          style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),

        // Bottom Section with 1 Klausul Button
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1 kategori dipilih',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '1 Klausul',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.arrow_forward, color: Colors.white),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _currentStep = 0;
                _selectedCategory = '';
              });
            },
            child: const Text('Buat Perjanjian Baru'),
          ),
        ),
      ],
    );
  }
}
