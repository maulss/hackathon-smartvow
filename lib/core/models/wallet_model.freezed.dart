// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WalletModel {

 String get address; String get chainId; String get balance; String? get ensName; DateTime? get connectedAt;
/// Create a copy of WalletModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletModelCopyWith<WalletModel> get copyWith => _$WalletModelCopyWithImpl<WalletModel>(this as WalletModel, _$identity);

  /// Serializes this WalletModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletModel&&(identical(other.address, address) || other.address == address)&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.ensName, ensName) || other.ensName == ensName)&&(identical(other.connectedAt, connectedAt) || other.connectedAt == connectedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,address,chainId,balance,ensName,connectedAt);

@override
String toString() {
  return 'WalletModel(address: $address, chainId: $chainId, balance: $balance, ensName: $ensName, connectedAt: $connectedAt)';
}


}

/// @nodoc
abstract mixin class $WalletModelCopyWith<$Res>  {
  factory $WalletModelCopyWith(WalletModel value, $Res Function(WalletModel) _then) = _$WalletModelCopyWithImpl;
@useResult
$Res call({
 String address, String chainId, String balance, String? ensName, DateTime? connectedAt
});




}
/// @nodoc
class _$WalletModelCopyWithImpl<$Res>
    implements $WalletModelCopyWith<$Res> {
  _$WalletModelCopyWithImpl(this._self, this._then);

  final WalletModel _self;
  final $Res Function(WalletModel) _then;

/// Create a copy of WalletModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? address = null,Object? chainId = null,Object? balance = null,Object? ensName = freezed,Object? connectedAt = freezed,}) {
  return _then(_self.copyWith(
address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as String,ensName: freezed == ensName ? _self.ensName : ensName // ignore: cast_nullable_to_non_nullable
as String?,connectedAt: freezed == connectedAt ? _self.connectedAt : connectedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [WalletModel].
extension WalletModelPatterns on WalletModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WalletModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WalletModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WalletModel value)  $default,){
final _that = this;
switch (_that) {
case _WalletModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WalletModel value)?  $default,){
final _that = this;
switch (_that) {
case _WalletModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String address,  String chainId,  String balance,  String? ensName,  DateTime? connectedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WalletModel() when $default != null:
return $default(_that.address,_that.chainId,_that.balance,_that.ensName,_that.connectedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String address,  String chainId,  String balance,  String? ensName,  DateTime? connectedAt)  $default,) {final _that = this;
switch (_that) {
case _WalletModel():
return $default(_that.address,_that.chainId,_that.balance,_that.ensName,_that.connectedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String address,  String chainId,  String balance,  String? ensName,  DateTime? connectedAt)?  $default,) {final _that = this;
switch (_that) {
case _WalletModel() when $default != null:
return $default(_that.address,_that.chainId,_that.balance,_that.ensName,_that.connectedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WalletModel implements WalletModel {
  const _WalletModel({required this.address, required this.chainId, required this.balance, this.ensName, this.connectedAt});
  factory _WalletModel.fromJson(Map<String, dynamic> json) => _$WalletModelFromJson(json);

@override final  String address;
@override final  String chainId;
@override final  String balance;
@override final  String? ensName;
@override final  DateTime? connectedAt;

/// Create a copy of WalletModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletModelCopyWith<_WalletModel> get copyWith => __$WalletModelCopyWithImpl<_WalletModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WalletModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalletModel&&(identical(other.address, address) || other.address == address)&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.ensName, ensName) || other.ensName == ensName)&&(identical(other.connectedAt, connectedAt) || other.connectedAt == connectedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,address,chainId,balance,ensName,connectedAt);

@override
String toString() {
  return 'WalletModel(address: $address, chainId: $chainId, balance: $balance, ensName: $ensName, connectedAt: $connectedAt)';
}


}

/// @nodoc
abstract mixin class _$WalletModelCopyWith<$Res> implements $WalletModelCopyWith<$Res> {
  factory _$WalletModelCopyWith(_WalletModel value, $Res Function(_WalletModel) _then) = __$WalletModelCopyWithImpl;
@override @useResult
$Res call({
 String address, String chainId, String balance, String? ensName, DateTime? connectedAt
});




}
/// @nodoc
class __$WalletModelCopyWithImpl<$Res>
    implements _$WalletModelCopyWith<$Res> {
  __$WalletModelCopyWithImpl(this._self, this._then);

  final _WalletModel _self;
  final $Res Function(_WalletModel) _then;

/// Create a copy of WalletModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? address = null,Object? chainId = null,Object? balance = null,Object? ensName = freezed,Object? connectedAt = freezed,}) {
  return _then(_WalletModel(
address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as String,ensName: freezed == ensName ? _self.ensName : ensName // ignore: cast_nullable_to_non_nullable
as String?,connectedAt: freezed == connectedAt ? _self.connectedAt : connectedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$WalletState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WalletState()';
}


}

/// @nodoc
class $WalletStateCopyWith<$Res>  {
$WalletStateCopyWith(WalletState _, $Res Function(WalletState) __);
}


/// Adds pattern-matching-related methods to [WalletState].
extension WalletStatePatterns on WalletState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Connecting value)?  connecting,TResult Function( _Connected value)?  connected,TResult Function( _Disconnected value)?  disconnected,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Connecting() when connecting != null:
return connecting(_that);case _Connected() when connected != null:
return connected(_that);case _Disconnected() when disconnected != null:
return disconnected(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Connecting value)  connecting,required TResult Function( _Connected value)  connected,required TResult Function( _Disconnected value)  disconnected,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Connecting():
return connecting(_that);case _Connected():
return connected(_that);case _Disconnected():
return disconnected(_that);case _Error():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Connecting value)?  connecting,TResult? Function( _Connected value)?  connected,TResult? Function( _Disconnected value)?  disconnected,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Connecting() when connecting != null:
return connecting(_that);case _Connected() when connected != null:
return connected(_that);case _Disconnected() when disconnected != null:
return disconnected(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  connecting,TResult Function( WalletModel wallet)?  connected,TResult Function()?  disconnected,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Connecting() when connecting != null:
return connecting();case _Connected() when connected != null:
return connected(_that.wallet);case _Disconnected() when disconnected != null:
return disconnected();case _Error() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  connecting,required TResult Function( WalletModel wallet)  connected,required TResult Function()  disconnected,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Connecting():
return connecting();case _Connected():
return connected(_that.wallet);case _Disconnected():
return disconnected();case _Error():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  connecting,TResult? Function( WalletModel wallet)?  connected,TResult? Function()?  disconnected,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Connecting() when connecting != null:
return connecting();case _Connected() when connected != null:
return connected(_that.wallet);case _Disconnected() when disconnected != null:
return disconnected();case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements WalletState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WalletState.initial()';
}


}




/// @nodoc


class _Connecting implements WalletState {
  const _Connecting();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Connecting);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WalletState.connecting()';
}


}




/// @nodoc


class _Connected implements WalletState {
  const _Connected(this.wallet);
  

 final  WalletModel wallet;

/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConnectedCopyWith<_Connected> get copyWith => __$ConnectedCopyWithImpl<_Connected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Connected&&(identical(other.wallet, wallet) || other.wallet == wallet));
}


@override
int get hashCode => Object.hash(runtimeType,wallet);

@override
String toString() {
  return 'WalletState.connected(wallet: $wallet)';
}


}

/// @nodoc
abstract mixin class _$ConnectedCopyWith<$Res> implements $WalletStateCopyWith<$Res> {
  factory _$ConnectedCopyWith(_Connected value, $Res Function(_Connected) _then) = __$ConnectedCopyWithImpl;
@useResult
$Res call({
 WalletModel wallet
});


$WalletModelCopyWith<$Res> get wallet;

}
/// @nodoc
class __$ConnectedCopyWithImpl<$Res>
    implements _$ConnectedCopyWith<$Res> {
  __$ConnectedCopyWithImpl(this._self, this._then);

  final _Connected _self;
  final $Res Function(_Connected) _then;

/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? wallet = null,}) {
  return _then(_Connected(
null == wallet ? _self.wallet : wallet // ignore: cast_nullable_to_non_nullable
as WalletModel,
  ));
}

/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WalletModelCopyWith<$Res> get wallet {
  
  return $WalletModelCopyWith<$Res>(_self.wallet, (value) {
    return _then(_self.copyWith(wallet: value));
  });
}
}

/// @nodoc


class _Disconnected implements WalletState {
  const _Disconnected();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Disconnected);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WalletState.disconnected()';
}


}




/// @nodoc


class _Error implements WalletState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'WalletState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $WalletStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
