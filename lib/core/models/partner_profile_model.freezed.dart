// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'partner_profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PartnerProfileModel {

 String get address; String get name; bool get isCertified; String? get avatarUrl; DateTime? get lastActive;
/// Create a copy of PartnerProfileModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PartnerProfileModelCopyWith<PartnerProfileModel> get copyWith => _$PartnerProfileModelCopyWithImpl<PartnerProfileModel>(this as PartnerProfileModel, _$identity);

  /// Serializes this PartnerProfileModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PartnerProfileModel&&(identical(other.address, address) || other.address == address)&&(identical(other.name, name) || other.name == name)&&(identical(other.isCertified, isCertified) || other.isCertified == isCertified)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.lastActive, lastActive) || other.lastActive == lastActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,address,name,isCertified,avatarUrl,lastActive);

@override
String toString() {
  return 'PartnerProfileModel(address: $address, name: $name, isCertified: $isCertified, avatarUrl: $avatarUrl, lastActive: $lastActive)';
}


}

/// @nodoc
abstract mixin class $PartnerProfileModelCopyWith<$Res>  {
  factory $PartnerProfileModelCopyWith(PartnerProfileModel value, $Res Function(PartnerProfileModel) _then) = _$PartnerProfileModelCopyWithImpl;
@useResult
$Res call({
 String address, String name, bool isCertified, String? avatarUrl, DateTime? lastActive
});




}
/// @nodoc
class _$PartnerProfileModelCopyWithImpl<$Res>
    implements $PartnerProfileModelCopyWith<$Res> {
  _$PartnerProfileModelCopyWithImpl(this._self, this._then);

  final PartnerProfileModel _self;
  final $Res Function(PartnerProfileModel) _then;

/// Create a copy of PartnerProfileModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? address = null,Object? name = null,Object? isCertified = null,Object? avatarUrl = freezed,Object? lastActive = freezed,}) {
  return _then(_self.copyWith(
address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isCertified: null == isCertified ? _self.isCertified : isCertified // ignore: cast_nullable_to_non_nullable
as bool,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,lastActive: freezed == lastActive ? _self.lastActive : lastActive // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [PartnerProfileModel].
extension PartnerProfileModelPatterns on PartnerProfileModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PartnerProfileModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PartnerProfileModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PartnerProfileModel value)  $default,){
final _that = this;
switch (_that) {
case _PartnerProfileModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PartnerProfileModel value)?  $default,){
final _that = this;
switch (_that) {
case _PartnerProfileModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String address,  String name,  bool isCertified,  String? avatarUrl,  DateTime? lastActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PartnerProfileModel() when $default != null:
return $default(_that.address,_that.name,_that.isCertified,_that.avatarUrl,_that.lastActive);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String address,  String name,  bool isCertified,  String? avatarUrl,  DateTime? lastActive)  $default,) {final _that = this;
switch (_that) {
case _PartnerProfileModel():
return $default(_that.address,_that.name,_that.isCertified,_that.avatarUrl,_that.lastActive);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String address,  String name,  bool isCertified,  String? avatarUrl,  DateTime? lastActive)?  $default,) {final _that = this;
switch (_that) {
case _PartnerProfileModel() when $default != null:
return $default(_that.address,_that.name,_that.isCertified,_that.avatarUrl,_that.lastActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PartnerProfileModel implements PartnerProfileModel {
  const _PartnerProfileModel({required this.address, required this.name, required this.isCertified, this.avatarUrl, this.lastActive});
  factory _PartnerProfileModel.fromJson(Map<String, dynamic> json) => _$PartnerProfileModelFromJson(json);

@override final  String address;
@override final  String name;
@override final  bool isCertified;
@override final  String? avatarUrl;
@override final  DateTime? lastActive;

/// Create a copy of PartnerProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PartnerProfileModelCopyWith<_PartnerProfileModel> get copyWith => __$PartnerProfileModelCopyWithImpl<_PartnerProfileModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PartnerProfileModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PartnerProfileModel&&(identical(other.address, address) || other.address == address)&&(identical(other.name, name) || other.name == name)&&(identical(other.isCertified, isCertified) || other.isCertified == isCertified)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.lastActive, lastActive) || other.lastActive == lastActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,address,name,isCertified,avatarUrl,lastActive);

@override
String toString() {
  return 'PartnerProfileModel(address: $address, name: $name, isCertified: $isCertified, avatarUrl: $avatarUrl, lastActive: $lastActive)';
}


}

/// @nodoc
abstract mixin class _$PartnerProfileModelCopyWith<$Res> implements $PartnerProfileModelCopyWith<$Res> {
  factory _$PartnerProfileModelCopyWith(_PartnerProfileModel value, $Res Function(_PartnerProfileModel) _then) = __$PartnerProfileModelCopyWithImpl;
@override @useResult
$Res call({
 String address, String name, bool isCertified, String? avatarUrl, DateTime? lastActive
});




}
/// @nodoc
class __$PartnerProfileModelCopyWithImpl<$Res>
    implements _$PartnerProfileModelCopyWith<$Res> {
  __$PartnerProfileModelCopyWithImpl(this._self, this._then);

  final _PartnerProfileModel _self;
  final $Res Function(_PartnerProfileModel) _then;

/// Create a copy of PartnerProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? address = null,Object? name = null,Object? isCertified = null,Object? avatarUrl = freezed,Object? lastActive = freezed,}) {
  return _then(_PartnerProfileModel(
address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isCertified: null == isCertified ? _self.isCertified : isCertified // ignore: cast_nullable_to_non_nullable
as bool,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,lastActive: freezed == lastActive ? _self.lastActive : lastActive // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$VowModel {

 BigInt get id; String get partnerA; String get partnerB; BigInt get escrowBalance; BigInt get pendingEscrowAmount; int get status;// VowStatus enum: 0=Draft, 1=Active, 2=Terminated, 3=Resolved
 DateTime get createdAt; DateTime? get activatedAt; bool get partnerASigned; bool get partnerBSigned; String? get metadataURI;
/// Create a copy of VowModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VowModelCopyWith<VowModel> get copyWith => _$VowModelCopyWithImpl<VowModel>(this as VowModel, _$identity);

  /// Serializes this VowModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VowModel&&(identical(other.id, id) || other.id == id)&&(identical(other.partnerA, partnerA) || other.partnerA == partnerA)&&(identical(other.partnerB, partnerB) || other.partnerB == partnerB)&&(identical(other.escrowBalance, escrowBalance) || other.escrowBalance == escrowBalance)&&(identical(other.pendingEscrowAmount, pendingEscrowAmount) || other.pendingEscrowAmount == pendingEscrowAmount)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.activatedAt, activatedAt) || other.activatedAt == activatedAt)&&(identical(other.partnerASigned, partnerASigned) || other.partnerASigned == partnerASigned)&&(identical(other.partnerBSigned, partnerBSigned) || other.partnerBSigned == partnerBSigned)&&(identical(other.metadataURI, metadataURI) || other.metadataURI == metadataURI));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,partnerA,partnerB,escrowBalance,pendingEscrowAmount,status,createdAt,activatedAt,partnerASigned,partnerBSigned,metadataURI);

@override
String toString() {
  return 'VowModel(id: $id, partnerA: $partnerA, partnerB: $partnerB, escrowBalance: $escrowBalance, pendingEscrowAmount: $pendingEscrowAmount, status: $status, createdAt: $createdAt, activatedAt: $activatedAt, partnerASigned: $partnerASigned, partnerBSigned: $partnerBSigned, metadataURI: $metadataURI)';
}


}

/// @nodoc
abstract mixin class $VowModelCopyWith<$Res>  {
  factory $VowModelCopyWith(VowModel value, $Res Function(VowModel) _then) = _$VowModelCopyWithImpl;
@useResult
$Res call({
 BigInt id, String partnerA, String partnerB, BigInt escrowBalance, BigInt pendingEscrowAmount, int status, DateTime createdAt, DateTime? activatedAt, bool partnerASigned, bool partnerBSigned, String? metadataURI
});




}
/// @nodoc
class _$VowModelCopyWithImpl<$Res>
    implements $VowModelCopyWith<$Res> {
  _$VowModelCopyWithImpl(this._self, this._then);

  final VowModel _self;
  final $Res Function(VowModel) _then;

/// Create a copy of VowModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? partnerA = null,Object? partnerB = null,Object? escrowBalance = null,Object? pendingEscrowAmount = null,Object? status = null,Object? createdAt = null,Object? activatedAt = freezed,Object? partnerASigned = null,Object? partnerBSigned = null,Object? metadataURI = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as BigInt,partnerA: null == partnerA ? _self.partnerA : partnerA // ignore: cast_nullable_to_non_nullable
as String,partnerB: null == partnerB ? _self.partnerB : partnerB // ignore: cast_nullable_to_non_nullable
as String,escrowBalance: null == escrowBalance ? _self.escrowBalance : escrowBalance // ignore: cast_nullable_to_non_nullable
as BigInt,pendingEscrowAmount: null == pendingEscrowAmount ? _self.pendingEscrowAmount : pendingEscrowAmount // ignore: cast_nullable_to_non_nullable
as BigInt,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,activatedAt: freezed == activatedAt ? _self.activatedAt : activatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,partnerASigned: null == partnerASigned ? _self.partnerASigned : partnerASigned // ignore: cast_nullable_to_non_nullable
as bool,partnerBSigned: null == partnerBSigned ? _self.partnerBSigned : partnerBSigned // ignore: cast_nullable_to_non_nullable
as bool,metadataURI: freezed == metadataURI ? _self.metadataURI : metadataURI // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VowModel].
extension VowModelPatterns on VowModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VowModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VowModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VowModel value)  $default,){
final _that = this;
switch (_that) {
case _VowModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VowModel value)?  $default,){
final _that = this;
switch (_that) {
case _VowModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BigInt id,  String partnerA,  String partnerB,  BigInt escrowBalance,  BigInt pendingEscrowAmount,  int status,  DateTime createdAt,  DateTime? activatedAt,  bool partnerASigned,  bool partnerBSigned,  String? metadataURI)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VowModel() when $default != null:
return $default(_that.id,_that.partnerA,_that.partnerB,_that.escrowBalance,_that.pendingEscrowAmount,_that.status,_that.createdAt,_that.activatedAt,_that.partnerASigned,_that.partnerBSigned,_that.metadataURI);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BigInt id,  String partnerA,  String partnerB,  BigInt escrowBalance,  BigInt pendingEscrowAmount,  int status,  DateTime createdAt,  DateTime? activatedAt,  bool partnerASigned,  bool partnerBSigned,  String? metadataURI)  $default,) {final _that = this;
switch (_that) {
case _VowModel():
return $default(_that.id,_that.partnerA,_that.partnerB,_that.escrowBalance,_that.pendingEscrowAmount,_that.status,_that.createdAt,_that.activatedAt,_that.partnerASigned,_that.partnerBSigned,_that.metadataURI);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BigInt id,  String partnerA,  String partnerB,  BigInt escrowBalance,  BigInt pendingEscrowAmount,  int status,  DateTime createdAt,  DateTime? activatedAt,  bool partnerASigned,  bool partnerBSigned,  String? metadataURI)?  $default,) {final _that = this;
switch (_that) {
case _VowModel() when $default != null:
return $default(_that.id,_that.partnerA,_that.partnerB,_that.escrowBalance,_that.pendingEscrowAmount,_that.status,_that.createdAt,_that.activatedAt,_that.partnerASigned,_that.partnerBSigned,_that.metadataURI);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VowModel implements VowModel {
  const _VowModel({required this.id, required this.partnerA, required this.partnerB, required this.escrowBalance, required this.pendingEscrowAmount, required this.status, required this.createdAt, this.activatedAt, required this.partnerASigned, required this.partnerBSigned, this.metadataURI});
  factory _VowModel.fromJson(Map<String, dynamic> json) => _$VowModelFromJson(json);

@override final  BigInt id;
@override final  String partnerA;
@override final  String partnerB;
@override final  BigInt escrowBalance;
@override final  BigInt pendingEscrowAmount;
@override final  int status;
// VowStatus enum: 0=Draft, 1=Active, 2=Terminated, 3=Resolved
@override final  DateTime createdAt;
@override final  DateTime? activatedAt;
@override final  bool partnerASigned;
@override final  bool partnerBSigned;
@override final  String? metadataURI;

/// Create a copy of VowModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VowModelCopyWith<_VowModel> get copyWith => __$VowModelCopyWithImpl<_VowModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VowModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VowModel&&(identical(other.id, id) || other.id == id)&&(identical(other.partnerA, partnerA) || other.partnerA == partnerA)&&(identical(other.partnerB, partnerB) || other.partnerB == partnerB)&&(identical(other.escrowBalance, escrowBalance) || other.escrowBalance == escrowBalance)&&(identical(other.pendingEscrowAmount, pendingEscrowAmount) || other.pendingEscrowAmount == pendingEscrowAmount)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.activatedAt, activatedAt) || other.activatedAt == activatedAt)&&(identical(other.partnerASigned, partnerASigned) || other.partnerASigned == partnerASigned)&&(identical(other.partnerBSigned, partnerBSigned) || other.partnerBSigned == partnerBSigned)&&(identical(other.metadataURI, metadataURI) || other.metadataURI == metadataURI));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,partnerA,partnerB,escrowBalance,pendingEscrowAmount,status,createdAt,activatedAt,partnerASigned,partnerBSigned,metadataURI);

@override
String toString() {
  return 'VowModel(id: $id, partnerA: $partnerA, partnerB: $partnerB, escrowBalance: $escrowBalance, pendingEscrowAmount: $pendingEscrowAmount, status: $status, createdAt: $createdAt, activatedAt: $activatedAt, partnerASigned: $partnerASigned, partnerBSigned: $partnerBSigned, metadataURI: $metadataURI)';
}


}

/// @nodoc
abstract mixin class _$VowModelCopyWith<$Res> implements $VowModelCopyWith<$Res> {
  factory _$VowModelCopyWith(_VowModel value, $Res Function(_VowModel) _then) = __$VowModelCopyWithImpl;
@override @useResult
$Res call({
 BigInt id, String partnerA, String partnerB, BigInt escrowBalance, BigInt pendingEscrowAmount, int status, DateTime createdAt, DateTime? activatedAt, bool partnerASigned, bool partnerBSigned, String? metadataURI
});




}
/// @nodoc
class __$VowModelCopyWithImpl<$Res>
    implements _$VowModelCopyWith<$Res> {
  __$VowModelCopyWithImpl(this._self, this._then);

  final _VowModel _self;
  final $Res Function(_VowModel) _then;

/// Create a copy of VowModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? partnerA = null,Object? partnerB = null,Object? escrowBalance = null,Object? pendingEscrowAmount = null,Object? status = null,Object? createdAt = null,Object? activatedAt = freezed,Object? partnerASigned = null,Object? partnerBSigned = null,Object? metadataURI = freezed,}) {
  return _then(_VowModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as BigInt,partnerA: null == partnerA ? _self.partnerA : partnerA // ignore: cast_nullable_to_non_nullable
as String,partnerB: null == partnerB ? _self.partnerB : partnerB // ignore: cast_nullable_to_non_nullable
as String,escrowBalance: null == escrowBalance ? _self.escrowBalance : escrowBalance // ignore: cast_nullable_to_non_nullable
as BigInt,pendingEscrowAmount: null == pendingEscrowAmount ? _self.pendingEscrowAmount : pendingEscrowAmount // ignore: cast_nullable_to_non_nullable
as BigInt,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,activatedAt: freezed == activatedAt ? _self.activatedAt : activatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,partnerASigned: null == partnerASigned ? _self.partnerASigned : partnerASigned // ignore: cast_nullable_to_non_nullable
as bool,partnerBSigned: null == partnerBSigned ? _self.partnerBSigned : partnerBSigned // ignore: cast_nullable_to_non_nullable
as bool,metadataURI: freezed == metadataURI ? _self.metadataURI : metadataURI // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$VaultBalancesModel {

 BigInt get personal; BigInt get sharedContribution; BigInt get totalShared;
/// Create a copy of VaultBalancesModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VaultBalancesModelCopyWith<VaultBalancesModel> get copyWith => _$VaultBalancesModelCopyWithImpl<VaultBalancesModel>(this as VaultBalancesModel, _$identity);

  /// Serializes this VaultBalancesModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VaultBalancesModel&&(identical(other.personal, personal) || other.personal == personal)&&(identical(other.sharedContribution, sharedContribution) || other.sharedContribution == sharedContribution)&&(identical(other.totalShared, totalShared) || other.totalShared == totalShared));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,personal,sharedContribution,totalShared);

@override
String toString() {
  return 'VaultBalancesModel(personal: $personal, sharedContribution: $sharedContribution, totalShared: $totalShared)';
}


}

/// @nodoc
abstract mixin class $VaultBalancesModelCopyWith<$Res>  {
  factory $VaultBalancesModelCopyWith(VaultBalancesModel value, $Res Function(VaultBalancesModel) _then) = _$VaultBalancesModelCopyWithImpl;
@useResult
$Res call({
 BigInt personal, BigInt sharedContribution, BigInt totalShared
});




}
/// @nodoc
class _$VaultBalancesModelCopyWithImpl<$Res>
    implements $VaultBalancesModelCopyWith<$Res> {
  _$VaultBalancesModelCopyWithImpl(this._self, this._then);

  final VaultBalancesModel _self;
  final $Res Function(VaultBalancesModel) _then;

/// Create a copy of VaultBalancesModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? personal = null,Object? sharedContribution = null,Object? totalShared = null,}) {
  return _then(_self.copyWith(
personal: null == personal ? _self.personal : personal // ignore: cast_nullable_to_non_nullable
as BigInt,sharedContribution: null == sharedContribution ? _self.sharedContribution : sharedContribution // ignore: cast_nullable_to_non_nullable
as BigInt,totalShared: null == totalShared ? _self.totalShared : totalShared // ignore: cast_nullable_to_non_nullable
as BigInt,
  ));
}

}


/// Adds pattern-matching-related methods to [VaultBalancesModel].
extension VaultBalancesModelPatterns on VaultBalancesModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VaultBalancesModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VaultBalancesModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VaultBalancesModel value)  $default,){
final _that = this;
switch (_that) {
case _VaultBalancesModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VaultBalancesModel value)?  $default,){
final _that = this;
switch (_that) {
case _VaultBalancesModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BigInt personal,  BigInt sharedContribution,  BigInt totalShared)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VaultBalancesModel() when $default != null:
return $default(_that.personal,_that.sharedContribution,_that.totalShared);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BigInt personal,  BigInt sharedContribution,  BigInt totalShared)  $default,) {final _that = this;
switch (_that) {
case _VaultBalancesModel():
return $default(_that.personal,_that.sharedContribution,_that.totalShared);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BigInt personal,  BigInt sharedContribution,  BigInt totalShared)?  $default,) {final _that = this;
switch (_that) {
case _VaultBalancesModel() when $default != null:
return $default(_that.personal,_that.sharedContribution,_that.totalShared);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VaultBalancesModel implements VaultBalancesModel {
  const _VaultBalancesModel({required this.personal, required this.sharedContribution, required this.totalShared});
  factory _VaultBalancesModel.fromJson(Map<String, dynamic> json) => _$VaultBalancesModelFromJson(json);

@override final  BigInt personal;
@override final  BigInt sharedContribution;
@override final  BigInt totalShared;

/// Create a copy of VaultBalancesModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VaultBalancesModelCopyWith<_VaultBalancesModel> get copyWith => __$VaultBalancesModelCopyWithImpl<_VaultBalancesModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VaultBalancesModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VaultBalancesModel&&(identical(other.personal, personal) || other.personal == personal)&&(identical(other.sharedContribution, sharedContribution) || other.sharedContribution == sharedContribution)&&(identical(other.totalShared, totalShared) || other.totalShared == totalShared));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,personal,sharedContribution,totalShared);

@override
String toString() {
  return 'VaultBalancesModel(personal: $personal, sharedContribution: $sharedContribution, totalShared: $totalShared)';
}


}

/// @nodoc
abstract mixin class _$VaultBalancesModelCopyWith<$Res> implements $VaultBalancesModelCopyWith<$Res> {
  factory _$VaultBalancesModelCopyWith(_VaultBalancesModel value, $Res Function(_VaultBalancesModel) _then) = __$VaultBalancesModelCopyWithImpl;
@override @useResult
$Res call({
 BigInt personal, BigInt sharedContribution, BigInt totalShared
});




}
/// @nodoc
class __$VaultBalancesModelCopyWithImpl<$Res>
    implements _$VaultBalancesModelCopyWith<$Res> {
  __$VaultBalancesModelCopyWithImpl(this._self, this._then);

  final _VaultBalancesModel _self;
  final $Res Function(_VaultBalancesModel) _then;

/// Create a copy of VaultBalancesModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? personal = null,Object? sharedContribution = null,Object? totalShared = null,}) {
  return _then(_VaultBalancesModel(
personal: null == personal ? _self.personal : personal // ignore: cast_nullable_to_non_nullable
as BigInt,sharedContribution: null == sharedContribution ? _self.sharedContribution : sharedContribution // ignore: cast_nullable_to_non_nullable
as BigInt,totalShared: null == totalShared ? _self.totalShared : totalShared // ignore: cast_nullable_to_non_nullable
as BigInt,
  ));
}


}


/// @nodoc
mixin _$DashboardDataModel {

 String get userAddress; PartnerProfileModel? get partner; VaultBalancesModel? get vaultBalances; List<VowModel>? get activeVows; int get totalAgreements; int get activeAgreements; int get assetNFTCount;
/// Create a copy of DashboardDataModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardDataModelCopyWith<DashboardDataModel> get copyWith => _$DashboardDataModelCopyWithImpl<DashboardDataModel>(this as DashboardDataModel, _$identity);

  /// Serializes this DashboardDataModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardDataModel&&(identical(other.userAddress, userAddress) || other.userAddress == userAddress)&&(identical(other.partner, partner) || other.partner == partner)&&(identical(other.vaultBalances, vaultBalances) || other.vaultBalances == vaultBalances)&&const DeepCollectionEquality().equals(other.activeVows, activeVows)&&(identical(other.totalAgreements, totalAgreements) || other.totalAgreements == totalAgreements)&&(identical(other.activeAgreements, activeAgreements) || other.activeAgreements == activeAgreements)&&(identical(other.assetNFTCount, assetNFTCount) || other.assetNFTCount == assetNFTCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userAddress,partner,vaultBalances,const DeepCollectionEquality().hash(activeVows),totalAgreements,activeAgreements,assetNFTCount);

@override
String toString() {
  return 'DashboardDataModel(userAddress: $userAddress, partner: $partner, vaultBalances: $vaultBalances, activeVows: $activeVows, totalAgreements: $totalAgreements, activeAgreements: $activeAgreements, assetNFTCount: $assetNFTCount)';
}


}

/// @nodoc
abstract mixin class $DashboardDataModelCopyWith<$Res>  {
  factory $DashboardDataModelCopyWith(DashboardDataModel value, $Res Function(DashboardDataModel) _then) = _$DashboardDataModelCopyWithImpl;
@useResult
$Res call({
 String userAddress, PartnerProfileModel? partner, VaultBalancesModel? vaultBalances, List<VowModel>? activeVows, int totalAgreements, int activeAgreements, int assetNFTCount
});


$PartnerProfileModelCopyWith<$Res>? get partner;$VaultBalancesModelCopyWith<$Res>? get vaultBalances;

}
/// @nodoc
class _$DashboardDataModelCopyWithImpl<$Res>
    implements $DashboardDataModelCopyWith<$Res> {
  _$DashboardDataModelCopyWithImpl(this._self, this._then);

  final DashboardDataModel _self;
  final $Res Function(DashboardDataModel) _then;

/// Create a copy of DashboardDataModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userAddress = null,Object? partner = freezed,Object? vaultBalances = freezed,Object? activeVows = freezed,Object? totalAgreements = null,Object? activeAgreements = null,Object? assetNFTCount = null,}) {
  return _then(_self.copyWith(
userAddress: null == userAddress ? _self.userAddress : userAddress // ignore: cast_nullable_to_non_nullable
as String,partner: freezed == partner ? _self.partner : partner // ignore: cast_nullable_to_non_nullable
as PartnerProfileModel?,vaultBalances: freezed == vaultBalances ? _self.vaultBalances : vaultBalances // ignore: cast_nullable_to_non_nullable
as VaultBalancesModel?,activeVows: freezed == activeVows ? _self.activeVows : activeVows // ignore: cast_nullable_to_non_nullable
as List<VowModel>?,totalAgreements: null == totalAgreements ? _self.totalAgreements : totalAgreements // ignore: cast_nullable_to_non_nullable
as int,activeAgreements: null == activeAgreements ? _self.activeAgreements : activeAgreements // ignore: cast_nullable_to_non_nullable
as int,assetNFTCount: null == assetNFTCount ? _self.assetNFTCount : assetNFTCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of DashboardDataModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PartnerProfileModelCopyWith<$Res>? get partner {
    if (_self.partner == null) {
    return null;
  }

  return $PartnerProfileModelCopyWith<$Res>(_self.partner!, (value) {
    return _then(_self.copyWith(partner: value));
  });
}/// Create a copy of DashboardDataModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VaultBalancesModelCopyWith<$Res>? get vaultBalances {
    if (_self.vaultBalances == null) {
    return null;
  }

  return $VaultBalancesModelCopyWith<$Res>(_self.vaultBalances!, (value) {
    return _then(_self.copyWith(vaultBalances: value));
  });
}
}


/// Adds pattern-matching-related methods to [DashboardDataModel].
extension DashboardDataModelPatterns on DashboardDataModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardDataModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardDataModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardDataModel value)  $default,){
final _that = this;
switch (_that) {
case _DashboardDataModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardDataModel value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardDataModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userAddress,  PartnerProfileModel? partner,  VaultBalancesModel? vaultBalances,  List<VowModel>? activeVows,  int totalAgreements,  int activeAgreements,  int assetNFTCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardDataModel() when $default != null:
return $default(_that.userAddress,_that.partner,_that.vaultBalances,_that.activeVows,_that.totalAgreements,_that.activeAgreements,_that.assetNFTCount);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userAddress,  PartnerProfileModel? partner,  VaultBalancesModel? vaultBalances,  List<VowModel>? activeVows,  int totalAgreements,  int activeAgreements,  int assetNFTCount)  $default,) {final _that = this;
switch (_that) {
case _DashboardDataModel():
return $default(_that.userAddress,_that.partner,_that.vaultBalances,_that.activeVows,_that.totalAgreements,_that.activeAgreements,_that.assetNFTCount);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userAddress,  PartnerProfileModel? partner,  VaultBalancesModel? vaultBalances,  List<VowModel>? activeVows,  int totalAgreements,  int activeAgreements,  int assetNFTCount)?  $default,) {final _that = this;
switch (_that) {
case _DashboardDataModel() when $default != null:
return $default(_that.userAddress,_that.partner,_that.vaultBalances,_that.activeVows,_that.totalAgreements,_that.activeAgreements,_that.assetNFTCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DashboardDataModel implements DashboardDataModel {
  const _DashboardDataModel({required this.userAddress, this.partner, this.vaultBalances, final  List<VowModel>? activeVows, required this.totalAgreements, required this.activeAgreements, required this.assetNFTCount}): _activeVows = activeVows;
  factory _DashboardDataModel.fromJson(Map<String, dynamic> json) => _$DashboardDataModelFromJson(json);

@override final  String userAddress;
@override final  PartnerProfileModel? partner;
@override final  VaultBalancesModel? vaultBalances;
 final  List<VowModel>? _activeVows;
@override List<VowModel>? get activeVows {
  final value = _activeVows;
  if (value == null) return null;
  if (_activeVows is EqualUnmodifiableListView) return _activeVows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  int totalAgreements;
@override final  int activeAgreements;
@override final  int assetNFTCount;

/// Create a copy of DashboardDataModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardDataModelCopyWith<_DashboardDataModel> get copyWith => __$DashboardDataModelCopyWithImpl<_DashboardDataModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DashboardDataModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardDataModel&&(identical(other.userAddress, userAddress) || other.userAddress == userAddress)&&(identical(other.partner, partner) || other.partner == partner)&&(identical(other.vaultBalances, vaultBalances) || other.vaultBalances == vaultBalances)&&const DeepCollectionEquality().equals(other._activeVows, _activeVows)&&(identical(other.totalAgreements, totalAgreements) || other.totalAgreements == totalAgreements)&&(identical(other.activeAgreements, activeAgreements) || other.activeAgreements == activeAgreements)&&(identical(other.assetNFTCount, assetNFTCount) || other.assetNFTCount == assetNFTCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userAddress,partner,vaultBalances,const DeepCollectionEquality().hash(_activeVows),totalAgreements,activeAgreements,assetNFTCount);

@override
String toString() {
  return 'DashboardDataModel(userAddress: $userAddress, partner: $partner, vaultBalances: $vaultBalances, activeVows: $activeVows, totalAgreements: $totalAgreements, activeAgreements: $activeAgreements, assetNFTCount: $assetNFTCount)';
}


}

/// @nodoc
abstract mixin class _$DashboardDataModelCopyWith<$Res> implements $DashboardDataModelCopyWith<$Res> {
  factory _$DashboardDataModelCopyWith(_DashboardDataModel value, $Res Function(_DashboardDataModel) _then) = __$DashboardDataModelCopyWithImpl;
@override @useResult
$Res call({
 String userAddress, PartnerProfileModel? partner, VaultBalancesModel? vaultBalances, List<VowModel>? activeVows, int totalAgreements, int activeAgreements, int assetNFTCount
});


@override $PartnerProfileModelCopyWith<$Res>? get partner;@override $VaultBalancesModelCopyWith<$Res>? get vaultBalances;

}
/// @nodoc
class __$DashboardDataModelCopyWithImpl<$Res>
    implements _$DashboardDataModelCopyWith<$Res> {
  __$DashboardDataModelCopyWithImpl(this._self, this._then);

  final _DashboardDataModel _self;
  final $Res Function(_DashboardDataModel) _then;

/// Create a copy of DashboardDataModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userAddress = null,Object? partner = freezed,Object? vaultBalances = freezed,Object? activeVows = freezed,Object? totalAgreements = null,Object? activeAgreements = null,Object? assetNFTCount = null,}) {
  return _then(_DashboardDataModel(
userAddress: null == userAddress ? _self.userAddress : userAddress // ignore: cast_nullable_to_non_nullable
as String,partner: freezed == partner ? _self.partner : partner // ignore: cast_nullable_to_non_nullable
as PartnerProfileModel?,vaultBalances: freezed == vaultBalances ? _self.vaultBalances : vaultBalances // ignore: cast_nullable_to_non_nullable
as VaultBalancesModel?,activeVows: freezed == activeVows ? _self._activeVows : activeVows // ignore: cast_nullable_to_non_nullable
as List<VowModel>?,totalAgreements: null == totalAgreements ? _self.totalAgreements : totalAgreements // ignore: cast_nullable_to_non_nullable
as int,activeAgreements: null == activeAgreements ? _self.activeAgreements : activeAgreements // ignore: cast_nullable_to_non_nullable
as int,assetNFTCount: null == assetNFTCount ? _self.assetNFTCount : assetNFTCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of DashboardDataModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PartnerProfileModelCopyWith<$Res>? get partner {
    if (_self.partner == null) {
    return null;
  }

  return $PartnerProfileModelCopyWith<$Res>(_self.partner!, (value) {
    return _then(_self.copyWith(partner: value));
  });
}/// Create a copy of DashboardDataModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VaultBalancesModelCopyWith<$Res>? get vaultBalances {
    if (_self.vaultBalances == null) {
    return null;
  }

  return $VaultBalancesModelCopyWith<$Res>(_self.vaultBalances!, (value) {
    return _then(_self.copyWith(vaultBalances: value));
  });
}
}

// dart format on
