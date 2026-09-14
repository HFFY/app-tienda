// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'monthly_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MonthlyReport {

 int get year; int get month; double get productsGross; double get servicesGross; double get netTotal; int get salesCount; int get unitsSold; double get discountsGiven; TopCustomer? get topCustomer; List<DailyTotal> get daily; List<CategoryRevenue> get byCategory; List<SoldItem> get soldItems;
/// Create a copy of MonthlyReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonthlyReportCopyWith<MonthlyReport> get copyWith => _$MonthlyReportCopyWithImpl<MonthlyReport>(this as MonthlyReport, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MonthlyReport;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonthlyReport&&(identical(other.year, _this.year) || other.year == _this.year)&&(identical(other.month, _this.month) || other.month == _this.month)&&(identical(other.productsGross, _this.productsGross) || other.productsGross == _this.productsGross)&&(identical(other.servicesGross, _this.servicesGross) || other.servicesGross == _this.servicesGross)&&(identical(other.netTotal, _this.netTotal) || other.netTotal == _this.netTotal)&&(identical(other.salesCount, _this.salesCount) || other.salesCount == _this.salesCount)&&(identical(other.unitsSold, _this.unitsSold) || other.unitsSold == _this.unitsSold)&&(identical(other.discountsGiven, _this.discountsGiven) || other.discountsGiven == _this.discountsGiven)&&(identical(other.topCustomer, _this.topCustomer) || other.topCustomer == _this.topCustomer)&&const DeepCollectionEquality().equals(other.daily, _this.daily)&&const DeepCollectionEquality().equals(other.byCategory, _this.byCategory)&&const DeepCollectionEquality().equals(other.soldItems, _this.soldItems));
}


@override
int get hashCode {
  final _this = this as MonthlyReport;
  return Object.hash(runtimeType,_this.year,_this.month,_this.productsGross,_this.servicesGross,_this.netTotal,_this.salesCount,_this.unitsSold,_this.discountsGiven,_this.topCustomer,const DeepCollectionEquality().hash(_this.daily),const DeepCollectionEquality().hash(_this.byCategory),const DeepCollectionEquality().hash(_this.soldItems));
}

@override
String toString() {
  final _this = this as MonthlyReport;
  return 'MonthlyReport(year: ${_this.year}, month: ${_this.month}, productsGross: ${_this.productsGross}, servicesGross: ${_this.servicesGross}, netTotal: ${_this.netTotal}, salesCount: ${_this.salesCount}, unitsSold: ${_this.unitsSold}, discountsGiven: ${_this.discountsGiven}, topCustomer: ${_this.topCustomer}, daily: ${_this.daily}, byCategory: ${_this.byCategory}, soldItems: ${_this.soldItems})';
}


}

