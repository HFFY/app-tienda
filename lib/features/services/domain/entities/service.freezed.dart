// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Service {

 int get id; int? get categoryId; String get name; String? get description; double get price; String? get imagePath; int get durationMinutes; bool get isActive; DateTime get createdAt; DateTime get updatedAt; String? get categoryName; String? get categoryColorHex; int? get categoryIconCode;
/// Create a copy of Service
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceCopyWith<Service> get copyWith => _$ServiceCopyWithImpl<Service>(this as Service, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Service;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Service&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.categoryId, _this.categoryId) || other.categoryId == _this.categoryId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.price, _this.price) || other.price == _this.price)&&(identical(other.imagePath, _this.imagePath) || other.imagePath == _this.imagePath)&&(identical(other.durationMinutes, _this.durationMinutes) || other.durationMinutes == _this.durationMinutes)&&(identical(other.isActive, _this.isActive) || other.isActive == _this.isActive)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.categoryName, _this.categoryName) || other.categoryName == _this.categoryName)&&(identical(other.categoryColorHex, _this.categoryColorHex) || other.categoryColorHex == _this.categoryColorHex)&&(identical(other.categoryIconCode, _this.categoryIconCode) || other.categoryIconCode == _this.categoryIconCode));
}


@override
int get hashCode {
  final _this = this as Service;
  return Object.hash(runtimeType,_this.id,_this.categoryId,_this.name,_this.description,_this.price,_this.imagePath,_this.durationMinutes,_this.isActive,_this.createdAt,_this.updatedAt,_this.categoryName,_this.categoryColorHex,_this.categoryIconCode);
}

@override
String toString() {
  final _this = this as Service;
  return 'Service(id: ${_this.id}, categoryId: ${_this.categoryId}, name: ${_this.name}, description: ${_this.description}, price: ${_this.price}, imagePath: ${_this.imagePath}, durationMinutes: ${_this.durationMinutes}, isActive: ${_this.isActive}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, categoryName: ${_this.categoryName}, categoryColorHex: ${_this.categoryColorHex}, categoryIconCode: ${_this.categoryIconCode})';
}


}

