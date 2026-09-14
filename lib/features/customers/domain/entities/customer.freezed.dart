// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Customer {

 int get id; String get firstName; String get lastName; String? get phone; String? get notes; Gender get gender; bool get isActive; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of Customer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerCopyWith<Customer> get copyWith => _$CustomerCopyWithImpl<Customer>(this as Customer, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Customer;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Customer&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.firstName, _this.firstName) || other.firstName == _this.firstName)&&(identical(other.lastName, _this.lastName) || other.lastName == _this.lastName)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.notes, _this.notes) || other.notes == _this.notes)&&(identical(other.gender, _this.gender) || other.gender == _this.gender)&&(identical(other.isActive, _this.isActive) || other.isActive == _this.isActive)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}


@override
int get hashCode {
  final _this = this as Customer;
  return Object.hash(runtimeType,_this.id,_this.firstName,_this.lastName,_this.phone,_this.notes,_this.gender,_this.isActive,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as Customer;
  return 'Customer(id: ${_this.id}, firstName: ${_this.firstName}, lastName: ${_this.lastName}, phone: ${_this.phone}, notes: ${_this.notes}, gender: ${_this.gender}, isActive: ${_this.isActive}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $CustomerCopyWith<$Res>  {
  factory $CustomerCopyWith(Customer value, $Res Function(Customer) _then) = _$CustomerCopyWithImpl;
@useResult
$Res call({
 int id, String firstName, String lastName, String? phone, String? notes, Gender gender, bool isActive, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$CustomerCopyWithImpl<$Res>
    implements $CustomerCopyWith<$Res> {
  _$CustomerCopyWithImpl(this._self, this._then);

  final Customer _self;
  final $Res Function(Customer) _then;

/// Create a copy of Customer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? firstName = null,Object? lastName = null,Object? phone = freezed,Object? notes = freezed,Object? gender = null,Object? isActive = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(Customer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as Gender,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Customer].
extension CustomerPatterns on Customer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Customer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Customer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Customer value)  $default,){
final _that = this;
switch (_that) {
case _Customer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Customer value)?  $default,){
final _that = this;
switch (_that) {
case _Customer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String firstName,  String lastName,  String? phone,  String? notes,  Gender gender,  bool isActive,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Customer() when $default != null:
return $default(_that.id,_that.firstName,_that.lastName,_that.phone,_that.notes,_that.gender,_that.isActive,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String firstName,  String lastName,  String? phone,  String? notes,  Gender gender,  bool isActive,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Customer():
return $default(_that.id,_that.firstName,_that.lastName,_that.phone,_that.notes,_that.gender,_that.isActive,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String firstName,  String lastName,  String? phone,  String? notes,  Gender gender,  bool isActive,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Customer() when $default != null:
return $default(_that.id,_that.firstName,_that.lastName,_that.phone,_that.notes,_that.gender,_that.isActive,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _Customer extends Customer {
  const _Customer({required this.id, required this.firstName, required this.lastName, this.phone, this.notes, this.gender = Gender.unspecified, this.isActive = true, required this.createdAt, required this.updatedAt}): super._();
  

@override final  int id;
@override final  String firstName;
@override final  String lastName;
@override final  String? phone;
@override final  String? notes;
@override@JsonKey() final  Gender gender;
@override@JsonKey() final  bool isActive;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of Customer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerCopyWith<_Customer> get copyWith => __$CustomerCopyWithImpl<_Customer>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Customer&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,firstName,lastName,phone,notes,gender,isActive,createdAt,updatedAt);
}

@override
String toString() {
    return 'Customer(id: $id, firstName: $firstName, lastName: $lastName, phone: $phone, notes: $notes, gender: $gender, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$CustomerCopyWith<$Res> implements $CustomerCopyWith<$Res> {
  factory _$CustomerCopyWith(_Customer value, $Res Function(_Customer) _then) = __$CustomerCopyWithImpl;
@override @useResult
$Res call({
 int id, String firstName, String lastName, String? phone, String? notes, Gender gender, bool isActive, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$CustomerCopyWithImpl<$Res>
    implements _$CustomerCopyWith<$Res> {
  __$CustomerCopyWithImpl(this._self, this._then);

  final _Customer _self;
  final $Res Function(_Customer) _then;

/// Create a copy of Customer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? firstName = null,Object? lastName = null,Object? phone = freezed,Object? notes = freezed,Object? gender = null,Object? isActive = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Customer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as Gender,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
mixin _$CustomerStats {

 int get salesCount; double get totalSpent; DateTime? get lastPurchaseAt;
/// Create a copy of CustomerStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerStatsCopyWith<CustomerStats> get copyWith => _$CustomerStatsCopyWithImpl<CustomerStats>(this as CustomerStats, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CustomerStats;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerStats&&(identical(other.salesCount, _this.salesCount) || other.salesCount == _this.salesCount)&&(identical(other.totalSpent, _this.totalSpent) || other.totalSpent == _this.totalSpent)&&(identical(other.lastPurchaseAt, _this.lastPurchaseAt) || other.lastPurchaseAt == _this.lastPurchaseAt));
}


@override
int get hashCode {
  final _this = this as CustomerStats;
  return Object.hash(runtimeType,_this.salesCount,_this.totalSpent,_this.lastPurchaseAt);
}

@override
String toString() {
  final _this = this as CustomerStats;
  return 'CustomerStats(salesCount: ${_this.salesCount}, totalSpent: ${_this.totalSpent}, lastPurchaseAt: ${_this.lastPurchaseAt})';
}


}

/// @nodoc
abstract mixin class $CustomerStatsCopyWith<$Res>  {
  factory $CustomerStatsCopyWith(CustomerStats value, $Res Function(CustomerStats) _then) = _$CustomerStatsCopyWithImpl;
@useResult
$Res call({
 int salesCount, double totalSpent, DateTime? lastPurchaseAt
});




}
/// @nodoc
class _$CustomerStatsCopyWithImpl<$Res>
    implements $CustomerStatsCopyWith<$Res> {
  _$CustomerStatsCopyWithImpl(this._self, this._then);

  final CustomerStats _self;
  final $Res Function(CustomerStats) _then;

/// Create a copy of CustomerStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? salesCount = null,Object? totalSpent = null,Object? lastPurchaseAt = freezed,}) {
  return _then(CustomerStats(
salesCount: null == salesCount ? _self.salesCount : salesCount // ignore: cast_nullable_to_non_nullable
as int,totalSpent: null == totalSpent ? _self.totalSpent : totalSpent // ignore: cast_nullable_to_non_nullable
as double,lastPurchaseAt: freezed == lastPurchaseAt ? _self.lastPurchaseAt : lastPurchaseAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CustomerStats].
extension CustomerStatsPatterns on CustomerStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomerStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomerStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomerStats value)  $default,){
final _that = this;
switch (_that) {
case _CustomerStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomerStats value)?  $default,){
final _that = this;
switch (_that) {
case _CustomerStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int salesCount,  double totalSpent,  DateTime? lastPurchaseAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomerStats() when $default != null:
return $default(_that.salesCount,_that.totalSpent,_that.lastPurchaseAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int salesCount,  double totalSpent,  DateTime? lastPurchaseAt)  $default,) {final _that = this;
switch (_that) {
case _CustomerStats():
return $default(_that.salesCount,_that.totalSpent,_that.lastPurchaseAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int salesCount,  double totalSpent,  DateTime? lastPurchaseAt)?  $default,) {final _that = this;
switch (_that) {
case _CustomerStats() when $default != null:
return $default(_that.salesCount,_that.totalSpent,_that.lastPurchaseAt);case _:
  return null;

}
}

}

/// @nodoc


class _CustomerStats implements CustomerStats {
  const _CustomerStats({required this.salesCount, required this.totalSpent, this.lastPurchaseAt});
  

@override final  int salesCount;
@override final  double totalSpent;
@override final  DateTime? lastPurchaseAt;

/// Create a copy of CustomerStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerStatsCopyWith<_CustomerStats> get copyWith => __$CustomerStatsCopyWithImpl<_CustomerStats>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomerStats&&(identical(other.salesCount, salesCount) || other.salesCount == salesCount)&&(identical(other.totalSpent, totalSpent) || other.totalSpent == totalSpent)&&(identical(other.lastPurchaseAt, lastPurchaseAt) || other.lastPurchaseAt == lastPurchaseAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,salesCount,totalSpent,lastPurchaseAt);
}

@override
String toString() {
    return 'CustomerStats(salesCount: $salesCount, totalSpent: $totalSpent, lastPurchaseAt: $lastPurchaseAt)';
}


}

/// @nodoc
abstract mixin class _$CustomerStatsCopyWith<$Res> implements $CustomerStatsCopyWith<$Res> {
  factory _$CustomerStatsCopyWith(_CustomerStats value, $Res Function(_CustomerStats) _then) = __$CustomerStatsCopyWithImpl;
@override @useResult
$Res call({
 int salesCount, double totalSpent, DateTime? lastPurchaseAt
});




}
/// @nodoc
class __$CustomerStatsCopyWithImpl<$Res>
    implements _$CustomerStatsCopyWith<$Res> {
  __$CustomerStatsCopyWithImpl(this._self, this._then);

  final _CustomerStats _self;
  final $Res Function(_CustomerStats) _then;

/// Create a copy of CustomerStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? salesCount = null,Object? totalSpent = null,Object? lastPurchaseAt = freezed,}) {
  return _then(_CustomerStats(
salesCount: null == salesCount ? _self.salesCount : salesCount // ignore: cast_nullable_to_non_nullable
as int,totalSpent: null == totalSpent ? _self.totalSpent : totalSpent // ignore: cast_nullable_to_non_nullable
as double,lastPurchaseAt: freezed == lastPurchaseAt ? _self.lastPurchaseAt : lastPurchaseAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
