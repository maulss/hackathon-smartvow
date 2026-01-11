import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/color_constant.dart';
import '../providers/wallet_provider.dart';

class DepositDialog extends ConsumerStatefulWidget {
  const DepositDialog({super.key});

  @override
  ConsumerState<DepositDialog> createState() => _DepositDialogState();
}

class _DepositDialogState extends ConsumerState<DepositDialog> {
  final _amountController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _deposit() async {
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

    setState(() => _isLoading = true);

    try {
      final service = ref.read(walletServiceProvider);
      final amountWei = BigInt.from(amount * 1e18);

      print('💰 Starting deposit: $amountText ETH ($amountWei wei)');

      // depositPersonal now waits for transaction confirmation
      await service.depositPersonal(amountWei);

      print('✅ Deposit transaction confirmed on blockchain');

      // Invalidate dashboard data provider to force refresh
      print('🔄 Refreshing dashboard data from blockchain...');
      ref.invalidate(dashboardDataProvider);

      // Give a moment for the provider to refresh
      await Future.delayed(const Duration(milliseconds: 500));

      if (mounted) {
        Navigator.of(context).pop(true);
        _showSuccess('Deposit berhasil! $amountText ETH');
      }
    } catch (e) {
      print('❌ Deposit failed: $e');
      if (mounted) {
        setState(() => _isLoading = false);
        _showError('Gagal deposit: $e');
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
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.account_balance_wallet, color: AppColors.success),
                const SizedBox(width: 8),
                const Text(
                  'Deposit ke Personal Vault',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              enabled: !_isLoading,
              decoration: InputDecoration(
                labelText: 'Jumlah ETH',
                hintText: '0.01',
                suffixText: 'ETH',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _isLoading ? null : () => Navigator.pop(context),
                    child: const Text('Batalkan'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _deposit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success,
                      foregroundColor: Colors.white,
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
                        : const Text('Deposit'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
