import 'package:flutter/material.dart';
import '../../../core/constants/color_constant.dart';

class SmartPrenupPage extends StatefulWidget {
  const SmartPrenupPage({super.key});

  @override
  State<SmartPrenupPage> createState() => _SmartPrenupPageState();
}

class _SmartPrenupPageState extends State<SmartPrenupPage> {
  int _currentStep = 0;
  final List<String> _selectedCategories = [];
  final List<Map<String, dynamic>> _clauses = [];
  final _partnerBAddressController = TextEditingController();
  String _claimMethod = ''; // 'verifikasi_ai' or 'internal_pasangan'

  @override
  void dispose() {
    _partnerBAddressController.dispose();
    super.dispose();
  }

  void _toggleCategory(String categoryId) {
    setState(() {
      if (_selectedCategories.contains(categoryId)) {
        _selectedCategories.remove(categoryId);
        // Remove clauses for this category
        _clauses.removeWhere((clause) => clause['categoryId'] == categoryId);
      } else {
        _selectedCategories.add(categoryId);
        // Add default clause for this category
        _clauses.add({
          'categoryId': categoryId,
          'distributionMethod': 'all_in',
          'partnerAPercentage': 100.0,
          'partnerBPercentage': 0.0,
        });
      }
    });
  }

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
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                      children: [
                        TextSpan(text: 'Buat Perjanjian '),
                        TextSpan(
                          text: 'Pranikah Digital',
                          style: TextStyle(color: AppColors.primary),
                        ),
                      ],
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
                  if (_currentStep == 1) _buildStepVerifikasi(),
                  if (_currentStep == 2) _buildStepSelesai(),

                  const SizedBox(height: 80), // Space for bottom nav
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _currentStep == 0 && _clauses.isNotEmpty
          ? Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _currentStep = 1;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${_selectedCategories.length} kategori dipilih',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${_clauses.length} Klausul',
                            style: const TextStyle(
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
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : null,
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
              child: isCompleted
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

  // STEP 1: Pilih Kategori & Klausul
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
          'Perlindungan dari terjadinya selingkuh',
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
          'Hak asuh dan tanggung jawab keluarga',
          Icons.family_restroom,
          AppColors.smartContract,
          'anak',
        ),

        const SizedBox(height: 20),