/// @nodoc
abstract mixin class $ServiceCopyWith<$Res>  {
  factory $ServiceCopyWith(Service value, $Res Function(Service) _then) = _$ServiceCopyWithImpl;
@useResult
$Res call({
 int id, int? categoryId, String name, String? description, double price, String? imagePath, int durationMinutes, bool isActive, DateTime createdAt, DateTime updatedAt, String? categoryName, String? categoryColorHex, int? categoryIconCode
});




}
/// @nodoc
class _$ServiceCopyWithImpl<$Res>
    implements $ServiceCopyWith<$Res> {
  _$ServiceCopyWithImpl(this._self, this._then);

  final Service _self;
  final $Res Function(Service) _then;

/// Create a copy of Service
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? categoryId = freezed,Object? name = null,Object? description = freezed,Object? price = null,Object? imagePath = freezed,Object? durationMinutes = null,Object? isActive = null,Object? createdAt = null,Object? updatedAt = null,Object? categoryName = freezed,Object? categoryColorHex = freezed,Object? categoryIconCode = freezed,}) {
  return _then(Service(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,categoryColorHex: freezed == categoryColorHex ? _self.categoryColorHex : categoryColorHex // ignore: cast_nullable_to_non_nullable
as String?,categoryIconCode: freezed == categoryIconCode ? _self.categoryIconCode : categoryIconCode // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [Service].
extension ServicePatterns on Service {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Service value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Service() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Service value)  $default,){
final _that = this;
switch (_that) {
case _Service():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Service value)?  $default,){
final _that = this;
switch (_that) {
case _Service() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int? categoryId,  String name,  String? description,  double price,  String? imagePath,  int durationMinutes,  bool isActive,  DateTime createdAt,  DateTime updatedAt,  String? categoryName,  String? categoryColorHex,  int? categoryIconCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Service() when $default != null:
return $default(_that.id,_that.categoryId,_that.name,_that.description,_that.price,_that.imagePath,_that.durationMinutes,_that.isActive,_that.createdAt,_that.updatedAt,_that.categoryName,_that.categoryColorHex,_that.categoryIconCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int? categoryId,  String name,  String? description,  double price,  String? imagePath,  int durationMinutes,  bool isActive,  DateTime createdAt,  DateTime updatedAt,  String? categoryName,  String? categoryColorHex,  int? categoryIconCode)  $default,) {final _that = this;
switch (_that) {
case _Service():
return $default(_that.id,_that.categoryId,_that.name,_that.description,_that.price,_that.imagePath,_that.durationMinutes,_that.isActive,_that.createdAt,_that.updatedAt,_that.categoryName,_that.categoryColorHex,_that.categoryIconCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int? categoryId,  String name,  String? description,  double price,  String? imagePath,  int durationMinutes,  bool isActive,  DateTime createdAt,  DateTime updatedAt,  String? categoryName,  String? categoryColorHex,  int? categoryIconCode)?  $default,) {final _that = this;
switch (_that) {
case _Service() when $default != null:
return $default(_that.id,_that.categoryId,_that.name,_that.description,_that.price,_that.imagePath,_that.durationMinutes,_that.isActive,_that.createdAt,_that.updatedAt,_that.categoryName,_that.categoryColorHex,_that.categoryIconCode);case _:
  return null;

}
}

}

/// @nodoc


class _Service extends Service {
  const _Service({required this.id, this.categoryId, required this.name, this.description, required this.price, this.imagePath, this.durationMinutes = 30, this.isActive = true, required this.createdAt, required this.updatedAt, this.categoryName, this.categoryColorHex, this.categoryIconCode}): super._();
  

@override final  int id;
@override final  int? categoryId;
@override final  String name;
@override final  String? description;
@override final  double price;
@override final  String? imagePath;
@override@JsonKey() final  int durationMinutes;
@override@JsonKey() final  bool isActive;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  String? categoryName;
@override final  String? categoryColorHex;
@override final  int? categoryIconCode;

/// Create a copy of Service
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceCopyWith<_Service> get copyWith => __$ServiceCopyWithImpl<_Service>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Service&&(identical(other.id, id) || other.id == id)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.categoryColorHex, categoryColorHex) || other.categoryColorHex == categoryColorHex)&&(identical(other.categoryIconCode, categoryIconCode) || other.categoryIconCode == categoryIconCode));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,categoryId,name,description,price,imagePath,durationMinutes,isActive,createdAt,updatedAt,categoryName,categoryColorHex,categoryIconCode);
}

@override
String toString() {
    return 'Service(id: $id, categoryId: $categoryId, name: $name, description: $description, price: $price, imagePath: $imagePath, durationMinutes: $durationMinutes, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, categoryName: $categoryName, categoryColorHex: $categoryColorHex, categoryIconCode: $categoryIconCode)';
}


}

/// @nodoc
abstract mixin class _$ServiceCopyWith<$Res> implements $ServiceCopyWith<$Res> {
  factory _$ServiceCopyWith(_Service value, $Res Function(_Service) _then) = __$ServiceCopyWithImpl;
@override @useResult
$Res call({
 int id, int? categoryId, String name, String? description, double price, String? imagePath, int durationMinutes, bool isActive, DateTime createdAt, DateTime updatedAt, String? categoryName, String? categoryColorHex, int? categoryIconCode
});




}
/// @nodoc
class __$ServiceCopyWithImpl<$Res>
    implements _$ServiceCopyWith<$Res> {
  __$ServiceCopyWithImpl(this._self, this._then);

  final _Service _self;
  final $Res Function(_Service) _then;

/// Create a copy of Service
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? categoryId = freezed,Object? name = null,Object? description = freezed,Object? price = null,Object? imagePath = freezed,Object? durationMinutes = null,Object? isActive = null,Object? createdAt = null,Object? updatedAt = null,Object? categoryName = freezed,Object? categoryColorHex = freezed,Object? categoryIconCode = freezed,}) {
  return _then(_Service(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,categoryColorHex: freezed == categoryColorHex ? _self.categoryColorHex : categoryColorHex // ignore: cast_nullable_to_non_nullable
as String?,categoryIconCode: freezed == categoryIconCode ? _self.categoryIconCode : categoryIconCode // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
