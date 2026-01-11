import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/color_constant.dart';
import '../providers/wallet_provider.dart';

class TransferToSharedDialog extends ConsumerStatefulWidget {
  const TransferToSharedDialog({super.key});

  @override
  ConsumerState<TransferToSharedDialog> createState() =>
      _TransferToSharedDialogState();
}

class _TransferToSharedDialogState
    extends ConsumerState<TransferToSharedDialog> {
  final _amountController = TextEditingController();
  bool _isLoading = false;
  double _availableBalance = 0.0;
  int _selectedCertificateId = 1; // Default certificate ID

  @override
  void initState() {
    super.initState();
    _loadBalance();
  }

  void _loadBalance() {
    final dashboardAsync = ref.read(dashboardDataProvider);
    dashboardAsync.whenData((data) {
      setState(() {
        _availableBalance =
            (data.vaultBalances?.personal ?? BigInt.zero).toDouble() / 1e18;
      });
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _setPercentage(double percentage) {
    final amount = _availableBalance * percentage;
    _amountController.text = amount.toStringAsFixed(5);
  }

  Future<void> _transferToShared() async {
    final amountText = _amountController.text.trim();
    if (amountText.isEmpty) {
      _showError('Masukkan jumlah ETH');
      return;
    }

    final amount = double.tryParse(amountText);
    if (amount == null || amount <= 0) {
      _showError('Jumlah tidak valid');
      return;
    }

    if (amount > _availableBalance) {
      _showError('Saldo brankas pribadi tidak cukup');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final service = ref.read(walletServiceProvider);
      final amountWei = BigInt.from(amount * 1e18);

      print(
        '🔄 Starting transfer to shared vault: $amountText ETH ($amountWei wei)',
      );
      print('📋 Certificate ID: $_selectedCertificateId');

      // Call transferToSharedVault function
      await service.transferToSharedVault(_selectedCertificateId, amountWei);

      print('✅ Transfer to shared vault transaction confirmed');

      // Invalidate dashboard data provider to force refresh
      print('🔄 Refreshing dashboard data from blockchain...');
      ref.invalidate(dashboardDataProvider);

      // Give a moment for the provider to refresh
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        Navigator.of(context).pop(true);
        _showSuccess('Transfer berhasil! $amountText ETH ke brankas bersama');
      }
    } catch (e) {
      print('❌ Transfer to shared vault failed: $e');
      if (mounted) {
        setState(() => _isLoading = false);
        _showError(
          'Gagal transfer: ${e.toString().replaceAll('Exception: ', '')}',
        );
      }
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: AppColors.error),
    );
  }

  void _showSuccess(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: AppColors.success),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dashboardAsync = ref.watch(dashboardDataProvider);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      Icon(Icons.swap_horiz, color: AppColors.info),
                      const SizedBox(width: 8),
                      const Flexible(
                        child: Text(
                          'Transfer ke Brankas Bersama',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Available Balance Info
            dashboardAsync.when(
              data: (dashboardData) {
                final personalBalance =
                    dashboardData.vaultBalances?.personal ?? BigInt.zero;
                final ethBalance = personalBalance.toDouble() / 1e18;
                _availableBalance = ethBalance;

                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.info.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.info.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: AppColors.info, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Transfer dari brankas pribadi ke brankas bersama. Saldo tersedia: ${ethBalance.toStringAsFixed(5)} ETH',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (_, __) => const SizedBox.shrink(),
            ),
            const SizedBox(height: 20),

            // Amount Input
            const Text(
              'Jumlah (ETH)',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              enabled: !_isLoading,
              decoration: InputDecoration(
                hintText: '0.001',
                suffixText: 'ETH',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),

            // Percentage Buttons
            Row(
              children: [
                Expanded(child: _buildPercentageButton('25%', 0.25)),
                const SizedBox(width: 8),
                Expanded(child: _buildPercentageButton('50%', 0.50)),
                const SizedBox(width: 8),
                Expanded(child: _buildPercentageButton('75%', 0.75)),
                const SizedBox(width: 8),
                Expanded(child: _buildPercentageButton('MAX', 1.0)),
              ],
            ),
            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _isLoading ? null : () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Batal'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _transferToShared,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.info,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Transfer'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPercentageButton(String label, double percentage) {
    return OutlinedButton(
      onPressed: _isLoading ? null : () => _setPercentage(percentage),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: BorderSide(color: AppColors.neutral300),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
      ),
    );
  }
}
