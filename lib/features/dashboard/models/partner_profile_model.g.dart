// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PartnerProfileModel _$PartnerProfileModelFromJson(Map<String, dynamic> json) =>
    _PartnerProfileModel(
      address: json['address'] as String,
      name: json['name'] as String,
      isCertified: json['isCertified'] as bool,
      avatarUrl: json['avatarUrl'] as String?,
      lastActive: json['lastActive'] == null
          ? null
          : DateTime.parse(json['lastActive'] as String),
    );

Map<String, dynamic> _$PartnerProfileModelToJson(
  _PartnerProfileModel instance,
) => <String, dynamic>{
  'address': instance.address,
  'name': instance.name,
  'isCertified': instance.isCertified,
  'avatarUrl': instance.avatarUrl,
  'lastActive': instance.lastActive?.toIso8601String(),
};

_VowModel _$VowModelFromJson(Map<String, dynamic> json) => _VowModel(
  id: BigInt.parse(json['id'] as String),
  partnerA: json['partnerA'] as String,
  partnerB: json['partnerB'] as String,
  escrowBalance: BigInt.parse(json['escrowBalance'] as String),
  pendingEscrowAmount: BigInt.parse(json['pendingEscrowAmount'] as String),
  status: (json['status'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  activatedAt: json['activatedAt'] == null
      ? null
      : DateTime.parse(json['activatedAt'] as String),
  partnerASigned: json['partnerASigned'] as bool,
  partnerBSigned: json['partnerBSigned'] as bool,
  metadataURI: json['metadataURI'] as String?,
);

Map<String, dynamic> _$VowModelToJson(_VowModel instance) => <String, dynamic>{
  'id': instance.id.toString(),
  'partnerA': instance.partnerA,
  'partnerB': instance.partnerB,
  'escrowBalance': instance.escrowBalance.toString(),
  'pendingEscrowAmount': instance.pendingEscrowAmount.toString(),
  'status': instance.status,
  'createdAt': instance.createdAt.toIso8601String(),
  'activatedAt': instance.activatedAt?.toIso8601String(),
  'partnerASigned': instance.partnerASigned,
  'partnerBSigned': instance.partnerBSigned,
  'metadataURI': instance.metadataURI,
};

_VaultBalancesModel _$VaultBalancesModelFromJson(Map<String, dynamic> json) =>
    _VaultBalancesModel(
      personal: BigInt.parse(json['personal'] as String),
      sharedContribution: BigInt.parse(json['sharedContribution'] as String),
      totalShared: BigInt.parse(json['totalShared'] as String),
    );

Map<String, dynamic> _$VaultBalancesModelToJson(_VaultBalancesModel instance) =>
    <String, dynamic>{
      'personal': instance.personal.toString(),
      'sharedContribution': instance.sharedContribution.toString(),
      'totalShared': instance.totalShared.toString(),
    };

_DashboardDataModel _$DashboardDataModelFromJson(
  Map<String, dynamic> json,
) => _DashboardDataModel(
  userAddress: json['userAddress'] as String,
  partnerA: json['partnerA'] == null
      ? null
      : PartnerProfileModel.fromJson(json['partnerA'] as Map<String, dynamic>),
  partnerB: json['partnerB'] == null
      ? null
      : PartnerProfileModel.fromJson(json['partnerB'] as Map<String, dynamic>),
  vaultBalances: json['vaultBalances'] == null
      ? null
      : VaultBalancesModel.fromJson(
          json['vaultBalances'] as Map<String, dynamic>,
        ),
  activeVows: (json['activeVows'] as List<dynamic>?)
      ?.map((e) => VowModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  certificates: (json['certificates'] as List<dynamic>?)
      ?.map((e) => CertificateModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalAgreements: (json['totalAgreements'] as num).toInt(),
  activeAgreements: (json['activeAgreements'] as num).toInt(),
  assetNFTCount: (json['assetNFTCount'] as num).toInt(),
  totalEscrowLocked: json['totalEscrowLocked'] == null
      ? null
      : BigInt.parse(json['totalEscrowLocked'] as String),
  partnerAContribution: json['partnerAContribution'] == null
      ? null
      : BigInt.parse(json['partnerAContribution'] as String),
  partnerBContribution: json['partnerBContribution'] == null
      ? null
      : BigInt.parse(json['partnerBContribution'] as String),
);

Map<String, dynamic> _$DashboardDataModelToJson(_DashboardDataModel instance) =>
    <String, dynamic>{
      'userAddress': instance.userAddress,
      'partnerA': instance.partnerA,
      'partnerB': instance.partnerB,
      'vaultBalances': instance.vaultBalances,
      'activeVows': instance.activeVows,
      'certificates': instance.certificates,
      'totalAgreements': instance.totalAgreements,
      'activeAgreements': instance.activeAgreements,
      'assetNFTCount': instance.assetNFTCount,
      'totalEscrowLocked': instance.totalEscrowLocked?.toString(),
      'partnerAContribution': instance.partnerAContribution?.toString(),
      'partnerBContribution': instance.partnerBContribution?.toString(),
    };

_CertificateModel _$CertificateModelFromJson(Map<String, dynamic> json) =>
    _CertificateModel(
      id: BigInt.parse(json['id'] as String),
      partnerA: json['partnerA'] as String,
      partnerB: json['partnerB'] as String,
      status: (json['status'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$CertificateModelToJson(_CertificateModel instance) =>
    <String, dynamic>{
      'id': instance.id.toString(),
      'partnerA': instance.partnerA,
      'partnerB': instance.partnerB,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_SharedVaultInfoModel _$SharedVaultInfoModelFromJson(
  Map<String, dynamic> json,
) => _SharedVaultInfoModel(
  totalBalance: BigInt.parse(json['totalBalance'] as String),
  myContribution: BigInt.parse(json['myContribution'] as String),
  partnerContribution: BigInt.parse(json['partnerContribution'] as String),
  partnerA: json['partnerA'] as String,
  partnerB: json['partnerB'] as String,
);

Map<String, dynamic> _$SharedVaultInfoModelToJson(
  _SharedVaultInfoModel instance,
) => <String, dynamic>{
  'totalBalance': instance.totalBalance.toString(),
  'myContribution': instance.myContribution.toString(),
  'partnerContribution': instance.partnerContribution.toString(),
  'partnerA': instance.partnerA,
  'partnerB': instance.partnerB,
};
