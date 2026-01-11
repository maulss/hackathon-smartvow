import 'package:flutter/material.dart';
import '../../../core/constants/color_constant.dart';

/// Asset Virtualizer Page
/// Halaman untuk mendaftarkan aset bersama sebagai NFT di blockchain
class AssetsVirtualizerPage extends StatefulWidget {
  const AssetsVirtualizerPage({super.key});

  @override
  State<AssetsVirtualizerPage> createState() => _AssetsVirtualizerPageState();
}

class _AssetsVirtualizerPageState extends State<AssetsVirtualizerPage> {
  // Selected category
  String? _selectedCategory;

  // Selected ownership status
  String _selectedOwnership = 'pribadi';

  // Asset description controller
  final TextEditingController _descriptionController = TextEditingController();

  // Categories
  final List<Map<String, dynamic>> _categories = [
    {
      'id': 'properti',
      'name': 'Properti',
      'icon': Icons.home_rounded,
      'color': AppColors.finance,
    },
    {
      'id': 'kendaraan',
      'name': 'Kendaraan',
      'icon': Icons.directions_car_rounded,
      'color': AppColors.secondary,
    },
    {
      'id': 'investasi',
      'name': 'Investasi',
      'icon': Icons.trending_up_rounded,
      'color': AppColors.primary,
    },
    {
      'id': 'barang_berharga',
      'name': 'Barang Berharga',
      'icon': Icons.diamond_rounded,
      'color': AppColors.accent,
    },
  ];

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.backgroundDark : AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Asset Virtualizer',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: isDarkMode ? AppColors.surfaceDark : AppColors.surface,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDarkMode ? AppColors.surfaceDark : AppColors.surface,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowLight,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Daftarkan Aset Bersama',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? AppColors.textOnDark : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Ubah aset fisik Anda menjadi NFT terverifikasi di blockchain',
                    style: TextStyle(
                      fontSize: 14,
                      color: isDarkMode ? AppColors.textSecondary : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            // Warning Box
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.warning.withValues(alpha: 0.1),
                border: Border.all(color: AppColors.warning),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_rounded,
                    color: AppColors.warning,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Wallet Belum Terhubung',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.warning,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Main Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Step 1: Pilih Kategori Aset
                  _buildSectionTitle('Step 1: Pilih Kategori Aset', isDarkMode),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.2,
                    ),
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      final category = _categories[index];
                      final isSelected = _selectedCategory == category['id'];

