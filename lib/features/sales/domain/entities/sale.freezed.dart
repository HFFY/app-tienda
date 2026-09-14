// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sale.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Sale {

 int get id; int get customerId; DateTime get saleDate; double get subtotal; DiscountType get discountType; double get discountValue; double get discountAmount; double get total; String? get note; DateTime get createdAt; List<SaleItem> get items; String? get customerName;
/// Create a copy of Sale
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SaleCopyWith<Sale> get copyWith => _$SaleCopyWithImpl<Sale>(this as Sale, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Sale;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Sale&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.customerId, _this.customerId) || other.customerId == _this.customerId)&&(identical(other.saleDate, _this.saleDate) || other.saleDate == _this.saleDate)&&(identical(other.subtotal, _this.subtotal) || other.subtotal == _this.subtotal)&&(identical(other.discountType, _this.discountType) || other.discountType == _this.discountType)&&(identical(other.discountValue, _this.discountValue) || other.discountValue == _this.discountValue)&&(identical(other.discountAmount, _this.discountAmount) || other.discountAmount == _this.discountAmount)&&(identical(other.total, _this.total) || other.total == _this.total)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.customerName, _this.customerName) || other.customerName == _this.customerName));
}


@override
int get hashCode {
  final _this = this as Sale;
  return Object.hash(runtimeType,_this.id,_this.customerId,_this.saleDate,_this.subtotal,_this.discountType,_this.discountValue,_this.discountAmount,_this.total,_this.note,_this.createdAt,const DeepCollectionEquality().hash(_this.items),_this.customerName);
}

@override
String toString() {
  final _this = this as Sale;
  return 'Sale(id: ${_this.id}, customerId: ${_this.customerId}, saleDate: ${_this.saleDate}, subtotal: ${_this.subtotal}, discountType: ${_this.discountType}, discountValue: ${_this.discountValue}, discountAmount: ${_this.discountAmount}, total: ${_this.total}, note: ${_this.note}, createdAt: ${_this.createdAt}, items: ${_this.items}, customerName: ${_this.customerName})';
}


}

