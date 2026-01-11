// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Wallet Service Provider - keepAlive to persist credentials

@ProviderFor(walletService)
const walletServiceProvider = WalletServiceProvider._();

/// Wallet Service Provider - keepAlive to persist credentials

final class WalletServiceProvider
    extends $FunctionalProvider<WalletService, WalletService, WalletService>
    with $Provider<WalletService> {
  /// Wallet Service Provider - keepAlive to persist credentials
  const WalletServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'walletServiceProvider',
        isAutoDispose: false,
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

String _$walletServiceHash() => r'9bee8b73c6908aae28749d3e8d500e0c96cc9ba8';

/// Wallet State Notifier - keepAlive to persist state

@ProviderFor(WalletNotifier)
const walletProvider = WalletNotifierProvider._();

/// Wallet State Notifier - keepAlive to persist state
final class WalletNotifierProvider
    extends $NotifierProvider<WalletNotifier, WalletState> {
  /// Wallet State Notifier - keepAlive to persist state
  const WalletNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'walletProvider',
        isAutoDispose: false,
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

String _$walletNotifierHash() => r'37b5828962e4327c61877ee326d4c9ca7f121732';

/// Wallet State Notifier - keepAlive to persist state

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

String _$dashboardDataHash() => r'a4383628ee39c75e5ba53e0374a1ba1e9e622614';

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

/// Partners Profile Provider

@ProviderFor(partnersProfile)
const partnersProfileProvider = PartnersProfileProvider._();

/// Partners Profile Provider

final class PartnersProfileProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, PartnerProfileModel?>>,
          Map<String, PartnerProfileModel?>,
          FutureOr<Map<String, PartnerProfileModel?>>
        >
    with
        $FutureModifier<Map<String, PartnerProfileModel?>>,
        $FutureProvider<Map<String, PartnerProfileModel?>> {
  /// Partners Profile Provider
  const PartnersProfileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'partnersProfileProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$partnersProfileHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, PartnerProfileModel?>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, PartnerProfileModel?>> create(Ref ref) {
    return partnersProfile(ref);
  }
}

String _$partnersProfileHash() => r'2a998c3b215a8910bd7540241e80fcef7ce040f9';

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

String _$userVowsHash() => r'a33c1a5c040865b6ef9fe872d476e1876676131c';

/// Certificates Provider

@ProviderFor(certificates)
const certificatesProvider = CertificatesProvider._();

/// Certificates Provider

final class CertificatesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CertificateModel>>,
          List<CertificateModel>,
          FutureOr<List<CertificateModel>>
        >
    with
        $FutureModifier<List<CertificateModel>>,
        $FutureProvider<List<CertificateModel>> {
  /// Certificates Provider
  const CertificatesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'certificatesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$certificatesHash();

  @$internal
  @override
  $FutureProviderElement<List<CertificateModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CertificateModel>> create(Ref ref) {
    return certificates(ref);
  }
}

String _$certificatesHash() => r'56b3440f4acf3cd9e610c25aaa2c86f9c8e8349b';