/// @nodoc
abstract mixin class $MonthlyReportCopyWith<$Res>  {
  factory $MonthlyReportCopyWith(MonthlyReport value, $Res Function(MonthlyReport) _then) = _$MonthlyReportCopyWithImpl;
@useResult
$Res call({
 int year, int month, double productsGross, double servicesGross, double netTotal, int salesCount, int unitsSold, double discountsGiven, TopCustomer? topCustomer, List<DailyTotal> daily, List<CategoryRevenue> byCategory, List<SoldItem> soldItems
});


$TopCustomerCopyWith<$Res>? get topCustomer;

}
/// @nodoc
class _$MonthlyReportCopyWithImpl<$Res>
    implements $MonthlyReportCopyWith<$Res> {
  _$MonthlyReportCopyWithImpl(this._self, this._then);

  final MonthlyReport _self;
  final $Res Function(MonthlyReport) _then;

/// Create a copy of MonthlyReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? year = null,Object? month = null,Object? productsGross = null,Object? servicesGross = null,Object? netTotal = null,Object? salesCount = null,Object? unitsSold = null,Object? discountsGiven = null,Object? topCustomer = freezed,Object? daily = null,Object? byCategory = null,Object? soldItems = null,}) {
  return _then(MonthlyReport(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,productsGross: null == productsGross ? _self.productsGross : productsGross // ignore: cast_nullable_to_non_nullable
as double,servicesGross: null == servicesGross ? _self.servicesGross : servicesGross // ignore: cast_nullable_to_non_nullable
as double,netTotal: null == netTotal ? _self.netTotal : netTotal // ignore: cast_nullable_to_non_nullable
as double,salesCount: null == salesCount ? _self.salesCount : salesCount // ignore: cast_nullable_to_non_nullable
as int,unitsSold: null == unitsSold ? _self.unitsSold : unitsSold // ignore: cast_nullable_to_non_nullable
as int,discountsGiven: null == discountsGiven ? _self.discountsGiven : discountsGiven // ignore: cast_nullable_to_non_nullable
as double,topCustomer: freezed == topCustomer ? _self.topCustomer : topCustomer // ignore: cast_nullable_to_non_nullable
as TopCustomer?,daily: null == daily ? _self.daily : daily // ignore: cast_nullable_to_non_nullable
as List<DailyTotal>,byCategory: null == byCategory ? _self.byCategory : byCategory // ignore: cast_nullable_to_non_nullable
as List<CategoryRevenue>,soldItems: null == soldItems ? _self.soldItems : soldItems // ignore: cast_nullable_to_non_nullable
as List<SoldItem>,
  ));
}
/// Create a copy of MonthlyReport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TopCustomerCopyWith<$Res>? get topCustomer {
    if (_self.topCustomer == null) {
    return null;
  }

  return $TopCustomerCopyWith<$Res>(_self.topCustomer!, (value) {
    return _then(_self.copyWith(topCustomer: value));
  });
}
}


/// Adds pattern-matching-related methods to [MonthlyReport].
extension MonthlyReportPatterns on MonthlyReport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MonthlyReport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MonthlyReport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MonthlyReport value)  $default,){
final _that = this;
switch (_that) {
case _MonthlyReport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MonthlyReport value)?  $default,){
final _that = this;
switch (_that) {
case _MonthlyReport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int year,  int month,  double productsGross,  double servicesGross,  double netTotal,  int salesCount,  int unitsSold,  double discountsGiven,  TopCustomer? topCustomer,  List<DailyTotal> daily,  List<CategoryRevenue> byCategory,  List<SoldItem> soldItems)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonthlyReport() when $default != null:
return $default(_that.year,_that.month,_that.productsGross,_that.servicesGross,_that.netTotal,_that.salesCount,_that.unitsSold,_that.discountsGiven,_that.topCustomer,_that.daily,_that.byCategory,_that.soldItems);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int year,  int month,  double productsGross,  double servicesGross,  double netTotal,  int salesCount,  int unitsSold,  double discountsGiven,  TopCustomer? topCustomer,  List<DailyTotal> daily,  List<CategoryRevenue> byCategory,  List<SoldItem> soldItems)  $default,) {final _that = this;
switch (_that) {
case _MonthlyReport():
return $default(_that.year,_that.month,_that.productsGross,_that.servicesGross,_that.netTotal,_that.salesCount,_that.unitsSold,_that.discountsGiven,_that.topCustomer,_that.daily,_that.byCategory,_that.soldItems);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int year,  int month,  double productsGross,  double servicesGross,  double netTotal,  int salesCount,  int unitsSold,  double discountsGiven,  TopCustomer? topCustomer,  List<DailyTotal> daily,  List<CategoryRevenue> byCategory,  List<SoldItem> soldItems)?  $default,) {final _that = this;
switch (_that) {
case _MonthlyReport() when $default != null:
return $default(_that.year,_that.month,_that.productsGross,_that.servicesGross,_that.netTotal,_that.salesCount,_that.unitsSold,_that.discountsGiven,_that.topCustomer,_that.daily,_that.byCategory,_that.soldItems);case _:
  return null;

}
}

}

/// @nodoc


