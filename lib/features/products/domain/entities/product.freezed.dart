// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Product {

 int get id; int? get categoryId; String get name; String? get description; double get price; String? get imagePath; int get stock; int get minStock; bool get isActive; DateTime get createdAt; DateTime get updatedAt; String? get categoryName; String? get categoryColorHex; int? get categoryIconCode;
/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductCopyWith<Product> get copyWith => _$ProductCopyWithImpl<Product>(this as Product, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Product;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Product&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.categoryId, _this.categoryId) || other.categoryId == _this.categoryId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.price, _this.price) || other.price == _this.price)&&(identical(other.imagePath, _this.imagePath) || other.imagePath == _this.imagePath)&&(identical(other.stock, _this.stock) || other.stock == _this.stock)&&(identical(other.minStock, _this.minStock) || other.minStock == _this.minStock)&&(identical(other.isActive, _this.isActive) || other.isActive == _this.isActive)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.categoryName, _this.categoryName) || other.categoryName == _this.categoryName)&&(identical(other.categoryColorHex, _this.categoryColorHex) || other.categoryColorHex == _this.categoryColorHex)&&(identical(other.categoryIconCode, _this.categoryIconCode) || other.categoryIconCode == _this.categoryIconCode));
}


@override
int get hashCode {
  final _this = this as Product;
  return Object.hash(runtimeType,_this.id,_this.categoryId,_this.name,_this.description,_this.price,_this.imagePath,_this.stock,_this.minStock,_this.isActive,_this.createdAt,_this.updatedAt,_this.categoryName,_this.categoryColorHex,_this.categoryIconCode);
}

@override
String toString() {
  final _this = this as Product;
  return 'Product(id: ${_this.id}, categoryId: ${_this.categoryId}, name: ${_this.name}, description: ${_this.description}, price: ${_this.price}, imagePath: ${_this.imagePath}, stock: ${_this.stock}, minStock: ${_this.minStock}, isActive: ${_this.isActive}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, categoryName: ${_this.categoryName}, categoryColorHex: ${_this.categoryColorHex}, categoryIconCode: ${_this.categoryIconCode})';
}


}

/// @nodoc
abstract mixin class $ProductCopyWith<$Res>  {
  factory $ProductCopyWith(Product value, $Res Function(Product) _then) = _$ProductCopyWithImpl;
@useResult
$Res call({
 int id, int? categoryId, String name, String? description, double price, String? imagePath, int stock, int minStock, bool isActive, DateTime createdAt, DateTime updatedAt, String? categoryName, String? categoryColorHex, int? categoryIconCode
});




}
/// @nodoc
class _$ProductCopyWithImpl<$Res>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._self, this._then);

  final Product _self;
  final $Res Function(Product) _then;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? categoryId = freezed,Object? name = null,Object? description = freezed,Object? price = null,Object? imagePath = freezed,Object? stock = null,Object? minStock = null,Object? isActive = null,Object? createdAt = null,Object? updatedAt = null,Object? categoryName = freezed,Object? categoryColorHex = freezed,Object? categoryIconCode = freezed,}) {
  return _then(Product(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,stock: null == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int,minStock: null == minStock ? _self.minStock : minStock // ignore: cast_nullable_to_non_nullable
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


/// Adds pattern-matching-related methods to [Product].
extension ProductPatterns on Product {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Product value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Product() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Product value)  $default,){
final _that = this;
switch (_that) {
case _Product():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Product value)?  $default,){
final _that = this;
switch (_that) {
case _Product() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int? categoryId,  String name,  String? description,  double price,  String? imagePath,  int stock,  int minStock,  bool isActive,  DateTime createdAt,  DateTime updatedAt,  String? categoryName,  String? categoryColorHex,  int? categoryIconCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that.id,_that.categoryId,_that.name,_that.description,_that.price,_that.imagePath,_that.stock,_that.minStock,_that.isActive,_that.createdAt,_that.updatedAt,_that.categoryName,_that.categoryColorHex,_that.categoryIconCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int? categoryId,  String name,  String? description,  double price,  String? imagePath,  int stock,  int minStock,  bool isActive,  DateTime createdAt,  DateTime updatedAt,  String? categoryName,  String? categoryColorHex,  int? categoryIconCode)  $default,) {final _that = this;
switch (_that) {
case _Product():
return $default(_that.id,_that.categoryId,_that.name,_that.description,_that.price,_that.imagePath,_that.stock,_that.minStock,_that.isActive,_that.createdAt,_that.updatedAt,_that.categoryName,_that.categoryColorHex,_that.categoryIconCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int? categoryId,  String name,  String? description,  double price,  String? imagePath,  int stock,  int minStock,  bool isActive,  DateTime createdAt,  DateTime updatedAt,  String? categoryName,  String? categoryColorHex,  int? categoryIconCode)?  $default,) {final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that.id,_that.categoryId,_that.name,_that.description,_that.price,_that.imagePath,_that.stock,_that.minStock,_that.isActive,_that.createdAt,_that.updatedAt,_that.categoryName,_that.categoryColorHex,_that.categoryIconCode);case _:
  return null;

}
}

}

