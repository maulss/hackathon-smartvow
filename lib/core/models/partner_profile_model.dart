import 'package:freezed_annotation/freezed_annotation.dart';

part 'partner_profile_model.freezed.dart';
part 'partner_profile_model.g.dart';

/// Partner Profile Model
/// Model untuk menyimpan informasi profil pasangan dari smart contract
@freezed
abstract class PartnerProfileModel with _$PartnerProfileModel {
  const factory PartnerProfileModel({
    required String address,
    required String name,
    required bool isCertified,
    String? avatarUrl,
    DateTime? lastActive,
  }) = _PartnerProfileModel;

  factory PartnerProfileModel.fromJson(Map<String, dynamic> json) =>
      _$PartnerProfileModelFromJson(json);
}

/// Vow (Perjanjian) Model
/// Model untuk data perjanjian dari smart contract
@freezed
abstract class VowModel with _$VowModel {
  const factory VowModel({
    required BigInt id,
    required String partnerA,
    required String partnerB,
    required BigInt escrowBalance,
    required BigInt pendingEscrowAmount,
    required int
    status, // VowStatus enum: 0=Draft, 1=Active, 2=Terminated, 3=Resolved
    required DateTime createdAt,
    DateTime? activatedAt,
    required bool partnerASigned,
    required bool partnerBSigned,
    String? metadataURI,
  }) = _VowModel;

  factory VowModel.fromJson(Map<String, dynamic> json) =>
      _$VowModelFromJson(json);

  /// Convert dari smart contract return value
  factory VowModel.fromContract(List<dynamic> data) {
    try {
      // Ensure we have enough data
      if (data.length < 11) {
        throw Exception(
          'Insufficient data fields: expected 11, got ${data.length}',
        );
      }

      // Extract and convert each field safely
      final id = data[0] is BigInt ? data[0] as BigInt : BigInt.from(data[0]);

      // For addresses, handle both String and EthereumAddress types
      final partnerA = data[1] is String
          ? data[1] as String
          : data[1].toString();
      final partnerB = data[2] is String
          ? data[2] as String
          : data[2].toString();

      final escrowBalance = data[3] is BigInt
          ? data[3] as BigInt
          : BigInt.from(data[3]);
      final pendingEscrowAmount = data[4] is BigInt
          ? data[4] as BigInt
          : BigInt.from(data[4]);

      final status = data[5] is int
          ? data[5] as int
          : int.parse(data[5].toString());

      final createdAtTimestamp = data[6] is BigInt
          ? data[6] as BigInt
          : BigInt.from(data[6]);
      final createdAt = DateTime.fromMillisecondsSinceEpoch(
        (createdAtTimestamp * BigInt.from(1000)).toInt(),
      );

      final activatedAtTimestamp = data[7] is BigInt
          ? data[7] as BigInt
          : BigInt.from(data[7]);
      final activatedAt = activatedAtTimestamp > BigInt.zero
          ? DateTime.fromMillisecondsSinceEpoch(
              (activatedAtTimestamp * BigInt.from(1000)).toInt(),
            )
          : null;

      final partnerASigned = data[8] as bool;
      final partnerBSigned = data[9] as bool;
      final metadataURI = data[10] as String?;

      return VowModel(
        id: id,
        partnerA: partnerA,
        partnerB: partnerB,
        escrowBalance: escrowBalance,
        pendingEscrowAmount: pendingEscrowAmount,
        status: status,
        createdAt: createdAt,
        activatedAt: activatedAt,
        partnerASigned: partnerASigned,
        partnerBSigned: partnerBSigned,
        metadataURI: metadataURI,
      );
    } catch (e) {
      throw Exception(
        'Failed to parse VowModel from contract data: $e. Data: $data',
      );
    }
  }
}

/// Vault Balances Model
/// Model untuk balance vault dari smart contract
@freezed
abstract class VaultBalancesModel with _$VaultBalancesModel {
  const factory VaultBalancesModel({
    required BigInt personal,
    required BigInt sharedContribution,
    required BigInt totalShared,
  }) = _VaultBalancesModel;

  factory VaultBalancesModel.fromJson(Map<String, dynamic> json) =>
      _$VaultBalancesModelFromJson(json);

  /// Convert dari smart contract return value
  factory VaultBalancesModel.fromContract(List<dynamic> data) {
    try {
      // Ensure we have enough data
      if (data.length < 3) {
        throw Exception(
          'Insufficient data fields: expected 3, got ${data.length}',
        );
      }

      return VaultBalancesModel(
        personal: data[0] is BigInt ? data[0] as BigInt : BigInt.from(data[0]),
        sharedContribution: data[1] is BigInt
            ? data[1] as BigInt
            : BigInt.from(data[1]),
        totalShared: data[2] is BigInt
            ? data[2] as BigInt
            : BigInt.from(data[2]),
      );
    } catch (e) {
      throw Exception(
        'Failed to parse VaultBalancesModel from contract data: $e. Data: $data',
      );
    }
  }
}

/// Dashboard Data Model
/// Model untuk aggregate data dashboard
@freezed
abstract class DashboardDataModel with _$DashboardDataModel {
  const factory DashboardDataModel({
    required String userAddress,
    PartnerProfileModel? partner,
    VaultBalancesModel? vaultBalances,
    List<VowModel>? activeVows,
    required int totalAgreements,
    required int activeAgreements,
    required int assetNFTCount,
  }) = _DashboardDataModel;

  factory DashboardDataModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardDataModelFromJson(json);
}