class _MonthlyReport extends MonthlyReport {
  const _MonthlyReport({required this.year, required this.month, required this.productsGross, required this.servicesGross, required this.netTotal, required this.salesCount, required this.unitsSold, required this.discountsGiven, this.topCustomer,  List<DailyTotal> daily = const <DailyTotal>[],  List<CategoryRevenue> byCategory = const <CategoryRevenue>[],  List<SoldItem> soldItems = const <SoldItem>[]}): _daily = daily,_byCategory = byCategory,_soldItems = soldItems,super._();
  

@override final  int year;
@override final  int month;
@override final  double productsGross;
@override final  double servicesGross;
@override final  double netTotal;
@override final  int salesCount;
@override final  int unitsSold;
@override final  double discountsGiven;
@override final  TopCustomer? topCustomer;
 final  List<DailyTotal> _daily;
@override@JsonKey() List<DailyTotal> get daily {
  if (_daily is EqualUnmodifiableListView) return _daily;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_daily);
}

 final  List<CategoryRevenue> _byCategory;
@override@JsonKey() List<CategoryRevenue> get byCategory {
  if (_byCategory is EqualUnmodifiableListView) return _byCategory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_byCategory);
}

 final  List<SoldItem> _soldItems;
@override@JsonKey() List<SoldItem> get soldItems {
  if (_soldItems is EqualUnmodifiableListView) return _soldItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_soldItems);
}


/// Create a copy of MonthlyReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonthlyReportCopyWith<_MonthlyReport> get copyWith => __$MonthlyReportCopyWithImpl<_MonthlyReport>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonthlyReport&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.productsGross, productsGross) || other.productsGross == productsGross)&&(identical(other.servicesGross, servicesGross) || other.servicesGross == servicesGross)&&(identical(other.netTotal, netTotal) || other.netTotal == netTotal)&&(identical(other.salesCount, salesCount) || other.salesCount == salesCount)&&(identical(other.unitsSold, unitsSold) || other.unitsSold == unitsSold)&&(identical(other.discountsGiven, discountsGiven) || other.discountsGiven == discountsGiven)&&(identical(other.topCustomer, topCustomer) || other.topCustomer == topCustomer)&&const DeepCollectionEquality().equals(other.daily, _daily)&&const DeepCollectionEquality().equals(other.byCategory, _byCategory)&&const DeepCollectionEquality().equals(other.soldItems, _soldItems));
}


@override
int get hashCode {
    return Object.hash(runtimeType,year,month,productsGross,servicesGross,netTotal,salesCount,unitsSold,discountsGiven,topCustomer,const DeepCollectionEquality().hash(_daily),const DeepCollectionEquality().hash(_byCategory),const DeepCollectionEquality().hash(_soldItems));
}

@override
String toString() {
    return 'MonthlyReport(year: $year, month: $month, productsGross: $productsGross, servicesGross: $servicesGross, netTotal: $netTotal, salesCount: $salesCount, unitsSold: $unitsSold, discountsGiven: $discountsGiven, topCustomer: $topCustomer, daily: $daily, byCategory: $byCategory, soldItems: $soldItems)';
}


}

/// @nodoc
abstract mixin class _$MonthlyReportCopyWith<$Res> implements $MonthlyReportCopyWith<$Res> {
  factory _$MonthlyReportCopyWith(_MonthlyReport value, $Res Function(_MonthlyReport) _then) = __$MonthlyReportCopyWithImpl;
@override @useResult
$Res call({
 int year, int month, double productsGross, double servicesGross, double netTotal, int salesCount, int unitsSold, double discountsGiven, TopCustomer? topCustomer, List<DailyTotal> daily, List<CategoryRevenue> byCategory, List<SoldItem> soldItems
});


@override $TopCustomerCopyWith<$Res>? get topCustomer;

}
/// @nodoc
class __$MonthlyReportCopyWithImpl<$Res>
    implements _$MonthlyReportCopyWith<$Res> {
  __$MonthlyReportCopyWithImpl(this._self, this._then);

  final _MonthlyReport _self;
  final $Res Function(_MonthlyReport) _then;

/// Create a copy of MonthlyReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? year = null,Object? month = null,Object? productsGross = null,Object? servicesGross = null,Object? netTotal = null,Object? salesCount = null,Object? unitsSold = null,Object? discountsGiven = null,Object? topCustomer = freezed,Object? daily = null,Object? byCategory = null,Object? soldItems = null,}) {
  return _then(_MonthlyReport(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,productsGross: null == productsGross ? _self.productsGross : productsGross // ignore: cast_nullable_to_non_nullable
as double,servicesGross: null == servicesGross ? _self.servicesGross : servicesGross // ignore: cast_nullable_to_non_nullable
as double,netTotal: null == netTotal ? _self.netTotal : netTotal // ignore: cast_nullable_to_non_nullable
as double,salesCount: null == salesCount ? _self.salesCount : salesCount // ignore: cast_nullable_to_non_nullable
as int,unitsSold: null == unitsSold ? _self.unitsSold : unitsSold // ignore: cast_nullable_to_non_nullable
as int,discountsGiven: null == discountsGiven ? _self.discountsGiven : discountsGiven // ignore: cast_nullable_to_non_nullable
as double,topCustomer: freezed == topCustomer ? _self.topCustomer : topCustomer // ignore: cast_nullable_to_non_nullable
as TopCustomer?,daily: null == daily ? _self._daily : daily // ignore: cast_nullable_to_non_nullable
as List<DailyTotal>,byCategory: null == byCategory ? _self._byCategory : byCategory // ignore: cast_nullable_to_non_nullable
as List<CategoryRevenue>,soldItems: null == soldItems ? _self._soldItems : soldItems // ignore: cast_nullable_to_non_nullable
as List<SoldItem>,
  ));
}

