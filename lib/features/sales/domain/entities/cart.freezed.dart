// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CartItem {

 SaleItemType get type; int get refId; String get name; String? get categoryName; double get unitPrice; int get quantity;/// Stock disponible al agregar (solo productos); la verdad la impone la
/// transacción al registrar.
 int? get availableStock;
/// Create a copy of CartItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartItemCopyWith<CartItem> get copyWith => _$CartItemCopyWithImpl<CartItem>(this as CartItem, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CartItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartItem&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.refId, _this.refId) || other.refId == _this.refId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.categoryName, _this.categoryName) || other.categoryName == _this.categoryName)&&(identical(other.unitPrice, _this.unitPrice) || other.unitPrice == _this.unitPrice)&&(identical(other.quantity, _this.quantity) || other.quantity == _this.quantity)&&(identical(other.availableStock, _this.availableStock) || other.availableStock == _this.availableStock));
}


@override
int get hashCode {
  final _this = this as CartItem;
  return Object.hash(runtimeType,_this.type,_this.refId,_this.name,_this.categoryName,_this.unitPrice,_this.quantity,_this.availableStock);
}

@override
String toString() {
  final _this = this as CartItem;
  return 'CartItem(type: ${_this.type}, refId: ${_this.refId}, name: ${_this.name}, categoryName: ${_this.categoryName}, unitPrice: ${_this.unitPrice}, quantity: ${_this.quantity}, availableStock: ${_this.availableStock})';
}


}

/// @nodoc
abstract mixin class $CartItemCopyWith<$Res>  {
  factory $CartItemCopyWith(CartItem value, $Res Function(CartItem) _then) = _$CartItemCopyWithImpl;
@useResult
$Res call({
 SaleItemType type, int refId, String name, String? categoryName, double unitPrice, int quantity, int? availableStock
});




}
/// @nodoc
class _$CartItemCopyWithImpl<$Res>
    implements $CartItemCopyWith<$Res> {
  _$CartItemCopyWithImpl(this._self, this._then);

  final CartItem _self;
  final $Res Function(CartItem) _then;

/// Create a copy of CartItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? refId = null,Object? name = null,Object? categoryName = freezed,Object? unitPrice = null,Object? quantity = null,Object? availableStock = freezed,}) {
  return _then(CartItem(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SaleItemType,refId: null == refId ? _self.refId : refId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,availableStock: freezed == availableStock ? _self.availableStock : availableStock // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CartItem].
extension CartItemPatterns on CartItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CartItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CartItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CartItem value)  $default,){
final _that = this;
switch (_that) {
case _CartItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CartItem value)?  $default,){
final _that = this;
switch (_that) {
case _CartItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SaleItemType type,  int refId,  String name,  String? categoryName,  double unitPrice,  int quantity,  int? availableStock)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CartItem() when $default != null:
return $default(_that.type,_that.refId,_that.name,_that.categoryName,_that.unitPrice,_that.quantity,_that.availableStock);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SaleItemType type,  int refId,  String name,  String? categoryName,  double unitPrice,  int quantity,  int? availableStock)  $default,) {final _that = this;
switch (_that) {
case _CartItem():
return $default(_that.type,_that.refId,_that.name,_that.categoryName,_that.unitPrice,_that.quantity,_that.availableStock);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SaleItemType type,  int refId,  String name,  String? categoryName,  double unitPrice,  int quantity,  int? availableStock)?  $default,) {final _that = this;
switch (_that) {
case _CartItem() when $default != null:
return $default(_that.type,_that.refId,_that.name,_that.categoryName,_that.unitPrice,_that.quantity,_that.availableStock);case _:
  return null;

}
}

}

/// @nodoc


class _CartItem extends CartItem {
  const _CartItem({required this.type, required this.refId, required this.name, this.categoryName, required this.unitPrice, this.quantity = 1, this.availableStock}): super._();
  

@override final  SaleItemType type;
@override final  int refId;
@override final  String name;
@override final  String? categoryName;
@override final  double unitPrice;
@override@JsonKey() final  int quantity;
/// Stock disponible al agregar (solo productos); la verdad la impone la
/// transacción al registrar.
@override final  int? availableStock;

/// Create a copy of CartItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CartItemCopyWith<_CartItem> get copyWith => __$CartItemCopyWithImpl<_CartItem>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CartItem&&(identical(other.type, type) || other.type == type)&&(identical(other.refId, refId) || other.refId == refId)&&(identical(other.name, name) || other.name == name)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.availableStock, availableStock) || other.availableStock == availableStock));
}


