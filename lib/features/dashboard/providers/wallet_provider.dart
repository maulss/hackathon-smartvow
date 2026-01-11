import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/wallet_model.dart';
import '../models/partner_profile_model.dart';
import '../services/wallet_service.dart';

part 'wallet_provider.g.dart';

/// Wallet Service Provider - keepAlive to persist credentials
@Riverpod(keepAlive: true)
WalletService walletService(Ref ref) {
  final service = WalletService();
  ref.onDispose(() => service.dispose());
  return service;
}

/// Wallet State Notifier - keepAlive to persist state
@Riverpod(keepAlive: true)
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
    final walletState = ref.watch(walletProvider);

    return walletState.when(
      initial: () {
        print('📊 Dashboard: Wallet state is initial');
        return _emptyDashboard('');
      },
      connecting: () {
        print('📊 Dashboard: Wallet is connecting');
        return _emptyDashboard('');
      },
      connected: (wallet) async {
        try {
          print(
            '📊 Dashboard: Wallet connected, fetching data for ${wallet.address}',
          );
          final service = ref.watch(walletServiceProvider);
          final data = await service.getDashboardData(wallet.address);
          print(
            '📊 Dashboard: Data fetched - ${data.totalAgreements} agreements, ${data.assetNFTCount} NFTs, escrow: ${data.totalEscrowLocked}',
          );
          return data;
        } catch (e) {
          print('📊 Dashboard ERROR: $e');
          return _emptyDashboard(wallet.address);
        }
      },
      disconnected: () {
        print('📊 Dashboard: Wallet disconnected');
        return _emptyDashboard('');
      },
      error: (err) {
        print('📊 Dashboard: Wallet error: $err');
        return _emptyDashboard('');
      },
    );
  }

  DashboardDataModel _emptyDashboard(String address) {
    return DashboardDataModel(
      userAddress: address,
      partnerA: null,
      partnerB: null,
      vaultBalances: VaultBalancesModel(
        personal: BigInt.zero,
        sharedContribution: BigInt.zero,
        totalShared: BigInt.zero,
      ),
      activeVows: [],
      certificates: [],
      totalAgreements: 0,
      activeAgreements: 0,
      assetNFTCount: 0,
      totalEscrowLocked: BigInt.zero,
      partnerAContribution: BigInt.zero,
      partnerBContribution: BigInt.zero,
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => build());
  }
}

/// Partners Profile Provider
@riverpod
Future<Map<String, PartnerProfileModel?>> partnersProfile(Ref ref) async {
  final walletState = ref.watch(walletProvider);

  return walletState.when(
    initial: () => {'partnerA': null, 'partnerB': null},
    connecting: () => {'partnerA': null, 'partnerB': null},
    connected: (wallet) async {
      final service = ref.watch(walletServiceProvider);
      return await service.getPartners(wallet.address);
    },
    disconnected: () => {'partnerA': null, 'partnerB': null},
    error: (_) => {'partnerA': null, 'partnerB': null},
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
    initial: () {
      print('🔹 userVowsProvider: Wallet state is initial');
      return [];
    },
    connecting: () {
      print('🔹 userVowsProvider: Wallet is connecting');
      return [];
    },
    connected: (wallet) async {
      print('🔹 userVowsProvider: Fetching vows for ${wallet.address}');
      final service = ref.watch(walletServiceProvider);
      final vows = await service.getUserVows(wallet.address);
      print('🔹 userVowsProvider: Returning ${vows.length} vows to UI');
      return vows;
    },
    disconnected: () {
      print('🔹 userVowsProvider: Wallet disconnected');
      return [];
    },
    error: (_) {
      print('🔹 userVowsProvider: Wallet error');
      return [];
    },
  );
}

/// Certificates Provider
@riverpod
Future<List<CertificateModel>> certificates(Ref ref) async {
  final walletState = ref.watch(walletProvider);

  return walletState.when(
    initial: () => [],
    connecting: () => [],
    connected: (wallet) async {
      final service = ref.watch(walletServiceProvider);
      return await service.getAllCertificates();
    },
    disconnected: () => [],
    error: (_) => [],
  );
}