/// Create a copy of MonthlyReport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TopCustomerCopyWith<$Res>? get topCustomer {
    if (_self.topCustomer == null) {
    return null;
  }

  return $TopCustomerCopyWith<$Res>(_self.topCustomer!, (value) {
    return _then(_self.copyWith(topCustomer: value));
  });
}
}

/// @nodoc
mixin _$DailyTotal {

 int get day; double get total; int get salesCount;
/// Create a copy of DailyTotal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyTotalCopyWith<DailyTotal> get copyWith => _$DailyTotalCopyWithImpl<DailyTotal>(this as DailyTotal, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DailyTotal;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyTotal&&(identical(other.day, _this.day) || other.day == _this.day)&&(identical(other.total, _this.total) || other.total == _this.total)&&(identical(other.salesCount, _this.salesCount) || other.salesCount == _this.salesCount));
}


@override
int get hashCode {
  final _this = this as DailyTotal;
  return Object.hash(runtimeType,_this.day,_this.total,_this.salesCount);
}

@override
String toString() {
  final _this = this as DailyTotal;
  return 'DailyTotal(day: ${_this.day}, total: ${_this.total}, salesCount: ${_this.salesCount})';
}


}

/// @nodoc
abstract mixin class $DailyTotalCopyWith<$Res>  {
  factory $DailyTotalCopyWith(DailyTotal value, $Res Function(DailyTotal) _then) = _$DailyTotalCopyWithImpl;
@useResult
$Res call({
 int day, double total, int salesCount
});




}
/// @nodoc
class _$DailyTotalCopyWithImpl<$Res>
    implements $DailyTotalCopyWith<$Res> {
  _$DailyTotalCopyWithImpl(this._self, this._then);

  final DailyTotal _self;
  final $Res Function(DailyTotal) _then;

/// Create a copy of DailyTotal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? day = null,Object? total = null,Object? salesCount = null,}) {
  return _then(DailyTotal(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,salesCount: null == salesCount ? _self.salesCount : salesCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyTotal].
extension DailyTotalPatterns on DailyTotal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyTotal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyTotal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyTotal value)  $default,){
final _that = this;
switch (_that) {
case _DailyTotal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyTotal value)?  $default,){
final _that = this;
switch (_that) {
case _DailyTotal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int day,  double total,  int salesCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyTotal() when $default != null:
return $default(_that.day,_that.total,_that.salesCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int day,  double total,  int salesCount)  $default,) {final _that = this;
switch (_that) {
case _DailyTotal():
return $default(_that.day,_that.total,_that.salesCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int day,  double total,  int salesCount)?  $default,) {final _that = this;
switch (_that) {
case _DailyTotal() when $default != null:
return $default(_that.day,_that.total,_that.salesCount);case _:
  return null;

}
}

}

/// @nodoc


class _DailyTotal implements DailyTotal {
  const _DailyTotal({required this.day, required this.total, required this.salesCount});
  

@override final  int day;
@override final  double total;
@override final  int salesCount;

/// Create a copy of DailyTotal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyTotalCopyWith<_DailyTotal> get copyWith => __$DailyTotalCopyWithImpl<_DailyTotal>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyTotal&&(identical(other.day, day) || other.day == day)&&(identical(other.total, total) || other.total == total)&&(identical(other.salesCount, salesCount) || other.salesCount == salesCount));
}


@override
int get hashCode {
    return Object.hash(runtimeType,day,total,salesCount);
}

@override
String toString() {
    return 'DailyTotal(day: $day, total: $total, salesCount: $salesCount)';
}


}