@override
int get hashCode {
    return Object.hash(runtimeType,type,refId,name,categoryName,unitPrice,quantity,availableStock);
}

@override
String toString() {
    return 'CartItem(type: $type, refId: $refId, name: $name, categoryName: $categoryName, unitPrice: $unitPrice, quantity: $quantity, availableStock: $availableStock)';
}


}

/// @nodoc
abstract mixin class _$CartItemCopyWith<$Res> implements $CartItemCopyWith<$Res> {
  factory _$CartItemCopyWith(_CartItem value, $Res Function(_CartItem) _then) = __$CartItemCopyWithImpl;
@override @useResult
$Res call({
 SaleItemType type, int refId, String name, String? categoryName, double unitPrice, int quantity, int? availableStock
});




}
/// @nodoc
class __$CartItemCopyWithImpl<$Res>
    implements _$CartItemCopyWith<$Res> {
  __$CartItemCopyWithImpl(this._self, this._then);

  final _CartItem _self;
  final $Res Function(_CartItem) _then;

/// Create a copy of CartItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? refId = null,Object? name = null,Object? categoryName = freezed,Object? unitPrice = null,Object? quantity = null,Object? availableStock = freezed,}) {
  return _then(_CartItem(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SaleItemType,refId: null == refId ? _self.refId : refId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,availableStock: freezed == availableStock ? _self.availableStock : availableStock // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
mixin _$Cart {

 Customer? get customer; List<CartItem> get items; DiscountType get discountType; double get discountValue; String? get note;
/// Create a copy of Cart
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartCopyWith<Cart> get copyWith => _$CartCopyWithImpl<Cart>(this as Cart, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Cart;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Cart&&(identical(other.customer, _this.customer) || other.customer == _this.customer)&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.discountType, _this.discountType) || other.discountType == _this.discountType)&&(identical(other.discountValue, _this.discountValue) || other.discountValue == _this.discountValue)&&(identical(other.note, _this.note) || other.note == _this.note));
}


@override
int get hashCode {
  final _this = this as Cart;
  return Object.hash(runtimeType,_this.customer,const DeepCollectionEquality().hash(_this.items),_this.discountType,_this.discountValue,_this.note);
}

@override
String toString() {
  final _this = this as Cart;
  return 'Cart(customer: ${_this.customer}, items: ${_this.items}, discountType: ${_this.discountType}, discountValue: ${_this.discountValue}, note: ${_this.note})';
}


}

/// @nodoc
abstract mixin class $CartCopyWith<$Res>  {
  factory $CartCopyWith(Cart value, $Res Function(Cart) _then) = _$CartCopyWithImpl;
@useResult
$Res call({
 Customer? customer, List<CartItem> items, DiscountType discountType, double discountValue, String? note
});


$CustomerCopyWith<$Res>? get customer;

}
/// @nodoc
class _$CartCopyWithImpl<$Res>
    implements $CartCopyWith<$Res> {
  _$CartCopyWithImpl(this._self, this._then);

  final Cart _self;
  final $Res Function(Cart) _then;

/// Create a copy of Cart
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? customer = freezed,Object? items = null,Object? discountType = null,Object? discountValue = null,Object? note = freezed,}) {
  return _then(Cart(
customer: freezed == customer ? _self.customer : customer // ignore: cast_nullable_to_non_nullable
as Customer?,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<CartItem>,discountType: null == discountType ? _self.discountType : discountType // ignore: cast_nullable_to_non_nullable
as DiscountType,discountValue: null == discountValue ? _self.discountValue : discountValue // ignore: cast_nullable_to_non_nullable
as double,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of Cart
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CustomerCopyWith<$Res>? get customer {
    if (_self.customer == null) {
    return null;
  }

  return $CustomerCopyWith<$Res>(_self.customer!, (value) {
    return _then(_self.copyWith(customer: value));
  });
}
}


/// Adds pattern-matching-related methods to [Cart].
extension CartPatterns on Cart {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Cart value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Cart() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Cart value)  $default,){
final _that = this;
switch (_that) {
case _Cart():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Cart value)?  $default,){
final _that = this;
switch (_that) {
case _Cart() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Customer? customer,  List<CartItem> items,  DiscountType discountType,  double discountValue,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Cart() when $default != null:
return $default(_that.customer,_that.items,_that.discountType,_that.discountValue,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Customer? customer,  List<CartItem> items,  DiscountType discountType,  double discountValue,  String? note)  $default,) {final _that = this;
switch (_that) {
case _Cart():
return $default(_that.customer,_that.items,_that.discountType,_that.discountValue,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Customer? customer,  List<CartItem> items,  DiscountType discountType,  double discountValue,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _Cart() when $default != null:
return $default(_that.customer,_that.items,_that.discountType,_that.discountValue,_that.note);case _:
  return null;

}
}

}

/// @nodoc


class _Cart extends Cart {
  const _Cart({this.customer,  List<CartItem> items = const <CartItem>[], this.discountType = DiscountType.none, this.discountValue = 0, this.note}): _items = items,super._();
  

@override final  Customer? customer;
 final  List<CartItem> _items;
@override@JsonKey() List<CartItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  DiscountType discountType;
@override@JsonKey() final  double discountValue;
@override final  String? note;

/// Create a copy of Cart
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CartCopyWith<_Cart> get copyWith => __$CartCopyWithImpl<_Cart>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Cart&&(identical(other.customer, customer) || other.customer == customer)&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.discountType, discountType) || other.discountType == discountType)&&(identical(other.discountValue, discountValue) || other.discountValue == discountValue)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode {
    return Object.hash(runtimeType,customer,const DeepCollectionEquality().hash(_items),discountType,discountValue,note);
}

@override
String toString() {
    return 'Cart(customer: $customer, items: $items, discountType: $discountType, discountValue: $discountValue, note: $note)';
}


}