/// @nodoc
abstract mixin class $SaleCopyWith<$Res>  {
  factory $SaleCopyWith(Sale value, $Res Function(Sale) _then) = _$SaleCopyWithImpl;
@useResult
$Res call({
 int id, int customerId, DateTime saleDate, double subtotal, DiscountType discountType, double discountValue, double discountAmount, double total, String? note, DateTime createdAt, List<SaleItem> items, String? customerName
});




}
/// @nodoc
class _$SaleCopyWithImpl<$Res>
    implements $SaleCopyWith<$Res> {
  _$SaleCopyWithImpl(this._self, this._then);

  final Sale _self;
  final $Res Function(Sale) _then;

/// Create a copy of Sale
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? customerId = null,Object? saleDate = null,Object? subtotal = null,Object? discountType = null,Object? discountValue = null,Object? discountAmount = null,Object? total = null,Object? note = freezed,Object? createdAt = null,Object? items = null,Object? customerName = freezed,}) {
  return _then(Sale(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as int,saleDate: null == saleDate ? _self.saleDate : saleDate // ignore: cast_nullable_to_non_nullable
as DateTime,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double,discountType: null == discountType ? _self.discountType : discountType // ignore: cast_nullable_to_non_nullable
as DiscountType,discountValue: null == discountValue ? _self.discountValue : discountValue // ignore: cast_nullable_to_non_nullable
as double,discountAmount: null == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<SaleItem>,customerName: freezed == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Sale].
extension SalePatterns on Sale {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Sale value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Sale() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Sale value)  $default,){
final _that = this;
switch (_that) {
case _Sale():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Sale value)?  $default,){
final _that = this;
switch (_that) {
case _Sale() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int customerId,  DateTime saleDate,  double subtotal,  DiscountType discountType,  double discountValue,  double discountAmount,  double total,  String? note,  DateTime createdAt,  List<SaleItem> items,  String? customerName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Sale() when $default != null:
return $default(_that.id,_that.customerId,_that.saleDate,_that.subtotal,_that.discountType,_that.discountValue,_that.discountAmount,_that.total,_that.note,_that.createdAt,_that.items,_that.customerName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int customerId,  DateTime saleDate,  double subtotal,  DiscountType discountType,  double discountValue,  double discountAmount,  double total,  String? note,  DateTime createdAt,  List<SaleItem> items,  String? customerName)  $default,) {final _that = this;
switch (_that) {
case _Sale():
return $default(_that.id,_that.customerId,_that.saleDate,_that.subtotal,_that.discountType,_that.discountValue,_that.discountAmount,_that.total,_that.note,_that.createdAt,_that.items,_that.customerName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int customerId,  DateTime saleDate,  double subtotal,  DiscountType discountType,  double discountValue,  double discountAmount,  double total,  String? note,  DateTime createdAt,  List<SaleItem> items,  String? customerName)?  $default,) {final _that = this;
switch (_that) {
case _Sale() when $default != null:
return $default(_that.id,_that.customerId,_that.saleDate,_that.subtotal,_that.discountType,_that.discountValue,_that.discountAmount,_that.total,_that.note,_that.createdAt,_that.items,_that.customerName);case _:
  return null;

}
}

}

/// @nodoc


class _Sale extends Sale {
  const _Sale({required this.id, required this.customerId, required this.saleDate, required this.subtotal, required this.discountType, required this.discountValue, required this.discountAmount, required this.total, this.note, required this.createdAt,  List<SaleItem> items = const <SaleItem>[], this.customerName}): _items = items,super._();
  

@override final  int id;
@override final  int customerId;
@override final  DateTime saleDate;
@override final  double subtotal;
@override final  DiscountType discountType;
@override final  double discountValue;
@override final  double discountAmount;
@override final  double total;
@override final  String? note;
@override final  DateTime createdAt;
 final  List<SaleItem> _items;
@override@JsonKey() List<SaleItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  String? customerName;

/// Create a copy of Sale
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaleCopyWith<_Sale> get copyWith => __$SaleCopyWithImpl<_Sale>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Sale&&(identical(other.id, id) || other.id == id)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.saleDate, saleDate) || other.saleDate == saleDate)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.discountType, discountType) || other.discountType == discountType)&&(identical(other.discountValue, discountValue) || other.discountValue == discountValue)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.total, total) || other.total == total)&&(identical(other.note, note) || other.note == note)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.customerName, customerName) || other.customerName == customerName));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,customerId,saleDate,subtotal,discountType,discountValue,discountAmount,total,note,createdAt,const DeepCollectionEquality().hash(_items),customerName);
}

@override
String toString() {
    return 'Sale(id: $id, customerId: $customerId, saleDate: $saleDate, subtotal: $subtotal, discountType: $discountType, discountValue: $discountValue, discountAmount: $discountAmount, total: $total, note: $note, createdAt: $createdAt, items: $items, customerName: $customerName)';
}


}

