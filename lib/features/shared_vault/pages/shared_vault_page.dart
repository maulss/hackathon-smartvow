import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_smartvow/features/dashboard/providers/wallet_provider.dart';
import '../../../core/constants/color_constant.dart';

import '../../dashboard/widgets/deposit_dialog.dart';
import '../../dashboard/widgets/transfer_to_shared_dialog.dart';

class SharedVaultPage extends ConsumerStatefulWidget {
  const SharedVaultPage({super.key});

  @override
  ConsumerState<SharedVaultPage> createState() => _SharedVaultPageState();
}

class _SharedVaultPageState extends ConsumerState<SharedVaultPage> {
  int _selectedTab = 0; // 0: Semua, 1: Pribadi, 2: Bersama

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Brankas Digital'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Refresh dashboard data
              ref.invalidate(dashboardDataProvider);
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Text(
                    'Brankas Digital',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Kelola aset pribadi dan bersama dengan aman',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Deposit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => const DepositDialog(),
                        );
                      },
                      icon: const Icon(Icons.add, size: 20),
                      label: const Text('Deposit'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Steps Section
                  _buildStepsSection(),

                  const SizedBox(height: 24),

                  // Vault Cards Grid
                  _buildVaultCardsGrid(),

                  const SizedBox(height: 24),

                  // Inventaris Aset NFT Section
                  _buildInventarisSection(),

                  const SizedBox(height: 80), // Space for bottom nav
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepsSection() {
    return Row(
      children: [
        Expanded(
          child: _buildStepCard(
            'STEP 1',
            'Brankas Pribadi',
            'Deposit dari wallet Anda',
            Icons.account_balance_wallet,
            AppColors.info,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStepCard(
            'STEP 2',
            'Brankas Bersama',
            'Pindahkan untuk harta bersama',
            Icons.folder_shared,
            AppColors.secondary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStepCard(
            'STEP 3',
            'Escrow Perjanjian',
            'Terkunci di smart contract',
            Icons.lock,
            AppColors.warning,
          ),
        ),
      ],
    );
  }

  Widget _buildStepCard(
    String step,
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            step,
            style: TextStyle(
              fontSize: 9,
              color: color,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 10,
              color: AppColors.textSecondary,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVaultCardsGrid() {
    final dashboardAsync = ref.watch(dashboardDataProvider);

    return dashboardAsync.when(
      data: (dashboardData) {
        final personalBalance =
            dashboardData.vaultBalances?.personal ?? BigInt.zero;
        final personalEth = (personalBalance.toDouble() / 1e18).toStringAsFixed(
          4,
        );

        final sharedBalance =
            dashboardData.vaultBalances?.totalShared ?? BigInt.zero;
        final sharedEth = (sharedBalance.toDouble() / 1e18).toStringAsFixed(4);

        final partnerAContribution =
            dashboardData.partnerAContribution ?? BigInt.zero;
        final partnerBContribution =
            dashboardData.partnerBContribution ?? BigInt.zero;
        final partnerAEth = (partnerAContribution.toDouble() / 1e18)
            .toStringAsFixed(4);
        final partnerBEth = (partnerBContribution.toDouble() / 1e18)
            .toStringAsFixed(4);

        final escrowLocked = dashboardData.totalEscrowLocked ?? BigInt.zero;
        final escrowEth = (escrowLocked.toDouble() / 1e18).toStringAsFixed(4);

        return Column(
          children: [
            Row(
              children: [
                // Brankas Pribadi
                Expanded(
                  child: _buildVaultCard(
                    'Brankas Pribadi',
                    personalEth,
                    'ETH',
                    Icons.account_balance_wallet,
                    AppColors.info,
                    [
                      _VaultItem(
                        'Saldo Tersedia',
                        '$personalEth ETH',
                        AppColors.info,
                      ),
                    ],
                    [
                      _VaultAction(
                        'Deposit',
                        Icons.arrow_downward,
                        AppColors.info,
                      ),
                      _VaultAction(
                        'Transfer',
                        Icons.swap_horiz,
                        AppColors.secondary,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Brankas Bersama
                Expanded(
                  child: _buildVaultCard(
                    'Brankas Bersama',
                    sharedEth,
                    'ETH',
                    Icons.folder_shared,
                    AppColors.secondary,
                    [
                      _VaultItem(
                        'Kontribusi A',
                        '$partnerAEth ETH',
                        AppColors.info,
                      ),
                      _VaultItem(
                        'Kontribusi B',
                        '$partnerBEth ETH',
                        AppColors.error,
                      ),
                    ],
                    [],
                    infoMessage:
                        'Dana di sini bisa dipakai jaminan escrow saat buat perjanjian',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Escrow Terkunci (Full Width)
            _buildEscrowCard(sharedEth, escrowEth),
          ],
        );
      },
      loading: () => Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildLoadingCard()),
              const SizedBox(width: 12),
              Expanded(child: _buildLoadingCard()),
            ],
          ),
          const SizedBox(height: 12),
          _buildLoadingCard(),
        ],
      ),
      error: (_, __) => Column(
        children: [
          Row(
            children: [
              // Brankas Pribadi
              Expanded(
                child: _buildVaultCard(
                  'Brankas Pribadi',
                  '0.0000',
                  'ETH',
                  Icons.account_balance_wallet,
                  AppColors.info,
                  [_VaultItem('Saldo Tersedia', '0.0000 ETH', AppColors.info)],
                  [
                    _VaultAction(
                      'Deposit',
                      Icons.arrow_downward,
                      AppColors.info,
                    ),
                    _VaultAction(
                      'Transfer',
                      Icons.swap_horiz,
                      AppColors.secondary,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Brankas Bersama
              Expanded(
                child: _buildVaultCard(
                  'Brankas Bersama',
                  '0.0000',
                  'ETH',
                  Icons.folder_shared,
                  AppColors.secondary,
                  [
                    _VaultItem('Kontribusi A', '0.0000 ETH', AppColors.info),
                    _VaultItem('Kontribusi B', '0.0000 ETH', AppColors.error),
                  ],
                  [],
                  infoMessage:
                      'Dana di sini bisa dipakai jaminan escrow saat buat perjanjian',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildEscrowCard('0.0000', '0.0000'),
        ],
      ),
    );
  }

  Widget _buildVaultCard(
    String title,
    String amount,
    String currency,
    IconData icon,
    Color color,
    List<_VaultItem> items,
    List<_VaultAction> actions, {
    String? infoMessage,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Amount
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                amount,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                currency,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Items
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item.label, style: const TextStyle(fontSize: 11)),
                  Text(
                    item.value,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: item.color,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Info Message
          if (infoMessage != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.warning.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, color: AppColors.warning, size: 14),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      infoMessage,
                      style: TextStyle(
                        fontSize: 9,
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Actions
          if (actions.isNotEmpty) ...[
            const SizedBox(height: 12),
            Row(
              children: actions.map((action) {
                final isFirst = actions.first == action;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: isFirst ? 0 : 6),
                    child: _buildActionButton(
                      action.label,
                      action.icon,
                      action.color,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLoadingCard() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Center(child: CircularProgressIndicator(color: AppColors.primary)),
    );
  }

  Widget _buildEscrowCard([String? sharedEth, String? escrowEth]) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.accentGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.lock, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Escrow Terkunci',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Amount
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                escrowEth ?? '0.0000',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 6),
              const Text(
                'ETH',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Details
          _buildEscrowItem(
            'Total di Brankas Bersama',
            '${sharedEth ?? "0.0000"} ETH',
          ),
          const SizedBox(height: 8),
          _buildEscrowItem(
            'Terkunci di Escrow',
            '${escrowEth ?? "0.0000"} ETH',
          ),
          const SizedBox(height: 8),
          _buildEscrowItem(
            'Sisa (Belum Terkunci)',
            _calculateRemaining(sharedEth, escrowEth),
          ),

          const SizedBox(height: 16),

          // Info Box
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Escrow otomatis terkunci saat perjanjian aktif dan dibuka sesuai ketentuan',
              style: TextStyle(fontSize: 10, color: Colors.white, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEscrowItem(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.white70),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  String _calculateRemaining(String? sharedEth, String? escrowEth) {
    if (sharedEth == null || escrowEth == null) return '0.0000 ETH';

    final shared = double.tryParse(sharedEth) ?? 0.0;
    final escrow = double.tryParse(escrowEth) ?? 0.0;
    final remaining = shared - escrow;

    return '${remaining.toStringAsFixed(4)} ETH';
  }

  Widget _buildActionButton(String label, IconData icon, Color color) {
    return InkWell(
      onTap: () {
        if (label == 'Deposit') {
          showDialog(context: context, builder: (_) => const DepositDialog());
        } else if (label == 'Transfer') {
          showDialog(
            context: context,
            builder: (_) => const TransferToSharedDialog(),
          );
        }
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 14),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInventarisSection() {
    final dashboardAsync = ref.watch(dashboardDataProvider);

    return dashboardAsync.when(
      data: (dashboardData) {
        final nftCount = dashboardData.assetNFTCount;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.grid_view,
                        color: AppColors.secondary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Inventaris Aset NFT',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '$nftCount aset terdaftar di blockchain',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.refresh, size: 20),
                  onPressed: () {
                    ref.invalidate(dashboardDataProvider);
                  },
                  color: AppColors.textSecondary,
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Tabs
            Row(
              children: [
                _buildTab('Semua ($nftCount)', 0),
                const SizedBox(width: 8),
                _buildTab('Pribadi (0)', 1),
                const SizedBox(width: 8),
                _buildTab('Bersama ($nftCount)', 2),
              ],
            ),
            const SizedBox(height: 20),
            // Content based on NFT count
            nftCount > 0 ? _buildNFTGrid() : _buildEmptyState(),
          ],
        );
      },
      loading: () => _buildInventarisLoading(),
      error: (_, __) => _buildInventarisError(),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.neutral100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.image_outlined,
              size: 48,
              color: AppColors.neutral400,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Belum ada aset NFT terdaftar',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add, size: 18),
            label: const Text('Daftarkan Aset Baru'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNFTGrid() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: const Center(child: Text('NFT Grid akan ditampilkan di sini')),
    );
  }

  Widget _buildInventarisLoading() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Center(child: CircularProgressIndicator(color: AppColors.primary)),
    );
  }

  Widget _buildInventarisError() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Column(
        children: [
          Icon(Icons.error_outline, size: 48, color: AppColors.error),
          const SizedBox(height: 16),
          Text(
            'Gagal memuat data NFT',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String label, int index) {
    final isSelected = _selectedTab == index;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedTab = index;
        });
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.neutral300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

// Helper classes
class _VaultItem {
  final String label;
  final String value;
  final Color color;

  _VaultItem(this.label, this.value, this.color);
}

class _VaultAction {
  final String label;
  final IconData icon;
  final Color color;

  _VaultAction(this.label, this.icon, this.color);
}