/// @nodoc
abstract mixin class _$CartCopyWith<$Res> implements $CartCopyWith<$Res> {
  factory _$CartCopyWith(_Cart value, $Res Function(_Cart) _then) = __$CartCopyWithImpl;
@override @useResult
$Res call({
 Customer? customer, List<CartItem> items, DiscountType discountType, double discountValue, String? note
});


@override $CustomerCopyWith<$Res>? get customer;

}
/// @nodoc
class __$CartCopyWithImpl<$Res>
    implements _$CartCopyWith<$Res> {
  __$CartCopyWithImpl(this._self, this._then);

  final _Cart _self;
  final $Res Function(_Cart) _then;

/// Create a copy of Cart
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? customer = freezed,Object? items = null,Object? discountType = null,Object? discountValue = null,Object? note = freezed,}) {
  return _then(_Cart(
customer: freezed == customer ? _self.customer : customer // ignore: cast_nullable_to_non_nullable
as Customer?,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CartItem>,discountType: null == discountType ? _self.discountType : discountType // ignore: cast_nullable_to_non_nullable
as DiscountType,discountValue: null == discountValue ? _self.discountValue : discountValue // ignore: cast_nullable_to_non_nullable
as double,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of Cart
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CustomerCopyWith<$Res>? get customer {
    if (_self.customer == null) {
    return null;
  }

  return $CustomerCopyWith<$Res>(_self.customer!, (value) {
    return _then(_self.copyWith(customer: value));
  });
}
}

/// @nodoc
mixin _$SaleTotals {

 double get subtotalProducts; double get subtotalServices; double get subtotal; double get discountAmount; double get total;
/// Create a copy of SaleTotals
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SaleTotalsCopyWith<SaleTotals> get copyWith => _$SaleTotalsCopyWithImpl<SaleTotals>(this as SaleTotals, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SaleTotals;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaleTotals&&(identical(other.subtotalProducts, _this.subtotalProducts) || other.subtotalProducts == _this.subtotalProducts)&&(identical(other.subtotalServices, _this.subtotalServices) || other.subtotalServices == _this.subtotalServices)&&(identical(other.subtotal, _this.subtotal) || other.subtotal == _this.subtotal)&&(identical(other.discountAmount, _this.discountAmount) || other.discountAmount == _this.discountAmount)&&(identical(other.total, _this.total) || other.total == _this.total));
}


@override
int get hashCode {
  final _this = this as SaleTotals;
  return Object.hash(runtimeType,_this.subtotalProducts,_this.subtotalServices,_this.subtotal,_this.discountAmount,_this.total);
}

@override
String toString() {
  final _this = this as SaleTotals;
  return 'SaleTotals(subtotalProducts: ${_this.subtotalProducts}, subtotalServices: ${_this.subtotalServices}, subtotal: ${_this.subtotal}, discountAmount: ${_this.discountAmount}, total: ${_this.total})';
}


}

/// @nodoc
abstract mixin class $SaleTotalsCopyWith<$Res>  {
  factory $SaleTotalsCopyWith(SaleTotals value, $Res Function(SaleTotals) _then) = _$SaleTotalsCopyWithImpl;
@useResult
$Res call({
 double subtotalProducts, double subtotalServices, double subtotal, double discountAmount, double total
});




}
/// @nodoc
class _$SaleTotalsCopyWithImpl<$Res>
    implements $SaleTotalsCopyWith<$Res> {
  _$SaleTotalsCopyWithImpl(this._self, this._then);

  final SaleTotals _self;
  final $Res Function(SaleTotals) _then;

/// Create a copy of SaleTotals
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? subtotalProducts = null,Object? subtotalServices = null,Object? subtotal = null,Object? discountAmount = null,Object? total = null,}) {
  return _then(SaleTotals(
subtotalProducts: null == subtotalProducts ? _self.subtotalProducts : subtotalProducts // ignore: cast_nullable_to_non_nullable
as double,subtotalServices: null == subtotalServices ? _self.subtotalServices : subtotalServices // ignore: cast_nullable_to_non_nullable
as double,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double,discountAmount: null == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SaleTotals].
extension SaleTotalsPatterns on SaleTotals {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SaleTotals value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SaleTotals() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SaleTotals value)  $default,){
final _that = this;
switch (_that) {
case _SaleTotals():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SaleTotals value)?  $default,){
final _that = this;
switch (_that) {
case _SaleTotals() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double subtotalProducts,  double subtotalServices,  double subtotal,  double discountAmount,  double total)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SaleTotals() when $default != null:
return $default(_that.subtotalProducts,_that.subtotalServices,_that.subtotal,_that.discountAmount,_that.total);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double subtotalProducts,  double subtotalServices,  double subtotal,  double discountAmount,  double total)  $default,) {final _that = this;
switch (_that) {
case _SaleTotals():
return $default(_that.subtotalProducts,_that.subtotalServices,_that.subtotal,_that.discountAmount,_that.total);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double subtotalProducts,  double subtotalServices,  double subtotal,  double discountAmount,  double total)?  $default,) {final _that = this;
switch (_that) {
case _SaleTotals() when $default != null:
return $default(_that.subtotalProducts,_that.subtotalServices,_that.subtotal,_that.discountAmount,_that.total);case _:
  return null;

}
}

}

