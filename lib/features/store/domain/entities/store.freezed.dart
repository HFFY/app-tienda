// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'store.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Store {

 int get id; String get name; String? get logoPath; String? get address; String? get phone; ThemeColorOption get themeColor; ThemeModeOption get themeMode; String get currencySymbol; String get currencyCode; String get numberLocale; int get decimalPlaces; String get whatsappCountryCode; DateTime? get lastBackupAt; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of Store
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoreCopyWith<Store> get copyWith => _$StoreCopyWithImpl<Store>(this as Store, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Store;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Store&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.logoPath, _this.logoPath) || other.logoPath == _this.logoPath)&&(identical(other.address, _this.address) || other.address == _this.address)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.themeColor, _this.themeColor) || other.themeColor == _this.themeColor)&&(identical(other.themeMode, _this.themeMode) || other.themeMode == _this.themeMode)&&(identical(other.currencySymbol, _this.currencySymbol) || other.currencySymbol == _this.currencySymbol)&&(identical(other.currencyCode, _this.currencyCode) || other.currencyCode == _this.currencyCode)&&(identical(other.numberLocale, _this.numberLocale) || other.numberLocale == _this.numberLocale)&&(identical(other.decimalPlaces, _this.decimalPlaces) || other.decimalPlaces == _this.decimalPlaces)&&(identical(other.whatsappCountryCode, _this.whatsappCountryCode) || other.whatsappCountryCode == _this.whatsappCountryCode)&&(identical(other.lastBackupAt, _this.lastBackupAt) || other.lastBackupAt == _this.lastBackupAt)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}


@override
int get hashCode {
  final _this = this as Store;
  return Object.hash(runtimeType,_this.id,_this.name,_this.logoPath,_this.address,_this.phone,_this.themeColor,_this.themeMode,_this.currencySymbol,_this.currencyCode,_this.numberLocale,_this.decimalPlaces,_this.whatsappCountryCode,_this.lastBackupAt,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as Store;
  return 'Store(id: ${_this.id}, name: ${_this.name}, logoPath: ${_this.logoPath}, address: ${_this.address}, phone: ${_this.phone}, themeColor: ${_this.themeColor}, themeMode: ${_this.themeMode}, currencySymbol: ${_this.currencySymbol}, currencyCode: ${_this.currencyCode}, numberLocale: ${_this.numberLocale}, decimalPlaces: ${_this.decimalPlaces}, whatsappCountryCode: ${_this.whatsappCountryCode}, lastBackupAt: ${_this.lastBackupAt}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $StoreCopyWith<$Res>  {
  factory $StoreCopyWith(Store value, $Res Function(Store) _then) = _$StoreCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? logoPath, String? address, String? phone, ThemeColorOption themeColor, ThemeModeOption themeMode, String currencySymbol, String currencyCode, String numberLocale, int decimalPlaces, String whatsappCountryCode, DateTime? lastBackupAt, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$StoreCopyWithImpl<$Res>
    implements $StoreCopyWith<$Res> {
  _$StoreCopyWithImpl(this._self, this._then);

  final Store _self;
  final $Res Function(Store) _then;

/// Create a copy of Store
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? logoPath = freezed,Object? address = freezed,Object? phone = freezed,Object? themeColor = null,Object? themeMode = null,Object? currencySymbol = null,Object? currencyCode = null,Object? numberLocale = null,Object? decimalPlaces = null,Object? whatsappCountryCode = null,Object? lastBackupAt = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(Store(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,logoPath: freezed == logoPath ? _self.logoPath : logoPath // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,themeColor: null == themeColor ? _self.themeColor : themeColor // ignore: cast_nullable_to_non_nullable
as ThemeColorOption,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeModeOption,currencySymbol: null == currencySymbol ? _self.currencySymbol : currencySymbol // ignore: cast_nullable_to_non_nullable
as String,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,numberLocale: null == numberLocale ? _self.numberLocale : numberLocale // ignore: cast_nullable_to_non_nullable
as String,decimalPlaces: null == decimalPlaces ? _self.decimalPlaces : decimalPlaces // ignore: cast_nullable_to_non_nullable
as int,whatsappCountryCode: null == whatsappCountryCode ? _self.whatsappCountryCode : whatsappCountryCode // ignore: cast_nullable_to_non_nullable
as String,lastBackupAt: freezed == lastBackupAt ? _self.lastBackupAt : lastBackupAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Store].
extension StorePatterns on Store {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Store value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Store() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Store value)  $default,){
final _that = this;
switch (_that) {
case _Store():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Store value)?  $default,){
final _that = this;
switch (_that) {
case _Store() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? logoPath,  String? address,  String? phone,  ThemeColorOption themeColor,  ThemeModeOption themeMode,  String currencySymbol,  String currencyCode,  String numberLocale,  int decimalPlaces,  String whatsappCountryCode,  DateTime? lastBackupAt,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Store() when $default != null:
return $default(_that.id,_that.name,_that.logoPath,_that.address,_that.phone,_that.themeColor,_that.themeMode,_that.currencySymbol,_that.currencyCode,_that.numberLocale,_that.decimalPlaces,_that.whatsappCountryCode,_that.lastBackupAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? logoPath,  String? address,  String? phone,  ThemeColorOption themeColor,  ThemeModeOption themeMode,  String currencySymbol,  String currencyCode,  String numberLocale,  int decimalPlaces,  String whatsappCountryCode,  DateTime? lastBackupAt,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Store():
return $default(_that.id,_that.name,_that.logoPath,_that.address,_that.phone,_that.themeColor,_that.themeMode,_that.currencySymbol,_that.currencyCode,_that.numberLocale,_that.decimalPlaces,_that.whatsappCountryCode,_that.lastBackupAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? logoPath,  String? address,  String? phone,  ThemeColorOption themeColor,  ThemeModeOption themeMode,  String currencySymbol,  String currencyCode,  String numberLocale,  int decimalPlaces,  String whatsappCountryCode,  DateTime? lastBackupAt,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Store() when $default != null:
return $default(_that.id,_that.name,_that.logoPath,_that.address,_that.phone,_that.themeColor,_that.themeMode,_that.currencySymbol,_that.currencyCode,_that.numberLocale,_that.decimalPlaces,_that.whatsappCountryCode,_that.lastBackupAt,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _Store extends Store {
  const _Store({required this.id, required this.name, this.logoPath, this.address, this.phone, required this.themeColor, required this.themeMode, required this.currencySymbol, required this.currencyCode, required this.numberLocale, required this.decimalPlaces, required this.whatsappCountryCode, this.lastBackupAt, required this.createdAt, required this.updatedAt}): super._();
  

@override final  int id;
@override final  String name;
@override final  String? logoPath;
@override final  String? address;
@override final  String? phone;
@override final  ThemeColorOption themeColor;
@override final  ThemeModeOption themeMode;
@override final  String currencySymbol;
@override final  String currencyCode;
@override final  String numberLocale;
@override final  int decimalPlaces;
@override final  String whatsappCountryCode;
@override final  DateTime? lastBackupAt;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of Store
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoreCopyWith<_Store> get copyWith => __$StoreCopyWithImpl<_Store>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Store&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.logoPath, logoPath) || other.logoPath == logoPath)&&(identical(other.address, address) || other.address == address)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.themeColor, themeColor) || other.themeColor == themeColor)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.currencySymbol, currencySymbol) || other.currencySymbol == currencySymbol)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.numberLocale, numberLocale) || other.numberLocale == numberLocale)&&(identical(other.decimalPlaces, decimalPlaces) || other.decimalPlaces == decimalPlaces)&&(identical(other.whatsappCountryCode, whatsappCountryCode) || other.whatsappCountryCode == whatsappCountryCode)&&(identical(other.lastBackupAt, lastBackupAt) || other.lastBackupAt == lastBackupAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,logoPath,address,phone,themeColor,themeMode,currencySymbol,currencyCode,numberLocale,decimalPlaces,whatsappCountryCode,lastBackupAt,createdAt,updatedAt);
}

