import '../../../../core/database/tables.dart';
import '../../../../core/utils/clock.dart';
import '../../domain/entities/sale.dart';

const kSaleCustomerNameCol = 'customer_name';

Sale saleFromMap(Map<String, Object?> m, {List<SaleItem> items = const []}) => Sale(
      id: m[SaleCols.id] as int,
      customerId: m[SaleCols.customerId] as int,
      saleDate: parseUtc(m[SaleCols.saleDate] as String),
      subtotal: ((m[SaleCols.subtotal] as num?) ?? 0).toDouble(),
      discountType: DiscountType.fromDb(m[SaleCols.discountType] as String?),
      discountValue: ((m[SaleCols.discountValue] as num?) ?? 0).toDouble(),
      discountAmount: ((m[SaleCols.discountAmount] as num?) ?? 0).toDouble(),
      total: ((m[SaleCols.total] as num?) ?? 0).toDouble(),
      note: m[SaleCols.note] as String?,
      createdAt: parseUtc(m[SaleCols.createdAt] as String),
      items: items,
      customerName: m[kSaleCustomerNameCol] as String?,
    );

SaleItem saleItemFromMap(Map<String, Object?> m) => SaleItem(
      id: m[SaleItemCols.id] as int,
      saleId: m[SaleItemCols.saleId] as int,
      type: SaleItemType.fromDb(m[SaleItemCols.itemType] as String?),
      productId: m[SaleItemCols.productId] as int?,
      serviceId: m[SaleItemCols.serviceId] as int?,
      nameSnapshot: m[SaleItemCols.nameSnapshot] as String,
      categorySnapshot: m[SaleItemCols.categorySnapshot] as String?,
      unitPrice: ((m[SaleItemCols.unitPrice] as num?) ?? 0).toDouble(),
      quantity: m[SaleItemCols.quantity] as int,
      lineTotal: ((m[SaleItemCols.lineTotal] as num?) ?? 0).toDouble(),
    );

extension SaleDraftMapper on SaleDraft {
  Map<String, Object?> toInsertMap() {
    final now = nowUtcIso();
    return {
      SaleCols.customerId: customerId,
      SaleCols.saleDate: now,
      SaleCols.subtotal: subtotal,
      SaleCols.discountType: discountType.dbValue,
      SaleCols.discountValue: discountValue,
      SaleCols.discountAmount: discountAmount,
      SaleCols.total: total,
      SaleCols.note: note,
      SaleCols.createdAt: now,
    };
  }
}

extension SaleDraftItemMapper on SaleDraftItem {
  Map<String, Object?> toInsertMap(int saleId) => {
        SaleItemCols.saleId: saleId,
        SaleItemCols.itemType: type.dbValue,
        SaleItemCols.productId: type == SaleItemType.product ? refId : null,
        SaleItemCols.serviceId: type == SaleItemType.service ? refId : null,
        SaleItemCols.nameSnapshot: nameSnapshot,
        SaleItemCols.categorySnapshot: categorySnapshot,
        SaleItemCols.unitPrice: unitPrice,
        SaleItemCols.quantity: quantity,
        SaleItemCols.lineTotal: lineTotal,
      };
}
