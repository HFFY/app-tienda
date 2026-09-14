// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Category {

 int get id; String get name; CategoryScope get scope; String? get colorHex; int? get iconCode; int get sortOrder; bool get isActive; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of Category
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryCopyWith<Category> get copyWith => _$CategoryCopyWithImpl<Category>(this as Category, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Category;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Category&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.scope, _this.scope) || other.scope == _this.scope)&&(identical(other.colorHex, _this.colorHex) || other.colorHex == _this.colorHex)&&(identical(other.iconCode, _this.iconCode) || other.iconCode == _this.iconCode)&&(identical(other.sortOrder, _this.sortOrder) || other.sortOrder == _this.sortOrder)&&(identical(other.isActive, _this.isActive) || other.isActive == _this.isActive)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}


@override
int get hashCode {
  final _this = this as Category;
  return Object.hash(runtimeType,_this.id,_this.name,_this.scope,_this.colorHex,_this.iconCode,_this.sortOrder,_this.isActive,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as Category;
  return 'Category(id: ${_this.id}, name: ${_this.name}, scope: ${_this.scope}, colorHex: ${_this.colorHex}, iconCode: ${_this.iconCode}, sortOrder: ${_this.sortOrder}, isActive: ${_this.isActive}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $CategoryCopyWith<$Res>  {
  factory $CategoryCopyWith(Category value, $Res Function(Category) _then) = _$CategoryCopyWithImpl;
@useResult
$Res call({
 int id, String name, CategoryScope scope, String? colorHex, int? iconCode, int sortOrder, bool isActive, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$CategoryCopyWithImpl<$Res>
    implements $CategoryCopyWith<$Res> {
  _$CategoryCopyWithImpl(this._self, this._then);

  final Category _self;
  final $Res Function(Category) _then;

/// Create a copy of Category
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? scope = null,Object? colorHex = freezed,Object? iconCode = freezed,Object? sortOrder = null,Object? isActive = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(Category(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as CategoryScope,colorHex: freezed == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String?,iconCode: freezed == iconCode ? _self.iconCode : iconCode // ignore: cast_nullable_to_non_nullable
as int?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Category].
extension CategoryPatterns on Category {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Category value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Category() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Category value)  $default,){
final _that = this;
switch (_that) {
case _Category():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Category value)?  $default,){
final _that = this;
switch (_that) {
case _Category() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  CategoryScope scope,  String? colorHex,  int? iconCode,  int sortOrder,  bool isActive,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Category() when $default != null:
return $default(_that.id,_that.name,_that.scope,_that.colorHex,_that.iconCode,_that.sortOrder,_that.isActive,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  CategoryScope scope,  String? colorHex,  int? iconCode,  int sortOrder,  bool isActive,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Category():
return $default(_that.id,_that.name,_that.scope,_that.colorHex,_that.iconCode,_that.sortOrder,_that.isActive,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  CategoryScope scope,  String? colorHex,  int? iconCode,  int sortOrder,  bool isActive,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Category() when $default != null:
return $default(_that.id,_that.name,_that.scope,_that.colorHex,_that.iconCode,_that.sortOrder,_that.isActive,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _Category extends Category {
  const _Category({required this.id, required this.name, required this.scope, this.colorHex, this.iconCode, this.sortOrder = 0, this.isActive = true, required this.createdAt, required this.updatedAt}): super._();
  

@override final  int id;
@override final  String name;
@override final  CategoryScope scope;
@override final  String? colorHex;
@override final  int? iconCode;
@override@JsonKey() final  int sortOrder;
@override@JsonKey() final  bool isActive;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of Category
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryCopyWith<_Category> get copyWith => __$CategoryCopyWithImpl<_Category>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Category&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.scope, scope) || other.scope == scope)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.iconCode, iconCode) || other.iconCode == iconCode)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,scope,colorHex,iconCode,sortOrder,isActive,createdAt,updatedAt);
}

@override
String toString() {
    return 'Category(id: $id, name: $name, scope: $scope, colorHex: $colorHex, iconCode: $iconCode, sortOrder: $sortOrder, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$CategoryCopyWith<$Res> implements $CategoryCopyWith<$Res> {
  factory _$CategoryCopyWith(_Category value, $Res Function(_Category) _then) = __$CategoryCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, CategoryScope scope, String? colorHex, int? iconCode, int sortOrder, bool isActive, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$CategoryCopyWithImpl<$Res>
    implements _$CategoryCopyWith<$Res> {
  __$CategoryCopyWithImpl(this._self, this._then);

  final _Category _self;
  final $Res Function(_Category) _then;

/// Create a copy of Category
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? scope = null,Object? colorHex = freezed,Object? iconCode = freezed,Object? sortOrder = null,Object? isActive = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Category(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as CategoryScope,colorHex: freezed == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String?,iconCode: freezed == iconCode ? _self.iconCode : iconCode // ignore: cast_nullable_to_non_nullable
as int?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
mixin _$CategoryUsage {

 Category get category; int get productCount; int get serviceCount;
/// Create a copy of CategoryUsage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryUsageCopyWith<CategoryUsage> get copyWith => _$CategoryUsageCopyWithImpl<CategoryUsage>(this as CategoryUsage, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CategoryUsage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryUsage&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.productCount, _this.productCount) || other.productCount == _this.productCount)&&(identical(other.serviceCount, _this.serviceCount) || other.serviceCount == _this.serviceCount));
}


@override
int get hashCode {
  final _this = this as CategoryUsage;
  return Object.hash(runtimeType,_this.category,_this.productCount,_this.serviceCount);
}

@override
String toString() {
  final _this = this as CategoryUsage;
  return 'CategoryUsage(category: ${_this.category}, productCount: ${_this.productCount}, serviceCount: ${_this.serviceCount})';
}


}

/// @nodoc
abstract mixin class $CategoryUsageCopyWith<$Res>  {
  factory $CategoryUsageCopyWith(CategoryUsage value, $Res Function(CategoryUsage) _then) = _$CategoryUsageCopyWithImpl;
@useResult
$Res call({
 Category category, int productCount, int serviceCount
});


$CategoryCopyWith<$Res> get category;

}
/// @nodoc
class _$CategoryUsageCopyWithImpl<$Res>
    implements $CategoryUsageCopyWith<$Res> {
  _$CategoryUsageCopyWithImpl(this._self, this._then);

  final CategoryUsage _self;
  final $Res Function(CategoryUsage) _then;

/// Create a copy of CategoryUsage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? category = null,Object? productCount = null,Object? serviceCount = null,}) {
  return _then(CategoryUsage(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as Category,productCount: null == productCount ? _self.productCount : productCount // ignore: cast_nullable_to_non_nullable
as int,serviceCount: null == serviceCount ? _self.serviceCount : serviceCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of CategoryUsage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryCopyWith<$Res> get category {
  
  return $CategoryCopyWith<$Res>(_self.category, (value) {
    return _then(_self.copyWith(category: value));
  });
}
}


/// Adds pattern-matching-related methods to [CategoryUsage].
extension CategoryUsagePatterns on CategoryUsage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryUsage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryUsage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryUsage value)  $default,){
final _that = this;
switch (_that) {
case _CategoryUsage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryUsage value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryUsage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Category category,  int productCount,  int serviceCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryUsage() when $default != null:
return $default(_that.category,_that.productCount,_that.serviceCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Category category,  int productCount,  int serviceCount)  $default,) {final _that = this;
switch (_that) {
case _CategoryUsage():
return $default(_that.category,_that.productCount,_that.serviceCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Category category,  int productCount,  int serviceCount)?  $default,) {final _that = this;
switch (_that) {
case _CategoryUsage() when $default != null:
return $default(_that.category,_that.productCount,_that.serviceCount);case _:
  return null;

}
}

}

/// @nodoc


class _CategoryUsage extends CategoryUsage {
  const _CategoryUsage({required this.category, required this.productCount, required this.serviceCount}): super._();
  

@override final  Category category;
@override final  int productCount;
@override final  int serviceCount;

/// Create a copy of CategoryUsage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryUsageCopyWith<_CategoryUsage> get copyWith => __$CategoryUsageCopyWithImpl<_CategoryUsage>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryUsage&&(identical(other.category, category) || other.category == category)&&(identical(other.productCount, productCount) || other.productCount == productCount)&&(identical(other.serviceCount, serviceCount) || other.serviceCount == serviceCount));
}


@override
int get hashCode {
    return Object.hash(runtimeType,category,productCount,serviceCount);
}

@override
String toString() {
    return 'CategoryUsage(category: $category, productCount: $productCount, serviceCount: $serviceCount)';
}


}

/// @nodoc
abstract mixin class _$CategoryUsageCopyWith<$Res> implements $CategoryUsageCopyWith<$Res> {
  factory _$CategoryUsageCopyWith(_CategoryUsage value, $Res Function(_CategoryUsage) _then) = __$CategoryUsageCopyWithImpl;
@override @useResult
$Res call({
 Category category, int productCount, int serviceCount
});


@override $CategoryCopyWith<$Res> get category;

}
/// @nodoc
class __$CategoryUsageCopyWithImpl<$Res>
    implements _$CategoryUsageCopyWith<$Res> {
  __$CategoryUsageCopyWithImpl(this._self, this._then);

  final _CategoryUsage _self;
  final $Res Function(_CategoryUsage) _then;

/// Create a copy of CategoryUsage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? category = null,Object? productCount = null,Object? serviceCount = null,}) {
  return _then(_CategoryUsage(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as Category,productCount: null == productCount ? _self.productCount : productCount // ignore: cast_nullable_to_non_nullable
as int,serviceCount: null == serviceCount ? _self.serviceCount : serviceCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of CategoryUsage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryCopyWith<$Res> get category {
  
  return $CategoryCopyWith<$Res>(_self.category, (value) {
    return _then(_self.copyWith(category: value));
  });
}
}

// dart format on