/// @nodoc


class _Product extends Product {
  const _Product({required this.id, this.categoryId, required this.name, this.description, required this.price, this.imagePath, this.stock = 0, this.minStock = 0, this.isActive = true, required this.createdAt, required this.updatedAt, this.categoryName, this.categoryColorHex, this.categoryIconCode}): super._();
  

@override final  int id;
@override final  int? categoryId;
@override final  String name;
@override final  String? description;
@override final  double price;
@override final  String? imagePath;
@override@JsonKey() final  int stock;
@override@JsonKey() final  int minStock;
@override@JsonKey() final  bool isActive;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  String? categoryName;
@override final  String? categoryColorHex;
@override final  int? categoryIconCode;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductCopyWith<_Product> get copyWith => __$ProductCopyWithImpl<_Product>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Product&&(identical(other.id, id) || other.id == id)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.minStock, minStock) || other.minStock == minStock)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.categoryColorHex, categoryColorHex) || other.categoryColorHex == categoryColorHex)&&(identical(other.categoryIconCode, categoryIconCode) || other.categoryIconCode == categoryIconCode));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,categoryId,name,description,price,imagePath,stock,minStock,isActive,createdAt,updatedAt,categoryName,categoryColorHex,categoryIconCode);
}

@override
String toString() {
    return 'Product(id: $id, categoryId: $categoryId, name: $name, description: $description, price: $price, imagePath: $imagePath, stock: $stock, minStock: $minStock, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, categoryName: $categoryName, categoryColorHex: $categoryColorHex, categoryIconCode: $categoryIconCode)';
}


}

/// @nodoc
abstract mixin class _$ProductCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$ProductCopyWith(_Product value, $Res Function(_Product) _then) = __$ProductCopyWithImpl;
@override @useResult
$Res call({
 int id, int? categoryId, String name, String? description, double price, String? imagePath, int stock, int minStock, bool isActive, DateTime createdAt, DateTime updatedAt, String? categoryName, String? categoryColorHex, int? categoryIconCode
});




}
/// @nodoc
class __$ProductCopyWithImpl<$Res>
    implements _$ProductCopyWith<$Res> {
  __$ProductCopyWithImpl(this._self, this._then);

  final _Product _self;
  final $Res Function(_Product) _then;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? categoryId = freezed,Object? name = null,Object? description = freezed,Object? price = null,Object? imagePath = freezed,Object? stock = null,Object? minStock = null,Object? isActive = null,Object? createdAt = null,Object? updatedAt = null,Object? categoryName = freezed,Object? categoryColorHex = freezed,Object? categoryIconCode = freezed,}) {
  return _then(_Product(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,stock: null == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int,minStock: null == minStock ? _self.minStock : minStock // ignore: cast_nullable_to_non_nullable
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
