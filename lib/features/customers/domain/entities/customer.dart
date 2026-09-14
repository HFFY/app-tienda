import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer.freezed.dart';

enum Gender {
  female('F', 'Femenino'),
  male('M', 'Masculino'),
  unspecified('U', 'Sin determinar');

  const Gender(this.dbValue, this.label);

  final String dbValue;
  final String label;

  static Gender fromDb(String? v) =>
      values.firstWhere((e) => e.dbValue == v, orElse: () => Gender.unspecified);
}

@freezed
abstract class Customer with _$Customer {
  const Customer._();

  const factory Customer({
    required int id,
    required String firstName,
    required String lastName,
    String? phone,
    String? notes,
    @Default(Gender.unspecified) Gender gender,
    @Default(true) bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Customer;

  factory Customer.draft() {
    final now = DateTime.now().toUtc();
    return Customer(id: 0, firstName: '', lastName: '', createdAt: now, updatedAt: now);
  }

  bool get isNew => id == 0;

  String get fullName => '$firstName $lastName'.trim();

  String get initials {
    final f = firstName.trim().isEmpty ? '' : firstName.trim()[0];
    final l = lastName.trim().isEmpty ? '' : lastName.trim()[0];
    final r = (f + l).toUpperCase();
    return r.isEmpty ? '?' : r;
  }

  bool get hasPhone => phone != null && phone!.trim().isNotEmpty;
}

/// Historial de compras de un cliente.
@freezed
abstract class CustomerStats with _$CustomerStats {
  const factory CustomerStats({
    required int salesCount,
    required double totalSpent,
    DateTime? lastPurchaseAt,
  }) = _CustomerStats;
}