                      return _buildCategoryCard(
                        category: category,
                        isSelected: isSelected,
                        isDarkMode: isDarkMode,
                        onTap: () {
                          setState(() {
                            _selectedCategory = category['id'];
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 32),

                  // Step 2: Status Kepemilikan
                  _buildSectionTitle('Step 2: Status Kepemilikan', isDarkMode),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildOwnershipOption(
                          title: 'Harta Pribadi',
                          subtitle: 'Aset milik individu',
                          value: 'pribadi',
                          isDarkMode: isDarkMode,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildOwnershipOption(
                          title: 'Harta Bersama',
                          subtitle: 'Aset milik pasangan',
                          value: 'bersama',
                          isDarkMode: isDarkMode,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Step 3: Deskripsikan Aset
                  _buildSectionTitle('Step 3: Deskripsikan Aset', isDarkMode),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: isDarkMode ? AppColors.surfaceDark : AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isDarkMode ? AppColors.neutral600 : AppColors.neutral300,
                      ),
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: _descriptionController,
                          maxLines: 6,
                          decoration: InputDecoration(
                            hintText: 'Masukkan detail aset seperti lokasi, ukuran, nilai, dll...',
                            hintStyle: TextStyle(
                              color: isDarkMode ? AppColors.textSecondary : AppColors.textSecondary,
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(16),
                          ),
                          style: TextStyle(
                            color: isDarkMode ? AppColors.textOnDark : AppColors.textPrimary,
                            fontSize: 14,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: isDarkMode ? AppColors.neutral600 : AppColors.neutral300,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.auto_awesome_rounded,
                                size: 20,
                                color: AppColors.secondary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'AI Generate',
                                style: TextStyle(
                                  color: AppColors.secondary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Spacer(),
                              Icon(
                                Icons.arrow_forward_rounded,
                                size: 20,
                                color: AppColors.secondary,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Preview Card
                  _buildSectionTitle('Preview Sertifikat NFT', isDarkMode),
                  const SizedBox(height: 16),
                  _buildPreviewCard(isDarkMode),

                  const SizedBox(height: 32),

                  // Why Register Section
                  _buildSectionTitle('Mengapa perlu didaftarkan?', isDarkMode),
                  const SizedBox(height: 16),
                  _buildBenefitItem(
                    'Bukti kepemilikan yang tidak dapat dipalsukan',
                    isDarkMode,
                  ),
                  const SizedBox(height: 8),
                  _buildBenefitItem(
                    'Tercatat permanen di blockchain',
                    isDarkMode,
                  ),
                  const SizedBox(height: 8),
                  _buildBenefitItem(
                    'Dapat ditransfer dan diverifikasi kapan saja',
                    isDarkMode,
                  ),
                  const SizedBox(height: 8),
                  _buildBenefitItem(
                    'Melindungi hak Anda dalam perjanjian',
                    isDarkMode,
                  ),

                  const SizedBox(height: 32),

                  // Registration Info
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDarkMode ? AppColors.surfaceDark : AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isDarkMode ? AppColors.neutral600 : AppColors.neutral300,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'BIAYA REGISTRASI:',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isDarkMode ? AppColors.textSecondary : AppColors.textSecondary,
                              ),
                            ),
                            Text(
                              '0.002 ETH',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.secondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'JARINGAN:',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isDarkMode ? AppColors.textSecondary : AppColors.textSecondary,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'Base L2',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Connect Wallet Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Implement wallet connection
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'CONNECT WALLET DULU',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDarkMode) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: isDarkMode ? AppColors.textOnDark : AppColors.textPrimary,
      ),
    );
  }

  Widget _buildCategoryCard({
    required Map<String, dynamic> category,
    required bool isSelected,
    required bool isDarkMode,
    required VoidCallback onTap,
  }) {
    final Color categoryColor = category['color'] as Color;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? categoryColor.withValues(alpha: 0.1)
              : (isDarkMode ? AppColors.surfaceDark : AppColors.surface),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? categoryColor : (isDarkMode ? AppColors.neutral600 : AppColors.neutral300),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: categoryColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                category['icon'] as IconData,
                color: categoryColor,
                size: 28,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              category['name'] as String,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? categoryColor
                    : (isDarkMode ? AppColors.textOnDark : AppColors.textPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOwnershipOption({
    required String title,
    required String subtitle,
    required String value,
    required bool isDarkMode,
  }) {
    final isSelected = _selectedOwnership == value;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedOwnership = value;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : (isDarkMode ? AppColors.surfaceDark : AppColors.surface),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : (isDarkMode ? AppColors.neutral600 : AppColors.neutral300),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                  color: isSelected ? AppColors.primary : (isDarkMode ? AppColors.neutral500 : AppColors.neutral400),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? AppColors.primary
                          : (isDarkMode ? AppColors.textOnDark : AppColors.textPrimary),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 28),
              child: Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: isDarkMode ? AppColors.textSecondary : AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewCard(bool isDarkMode) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.secondary,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'SERTIFIKAT PREVIEW',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Icon(
            Icons.workspace_premium_rounded,
            size: 80,
            color: Colors.white.withValues(alpha: 0.9),
          ),
          const SizedBox(height: 16),
          const Text(
            'NFT Certificate',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _selectedCategory != null
                ? _categories.firstWhere((cat) => cat['id'] == _selectedCategory)['name']
                : 'Pilih kategori aset',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _selectedOwnership == 'pribadi' ? 'Harta Pribadi' : 'Harta Bersama',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(String text, bool isDarkMode) {
    return Row(
      children: [
        Icon(
          Icons.check_circle_rounded,
          color: AppColors.success,
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: isDarkMode ? AppColors.textOnDark : AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
