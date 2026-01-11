// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WalletModel _$WalletModelFromJson(Map<String, dynamic> json) => _WalletModel(
  address: json['address'] as String,
  chainId: json['chainId'] as String,
  balance: json['balance'] as String,
  ensName: json['ensName'] as String?,
  connectedAt: json['connectedAt'] == null
      ? null
      : DateTime.parse(json['connectedAt'] as String),
);

Map<String, dynamic> _$WalletModelToJson(_WalletModel instance) =>
    <String, dynamic>{
      'address': instance.address,
      'chainId': instance.chainId,
      'balance': instance.balance,
      'ensName': instance.ensName,
      'connectedAt': instance.connectedAt?.toIso8601String(),
    };
