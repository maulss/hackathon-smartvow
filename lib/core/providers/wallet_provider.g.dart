// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Wallet Service Provider

@ProviderFor(walletService)
const walletServiceProvider = WalletServiceProvider._();

/// Wallet Service Provider

final class WalletServiceProvider
    extends $FunctionalProvider<WalletService, WalletService, WalletService>
    with $Provider<WalletService> {
  /// Wallet Service Provider
  const WalletServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'walletServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$walletServiceHash();

  @$internal
  @override
  $ProviderElement<WalletService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WalletService create(Ref ref) {
    return walletService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WalletService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WalletService>(value),
    );
  }
}

String _$walletServiceHash() => r'b1a22d74a64eeb01a165c69e6b2b4285bc32caca';

/// Wallet State Notifier

@ProviderFor(WalletNotifier)
const walletProvider = WalletNotifierProvider._();

/// Wallet State Notifier
final class WalletNotifierProvider
    extends $NotifierProvider<WalletNotifier, WalletState> {
  /// Wallet State Notifier
  const WalletNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'walletProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$walletNotifierHash();

  @$internal
  @override
  WalletNotifier create() => WalletNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WalletState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WalletState>(value),
    );
  }
}

String _$walletNotifierHash() => r'72aed6dfd640c38649c521708f8d75451b0fb66a';

/// Wallet State Notifier

abstract class _$WalletNotifier extends $Notifier<WalletState> {
  WalletState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<WalletState, WalletState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<WalletState, WalletState>,
              WalletState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Dashboard Data Provider

@ProviderFor(DashboardData)
const dashboardDataProvider = DashboardDataProvider._();

/// Dashboard Data Provider
final class DashboardDataProvider
    extends $AsyncNotifierProvider<DashboardData, DashboardDataModel> {
  /// Dashboard Data Provider
  const DashboardDataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardDataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardDataHash();

  @$internal
  @override
  DashboardData create() => DashboardData();
}

String _$dashboardDataHash() => r'122480c471cd40352c95e146d2ea2adcaac0db08';

/// Dashboard Data Provider

abstract class _$DashboardData extends $AsyncNotifier<DashboardDataModel> {
  FutureOr<DashboardDataModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<DashboardDataModel>, DashboardDataModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DashboardDataModel>, DashboardDataModel>,
              AsyncValue<DashboardDataModel>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Partner Profile Provider

@ProviderFor(partnerProfile)
const partnerProfileProvider = PartnerProfileProvider._();

/// Partner Profile Provider

final class PartnerProfileProvider
    extends
        $FunctionalProvider<
          AsyncValue<PartnerProfileModel?>,
          PartnerProfileModel?,
          FutureOr<PartnerProfileModel?>
        >
    with
        $FutureModifier<PartnerProfileModel?>,
        $FutureProvider<PartnerProfileModel?> {
  /// Partner Profile Provider
  const PartnerProfileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'partnerProfileProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$partnerProfileHash();

  @$internal
  @override
  $FutureProviderElement<PartnerProfileModel?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PartnerProfileModel?> create(Ref ref) {
    return partnerProfile(ref);
  }
}

String _$partnerProfileHash() => r'8d71bf06c3b4c95acdf73a2683169530506b4c63';

/// Vault Balances Provider

@ProviderFor(vaultBalances)
const vaultBalancesProvider = VaultBalancesProvider._();

/// Vault Balances Provider

final class VaultBalancesProvider
    extends
        $FunctionalProvider<
          AsyncValue<VaultBalancesModel?>,
          VaultBalancesModel?,
          FutureOr<VaultBalancesModel?>
        >
    with
        $FutureModifier<VaultBalancesModel?>,
        $FutureProvider<VaultBalancesModel?> {
  /// Vault Balances Provider
  const VaultBalancesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vaultBalancesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vaultBalancesHash();

  @$internal
  @override
  $FutureProviderElement<VaultBalancesModel?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<VaultBalancesModel?> create(Ref ref) {
    return vaultBalances(ref);
  }
}

String _$vaultBalancesHash() => r'0f605b83327c7b4162862aee80003183a804137b';

/// User Vows Provider

@ProviderFor(userVows)
const userVowsProvider = UserVowsProvider._();

/// User Vows Provider

final class UserVowsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<VowModel>>,
          List<VowModel>,
          FutureOr<List<VowModel>>
        >
    with $FutureModifier<List<VowModel>>, $FutureProvider<List<VowModel>> {
  /// User Vows Provider
  const UserVowsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userVowsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userVowsHash();

  @$internal
  @override
  $FutureProviderElement<List<VowModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<VowModel>> create(Ref ref) {
    return userVows(ref);
  }
}

String _$userVowsHash() => r'a5533a458b8d672e63c07aa13549ff9ca47dec6b';