@override
String toString() {
    return 'Store(id: $id, name: $name, logoPath: $logoPath, address: $address, phone: $phone, themeColor: $themeColor, themeMode: $themeMode, currencySymbol: $currencySymbol, currencyCode: $currencyCode, numberLocale: $numberLocale, decimalPlaces: $decimalPlaces, whatsappCountryCode: $whatsappCountryCode, lastBackupAt: $lastBackupAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$StoreCopyWith<$Res> implements $StoreCopyWith<$Res> {
  factory _$StoreCopyWith(_Store value, $Res Function(_Store) _then) = __$StoreCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? logoPath, String? address, String? phone, ThemeColorOption themeColor, ThemeModeOption themeMode, String currencySymbol, String currencyCode, String numberLocale, int decimalPlaces, String whatsappCountryCode, DateTime? lastBackupAt, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$StoreCopyWithImpl<$Res>
    implements _$StoreCopyWith<$Res> {
  __$StoreCopyWithImpl(this._self, this._then);

  final _Store _self;
  final $Res Function(_Store) _then;

/// Create a copy of Store
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? logoPath = freezed,Object? address = freezed,Object? phone = freezed,Object? themeColor = null,Object? themeMode = null,Object? currencySymbol = null,Object? currencyCode = null,Object? numberLocale = null,Object? decimalPlaces = null,Object? whatsappCountryCode = null,Object? lastBackupAt = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Store(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,logoPath: freezed == logoPath ? _self.logoPath : logoPath // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,themeColor: null == themeColor ? _self.themeColor : themeColor // ignore: cast_nullable_to_non_nullable
as ThemeColorOption,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeModeOption,currencySymbol: null == currencySymbol ? _self.currencySymbol : currencySymbol // ignore: cast_nullable_to_non_nullable
as String,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,numberLocale: null == numberLocale ? _self.numberLocale : numberLocale // ignore: cast_nullable_to_non_nullable
as String,decimalPlaces: null == decimalPlaces ? _self.decimalPlaces : decimalPlaces // ignore: cast_nullable_to_non_nullable
as int,whatsappCountryCode: null == whatsappCountryCode ? _self.whatsappCountryCode : whatsappCountryCode // ignore: cast_nullable_to_non_nullable
as String,lastBackupAt: freezed == lastBackupAt ? _self.lastBackupAt : lastBackupAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
