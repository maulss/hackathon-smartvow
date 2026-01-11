import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;
import '../../../core/constants/color_constant.dart';
import '../providers/wallet_provider.dart';
import '../models/wallet_model.dart';
import '../models/partner_profile_model.dart';
import '../../../core/widgets/shimmer_loading.dart';
import '../widgets/connect_wallet_dialog.dart';
import '../widgets/deposit_dialog.dart';
import '../widgets/withdraw_dialog.dart';
import '../widgets/transfer_to_shared_dialog.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch wallet state
    final walletState = ref.watch(walletProvider);
    final dashboardAsync = ref.watch(dashboardDataProvider);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Custom App Bar dengan Balance
          SliverAppBar(
            expandedHeight: 180,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(gradient: AppColors.primaryGradient),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Dashboard SmartVow',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    walletState.when(
                                      initial: () =>
                                          'Silakan hubungkan wallet Anda',
                                      connecting: () =>
                                          'Menghubungkan wallet...',
                                      connected: (wallet) =>
                                          '${wallet.address.substring(0, 6)}...${wallet.address.substring(wallet.address.length - 4)}',
                                      disconnected: () => 'Wallet terputus',
                                      error: (_) => 'Error koneksi wallet',
                                    ),
                                    style: TextStyle(
                                      color: Colors.white.withValues(
                                        alpha: 0.8,
                                      ),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                // Connect/Disconnect Wallet Button
                                walletState.when(
                                  initial: () =>
                                      _buildAppBarConnectButton(context),
                                  connecting: () => const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  ),
                                  connected: (_) => IconButton(
                                    icon: const Icon(
                                      Icons.logout,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      ref
                                          .read(walletProvider.notifier)
                                          .disconnectWallet();
                                    },
                                    tooltip: 'Disconnect Wallet',
                                  ),
                                  disconnected: () =>
                                      _buildAppBarConnectButton(context),
                                  error: (_) =>
                                      _buildAppBarConnectButton(context),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.refresh,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    // Refresh dashboard data
                                    ref.invalidate(dashboardDataProvider);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        // Balance Display
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: const BoxDecoration(
                                      color: AppColors.success,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Text(
                                    'LIVE',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            const Text(
                              'BRANKAS PRIBADI',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Display personal vault balance from dashboard data
                        dashboardAsync.when(
                          data: (dashboardData) {
                            final personalBalance =
                                dashboardData.vaultBalances?.personal ??
                                BigInt.zero;
                            final ethBalance =
                                personalBalance.toDouble() / 1e18;
                            return Row(
                              children: [
                                Text(
                                  ethBalance.toStringAsFixed(5),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'ETH',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            );
                          },
                          loading: () => const Row(
                            children: [
                              Text(
                                '...',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'ETH',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          error: (_, __) => const Row(
                            children: [
                              Text(
                                '0.00000',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'ETH',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              // Action buttons akan muncul di sini saat collapsed
            ],
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Action Buttons Row
                  Row(
                    children: [
                      Expanded(
                        child: _buildActionButton(
                          'Buat Perjanjian Baru',
                          Icons.add,
                          AppColors.primary,
                          () {},
                        ),
                      ),
                      const SizedBox(width: 12),
                      _buildIconButton(
                        Icons.file_download_outlined,
                        AppColors.error,
                        () {
                          showDialog(
                            context: context,
                            builder: (_) => const WithdrawDialog(),
                          );
                        },
                      ),
                      const SizedBox(width: 8),
                      _buildIconButton(
                        Icons.file_upload_outlined,
                        AppColors.success,
                        () {
                          showDialog(
                            context: context,
                            builder: (_) => const DepositDialog(),
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Stats Cards Row - Use real data from dashboard
                  dashboardAsync.when(
                    data: (dashboardData) {
                      final sharedBalance =
                          dashboardData.vaultBalances?.totalShared ??
                          BigInt.zero;
                      final sharedEth = (sharedBalance.toDouble() / 1e18)
                          .toStringAsFixed(5);

                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _buildStatsCard(
                                  'PERJANJIAN AKTIF',
                                  '${dashboardData.activeAgreements}',
                                  Icons.check_circle_outline,
                                  AppColors.success,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildStatsCardWithAction(
                                  'BRANKAS BERSAMA',
                                  '$sharedEth ETH',
                                  Icons.folder_outlined,
                                  AppColors.info,
                                  () {
                                    _showTransferToSharedDialog(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: _buildStatsCard(
                                  'ASSET NFT',
                                  '${dashboardData.assetNFTCount}',
                                  Icons.image_outlined,
                                  AppColors.secondary,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildStatsCard(
                                  'ESCROW TERKUNCI',
                                  '${((dashboardData.totalEscrowLocked ?? BigInt.zero).toDouble() / 1e18).toStringAsFixed(5)} ETH',
                                  Icons.lock_outline,
                                  AppColors.warning,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                    loading: () => Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: ShimmerLoading(
                                width: double.infinity,
                                height: 100,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ShimmerLoading(
                                width: double.infinity,
                                height: 100,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: ShimmerLoading(
                                width: double.infinity,
                                height: 100,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ShimmerLoading(
                                width: double.infinity,
                                height: 100,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    error: (_, __) => Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _buildStatsCard(
                                'PERJANJIAN AKTIF',
                                '0',
                                Icons.check_circle_outline,
                                AppColors.success,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildStatsCard(
                                'BRANKAS BERSAMA',
                                '0.00000 ETH',
                                Icons.folder_outlined,
                                AppColors.info,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _buildStatsCard(
                                'ASSET NFT',
                                '0',
                                Icons.image_outlined,
                                AppColors.secondary,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildStatsCard(
                                'ESCROW TERKUNCI',
                                '0.00000 ETH',
                                Icons.lock_outline,
                                AppColors.warning,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Profile Pasangan Section
                  _buildSectionTitle('Profile Pasangan', 'CERT'),
                  const SizedBox(height: 12),
                  _buildProfilePasanganCard(),

                  const SizedBox(height: 24),

                  // Pertumbuhan Shared Vault - Use real data
                  _buildSectionTitle('Pertumbuhan Shared Vault', null),
                  const SizedBox(height: 8),
                  Text(
                    'Aset dikonci dalam escrow',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  dashboardAsync.when(
                    data: (dashboardData) {
                      final sharedBalance =
                          dashboardData.vaultBalances?.totalShared ??
                          BigInt.zero;
                      final sharedEth = (sharedBalance.toDouble() / 1e18)
                          .toStringAsFixed(5);
                      return _buildSharedVaultGrowthCard(sharedEth);
                    },
                    loading: () => const ShimmerLoading(
                      width: double.infinity,
                      height: 200,
                    ),
                    error: (_, __) => _buildSharedVaultGrowthCard('0.00000'),
                  ),

                  const SizedBox(height: 24),

                  // Distribusi Harta - Use real data
                  Consumer(
                    builder: (context, ref, child) {
                      return Row(
                        children: [
                          Text(
                            'Distribusi Harta (ETH)',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.refresh, size: 20),
                            onPressed: () {
                              // Refresh dashboard data
                              ref.invalidate(dashboardDataProvider);
                            },
                            color: AppColors.textSecondary,
                            tooltip: 'Refresh data distribusi',
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  dashboardAsync.when(
                    data: (dashboardData) {
                      final sharedBalance =
                          dashboardData.vaultBalances?.totalShared ??
                          BigInt.zero;
                      final sharedEth = (sharedBalance.toDouble() / 1e18)
                          .toStringAsFixed(4);
                      final partnerAContribution =
                          dashboardData.partnerAContribution ?? BigInt.zero;
                      final partnerBContribution =
                          dashboardData.partnerBContribution ?? BigInt.zero;
                      final partnerAEth =
                          (partnerAContribution.toDouble() / 1e18)
                              .toStringAsFixed(4);
                      final partnerBEth =
                          (partnerBContribution.toDouble() / 1e18)
                              .toStringAsFixed(4);

                      // Calculate percentages
                      final totalContributions =
                          partnerAContribution + partnerBContribution;
                      final partnerAPercentage =
                          totalContributions > BigInt.zero
                          ? (partnerAContribution.toDouble() /
                                totalContributions.toDouble() *
                                100)
                          : 50.0;
                      final partnerBPercentage =
                          totalContributions > BigInt.zero
                          ? (partnerBContribution.toDouble() /
                                totalContributions.toDouble() *
                                100)
                          : 50.0;

                      return _buildDistribusiHartaCard(
                        totalShared: sharedEth,
                        partnerAAmount: partnerAEth,
                        partnerBAmount: partnerBEth,
                        partnerAPercentage: partnerAPercentage,
                        partnerBPercentage: partnerBPercentage,
                      );
                    },
                    loading: () => const ShimmerLoading(
                      width: double.infinity,
                      height: 400,
                    ),
                    error: (_, __) => _buildDistribusiHartaCard(
                      totalShared: '0.0000',
                      partnerAAmount: '0.0000',
                      partnerBAmount: '0.0000',
                      partnerAPercentage: 50.0,
                      partnerBPercentage: 50.0,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Semua Perjanjian - Use real data
                  dashboardAsync.when(
                    data: (dashboardData) => _buildSectionTitle(
                      'Semua Perjanjian',
                      '${dashboardData.totalAgreements} total',
                    ),
                    loading: () =>
                        _buildSectionTitle('Semua Perjanjian', '... total'),
                    error: (_, __) =>
                        _buildSectionTitle('Semua Perjanjian', '0 total'),
                  ),
                  const SizedBox(height: 12),
                  dashboardAsync.when(
                    data: (dashboardData) {
                      // Show ALL vows, not just active ones
                      final allVows = ref.watch(userVowsProvider);

                      return allVows.when(
                        data: (vows) {
                          if (vows.isEmpty) {
                            return _buildEmptyPerjanjianCard();
                          }
                          // Build list of ALL vows (including drafts)
                          return Column(
                            children: vows.map((vow) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: _buildVowCard(vow),
                              );
                            }).toList(),
                          );
                        },
                        loading: () => const ShimmerLoading(
                          width: double.infinity,
                          height: 150,
                        ),
                        error: (_, __) => _buildEmptyPerjanjianCard(),
                      );
                    },
                    loading: () => const ShimmerLoading(
                      width: double.infinity,
                      height: 150,
                    ),
                    error: (_, __) => _buildEmptyPerjanjianCard(),
                  ),

                  const SizedBox(height: 24),

                  // Aksi Cepat
                  _buildAksiCepatCard(),

                  const SizedBox(height: 80), // Space for bottom nav
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, Color color, VoidCallback onTap) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: IconButton(
        icon: Icon(icon, color: color, size: 20),
        onPressed: onTap,
      ),
    );
  }

  Widget _buildStatsCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(Icons.trending_up, color: color, size: 12),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCardWithAction(
    String label,
    String value,
    IconData icon,
    Color color,
    VoidCallback? onActionTap,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const Spacer(),
              if (onActionTap != null)
                GestureDetector(
                  onTap: onActionTap,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(Icons.add, color: color, size: 16),
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(Icons.trending_up, color: color, size: 12),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, String? badge) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        if (badge != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.info.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              badge,
              style: const TextStyle(
                fontSize: 10,
                color: AppColors.info,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildProfilePasanganCard() {
    return Consumer(
      builder: (context, ref, child) {
        final walletState = ref.watch(walletProvider);
        final dashboardAsync = ref.watch(dashboardDataProvider);

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.neutral200),
          ),
          child: Column(
            children: [
              // Info Message
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.warning.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppColors.warning,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Profile ini otomatis terciutasi dari Marriage Certificate NFT dan perjanjian. Nama diambil dari sertifikat pernikahan yang sudah di-mint di blockchain.',
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
              const SizedBox(height: 16),
              dashboardAsync.when(
                data: (dashboardData) {
                  final myAddress = walletState.maybeWhen(
                    connected: (wallet) => wallet.address.toLowerCase(),
                    orElse: () => '',
                  );
                  final myShortAddress = myAddress.length > 10
                      ? '${myAddress.substring(0, 6)}...${myAddress.substring(myAddress.length - 4)}'
                      : myAddress;

                  // Check if vow exists (partnerA not null)
                  final hasVow = dashboardData.partnerA != null;

                  if (!hasVow) {
                    // No vow yet - show connected wallet as "You"
                    return Row(
                      children: [
                        Expanded(
                          child: _buildPartnerProfileCard(
                            name: myShortAddress.isNotEmpty
                                ? '$myShortAddress (You)'
                                : 'You',
                            address: myAddress,
                            status: myAddress.isNotEmpty
                                ? 'CONNECTED'
                                : 'NOT CONNECTED',
                            isCertified: false,
                            isYou: true,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildPartnerProfileCard(
                            name: 'Partner',
                            address: '',
                            status: 'BELUM ADA VOW',
                            isCertified: false,
                            isYou: false,
                          ),
                        ),
                      ],
                    );
                  }

                  // Has vow - determine which partner is "You"
                  final isPartnerA =
                      dashboardData.partnerA!.address.toLowerCase() ==
                      myAddress;
                  final youPartner = isPartnerA
                      ? dashboardData.partnerA!
                      : dashboardData.partnerB!;
                  final otherPartner = isPartnerA
                      ? dashboardData.partnerB!
                      : dashboardData.partnerA!;

                  return Row(
                    children: [
                      Expanded(
                        child: _buildPartnerProfileCard(
                          name: '${youPartner.name} (You)',
                          address: youPartner.address,
                          status: 'CONNECTED',
                          isCertified: youPartner.isCertified,
                          isYou: true,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildPartnerProfileCard(
                          name: otherPartner.name,
                          address: otherPartner.address,
                          status: otherPartner.isCertified
                              ? 'SIGNED'
                              : 'PENDING',
                          isCertified: otherPartner.isCertified,
                          isYou: false,
                        ),
                      ),
                    ],
                  );
                },
                loading: () => Row(
                  children: [
                    Expanded(child: PartnerProfileShimmer()),
                    const SizedBox(width: 12),
                    Expanded(child: PartnerProfileShimmer()),
                  ],
                ),
                error: (error, stack) => Row(
                  children: [
                    Expanded(
                      child: _buildPartnerProfileCard(
                        name: 'You',
                        address: walletState.maybeWhen(
                          connected: (wallet) => wallet.address,
                          orElse: () => '',
                        ),
                        status: walletState.maybeWhen(
                          connected: (_) => 'CONNECTED',
                          orElse: () => 'NOT CONNECTED',
                        ),
                        isCertified: false,
                        isYou: true,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildPartnerProfileCard(
                        name: 'Partner',
                        address: '',
                        status: 'LINK DITUNGGU',
                        isCertified: false,
                        isYou: false,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPartnerProfileCard({
    required String name,
    required String address,
    required String status,
    required bool isCertified,
    required bool isYou,
  }) {
    final statusColor = status == 'CONNECTED' || status == 'CERTIFIED'
        ? AppColors.success
        : status == 'NOT CONNECTED' || status == 'LINK DITUNGGU'
        ? AppColors.neutral400
        : AppColors.info;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.neutral50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: isYou
                      ? AppColors.info
                      : (isCertified
                            ? AppColors.success
                            : AppColors.neutral300),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (isCertified)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'CERT',
                    style: TextStyle(
                      fontSize: 8,
                      color: AppColors.success,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 9,
                color: statusColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Address:',
            style: TextStyle(fontSize: 10, color: AppColors.textTertiary),
          ),
          const SizedBox(height: 4),
          Text(
            address.isEmpty
                ? (isYou ? 'Connect wallet' : 'Belum ada perjanjian')
                : '${address.substring(0, 6)}...${address.substring(address.length - 4)}',
            style: TextStyle(
              fontSize: 11,
              color: address.isEmpty ? AppColors.textSecondary : AppColors.info,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBarConnectButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.account_balance_wallet, color: Colors.white),
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (context) => const ConnectWalletDialog(),
        );
      },
      tooltip: 'Connect Wallet',
    );
  }

  Widget _buildSharedVaultGrowthCard(String ethBalance) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$ethBalance ETH',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.info,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Brankas Bersama',
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.success,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Simple Chart Placeholder
          Container(
            height: 150,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.info.withValues(alpha: 0.2),
                  AppColors.info.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                'Chart: Pertumbuhan Aset',
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDistribusiHartaCard({
    required String totalShared,
    required String partnerAAmount,
    required String partnerBAmount,
    required double partnerAPercentage,
    required double partnerBPercentage,
  }) {
    final hasBalance =
        double.tryParse(totalShared) != null && double.parse(totalShared) > 0;
    final hasContributions =
        double.tryParse(partnerAAmount) != null &&
        double.tryParse(partnerBAmount) != null &&
        (double.parse(partnerAAmount) > 0 || double.parse(partnerBAmount) > 0);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          // Donut Chart with real percentages
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: CustomPaint(
                  painter: DonutChartPainter(
                    partnerAPercentage: hasBalance ? partnerAPercentage : 50.0,
                    partnerBPercentage: hasBalance ? partnerBPercentage : 50.0,
                    hasData: hasBalance,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (hasBalance) ...[
                    Text(
                      'A: ${partnerAPercentage.toStringAsFixed(1)}%',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.info,
                      ),
                    ),
                    Text(
                      'B: ${partnerBPercentage.toStringAsFixed(1)}%',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.error,
                      ),
                    ),
                  ] else ...[
                    Text(
                      '0%',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      'No Data',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildDistribusiItem(
            'Partner A (You)',
            '${partnerAPercentage.toStringAsFixed(1)}%',
            '$partnerAAmount ETH',
            AppColors.info,
          ),
          const SizedBox(height: 12),
          _buildDistribusiItem(
            'Partner B',
            '${partnerBPercentage.toStringAsFixed(1)}%',
            '$partnerBAmount ETH',
            AppColors.error,
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Brankas Bersama:',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              Text(
                '$totalShared ETH',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: hasBalance
                      ? AppColors.primary
                      : AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (!hasBalance && !hasContributions)
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
                      'Belum ada deposit ke brankas bersama. Transfer ETH ke brankas bersama untuk melihat distribusi.',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.info,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            )
          else if (!hasBalance)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.warning.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning_amber, color: AppColors.warning, size: 16),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Data kontribusi tidak sinkron. Coba refresh atau periksa koneksi blockchain.',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.warning,
                        fontWeight: FontWeight.w500,
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

  Widget _buildDistribusiItem(
    String name,
    String percentage,
    String amount,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Senilai $amount',
                style: TextStyle(fontSize: 10, color: AppColors.textTertiary),
              ),
            ],
          ),
        ),
        Text(
          percentage,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildVowCard(VowModel vow) {
    // VowStatus: 0=Draft, 1=PendingSignatures, 2=Active, 3=Breached, 4=Resolved, 5=Terminated
    final statusText = vow.status == 0
        ? 'Draft'
        : vow.status == 1
        ? 'Pending'
        : vow.status == 2
        ? 'Active'
        : vow.status == 3
        ? 'Breached'
        : vow.status == 4
        ? 'Resolved'
        : vow.status == 5
        ? 'Terminated'
        : 'Unknown';

    final statusColor = vow.status == 2
        ? AppColors
              .success // Active
        : vow.status == 0
        ? AppColors
              .warning // Draft
        : vow.status == 1
        ? AppColors
              .info // Pending
        : vow.status == 4
        ? AppColors
              .info // Resolved
        : AppColors.error; // Breached/Terminated

    final partnerAShort = _getShortAddress(vow.partnerA);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.description, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 12),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vow #${vow.id}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Partner A: $partnerAShort',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Status badges
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Partner signed badges
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (vow.partnerASigned)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: AppColors.success.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: AppColors.success,
                            size: 10,
                          ),
                          const SizedBox(width: 3),
                          const Text(
                            'A Signed',
                            style: TextStyle(
                              fontSize: 9,
                              color: AppColors.success,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (vow.partnerASigned && vow.partnerBSigned)
                    const SizedBox(width: 4),
                  if (vow.partnerBSigned)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: AppColors.success.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: AppColors.success,
                            size: 10,
                          ),
                          const SizedBox(width: 3),
                          const Text(
                            'B Signed',
                            style: TextStyle(
                              fontSize: 9,
                              color: AppColors.success,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              if (vow.partnerASigned || vow.partnerBSigned)
                const SizedBox(height: 6),
              // Status badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                    fontSize: 10,
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              // Aktif badge (like in web screenshot)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.neutral100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Aktif',
                  style: TextStyle(
                    fontSize: 9,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          // Action button
          const SizedBox(width: 8),
          InkWell(
            onTap: () {
              // Navigate to detail page
            },
            borderRadius: BorderRadius.circular(6),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                ),
              ),
              child: const Text(
                'SELESAI',
                style: TextStyle(
                  fontSize: 9,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyPerjanjianCard() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Column(
        children: [
          Icon(
            Icons.description_outlined,
            size: 48,
            color: AppColors.neutral300,
          ),
          const SizedBox(height: 16),
          Text(
            'Belum ada perjanjian',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {},
            child: const Text('Buat perjanjian pertama →'),
          ),
        ],
      ),
    );
  }

  String _getShortAddress(String address) {
    if (address.length < 10) return address;
    return '${address.substring(0, 6)}...${address.substring(address.length - 4)}';
  }

  Widget _buildAksiCepatCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Aksi Cepat',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildAksiCepatItem(Icons.add, 'Buat Perjanjian Baru', () {}),
          const SizedBox(height: 12),
          _buildAksiCepatItem(Icons.folder_outlined, 'Kelola Brankas', () {}),
          const SizedBox(height: 12),
          _buildAksiCepatItem(Icons.image_outlined, 'Virtualisasi Aset', () {}),
        ],
      ),
    );
  }

  Widget _buildAksiCepatItem(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 14),
          ],
        ),
      ),
    );
  }

  void _showTransferToSharedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const TransferToSharedDialog(),
    );
  }
}

/// Custom Painter for Donut Chart
class DonutChartPainter extends CustomPainter {
  final double partnerAPercentage;
  final double partnerBPercentage;
  final bool hasData;

  DonutChartPainter({
    required this.partnerAPercentage,
    required this.partnerBPercentage,
    required this.hasData,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final strokeWidth = 20.0;

    // Background circle
    final backgroundPaint = Paint()
      ..color = AppColors.neutral200
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius - strokeWidth / 2, backgroundPaint);

    if (hasData && (partnerAPercentage > 0 || partnerBPercentage > 0)) {
      // Partner A arc (blue)
      final partnerAPaint = Paint()
        ..color = AppColors.info
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      final partnerAAngle = (partnerAPercentage / 100) * 2 * math.pi;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
        -math.pi / 2, // Start from top
        partnerAAngle,
        false,
        partnerAPaint,
      );

      // Partner B arc (red)
      final partnerBPaint = Paint()
        ..color = AppColors.error
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      final partnerBAngle = (partnerBPercentage / 100) * 2 * math.pi;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
        -math.pi / 2 + partnerAAngle, // Start after Partner A
        partnerBAngle,
        false,
        partnerBPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