/// @nodoc
abstract mixin class _$SaleCopyWith<$Res> implements $SaleCopyWith<$Res> {
  factory _$SaleCopyWith(_Sale value, $Res Function(_Sale) _then) = __$SaleCopyWithImpl;
@override @useResult
$Res call({
 int id, int customerId, DateTime saleDate, double subtotal, DiscountType discountType, double discountValue, double discountAmount, double total, String? note, DateTime createdAt, List<SaleItem> items, String? customerName
});




}
/// @nodoc
class __$SaleCopyWithImpl<$Res>
    implements _$SaleCopyWith<$Res> {
  __$SaleCopyWithImpl(this._self, this._then);

  final _Sale _self;
  final $Res Function(_Sale) _then;

/// Create a copy of Sale
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? customerId = null,Object? saleDate = null,Object? subtotal = null,Object? discountType = null,Object? discountValue = null,Object? discountAmount = null,Object? total = null,Object? note = freezed,Object? createdAt = null,Object? items = null,Object? customerName = freezed,}) {
  return _then(_Sale(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as int,saleDate: null == saleDate ? _self.saleDate : saleDate // ignore: cast_nullable_to_non_nullable
as DateTime,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double,discountType: null == discountType ? _self.discountType : discountType // ignore: cast_nullable_to_non_nullable
as DiscountType,discountValue: null == discountValue ? _self.discountValue : discountValue // ignore: cast_nullable_to_non_nullable
as double,discountAmount: null == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<SaleItem>,customerName: freezed == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$SaleItem {

 int get id; int get saleId; SaleItemType get type; int? get productId; int? get serviceId; String get nameSnapshot; String? get categorySnapshot; double get unitPrice; int get quantity; double get lineTotal;
/// Create a copy of SaleItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SaleItemCopyWith<SaleItem> get copyWith => _$SaleItemCopyWithImpl<SaleItem>(this as SaleItem, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SaleItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaleItem&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.saleId, _this.saleId) || other.saleId == _this.saleId)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.productId, _this.productId) || other.productId == _this.productId)&&(identical(other.serviceId, _this.serviceId) || other.serviceId == _this.serviceId)&&(identical(other.nameSnapshot, _this.nameSnapshot) || other.nameSnapshot == _this.nameSnapshot)&&(identical(other.categorySnapshot, _this.categorySnapshot) || other.categorySnapshot == _this.categorySnapshot)&&(identical(other.unitPrice, _this.unitPrice) || other.unitPrice == _this.unitPrice)&&(identical(other.quantity, _this.quantity) || other.quantity == _this.quantity)&&(identical(other.lineTotal, _this.lineTotal) || other.lineTotal == _this.lineTotal));
}


@override
int get hashCode {
  final _this = this as SaleItem;
  return Object.hash(runtimeType,_this.id,_this.saleId,_this.type,_this.productId,_this.serviceId,_this.nameSnapshot,_this.categorySnapshot,_this.unitPrice,_this.quantity,_this.lineTotal);
}

@override
String toString() {
  final _this = this as SaleItem;
  return 'SaleItem(id: ${_this.id}, saleId: ${_this.saleId}, type: ${_this.type}, productId: ${_this.productId}, serviceId: ${_this.serviceId}, nameSnapshot: ${_this.nameSnapshot}, categorySnapshot: ${_this.categorySnapshot}, unitPrice: ${_this.unitPrice}, quantity: ${_this.quantity}, lineTotal: ${_this.lineTotal})';
}


}

/// @nodoc
abstract mixin class $SaleItemCopyWith<$Res>  {
  factory $SaleItemCopyWith(SaleItem value, $Res Function(SaleItem) _then) = _$SaleItemCopyWithImpl;
@useResult
$Res call({
 int id, int saleId, SaleItemType type, int? productId, int? serviceId, String nameSnapshot, String? categorySnapshot, double unitPrice, int quantity, double lineTotal
});




}
/// @nodoc
class _$SaleItemCopyWithImpl<$Res>
    implements $SaleItemCopyWith<$Res> {
  _$SaleItemCopyWithImpl(this._self, this._then);

  final SaleItem _self;
  final $Res Function(SaleItem) _then;

/// Create a copy of SaleItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? saleId = null,Object? type = null,Object? productId = freezed,Object? serviceId = freezed,Object? nameSnapshot = null,Object? categorySnapshot = freezed,Object? unitPrice = null,Object? quantity = null,Object? lineTotal = null,}) {
  return _then(SaleItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,saleId: null == saleId ? _self.saleId : saleId // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SaleItemType,productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int?,serviceId: freezed == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as int?,nameSnapshot: null == nameSnapshot ? _self.nameSnapshot : nameSnapshot // ignore: cast_nullable_to_non_nullable
as String,categorySnapshot: freezed == categorySnapshot ? _self.categorySnapshot : categorySnapshot // ignore: cast_nullable_to_non_nullable
as String?,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,lineTotal: null == lineTotal ? _self.lineTotal : lineTotal // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SaleItem].
extension SaleItemPatterns on SaleItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SaleItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SaleItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SaleItem value)  $default,){
final _that = this;
switch (_that) {
case _SaleItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SaleItem value)?  $default,){
final _that = this;
switch (_that) {
case _SaleItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int saleId,  SaleItemType type,  int? productId,  int? serviceId,  String nameSnapshot,  String? categorySnapshot,  double unitPrice,  int quantity,  double lineTotal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SaleItem() when $default != null:
return $default(_that.id,_that.saleId,_that.type,_that.productId,_that.serviceId,_that.nameSnapshot,_that.categorySnapshot,_that.unitPrice,_that.quantity,_that.lineTotal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int saleId,  SaleItemType type,  int? productId,  int? serviceId,  String nameSnapshot,  String? categorySnapshot,  double unitPrice,  int quantity,  double lineTotal)  $default,) {final _that = this;
switch (_that) {
case _SaleItem():
return $default(_that.id,_that.saleId,_that.type,_that.productId,_that.serviceId,_that.nameSnapshot,_that.categorySnapshot,_that.unitPrice,_that.quantity,_that.lineTotal);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int saleId,  SaleItemType type,  int? productId,  int? serviceId,  String nameSnapshot,  String? categorySnapshot,  double unitPrice,  int quantity,  double lineTotal)?  $default,) {final _that = this;
switch (_that) {
case _SaleItem() when $default != null:
return $default(_that.id,_that.saleId,_that.type,_that.productId,_that.serviceId,_that.nameSnapshot,_that.categorySnapshot,_that.unitPrice,_that.quantity,_that.lineTotal);case _:
  return null;

}
}

}

/// @nodoc


class _SaleItem implements SaleItem {
  const _SaleItem({required this.id, required this.saleId, required this.type, this.productId, this.serviceId, required this.nameSnapshot, this.categorySnapshot, required this.unitPrice, required this.quantity, required this.lineTotal});
  

@override final  int id;
@override final  int saleId;
@override final  SaleItemType type;
@override final  int? productId;
@override final  int? serviceId;
@override final  String nameSnapshot;
@override final  String? categorySnapshot;
@override final  double unitPrice;
@override final  int quantity;
@override final  double lineTotal;

/// Create a copy of SaleItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaleItemCopyWith<_SaleItem> get copyWith => __$SaleItemCopyWithImpl<_SaleItem>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaleItem&&(identical(other.id, id) || other.id == id)&&(identical(other.saleId, saleId) || other.saleId == saleId)&&(identical(other.type, type) || other.type == type)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.nameSnapshot, nameSnapshot) || other.nameSnapshot == nameSnapshot)&&(identical(other.categorySnapshot, categorySnapshot) || other.categorySnapshot == categorySnapshot)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.lineTotal, lineTotal) || other.lineTotal == lineTotal));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,saleId,type,productId,serviceId,nameSnapshot,categorySnapshot,unitPrice,quantity,lineTotal);
}

@override
String toString() {
    return 'SaleItem(id: $id, saleId: $saleId, type: $type, productId: $productId, serviceId: $serviceId, nameSnapshot: $nameSnapshot, categorySnapshot: $categorySnapshot, unitPrice: $unitPrice, quantity: $quantity, lineTotal: $lineTotal)';
}


}

/// @nodoc
abstract mixin class _$SaleItemCopyWith<$Res> implements $SaleItemCopyWith<$Res> {
  factory _$SaleItemCopyWith(_SaleItem value, $Res Function(_SaleItem) _then) = __$SaleItemCopyWithImpl;
@override @useResult
$Res call({
 int id, int saleId, SaleItemType type, int? productId, int? serviceId, String nameSnapshot, String? categorySnapshot, double unitPrice, int quantity, double lineTotal
});




}
/// @nodoc
class __$SaleItemCopyWithImpl<$Res>
    implements _$SaleItemCopyWith<$Res> {
  __$SaleItemCopyWithImpl(this._self, this._then);

  final _SaleItem _self;
  final $Res Function(_SaleItem) _then;

/// Create a copy of SaleItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? saleId = null,Object? type = null,Object? productId = freezed,Object? serviceId = freezed,Object? nameSnapshot = null,Object? categorySnapshot = freezed,Object? unitPrice = null,Object? quantity = null,Object? lineTotal = null,}) {
  return _then(_SaleItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,saleId: null == saleId ? _self.saleId : saleId // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SaleItemType,productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int?,serviceId: freezed == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as int?,nameSnapshot: null == nameSnapshot ? _self.nameSnapshot : nameSnapshot // ignore: cast_nullable_to_non_nullable
as String,categorySnapshot: freezed == categorySnapshot ? _self.categorySnapshot : categorySnapshot // ignore: cast_nullable_to_non_nullable
as String?,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,lineTotal: null == lineTotal ? _self.lineTotal : lineTotal // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$SaleDraft {

 int get customerId; double get subtotal; DiscountType get discountType; double get discountValue; double get discountAmount; double get total; String? get note; List<SaleDraftItem> get items;
/// Create a copy of SaleDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SaleDraftCopyWith<SaleDraft> get copyWith => _$SaleDraftCopyWithImpl<SaleDraft>(this as SaleDraft, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SaleDraft;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaleDraft&&(identical(other.customerId, _this.customerId) || other.customerId == _this.customerId)&&(identical(other.subtotal, _this.subtotal) || other.subtotal == _this.subtotal)&&(identical(other.discountType, _this.discountType) || other.discountType == _this.discountType)&&(identical(other.discountValue, _this.discountValue) || other.discountValue == _this.discountValue)&&(identical(other.discountAmount, _this.discountAmount) || other.discountAmount == _this.discountAmount)&&(identical(other.total, _this.total) || other.total == _this.total)&&(identical(other.note, _this.note) || other.note == _this.note)&&const DeepCollectionEquality().equals(other.items, _this.items));
}


@override
int get hashCode {
  final _this = this as SaleDraft;
  return Object.hash(runtimeType,_this.customerId,_this.subtotal,_this.discountType,_this.discountValue,_this.discountAmount,_this.total,_this.note,const DeepCollectionEquality().hash(_this.items));
}

@override
String toString() {
  final _this = this as SaleDraft;
  return 'SaleDraft(customerId: ${_this.customerId}, subtotal: ${_this.subtotal}, discountType: ${_this.discountType}, discountValue: ${_this.discountValue}, discountAmount: ${_this.discountAmount}, total: ${_this.total}, note: ${_this.note}, items: ${_this.items})';
}


}

/// @nodoc
abstract mixin class $SaleDraftCopyWith<$Res>  {
  factory $SaleDraftCopyWith(SaleDraft value, $Res Function(SaleDraft) _then) = _$SaleDraftCopyWithImpl;
@useResult
$Res call({
 int customerId, double subtotal, DiscountType discountType, double discountValue, double discountAmount, double total, String? note, List<SaleDraftItem> items
});




}
/// @nodoc
class _$SaleDraftCopyWithImpl<$Res>
    implements $SaleDraftCopyWith<$Res> {
  _$SaleDraftCopyWithImpl(this._self, this._then);

  final SaleDraft _self;
  final $Res Function(SaleDraft) _then;

/// Create a copy of SaleDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? customerId = null,Object? subtotal = null,Object? discountType = null,Object? discountValue = null,Object? discountAmount = null,Object? total = null,Object? note = freezed,Object? items = null,}) {
  return _then(SaleDraft(
customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as int,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double,discountType: null == discountType ? _self.discountType : discountType // ignore: cast_nullable_to_non_nullable
as DiscountType,discountValue: null == discountValue ? _self.discountValue : discountValue // ignore: cast_nullable_to_non_nullable
as double,discountAmount: null == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<SaleDraftItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [SaleDraft].
extension SaleDraftPatterns on SaleDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SaleDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SaleDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SaleDraft value)  $default,){
final _that = this;
switch (_that) {
case _SaleDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SaleDraft value)?  $default,){
final _that = this;
switch (_that) {
case _SaleDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int customerId,  double subtotal,  DiscountType discountType,  double discountValue,  double discountAmount,  double total,  String? note,  List<SaleDraftItem> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SaleDraft() when $default != null:
return $default(_that.customerId,_that.subtotal,_that.discountType,_that.discountValue,_that.discountAmount,_that.total,_that.note,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int customerId,  double subtotal,  DiscountType discountType,  double discountValue,  double discountAmount,  double total,  String? note,  List<SaleDraftItem> items)  $default,) {final _that = this;
switch (_that) {
case _SaleDraft():
return $default(_that.customerId,_that.subtotal,_that.discountType,_that.discountValue,_that.discountAmount,_that.total,_that.note,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int customerId,  double subtotal,  DiscountType discountType,  double discountValue,  double discountAmount,  double total,  String? note,  List<SaleDraftItem> items)?  $default,) {final _that = this;
switch (_that) {
case _SaleDraft() when $default != null:
return $default(_that.customerId,_that.subtotal,_that.discountType,_that.discountValue,_that.discountAmount,_that.total,_that.note,_that.items);case _:
  return null;

}
}

}

/// @nodoc


class _SaleDraft implements SaleDraft {
  const _SaleDraft({required this.customerId, required this.subtotal, required this.discountType, required this.discountValue, required this.discountAmount, required this.total, this.note, required  List<SaleDraftItem> items}): _items = items;
  

@override final  int customerId;
@override final  double subtotal;
@override final  DiscountType discountType;
@override final  double discountValue;
@override final  double discountAmount;
@override final  double total;
@override final  String? note;
 final  List<SaleDraftItem> _items;
@override List<SaleDraftItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of SaleDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaleDraftCopyWith<_SaleDraft> get copyWith => __$SaleDraftCopyWithImpl<_SaleDraft>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaleDraft&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.discountType, discountType) || other.discountType == discountType)&&(identical(other.discountValue, discountValue) || other.discountValue == discountValue)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.total, total) || other.total == total)&&(identical(other.note, note) || other.note == note)&&const DeepCollectionEquality().equals(other.items, _items));
}