/// @nodoc


class _SaleTotals implements SaleTotals {
  const _SaleTotals({required this.subtotalProducts, required this.subtotalServices, required this.subtotal, required this.discountAmount, required this.total});
  

@override final  double subtotalProducts;
@override final  double subtotalServices;
@override final  double subtotal;
@override final  double discountAmount;
@override final  double total;

/// Create a copy of SaleTotals
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaleTotalsCopyWith<_SaleTotals> get copyWith => __$SaleTotalsCopyWithImpl<_SaleTotals>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaleTotals&&(identical(other.subtotalProducts, subtotalProducts) || other.subtotalProducts == subtotalProducts)&&(identical(other.subtotalServices, subtotalServices) || other.subtotalServices == subtotalServices)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.total, total) || other.total == total));
}


@override
int get hashCode {
    return Object.hash(runtimeType,subtotalProducts,subtotalServices,subtotal,discountAmount,total);
}

@override
String toString() {
    return 'SaleTotals(subtotalProducts: $subtotalProducts, subtotalServices: $subtotalServices, subtotal: $subtotal, discountAmount: $discountAmount, total: $total)';
}


}

/// @nodoc
abstract mixin class _$SaleTotalsCopyWith<$Res> implements $SaleTotalsCopyWith<$Res> {
  factory _$SaleTotalsCopyWith(_SaleTotals value, $Res Function(_SaleTotals) _then) = __$SaleTotalsCopyWithImpl;
@override @useResult
$Res call({
 double subtotalProducts, double subtotalServices, double subtotal, double discountAmount, double total
});




}
/// @nodoc
class __$SaleTotalsCopyWithImpl<$Res>
    implements _$SaleTotalsCopyWith<$Res> {
  __$SaleTotalsCopyWithImpl(this._self, this._then);

  final _SaleTotals _self;
  final $Res Function(_SaleTotals) _then;

/// Create a copy of SaleTotals
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? subtotalProducts = null,Object? subtotalServices = null,Object? subtotal = null,Object? discountAmount = null,Object? total = null,}) {
  return _then(_SaleTotals(
subtotalProducts: null == subtotalProducts ? _self.subtotalProducts : subtotalProducts // ignore: cast_nullable_to_non_nullable
as double,subtotalServices: null == subtotalServices ? _self.subtotalServices : subtotalServices // ignore: cast_nullable_to_non_nullable
as double,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double,discountAmount: null == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
