import 'package:app_tienda/core/database/app_database.dart';
import 'package:app_tienda/core/database/tables.dart';
import 'package:app_tienda/core/error/failure.dart';
import 'package:app_tienda/core/error/result.dart';
import 'package:app_tienda/features/customers/data/datasources/customer_local_data_source.dart';
import 'package:app_tienda/features/customers/data/repositories/customer_repository_impl.dart';
import 'package:app_tienda/features/customers/domain/entities/customer.dart';
import 'package:app_tienda/features/inventory/data/datasources/inventory_local_data_source.dart';
import 'package:app_tienda/features/products/data/datasources/product_local_data_source.dart';
import 'package:app_tienda/features/products/data/repositories/product_repository_impl.dart';
import 'package:app_tienda/features/products/domain/entities/product.dart';
import 'package:app_tienda/features/sales/data/datasources/sale_local_data_source.dart';
import 'package:app_tienda/features/sales/data/repositories/sale_repository_impl.dart';
import 'package:app_tienda/features/sales/domain/entities/cart.dart';
import 'package:app_tienda/features/sales/domain/entities/sale.dart';
import 'package:app_tienda/features/sales/domain/usecases/register_sale.dart';
import 'package:app_tienda/features/services/data/datasources/service_local_data_source.dart';
import 'package:app_tienda/features/services/data/repositories/service_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/test_database.dart';

void main() {
  late AppDatabase db;
  late RegisterSale registerSale;
  late CustomerRepositoryImpl customers;
  late ProductRepositoryImpl products;

  setUp(() async {
    db = await openTestDatabase();
    final productDs = ProductLocalDataSource(db);
    final inventoryDs = InventoryLocalDataSource(db);
    customers = CustomerRepositoryImpl(CustomerLocalDataSource(db));
    products = ProductRepositoryImpl(db, productDs, inventoryDs);
    registerSale = RegisterSale(
      SaleRepositoryImpl(db, SaleLocalDataSource(db), productDs, inventoryDs),
      customers,
      products,
      ServiceRepositoryImpl(ServiceLocalDataSource(db)),
    );
  });

  tearDown(() => db.close());

  test('el esquema se crea con las 9 tablas y la semilla', () async {
    final tables = await db.db.rawQuery("SELECT name FROM sqlite_master WHERE type='table'");
    final names = tables.map((r) => r['name']).toSet();
    expect(names, containsAll([Tables.store, Tables.appUser, Tables.category, Tables.customer, Tables.product, Tables.service, Tables.sale, Tables.saleItem, Tables.inventoryMovement]));
    expect((await db.db.query(Tables.store)).length, 1);
    expect((await db.db.query(Tables.category)).length, 6);
  });

  test('registrar venta descuenta stock y crea movimiento ligado', () async {
    final c = (await customers.insert(Customer.draft().copyWith(firstName: 'Ana', lastName: 'R'))).getOrThrow();
    final p = (await products.create(Product.draft().copyWith(name: 'Agua', price: 5), initialStock: 10)).getOrThrow();

    final result = await registerSale(Cart(
      customer: c,
      items: [CartItem(type: SaleItemType.product, refId: p.id, name: p.name, unitPrice: p.price, quantity: 3)],
      discountType: DiscountType.percent,
      discountValue: 10,
    ));

    final sale = result.getOrThrow();
    expect(sale.subtotal, 15.0);
    expect(sale.discountAmount, 1.5);
    expect(sale.total, 13.5);
    expect(sale.items.single.nameSnapshot, 'Agua');

    final after = (await products.findById(p.id)).getOrThrow()!;
    expect(after.stock, 7);

    final moves = await db.db.query(Tables.inventoryMovement, where: 'sale_id = ?', whereArgs: [sale.id]);
    expect(moves.single['quantity'], -3);
    expect(moves.single['reason'], 'sale');

    // stock denormalizado == suma firmada de movimientos
    final sum = await db.db.rawQuery('SELECT SUM(quantity) AS s FROM inventory_movement WHERE product_id = ?', [p.id]);
    expect(sum.first['s'], after.stock);
  });

  test('stock insuficiente revierte toda la transacción', () async {
    final c = (await customers.insert(Customer.draft().copyWith(firstName: 'Ana', lastName: 'R'))).getOrThrow();
    final p = (await products.create(Product.draft().copyWith(name: 'Agua', price: 5), initialStock: 2)).getOrThrow();

    final result = await registerSale(Cart(
      customer: c,
      items: [CartItem(type: SaleItemType.product, refId: p.id, name: p.name, unitPrice: p.price, quantity: 5)],
    ));

    expect(result, isA<Err<Sale>>());
    expect((result as Err).failure, isA<InsufficientStockFailure>());
    expect((await db.db.query(Tables.sale)).isEmpty, isTrue);
    expect((await db.db.query(Tables.saleItem)).isEmpty, isTrue);
    expect((await products.findById(p.id)).getOrThrow()!.stock, 2);
  });

  test('no se puede eliminar un cliente con ventas (FK RESTRICT)', () async {
    final c = (await customers.insert(Customer.draft().copyWith(firstName: 'Ana', lastName: 'R'))).getOrThrow();
    final p = (await products.create(Product.draft().copyWith(name: 'Agua', price: 5), initialStock: 5)).getOrThrow();
    await registerSale(Cart(
      customer: c,
      items: [CartItem(type: SaleItemType.product, refId: p.id, name: p.name, unitPrice: p.price)],
    ));

    final del = await customers.delete(c.id);
    expect(del, isA<Err<void>>());
    expect((del as Err).failure, isA<ReferencedEntityFailure>());
    expect((await customers.countSales(c.id)).getOrThrow(), 1);
  });
}