@override
int get hashCode {
    return Object.hash(runtimeType,customerId,subtotal,discountType,discountValue,discountAmount,total,note,const DeepCollectionEquality().hash(_items));
}

@override
String toString() {
    return 'SaleDraft(customerId: $customerId, subtotal: $subtotal, discountType: $discountType, discountValue: $discountValue, discountAmount: $discountAmount, total: $total, note: $note, items: $items)';
}


}

/// @nodoc
abstract mixin class _$SaleDraftCopyWith<$Res> implements $SaleDraftCopyWith<$Res> {
  factory _$SaleDraftCopyWith(_SaleDraft value, $Res Function(_SaleDraft) _then) = __$SaleDraftCopyWithImpl;
@override @useResult
$Res call({
 int customerId, double subtotal, DiscountType discountType, double discountValue, double discountAmount, double total, String? note, List<SaleDraftItem> items
});




}
/// @nodoc
class __$SaleDraftCopyWithImpl<$Res>
    implements _$SaleDraftCopyWith<$Res> {
  __$SaleDraftCopyWithImpl(this._self, this._then);

  final _SaleDraft _self;
  final $Res Function(_SaleDraft) _then;

/// Create a copy of SaleDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? customerId = null,Object? subtotal = null,Object? discountType = null,Object? discountValue = null,Object? discountAmount = null,Object? total = null,Object? note = freezed,Object? items = null,}) {
  return _then(_SaleDraft(
customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as int,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double,discountType: null == discountType ? _self.discountType : discountType // ignore: cast_nullable_to_non_nullable
as DiscountType,discountValue: null == discountValue ? _self.discountValue : discountValue // ignore: cast_nullable_to_non_nullable
as double,discountAmount: null == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<SaleDraftItem>,
  ));
}


}

