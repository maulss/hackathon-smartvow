import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_model.freezed.dart';
part 'wallet_model.g.dart';

/// Wallet Model
/// Model untuk menyimpan informasi wallet yang terhubung
@freezed
abstract class WalletModel with _$WalletModel {
  const factory WalletModel({
    required String address,
    required String chainId,
    required String balance,
    String? ensName,
    DateTime? connectedAt,
  }) = _WalletModel;

  factory WalletModel.fromJson(Map<String, dynamic> json) =>
      _$WalletModelFromJson(json);
}

/// Wallet State
/// State management untuk wallet connection
@freezed
abstract class WalletState with _$WalletState {
  const factory WalletState.initial() = _Initial;
  const factory WalletState.connecting() = _Connecting;
  const factory WalletState.connected(WalletModel wallet) = _Connected;
  const factory WalletState.disconnected() = _Disconnected;
  const factory WalletState.error(String message) = _Error;
}