/// @nodoc
abstract mixin class _$DailyTotalCopyWith<$Res> implements $DailyTotalCopyWith<$Res> {
  factory _$DailyTotalCopyWith(_DailyTotal value, $Res Function(_DailyTotal) _then) = __$DailyTotalCopyWithImpl;
@override @useResult
$Res call({
 int day, double total, int salesCount
});




}
/// @nodoc
class __$DailyTotalCopyWithImpl<$Res>
    implements _$DailyTotalCopyWith<$Res> {
  __$DailyTotalCopyWithImpl(this._self, this._then);

  final _DailyTotal _self;
  final $Res Function(_DailyTotal) _then;

/// Create a copy of DailyTotal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? day = null,Object? total = null,Object? salesCount = null,}) {
  return _then(_DailyTotal(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,salesCount: null == salesCount ? _self.salesCount : salesCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$CategoryRevenue {

 String get name; double get revenue; String? get colorHex; int? get iconCode;
/// Create a copy of CategoryRevenue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryRevenueCopyWith<CategoryRevenue> get copyWith => _$CategoryRevenueCopyWithImpl<CategoryRevenue>(this as CategoryRevenue, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CategoryRevenue;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryRevenue&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.revenue, _this.revenue) || other.revenue == _this.revenue)&&(identical(other.colorHex, _this.colorHex) || other.colorHex == _this.colorHex)&&(identical(other.iconCode, _this.iconCode) || other.iconCode == _this.iconCode));
}


@override
int get hashCode {
  final _this = this as CategoryRevenue;
  return Object.hash(runtimeType,_this.name,_this.revenue,_this.colorHex,_this.iconCode);
}

@override
String toString() {
  final _this = this as CategoryRevenue;
  return 'CategoryRevenue(name: ${_this.name}, revenue: ${_this.revenue}, colorHex: ${_this.colorHex}, iconCode: ${_this.iconCode})';
}


}

/// @nodoc
abstract mixin class $CategoryRevenueCopyWith<$Res>  {
  factory $CategoryRevenueCopyWith(CategoryRevenue value, $Res Function(CategoryRevenue) _then) = _$CategoryRevenueCopyWithImpl;
@useResult
$Res call({
 String name, double revenue, String? colorHex, int? iconCode
});




}
/// @nodoc
class _$CategoryRevenueCopyWithImpl<$Res>
    implements $CategoryRevenueCopyWith<$Res> {
  _$CategoryRevenueCopyWithImpl(this._self, this._then);

  final CategoryRevenue _self;
  final $Res Function(CategoryRevenue) _then;

/// Create a copy of CategoryRevenue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? revenue = null,Object? colorHex = freezed,Object? iconCode = freezed,}) {
  return _then(CategoryRevenue(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double,colorHex: freezed == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String?,iconCode: freezed == iconCode ? _self.iconCode : iconCode // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoryRevenue].
extension CategoryRevenuePatterns on CategoryRevenue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryRevenue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryRevenue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryRevenue value)  $default,){
final _that = this;
switch (_that) {
case _CategoryRevenue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryRevenue value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryRevenue() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  double revenue,  String? colorHex,  int? iconCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryRevenue() when $default != null:
return $default(_that.name,_that.revenue,_that.colorHex,_that.iconCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  double revenue,  String? colorHex,  int? iconCode)  $default,) {final _that = this;
switch (_that) {
case _CategoryRevenue():
return $default(_that.name,_that.revenue,_that.colorHex,_that.iconCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  double revenue,  String? colorHex,  int? iconCode)?  $default,) {final _that = this;
switch (_that) {
case _CategoryRevenue() when $default != null:
return $default(_that.name,_that.revenue,_that.colorHex,_that.iconCode);case _:
  return null;

}
}

}

/// @nodoc


class _CategoryRevenue implements CategoryRevenue {
  const _CategoryRevenue({required this.name, required this.revenue, this.colorHex, this.iconCode});
  

@override final  String name;
@override final  double revenue;
@override final  String? colorHex;
@override final  int? iconCode;

/// Create a copy of CategoryRevenue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryRevenueCopyWith<_CategoryRevenue> get copyWith => __$CategoryRevenueCopyWithImpl<_CategoryRevenue>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryRevenue&&(identical(other.name, name) || other.name == name)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.iconCode, iconCode) || other.iconCode == iconCode));
}


@override
int get hashCode {
    return Object.hash(runtimeType,name,revenue,colorHex,iconCode);
}

@override
String toString() {
    return 'CategoryRevenue(name: $name, revenue: $revenue, colorHex: $colorHex, iconCode: $iconCode)';
}


}

/// @nodoc
abstract mixin class _$CategoryRevenueCopyWith<$Res> implements $CategoryRevenueCopyWith<$Res> {
  factory _$CategoryRevenueCopyWith(_CategoryRevenue value, $Res Function(_CategoryRevenue) _then) = __$CategoryRevenueCopyWithImpl;
@override @useResult
$Res call({
 String name, double revenue, String? colorHex, int? iconCode
});




}
/// @nodoc
class __$CategoryRevenueCopyWithImpl<$Res>
    implements _$CategoryRevenueCopyWith<$Res> {
  __$CategoryRevenueCopyWithImpl(this._self, this._then);

  final _CategoryRevenue _self;
  final $Res Function(_CategoryRevenue) _then;

/// Create a copy of CategoryRevenue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? revenue = null,Object? colorHex = freezed,Object? iconCode = freezed,}) {
  return _then(_CategoryRevenue(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double,colorHex: freezed == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String?,iconCode: freezed == iconCode ? _self.iconCode : iconCode // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
mixin _$SoldItem {

 SaleItemType get type; int get refId; String get name; String? get category; int get unitsSold; int get timesSold; double get revenue;
/// Create a copy of SoldItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SoldItemCopyWith<SoldItem> get copyWith => _$SoldItemCopyWithImpl<SoldItem>(this as SoldItem, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SoldItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SoldItem&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.refId, _this.refId) || other.refId == _this.refId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.unitsSold, _this.unitsSold) || other.unitsSold == _this.unitsSold)&&(identical(other.timesSold, _this.timesSold) || other.timesSold == _this.timesSold)&&(identical(other.revenue, _this.revenue) || other.revenue == _this.revenue));
}


@override
int get hashCode {
  final _this = this as SoldItem;
  return Object.hash(runtimeType,_this.type,_this.refId,_this.name,_this.category,_this.unitsSold,_this.timesSold,_this.revenue);
}

@override
String toString() {
  final _this = this as SoldItem;
  return 'SoldItem(type: ${_this.type}, refId: ${_this.refId}, name: ${_this.name}, category: ${_this.category}, unitsSold: ${_this.unitsSold}, timesSold: ${_this.timesSold}, revenue: ${_this.revenue})';
}


}

/// @nodoc
abstract mixin class $SoldItemCopyWith<$Res>  {
  factory $SoldItemCopyWith(SoldItem value, $Res Function(SoldItem) _then) = _$SoldItemCopyWithImpl;
@useResult
$Res call({
 SaleItemType type, int refId, String name, String? category, int unitsSold, int timesSold, double revenue
});




}
/// @nodoc
class _$SoldItemCopyWithImpl<$Res>
    implements $SoldItemCopyWith<$Res> {
  _$SoldItemCopyWithImpl(this._self, this._then);

  final SoldItem _self;
  final $Res Function(SoldItem) _then;

/// Create a copy of SoldItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? refId = null,Object? name = null,Object? category = freezed,Object? unitsSold = null,Object? timesSold = null,Object? revenue = null,}) {
  return _then(SoldItem(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SaleItemType,refId: null == refId ? _self.refId : refId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,unitsSold: null == unitsSold ? _self.unitsSold : unitsSold // ignore: cast_nullable_to_non_nullable
as int,timesSold: null == timesSold ? _self.timesSold : timesSold // ignore: cast_nullable_to_non_nullable
as int,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SoldItem].
extension SoldItemPatterns on SoldItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SoldItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SoldItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SoldItem value)  $default,){
final _that = this;
switch (_that) {
case _SoldItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SoldItem value)?  $default,){
final _that = this;
switch (_that) {
case _SoldItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SaleItemType type,  int refId,  String name,  String? category,  int unitsSold,  int timesSold,  double revenue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SoldItem() when $default != null:
return $default(_that.type,_that.refId,_that.name,_that.category,_that.unitsSold,_that.timesSold,_that.revenue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SaleItemType type,  int refId,  String name,  String? category,  int unitsSold,  int timesSold,  double revenue)  $default,) {final _that = this;
switch (_that) {
case _SoldItem():
return $default(_that.type,_that.refId,_that.name,_that.category,_that.unitsSold,_that.timesSold,_that.revenue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SaleItemType type,  int refId,  String name,  String? category,  int unitsSold,  int timesSold,  double revenue)?  $default,) {final _that = this;
switch (_that) {
case _SoldItem() when $default != null:
return $default(_that.type,_that.refId,_that.name,_that.category,_that.unitsSold,_that.timesSold,_that.revenue);case _:
  return null;

}
}

}

/// @nodoc


class _SoldItem implements SoldItem {
  const _SoldItem({required this.type, required this.refId, required this.name, this.category, required this.unitsSold, required this.timesSold, required this.revenue});
  

@override final  SaleItemType type;
@override final  int refId;
@override final  String name;
@override final  String? category;
@override final  int unitsSold;
@override final  int timesSold;
@override final  double revenue;

/// Create a copy of SoldItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SoldItemCopyWith<_SoldItem> get copyWith => __$SoldItemCopyWithImpl<_SoldItem>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SoldItem&&(identical(other.type, type) || other.type == type)&&(identical(other.refId, refId) || other.refId == refId)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.unitsSold, unitsSold) || other.unitsSold == unitsSold)&&(identical(other.timesSold, timesSold) || other.timesSold == timesSold)&&(identical(other.revenue, revenue) || other.revenue == revenue));
}


@override
int get hashCode {
    return Object.hash(runtimeType,type,refId,name,category,unitsSold,timesSold,revenue);
}

@override
String toString() {
    return 'SoldItem(type: $type, refId: $refId, name: $name, category: $category, unitsSold: $unitsSold, timesSold: $timesSold, revenue: $revenue)';
}


}

/// @nodoc
abstract mixin class _$SoldItemCopyWith<$Res> implements $SoldItemCopyWith<$Res> {
  factory _$SoldItemCopyWith(_SoldItem value, $Res Function(_SoldItem) _then) = __$SoldItemCopyWithImpl;
@override @useResult
$Res call({
 SaleItemType type, int refId, String name, String? category, int unitsSold, int timesSold, double revenue
});




}
/// @nodoc
class __$SoldItemCopyWithImpl<$Res>
    implements _$SoldItemCopyWith<$Res> {
  __$SoldItemCopyWithImpl(this._self, this._then);

  final _SoldItem _self;
  final $Res Function(_SoldItem) _then;

/// Create a copy of SoldItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? refId = null,Object? name = null,Object? category = freezed,Object? unitsSold = null,Object? timesSold = null,Object? revenue = null,}) {
  return _then(_SoldItem(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SaleItemType,refId: null == refId ? _self.refId : refId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,unitsSold: null == unitsSold ? _self.unitsSold : unitsSold // ignore: cast_nullable_to_non_nullable
as int,timesSold: null == timesSold ? _self.timesSold : timesSold // ignore: cast_nullable_to_non_nullable
as int,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$TopCustomer {

 int get id; String get name; int get purchases; double get spent;
/// Create a copy of TopCustomer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TopCustomerCopyWith<TopCustomer> get copyWith => _$TopCustomerCopyWithImpl<TopCustomer>(this as TopCustomer, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TopCustomer;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TopCustomer&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.purchases, _this.purchases) || other.purchases == _this.purchases)&&(identical(other.spent, _this.spent) || other.spent == _this.spent));
}


@override
int get hashCode {
  final _this = this as TopCustomer;
  return Object.hash(runtimeType,_this.id,_this.name,_this.purchases,_this.spent);
}

@override
String toString() {
  final _this = this as TopCustomer;
  return 'TopCustomer(id: ${_this.id}, name: ${_this.name}, purchases: ${_this.purchases}, spent: ${_this.spent})';
}


}

/// @nodoc
abstract mixin class $TopCustomerCopyWith<$Res>  {
  factory $TopCustomerCopyWith(TopCustomer value, $Res Function(TopCustomer) _then) = _$TopCustomerCopyWithImpl;
@useResult
$Res call({
 int id, String name, int purchases, double spent
});




}
/// @nodoc
class _$TopCustomerCopyWithImpl<$Res>
    implements $TopCustomerCopyWith<$Res> {
  _$TopCustomerCopyWithImpl(this._self, this._then);

  final TopCustomer _self;
  final $Res Function(TopCustomer) _then;

/// Create a copy of TopCustomer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? purchases = null,Object? spent = null,}) {
  return _then(TopCustomer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,purchases: null == purchases ? _self.purchases : purchases // ignore: cast_nullable_to_non_nullable
as int,spent: null == spent ? _self.spent : spent // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [TopCustomer].
extension TopCustomerPatterns on TopCustomer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TopCustomer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TopCustomer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TopCustomer value)  $default,){
final _that = this;
switch (_that) {
case _TopCustomer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TopCustomer value)?  $default,){
final _that = this;
switch (_that) {
case _TopCustomer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  int purchases,  double spent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TopCustomer() when $default != null:
return $default(_that.id,_that.name,_that.purchases,_that.spent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  int purchases,  double spent)  $default,) {final _that = this;
switch (_that) {
case _TopCustomer():
return $default(_that.id,_that.name,_that.purchases,_that.spent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  int purchases,  double spent)?  $default,) {final _that = this;
switch (_that) {
case _TopCustomer() when $default != null:
return $default(_that.id,_that.name,_that.purchases,_that.spent);case _:
  return null;

}
}

}

/// @nodoc


class _TopCustomer implements TopCustomer {
  const _TopCustomer({required this.id, required this.name, required this.purchases, required this.spent});
  

@override final  int id;
@override final  String name;
@override final  int purchases;
@override final  double spent;

/// Create a copy of TopCustomer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TopCustomerCopyWith<_TopCustomer> get copyWith => __$TopCustomerCopyWithImpl<_TopCustomer>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TopCustomer&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.purchases, purchases) || other.purchases == purchases)&&(identical(other.spent, spent) || other.spent == spent));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,purchases,spent);
}

@override
String toString() {
    return 'TopCustomer(id: $id, name: $name, purchases: $purchases, spent: $spent)';
}


}

/// @nodoc
abstract mixin class _$TopCustomerCopyWith<$Res> implements $TopCustomerCopyWith<$Res> {
  factory _$TopCustomerCopyWith(_TopCustomer value, $Res Function(_TopCustomer) _then) = __$TopCustomerCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, int purchases, double spent
});




}
/// @nodoc
class __$TopCustomerCopyWithImpl<$Res>
    implements _$TopCustomerCopyWith<$Res> {
  __$TopCustomerCopyWithImpl(this._self, this._then);

  final _TopCustomer _self;
  final $Res Function(_TopCustomer) _then;

/// Create a copy of TopCustomer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? purchases = null,Object? spent = null,}) {
  return _then(_TopCustomer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,purchases: null == purchases ? _self.purchases : purchases // ignore: cast_nullable_to_non_nullable
as int,spent: null == spent ? _self.spent : spent // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