/// @nodoc
mixin _$SaleDraftItem {

 SaleItemType get type; int get refId; String get nameSnapshot; String? get categorySnapshot; double get unitPrice; int get quantity; double get lineTotal;
/// Create a copy of SaleDraftItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SaleDraftItemCopyWith<SaleDraftItem> get copyWith => _$SaleDraftItemCopyWithImpl<SaleDraftItem>(this as SaleDraftItem, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SaleDraftItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaleDraftItem&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.refId, _this.refId) || other.refId == _this.refId)&&(identical(other.nameSnapshot, _this.nameSnapshot) || other.nameSnapshot == _this.nameSnapshot)&&(identical(other.categorySnapshot, _this.categorySnapshot) || other.categorySnapshot == _this.categorySnapshot)&&(identical(other.unitPrice, _this.unitPrice) || other.unitPrice == _this.unitPrice)&&(identical(other.quantity, _this.quantity) || other.quantity == _this.quantity)&&(identical(other.lineTotal, _this.lineTotal) || other.lineTotal == _this.lineTotal));
}


@override
int get hashCode {
  final _this = this as SaleDraftItem;
  return Object.hash(runtimeType,_this.type,_this.refId,_this.nameSnapshot,_this.categorySnapshot,_this.unitPrice,_this.quantity,_this.lineTotal);
}

