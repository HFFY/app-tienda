# App Tienda

Aplicación móvil **Android** para la gestión de una tienda pequeña: clientes, inventario de productos, menú de servicios, registro de ventas y reportes mensuales. Funciona **100 % sin conexión** con una base de datos SQLite local; no requiere backend ni cuenta en la nube.

> Plataformas: **solo Android** (minSdk 24 / targetSdk 36). iOS, web y escritorio no están soportados y no existen sus carpetas de proyecto.

## Funcionalidades

| Módulo | Qué hace |
|---|---|
| Acceso | Onboarding en la primera ejecución, login local con contraseña hasheada (PBKDF2‑HMAC‑SHA256 + salt), sesión persistente, cambio de contraseña. |
| Clientes | CRUD, búsqueda por nombre/teléfono, sexo, notas, historial de compras, botón de WhatsApp. |
| Inventario | Productos con imagen, categoría, precio, stock y stock mínimo; grid con `Hero`; movimientos de entrada/salida/ajuste; kardex con saldo. |
| Servicios | CRUD con duración, categoría e imagen. |
| Categorías | Compartidas por productos y servicios, con alcance, color e ícono; reordenables. |
| Ventas | Carrito con productos y servicios, descuento por porcentaje o monto, **transacción atómica** que descuenta stock y registra movimientos. Las ventas son inmutables. |
| Reportes | Por mes: ingreso bruto (productos / servicios), ventas y unidades, mejor cliente, descuentos; barras por día; torta por categoría; ranking de lo más vendido. |
| Configuración | Datos y logo de la tienda, 3 temas de color (rojo / negro / azul) claro/oscuro/sistema, moneda y formato numérico configurables, respaldo `.db` compartible por email u otras apps. |

## Cómo ejecutar

Requisitos: Flutter 3.47.x (stable), Dart ≥ 3.13, Android SDK con un emulador o dispositivo API 24+.

```sh
flutter pub get
dart run build_runner build -d      # genera *.freezed.dart (ya están versionados)
flutter run                          # debug en el dispositivo conectado
flutter test                         # pruebas de dominio y de base de datos
```

Al abrir por primera vez, la app muestra el **onboarding** para crear la cuenta y nombrar la tienda. Para probar los reportes con datos, en *Configuración* mantén presionado el texto de versión al pie: carga clientes, productos, servicios y unas 60 ventas de demostración de los últimos 3 meses.

### APK de release

```sh
flutter build apk --release --split-per-abi
# → build/app/outputs/flutter-apk/app-arm64-v8a-release.apk
```

La firma se toma de `android/key.properties` + `android/upload-keystore.jks` (no versionados). Si no existen, el APK se firma con la clave de debug. Para generar la clave propia:

```sh
keytool -genkeypair -v -keystore android/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

y crear `android/key.properties` con `storePassword`, `keyPassword`, `keyAlias=upload` y `storeFile=upload-keystore.jks`.

## Arquitectura

Clean architecture por *feature* (`lib/features/<feature>/{domain,data,presentation}`), estado con **Riverpod 3** (sin codegen), navegación con **go_router**, entidades inmutables con **freezed**, persistencia con **sqflite** (SQL a la vista en `lib/core/database/migrations.dart`).

- `domain/` no importa Flutter ni sqflite: entidades, interfaces de repositorio y casos de uso.
- `data/` implementa los repositorios; los DataSources manejan solo `Map` y aceptan una transacción opcional.
- `presentation/` habla con casos de uso vía providers.
- Los repositorios devuelven `Result<T>` (`Ok` / `Err(Failure)`); ningún error de SQLite cruza capas sin tipar.

### Decisiones de diseño

- **Snapshots en el detalle de venta** (`name_snapshot`, `category_snapshot`, `unit_price`): cambiar el precio o la categoría de un producto no altera las ventas históricas.
- **Ventas inmutables, sin anulación.** Una venta mal registrada se corrige con un movimiento de ajuste de inventario.
- **`is_active` en lugar de borrado físico** cuando la entidad tiene transacciones; `ON DELETE RESTRICT` como red de seguridad. Las categorías sí pueden borrarse: los productos quedan "Sin categoría" (`ON DELETE SET NULL`).
- **Stock denormalizado** en `product.stock`, pero **toda** escritura pasa por una única sentencia (`applyStockDelta`) dentro de la misma transacción que inserta el movimiento; `stock` es siempre la suma firmada de `inventory_movement`.
- **Fechas ISO‑8601 en UTC.** Los límites de mes de los reportes se calculan en hora local y se convierten a UTC; la agrupación por día se hace en local.
- **Respaldo con `VACUUM INTO`** (SQLite ≥ 3.27); en Android 7–9 se cierra la conexión, se copia el archivo y se reabre.
- **Ingreso bruto, no utilidad:** no se registra costo de producto, así que los reportes muestran lo facturado.

## Fuera de alcance (mejoras futuras)

- Anulación o edición de ventas registradas.
- Costo de producto y cálculo de utilidad.
- Roles y permisos de usuario.
- Restauración de un respaldo desde la app.
- Exportación de reportes a PDF/CSV.
- Ventas a "consumidor final" sin cliente.
- Otros idiomas, sincronización en la nube, multi‑dispositivo.

El documento de diseño completo está en [PLAN.md](PLAN.md).
