import '../../../../core/database/local_data_source.dart';
import '../../../../core/database/tables.dart';
import '../../../../core/utils/clock.dart';
import '../../domain/entities/customer.dart';

Customer customerFromMap(Map<String, Object?> m) => Customer(
      id: m[CustomerCols.id] as int,
      firstName: m[CustomerCols.firstName] as String,
      lastName: m[CustomerCols.lastName] as String,
      phone: m[CustomerCols.phone] as String?,
      notes: m[CustomerCols.notes] as String?,
      gender: Gender.fromDb(m[CustomerCols.gender] as String?),
      isActive: dbBool(m[CustomerCols.isActive]),
      createdAt: parseUtc(m[CustomerCols.createdAt] as String),
      updatedAt: parseUtc(m[CustomerCols.updatedAt] as String),
    );

extension CustomerMapper on Customer {
  Map<String, Object?> toInsertMap() {
    final now = nowUtcIso();
    return {
      CustomerCols.firstName: firstName,
      CustomerCols.lastName: lastName,
      CustomerCols.phone: phone,
      CustomerCols.notes: notes,
      CustomerCols.gender: gender.dbValue,
      CustomerCols.isActive: dbInt(isActive),
      CustomerCols.createdAt: now,
      CustomerCols.updatedAt: now,
    };
  }

  Map<String, Object?> toUpdateMap() => {
        CustomerCols.firstName: firstName,
        CustomerCols.lastName: lastName,
        CustomerCols.phone: phone,
        CustomerCols.notes: notes,
        CustomerCols.gender: gender.dbValue,
        CustomerCols.updatedAt: nowUtcIso(),
      };
}