@override
String toString() {
  final _this = this as SaleDraftItem;
  return 'SaleDraftItem(type: ${_this.type}, refId: ${_this.refId}, nameSnapshot: ${_this.nameSnapshot}, categorySnapshot: ${_this.categorySnapshot}, unitPrice: ${_this.unitPrice}, quantity: ${_this.quantity}, lineTotal: ${_this.lineTotal})';
}


}

/// @nodoc
abstract mixin class $SaleDraftItemCopyWith<$Res>  {
  factory $SaleDraftItemCopyWith(SaleDraftItem value, $Res Function(SaleDraftItem) _then) = _$SaleDraftItemCopyWithImpl;
@useResult
$Res call({
 SaleItemType type, int refId, String nameSnapshot, String? categorySnapshot, double unitPrice, int quantity, double lineTotal
});




}
/// @nodoc
class _$SaleDraftItemCopyWithImpl<$Res>
    implements $SaleDraftItemCopyWith<$Res> {
  _$SaleDraftItemCopyWithImpl(this._self, this._then);

  final SaleDraftItem _self;
  final $Res Function(SaleDraftItem) _then;

/// Create a copy of SaleDraftItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? refId = null,Object? nameSnapshot = null,Object? categorySnapshot = freezed,Object? unitPrice = null,Object? quantity = null,Object? lineTotal = null,}) {
  return _then(SaleDraftItem(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SaleItemType,refId: null == refId ? _self.refId : refId // ignore: cast_nullable_to_non_nullable
as int,nameSnapshot: null == nameSnapshot ? _self.nameSnapshot : nameSnapshot // ignore: cast_nullable_to_non_nullable
as String,categorySnapshot: freezed == categorySnapshot ? _self.categorySnapshot : categorySnapshot // ignore: cast_nullable_to_non_nullable
as String?,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,lineTotal: null == lineTotal ? _self.lineTotal : lineTotal // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SaleDraftItem].
extension SaleDraftItemPatterns on SaleDraftItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SaleDraftItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SaleDraftItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SaleDraftItem value)  $default,){
final _that = this;
switch (_that) {
case _SaleDraftItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SaleDraftItem value)?  $default,){
final _that = this;
switch (_that) {
case _SaleDraftItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SaleItemType type,  int refId,  String nameSnapshot,  String? categorySnapshot,  double unitPrice,  int quantity,  double lineTotal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SaleDraftItem() when $default != null:
return $default(_that.type,_that.refId,_that.nameSnapshot,_that.categorySnapshot,_that.unitPrice,_that.quantity,_that.lineTotal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SaleItemType type,  int refId,  String nameSnapshot,  String? categorySnapshot,  double unitPrice,  int quantity,  double lineTotal)  $default,) {final _that = this;
switch (_that) {
case _SaleDraftItem():
return $default(_that.type,_that.refId,_that.nameSnapshot,_that.categorySnapshot,_that.unitPrice,_that.quantity,_that.lineTotal);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SaleItemType type,  int refId,  String nameSnapshot,  String? categorySnapshot,  double unitPrice,  int quantity,  double lineTotal)?  $default,) {final _that = this;
switch (_that) {
case _SaleDraftItem() when $default != null:
return $default(_that.type,_that.refId,_that.nameSnapshot,_that.categorySnapshot,_that.unitPrice,_that.quantity,_that.lineTotal);case _:
  return null;

}
}

}

/// @nodoc


class _SaleDraftItem implements SaleDraftItem {
  const _SaleDraftItem({required this.type, required this.refId, required this.nameSnapshot, this.categorySnapshot, required this.unitPrice, required this.quantity, required this.lineTotal});
  

@override final  SaleItemType type;
@override final  int refId;
@override final  String nameSnapshot;
@override final  String? categorySnapshot;
@override final  double unitPrice;
@override final  int quantity;
@override final  double lineTotal;

/// Create a copy of SaleDraftItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaleDraftItemCopyWith<_SaleDraftItem> get copyWith => __$SaleDraftItemCopyWithImpl<_SaleDraftItem>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaleDraftItem&&(identical(other.type, type) || other.type == type)&&(identical(other.refId, refId) || other.refId == refId)&&(identical(other.nameSnapshot, nameSnapshot) || other.nameSnapshot == nameSnapshot)&&(identical(other.categorySnapshot, categorySnapshot) || other.categorySnapshot == categorySnapshot)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.lineTotal, lineTotal) || other.lineTotal == lineTotal));
}


@override
int get hashCode {
    return Object.hash(runtimeType,type,refId,nameSnapshot,categorySnapshot,unitPrice,quantity,lineTotal);
}

@override
String toString() {
    return 'SaleDraftItem(type: $type, refId: $refId, nameSnapshot: $nameSnapshot, categorySnapshot: $categorySnapshot, unitPrice: $unitPrice, quantity: $quantity, lineTotal: $lineTotal)';
}


}