        // Metode Pengajuan Klaim
        if (_selectedCategories.isNotEmpty) ...[
          Row(
            children: [
              const Text(
                'Metode Pengajuan Klaim',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'WAJIB',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Verifikasi AI Card
          InkWell(
            onTap: () {
              setState(() {
                _claimMethod = 'verifikasi_ai';
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _claimMethod == 'verifikasi_ai'
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _claimMethod == 'verifikasi_ai'
                      ? AppColors.primary
                      : AppColors.neutral200,
                  width: _claimMethod == 'verifikasi_ai' ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.auto_awesome,
                      color: AppColors.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Verifikasi AI',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Upload bukti. AI verifikasi otomatis',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_claimMethod == 'verifikasi_ai')
                    const Icon(
                      Icons.check_circle,
                      color: AppColors.primary,
                      size: 24,
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Internal Pasangan Card
          InkWell(
            onTap: () {
              setState(() {
                _claimMethod = 'internal_pasangan';
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _claimMethod == 'internal_pasangan'
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _claimMethod == 'internal_pasangan'
                      ? AppColors.primary
                      : AppColors.neutral200,
                  width: _claimMethod == 'internal_pasangan' ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.info.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.lock_outline,
                      color: AppColors.info,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Internal Pasangan',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Privasi, tanpa pihak ketiga',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_claimMethod == 'internal_pasangan')
                    const Icon(
                      Icons.check_circle,
                      color: AppColors.primary,
                      size: 24,
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Show clause sections for each selected category
          ..._selectedCategories.asMap().entries.map((entry) {
            final index = entry.key;
            final categoryId = entry.value;
            return _buildClauseSection(categoryId, index + 1);
          }),
        ],
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
    final isSelected = _selectedCategories.contains(categoryId);

    return InkWell(
      onTap: () => _toggleCategory(categoryId),
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
                Icons.radio_button_unchecked,
                color: AppColors.neutral400,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildClauseSection(String categoryId, int clauseNumber) {
    final clause = _clauses.firstWhere(
      (c) => c['categoryId'] == categoryId,
      orElse: () => {},
    );

    final categoryInfo = _getCategoryInfo(categoryId);
    final distributionMethod = clause['distributionMethod'] ?? 'all_in';

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Clause Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: categoryInfo['color'].withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  categoryInfo['icon'],
                  color: categoryInfo['color'],
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Klausul #$clauseNumber',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Pembagian Harta ${categoryInfo['title']}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 20),
                onPressed: () => _toggleCategory(categoryId),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),

          const SizedBox(height: 16),

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

          const SizedBox(height: 16),

          // Asset Selection
          const Text(
            'PILIH ASET DARI BRANKAS *',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.neutral200),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.toll,
                    color: AppColors.warning,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'perhiasan emas 50 gram. Kategori: Barang Berharga. - Token #2',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ),
                const Icon(Icons.arrow_drop_down, size: 20),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Distribution Method
          const Text(
            'METODE PEMBAGIAN *',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),

          Row(
            children: [
              Expanded(
                child: _buildMethodCard(
                  'All-in (100%)',
                  '100% ke seorang',
                  distributionMethod == 'all_in',
                  () {
                    setState(() {
                      clause['distributionMethod'] = 'all_in';
                      clause['partnerAPercentage'] = 100.0;
                      clause['partnerBPercentage'] = 0.0;
                    });
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMethodCard(
                  'Custom %',
                  'Atur pembagian',
                  distributionMethod == 'custom',
                  () {
                    setState(() {
                      clause['distributionMethod'] = 'custom';
                      clause['partnerAPercentage'] = 50.0;
                      clause['partnerBPercentage'] = 50.0;
                    });
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Show slider only for custom method
          if (distributionMethod == 'custom')
            _buildPercentageSlider(clause)
          else
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.warning.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: AppColors.success, size: 18),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      '✓ Jika cerai: NFT dijual, 100% ke korban',
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
        ],
      ),
    );
  }

  Map<String, dynamic> _getCategoryInfo(String categoryId) {
    switch (categoryId) {
      case 'perceraian':
        return {
          'title': 'Perceraian',
          'icon': Icons.favorite_border,
          'color': AppColors.divorce,
        };
      case 'perselingkuhan':
        return {
          'title': 'Perselingkuhan',
          'icon': Icons.heart_broken,
          'color': AppColors.infidelity,
        };
      case 'kdrt':
        return {
          'title': 'KDRT',
          'icon': Icons.shield_outlined,
          'color': AppColors.violence,
        };
      case 'keuangan':
        return {
          'title': 'Keuangan',
          'icon': Icons.account_balance_wallet_outlined,
          'color': AppColors.finance,
        };
      case 'aset':
        return {
          'title': 'Aset & Properti',
          'icon': Icons.home_outlined,
          'color': AppColors.blockchain,
        };
      case 'anak':
        return {
          'title': 'Anak & Keluarga',
          'icon': Icons.family_restroom,
          'color': AppColors.smartContract,
        };
      default:
        return {
          'title': 'Unknown',
          'icon': Icons.help_outline,
          'color': AppColors.neutral400,
        };
    }
  }

  Widget _buildMethodCard(
    String title,
    String subtitle,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected
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
      ),
    );
  }

  Widget _buildPercentageSlider(Map<String, dynamic> clause) {
    final partnerAPercentage = clause['partnerAPercentage'] ?? 50.0;
    final partnerBPercentage = clause['partnerBPercentage'] ?? 50.0;

    return Column(
      children: [
        // Slider Labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Partner A: ${partnerAPercentage.toInt()}%',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.info,
              ),
            ),
            Text(
              'Partner B: ${partnerBPercentage.toInt()}%',
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
                  stops: [partnerAPercentage / 100, partnerAPercentage / 100],
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
                value: partnerAPercentage,
                min: 0,
                max: 100,
                divisions: 100,
                onChanged: (value) {
                  setState(() {
                    clause['partnerAPercentage'] = value;
                    clause['partnerBPercentage'] = 100 - value;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  // STEP 2: Verifikasi & Deploy
  Widget _buildStepVerifikasi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Icon
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.verified_user,
            color: AppColors.primary,
            size: 48,
          ),
        ),

        const SizedBox(height: 24),

        const Text(
          'Verifikasi & Deploy',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Tinjau dan konfirmasi perjanjian Anda',
          style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 32),

        // Partner A (You)
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.neutral50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.neutral200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PARTNER A (ANDA)',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textSecondary,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '0x15c4...9e9E',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Partner B Address Input
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ALAMAT PARTNER B',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AppColors.textSecondary,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _partnerBAddressController,
              decoration: InputDecoration(
                hintText: '0x...',
                hintStyle: TextStyle(color: AppColors.textTertiary),
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.neutral200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.neutral200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Agreement Summary
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.neutral200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RINGKASAN PERJANJIAN',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textSecondary,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 16),

              // Clause #1
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(
                      Icons.description,
                      color: AppColors.warning,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Pembagian Harta Perceraian',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'NFT: perhiasan emas 50 gram, Kategori: Barang Berharga, #2  →  Transfer 100%',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      '100%',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.warning,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Warning Boxes
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.warning.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.warning, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Klausul Perceraian\nAset dari brankas akan otomatis dibagi sesuai kesepakatan saat perceraian.',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.error.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.lock_outline, color: AppColors.error, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Klaim Internal Pasangan\nPrivasi antar pasangan',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

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
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('KEMBALI'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: _partnerBAddressController.text.isNotEmpty
                    ? () {
                        setState(() {
                          _currentStep = 2;
                        });
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.rocket_launch, size: 18),
                    SizedBox(width: 8),
                    Text('DEPLOY KE BASE'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // STEP 3: Menunggu Partner B
  Widget _buildStepSelesai() {
    return Column(
      children: [
        const SizedBox(height: 20),

        // Sync Icon Animation
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.warning.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.sync, color: AppColors.warning, size: 60),
        ),

        const SizedBox(height: 24),

        const Text(
          'Menunggu Partner B',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 12),

        Text(
          'Perjanjian sudah dibuat dan Anda sudah menandatangani. Partner B perlu menandatangani sebelum perjanjian aktif.',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 32),

        // Vow ID & Transaction
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.neutral200),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'VOW ID',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const Text(
                    '#2',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TRANSACTION',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const Text(
                    '0xc75612...4f4bff',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Status Section
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.warning.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.warning.withValues(alpha: 0.2)),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Partner A (Anda)',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.check_circle,
                          size: 12,
                          color: AppColors.success,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Sudah Sign',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppColors.success,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.warning,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Partner B',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.pending, size: 12, color: AppColors.warning),
                        SizedBox(width: 4),
                        Text(
                          'Menunggu Sign',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppColors.warning,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.neutral300,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Deposit & Aktivasi',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.neutral100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Setelah kedua sign',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Info message
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.info.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.info, size: 16),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Bagikan Vow ID #2 ke Partner B untuk menandatangani di Dashboard',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.info,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        // Action Buttons
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    _currentStep = 0;
                    _selectedCategories.clear();
                    _clauses.clear();
                    _partnerBAddressController.clear();
                  });
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('BUAT BARU'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to dashboard
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('DASHBOARD'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
