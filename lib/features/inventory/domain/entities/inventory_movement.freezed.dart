// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_movement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InventoryMovement {

 int get id; int get productId; MovementType get type; int get quantity; MovementReason get reason; int? get saleId; String? get note; DateTime get movedAt; DateTime get createdAt;
/// Create a copy of InventoryMovement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InventoryMovementCopyWith<InventoryMovement> get copyWith => _$InventoryMovementCopyWithImpl<InventoryMovement>(this as InventoryMovement, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as InventoryMovement;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InventoryMovement&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.productId, _this.productId) || other.productId == _this.productId)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.quantity, _this.quantity) || other.quantity == _this.quantity)&&(identical(other.reason, _this.reason) || other.reason == _this.reason)&&(identical(other.saleId, _this.saleId) || other.saleId == _this.saleId)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.movedAt, _this.movedAt) || other.movedAt == _this.movedAt)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}


@override
int get hashCode {
  final _this = this as InventoryMovement;
  return Object.hash(runtimeType,_this.id,_this.productId,_this.type,_this.quantity,_this.reason,_this.saleId,_this.note,_this.movedAt,_this.createdAt);
}

@override
String toString() {
  final _this = this as InventoryMovement;
  return 'InventoryMovement(id: ${_this.id}, productId: ${_this.productId}, type: ${_this.type}, quantity: ${_this.quantity}, reason: ${_this.reason}, saleId: ${_this.saleId}, note: ${_this.note}, movedAt: ${_this.movedAt}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $InventoryMovementCopyWith<$Res>  {
  factory $InventoryMovementCopyWith(InventoryMovement value, $Res Function(InventoryMovement) _then) = _$InventoryMovementCopyWithImpl;
@useResult
$Res call({
 int id, int productId, MovementType type, int quantity, MovementReason reason, int? saleId, String? note, DateTime movedAt, DateTime createdAt
});




}
/// @nodoc
class _$InventoryMovementCopyWithImpl<$Res>
    implements $InventoryMovementCopyWith<$Res> {
  _$InventoryMovementCopyWithImpl(this._self, this._then);

  final InventoryMovement _self;
  final $Res Function(InventoryMovement) _then;

/// Create a copy of InventoryMovement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? productId = null,Object? type = null,Object? quantity = null,Object? reason = null,Object? saleId = freezed,Object? note = freezed,Object? movedAt = null,Object? createdAt = null,}) {
  return _then(InventoryMovement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MovementType,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as MovementReason,saleId: freezed == saleId ? _self.saleId : saleId // ignore: cast_nullable_to_non_nullable
as int?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,movedAt: null == movedAt ? _self.movedAt : movedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [InventoryMovement].
extension InventoryMovementPatterns on InventoryMovement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InventoryMovement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InventoryMovement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InventoryMovement value)  $default,){
final _that = this;
switch (_that) {
case _InventoryMovement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InventoryMovement value)?  $default,){
final _that = this;
switch (_that) {
case _InventoryMovement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int productId,  MovementType type,  int quantity,  MovementReason reason,  int? saleId,  String? note,  DateTime movedAt,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InventoryMovement() when $default != null:
return $default(_that.id,_that.productId,_that.type,_that.quantity,_that.reason,_that.saleId,_that.note,_that.movedAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int productId,  MovementType type,  int quantity,  MovementReason reason,  int? saleId,  String? note,  DateTime movedAt,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _InventoryMovement():
return $default(_that.id,_that.productId,_that.type,_that.quantity,_that.reason,_that.saleId,_that.note,_that.movedAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int productId,  MovementType type,  int quantity,  MovementReason reason,  int? saleId,  String? note,  DateTime movedAt,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _InventoryMovement() when $default != null:
return $default(_that.id,_that.productId,_that.type,_that.quantity,_that.reason,_that.saleId,_that.note,_that.movedAt,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _InventoryMovement extends InventoryMovement {
  const _InventoryMovement({required this.id, required this.productId, required this.type, required this.quantity, required this.reason, this.saleId, this.note, required this.movedAt, required this.createdAt}): super._();
  

@override final  int id;
@override final  int productId;
@override final  MovementType type;
@override final  int quantity;
@override final  MovementReason reason;
@override final  int? saleId;
@override final  String? note;
@override final  DateTime movedAt;
@override final  DateTime createdAt;

/// Create a copy of InventoryMovement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InventoryMovementCopyWith<_InventoryMovement> get copyWith => __$InventoryMovementCopyWithImpl<_InventoryMovement>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _InventoryMovement&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.type, type) || other.type == type)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.saleId, saleId) || other.saleId == saleId)&&(identical(other.note, note) || other.note == note)&&(identical(other.movedAt, movedAt) || other.movedAt == movedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,productId,type,quantity,reason,saleId,note,movedAt,createdAt);
}

@override
String toString() {
    return 'InventoryMovement(id: $id, productId: $productId, type: $type, quantity: $quantity, reason: $reason, saleId: $saleId, note: $note, movedAt: $movedAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$InventoryMovementCopyWith<$Res> implements $InventoryMovementCopyWith<$Res> {
  factory _$InventoryMovementCopyWith(_InventoryMovement value, $Res Function(_InventoryMovement) _then) = __$InventoryMovementCopyWithImpl;
@override @useResult
$Res call({
 int id, int productId, MovementType type, int quantity, MovementReason reason, int? saleId, String? note, DateTime movedAt, DateTime createdAt
});




}
/// @nodoc
class __$InventoryMovementCopyWithImpl<$Res>
    implements _$InventoryMovementCopyWith<$Res> {
  __$InventoryMovementCopyWithImpl(this._self, this._then);

  final _InventoryMovement _self;
  final $Res Function(_InventoryMovement) _then;

/// Create a copy of InventoryMovement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? productId = null,Object? type = null,Object? quantity = null,Object? reason = null,Object? saleId = freezed,Object? note = freezed,Object? movedAt = null,Object? createdAt = null,}) {
  return _then(_InventoryMovement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MovementType,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as MovementReason,saleId: freezed == saleId ? _self.saleId : saleId // ignore: cast_nullable_to_non_nullable
as int?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,movedAt: null == movedAt ? _self.movedAt : movedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
mixin _$NewMovement {

 int get productId; MovementType get type; int get delta; MovementReason get reason; int? get saleId; String? get note; DateTime? get movedAt;
/// Create a copy of NewMovement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewMovementCopyWith<NewMovement> get copyWith => _$NewMovementCopyWithImpl<NewMovement>(this as NewMovement, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as NewMovement;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewMovement&&(identical(other.productId, _this.productId) || other.productId == _this.productId)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.delta, _this.delta) || other.delta == _this.delta)&&(identical(other.reason, _this.reason) || other.reason == _this.reason)&&(identical(other.saleId, _this.saleId) || other.saleId == _this.saleId)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.movedAt, _this.movedAt) || other.movedAt == _this.movedAt));
}


@override
int get hashCode {
  final _this = this as NewMovement;
  return Object.hash(runtimeType,_this.productId,_this.type,_this.delta,_this.reason,_this.saleId,_this.note,_this.movedAt);
}

@override
String toString() {
  final _this = this as NewMovement;
  return 'NewMovement(productId: ${_this.productId}, type: ${_this.type}, delta: ${_this.delta}, reason: ${_this.reason}, saleId: ${_this.saleId}, note: ${_this.note}, movedAt: ${_this.movedAt})';
}


}

/// @nodoc
abstract mixin class $NewMovementCopyWith<$Res>  {
  factory $NewMovementCopyWith(NewMovement value, $Res Function(NewMovement) _then) = _$NewMovementCopyWithImpl;
@useResult
$Res call({
 int productId, MovementType type, int delta, MovementReason reason, int? saleId, String? note, DateTime? movedAt
});




}
/// @nodoc
class _$NewMovementCopyWithImpl<$Res>
    implements $NewMovementCopyWith<$Res> {
  _$NewMovementCopyWithImpl(this._self, this._then);

  final NewMovement _self;
  final $Res Function(NewMovement) _then;

/// Create a copy of NewMovement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productId = null,Object? type = null,Object? delta = null,Object? reason = null,Object? saleId = freezed,Object? note = freezed,Object? movedAt = freezed,}) {
  return _then(NewMovement(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MovementType,delta: null == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as int,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as MovementReason,saleId: freezed == saleId ? _self.saleId : saleId // ignore: cast_nullable_to_non_nullable
as int?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,movedAt: freezed == movedAt ? _self.movedAt : movedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [NewMovement].
extension NewMovementPatterns on NewMovement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NewMovement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NewMovement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NewMovement value)  $default,){
final _that = this;
switch (_that) {
case _NewMovement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NewMovement value)?  $default,){
final _that = this;
switch (_that) {
case _NewMovement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int productId,  MovementType type,  int delta,  MovementReason reason,  int? saleId,  String? note,  DateTime? movedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NewMovement() when $default != null:
return $default(_that.productId,_that.type,_that.delta,_that.reason,_that.saleId,_that.note,_that.movedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int productId,  MovementType type,  int delta,  MovementReason reason,  int? saleId,  String? note,  DateTime? movedAt)  $default,) {final _that = this;
switch (_that) {
case _NewMovement():
return $default(_that.productId,_that.type,_that.delta,_that.reason,_that.saleId,_that.note,_that.movedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int productId,  MovementType type,  int delta,  MovementReason reason,  int? saleId,  String? note,  DateTime? movedAt)?  $default,) {final _that = this;
switch (_that) {
case _NewMovement() when $default != null:
return $default(_that.productId,_that.type,_that.delta,_that.reason,_that.saleId,_that.note,_that.movedAt);case _:
  return null;

}
}

}

/// @nodoc


class _NewMovement implements NewMovement {
  const _NewMovement({required this.productId, required this.type, required this.delta, required this.reason, this.saleId, this.note, this.movedAt});
  

@override final  int productId;
@override final  MovementType type;
@override final  int delta;
@override final  MovementReason reason;
@override final  int? saleId;
@override final  String? note;
@override final  DateTime? movedAt;

/// Create a copy of NewMovement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewMovementCopyWith<_NewMovement> get copyWith => __$NewMovementCopyWithImpl<_NewMovement>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewMovement&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.type, type) || other.type == type)&&(identical(other.delta, delta) || other.delta == delta)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.saleId, saleId) || other.saleId == saleId)&&(identical(other.note, note) || other.note == note)&&(identical(other.movedAt, movedAt) || other.movedAt == movedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,productId,type,delta,reason,saleId,note,movedAt);
}

@override
String toString() {
    return 'NewMovement(productId: $productId, type: $type, delta: $delta, reason: $reason, saleId: $saleId, note: $note, movedAt: $movedAt)';
}


}

/// @nodoc
abstract mixin class _$NewMovementCopyWith<$Res> implements $NewMovementCopyWith<$Res> {
  factory _$NewMovementCopyWith(_NewMovement value, $Res Function(_NewMovement) _then) = __$NewMovementCopyWithImpl;
@override @useResult
$Res call({
 int productId, MovementType type, int delta, MovementReason reason, int? saleId, String? note, DateTime? movedAt
});




}
/// @nodoc
class __$NewMovementCopyWithImpl<$Res>
    implements _$NewMovementCopyWith<$Res> {
  __$NewMovementCopyWithImpl(this._self, this._then);

  final _NewMovement _self;
  final $Res Function(_NewMovement) _then;

/// Create a copy of NewMovement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productId = null,Object? type = null,Object? delta = null,Object? reason = null,Object? saleId = freezed,Object? note = freezed,Object? movedAt = freezed,}) {
  return _then(_NewMovement(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MovementType,delta: null == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as int,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as MovementReason,saleId: freezed == saleId ? _self.saleId : saleId // ignore: cast_nullable_to_non_nullable
as int?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,movedAt: freezed == movedAt ? _self.movedAt : movedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