/// @nodoc
abstract mixin class _$SaleDraftItemCopyWith<$Res> implements $SaleDraftItemCopyWith<$Res> {
  factory _$SaleDraftItemCopyWith(_SaleDraftItem value, $Res Function(_SaleDraftItem) _then) = __$SaleDraftItemCopyWithImpl;
@override @useResult
$Res call({
 SaleItemType type, int refId, String nameSnapshot, String? categorySnapshot, double unitPrice, int quantity, double lineTotal
});




}
/// @nodoc
class __$SaleDraftItemCopyWithImpl<$Res>
    implements _$SaleDraftItemCopyWith<$Res> {
  __$SaleDraftItemCopyWithImpl(this._self, this._then);

  final _SaleDraftItem _self;
  final $Res Function(_SaleDraftItem) _then;

/// Create a copy of SaleDraftItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? refId = null,Object? nameSnapshot = null,Object? categorySnapshot = freezed,Object? unitPrice = null,Object? quantity = null,Object? lineTotal = null,}) {
  return _then(_SaleDraftItem(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SaleItemType,refId: null == refId ? _self.refId : refId // ignore: cast_nullable_to_non_nullable
as int,nameSnapshot: null == nameSnapshot ? _self.nameSnapshot : nameSnapshot // ignore: cast_nullable_to_non_nullable
as String,categorySnapshot: freezed == categorySnapshot ? _self.categorySnapshot : categorySnapshot // ignore: cast_nullable_to_non_nullable
as String?,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,lineTotal: null == lineTotal ? _self.lineTotal : lineTotal // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
