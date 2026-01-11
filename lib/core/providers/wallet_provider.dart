import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/wallet_model.dart';
import '../models/partner_profile_model.dart';
import '../services/wallet_service.dart';

part 'wallet_provider.g.dart';

/// Wallet Service Provider
@riverpod
WalletService walletService(Ref ref) {
  final service = WalletService();
  ref.onDispose(() => service.dispose());
  return service;
}

/// Wallet State Notifier
@riverpod
class WalletNotifier extends _$WalletNotifier {
  @override
  WalletState build() {
    return const WalletState.initial();
  }

  /// Connect wallet
  Future<void> connectWallet(String privateKey) async {
    state = const WalletState.connecting();

    try {
      final service = ref.read(walletServiceProvider);
      final wallet = await service.connectWallet(privateKey);
      state = WalletState.connected(wallet);
    } catch (e) {
      state = WalletState.error(e.toString());
    }
  }

  /// Disconnect wallet
  void disconnectWallet() {
    final service = ref.read(walletServiceProvider);
    service.disconnectWallet();
    state = const WalletState.disconnected();
  }

  /// Refresh wallet data
  Future<void> refreshWallet() async {
    final currentState = state;

    // Use pattern matching with when
    currentState.when(
      initial: () {},
      connecting: () {},
      connected: (currentWallet) async {
        try {
          final service = ref.read(walletServiceProvider);
          // Refresh with same credentials
          final wallet = await service.connectWallet(
            currentWallet.address, // This is a simplification
          );
          state = WalletState.connected(wallet);
        } catch (e) {
          state = WalletState.error(e.toString());
        }
      },
      disconnected: () {},
      error: (_) {},
    );
  }
}

/// Dashboard Data Provider
@riverpod
class DashboardData extends _$DashboardData {
  @override
  Future<DashboardDataModel> build() async {
    // Wait for wallet to be connected
    final walletState = ref.watch(walletProvider);

    return await walletState.when(
      initial: () async => throw Exception('Wallet not connected'),
      connecting: () async => throw Exception('Wallet connecting...'),
      connected: (wallet) async {
        final service = ref.watch(walletServiceProvider);
        return await service.getDashboardData(wallet.address);
      },
      disconnected: () async => throw Exception('Wallet disconnected'),
      error: (message) async => throw Exception(message),
    );
  }

  /// Refresh dashboard data
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final walletState = ref.read(walletProvider);

      // Use when to safely extract wallet
      return walletState.when(
        initial: () => throw Exception('Wallet not connected'),
        connecting: () => throw Exception('Wallet connecting...'),
        connected: (wallet) async {
          final service = ref.read(walletServiceProvider);
          return await service.getDashboardData(wallet.address);
        },
        disconnected: () => throw Exception('Wallet disconnected'),
        error: (message) => throw Exception(message),
      );
    });
  }
}

/// Partner Profile Provider
@riverpod
Future<PartnerProfileModel?> partnerProfile(Ref ref) async {
  final walletState = ref.watch(walletProvider);

  return walletState.when(
    initial: () => null,
    connecting: () => null,
    connected: (wallet) async {
      final service = ref.watch(walletServiceProvider);
      return await service.getPartner(wallet.address);
    },
    disconnected: () => null,
    error: (_) => null,
  );
}

/// Vault Balances Provider
@riverpod
Future<VaultBalancesModel?> vaultBalances(Ref ref) async {
  final walletState = ref.watch(walletProvider);

  return walletState.when(
    initial: () => null,
    connecting: () => null,
    connected: (wallet) async {
      final service = ref.watch(walletServiceProvider);
      return await service.getVaultBalances(wallet.address);
    },
    disconnected: () => null,
    error: (_) => null,
  );
}

/// User Vows Provider
@riverpod
Future<List<VowModel>> userVows(Ref ref) async {
  final walletState = ref.watch(walletProvider);

  return walletState.when(
    initial: () => [],
    connecting: () => [],
    connected: (wallet) async {
      final service = ref.watch(walletServiceProvider);
      return await service.getUserVows(wallet.address);
    },
    disconnected: () => [],
    error: (_) => [],
  );
}
