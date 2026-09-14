/// Versión actual del esquema. Al incrementarla, añadir las sentencias
/// incrementales en [upgrades] bajo la nueva versión.
const int kSchemaVersion = 1;

/// DDL completo de la versión 1. Una sentencia por string: sqflite no
/// ejecuta múltiples sentencias en un solo `execute`.
const List<String> schemaV1 = [
  // ─── Tienda (registro único) ───────────────────────────────────────────
  '''
  CREATE TABLE store (
    id                    INTEGER PRIMARY KEY CHECK (id = 1),
    name                  TEXT    NOT NULL,
    logo_path             TEXT,
    address               TEXT,
    phone                 TEXT,
    theme_color           TEXT    NOT NULL DEFAULT 'red'
                                  CHECK (theme_color IN ('red','black','blue')),
    theme_mode            TEXT    NOT NULL DEFAULT 'system'
                                  CHECK (theme_mode IN ('light','dark','system')),
    currency_symbol       TEXT    NOT NULL DEFAULT 'Bs',
    currency_code         TEXT    NOT NULL DEFAULT 'BOB',
    number_locale         TEXT    NOT NULL DEFAULT 'es_BO',
    decimal_places        INTEGER NOT NULL DEFAULT 2 CHECK (decimal_places BETWEEN 0 AND 2),
    whatsapp_country_code TEXT    NOT NULL DEFAULT '591',
    last_backup_at        TEXT,
    created_at            TEXT    NOT NULL,
    updated_at            TEXT    NOT NULL
  )
  ''',

  // ─── Usuario de la aplicación ──────────────────────────────────────────
  '''
  CREATE TABLE app_user (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name    TEXT NOT NULL,
    last_name     TEXT NOT NULL,
    email         TEXT NOT NULL UNIQUE COLLATE NOCASE,
    password_hash TEXT NOT NULL,
    password_salt TEXT NOT NULL,
    created_at    TEXT NOT NULL,
    updated_at    TEXT NOT NULL
  )
  ''',

  // ─── Categorías ────────────────────────────────────────────────────────
  '''
  CREATE TABLE category (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    name       TEXT    NOT NULL UNIQUE COLLATE NOCASE,
    scope      TEXT    NOT NULL DEFAULT 'both'
                       CHECK (scope IN ('product','service','both')),
    color_hex  TEXT,
    icon_code  INTEGER,
    sort_order INTEGER NOT NULL DEFAULT 0,
    is_active  INTEGER NOT NULL DEFAULT 1,
    created_at TEXT    NOT NULL,
    updated_at TEXT    NOT NULL
  )
  ''',
  'CREATE INDEX idx_category_active ON category(is_active, sort_order)',

  // ─── Clientes ──────────────────────────────────────────────────────────
  '''
  CREATE TABLE customer (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name  TEXT    NOT NULL,
    last_name   TEXT    NOT NULL,
    phone       TEXT,
    notes       TEXT,
    gender      TEXT    NOT NULL DEFAULT 'U' CHECK (gender IN ('F','M','U')),
    is_active   INTEGER NOT NULL DEFAULT 1,
    created_at  TEXT    NOT NULL,
    updated_at  TEXT    NOT NULL
  )
  ''',
  'CREATE INDEX idx_customer_active ON customer(is_active)',
  'CREATE INDEX idx_customer_name ON customer(last_name, first_name)',

  // ─── Productos ─────────────────────────────────────────────────────────
  '''
  CREATE TABLE product (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    category_id INTEGER REFERENCES category(id) ON DELETE SET NULL,
    name        TEXT    NOT NULL,
    description TEXT,
    price       REAL    NOT NULL CHECK (price >= 0),
    image_path  TEXT,
    stock       INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0),
    min_stock   INTEGER NOT NULL DEFAULT 0,
    is_active   INTEGER NOT NULL DEFAULT 1,
    created_at  TEXT    NOT NULL,
    updated_at  TEXT    NOT NULL
  )
  ''',
  'CREATE INDEX idx_product_active ON product(is_active)',
  'CREATE INDEX idx_product_category ON product(category_id)',

  // ─── Servicios ─────────────────────────────────────────────────────────
  '''
  CREATE TABLE service (
    id               INTEGER PRIMARY KEY AUTOINCREMENT,
    category_id      INTEGER REFERENCES category(id) ON DELETE SET NULL,
    name             TEXT    NOT NULL,
    description      TEXT,
    price            REAL    NOT NULL CHECK (price >= 0),
    image_path       TEXT,
    duration_minutes INTEGER NOT NULL DEFAULT 30 CHECK (duration_minutes > 0),
    is_active        INTEGER NOT NULL DEFAULT 1,
    created_at       TEXT    NOT NULL,
    updated_at       TEXT    NOT NULL
  )
  ''',
  'CREATE INDEX idx_service_active ON service(is_active)',
  'CREATE INDEX idx_service_category ON service(category_id)',

  // ─── Ventas (inmutables) ───────────────────────────────────────────────
  '''
  CREATE TABLE sale (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id     INTEGER NOT NULL REFERENCES customer(id) ON DELETE RESTRICT,
    sale_date       TEXT    NOT NULL,
    subtotal        REAL    NOT NULL CHECK (subtotal >= 0),
    discount_type   TEXT    NOT NULL DEFAULT 'none'
                            CHECK (discount_type IN ('none','percent','amount')),
    discount_value  REAL    NOT NULL DEFAULT 0 CHECK (discount_value >= 0),
    discount_amount REAL    NOT NULL DEFAULT 0 CHECK (discount_amount >= 0),
    total           REAL    NOT NULL CHECK (total >= 0),
    note            TEXT,
    created_at      TEXT    NOT NULL
  )
  ''',
  'CREATE INDEX idx_sale_date ON sale(sale_date)',
  'CREATE INDEX idx_sale_customer ON sale(customer_id)',

  // ─── Detalle de venta ──────────────────────────────────────────────────
  '''
  CREATE TABLE sale_item (
    id                INTEGER PRIMARY KEY AUTOINCREMENT,
    sale_id           INTEGER NOT NULL REFERENCES sale(id) ON DELETE CASCADE,
    item_type         TEXT    NOT NULL CHECK (item_type IN ('product','service')),
    product_id        INTEGER REFERENCES product(id) ON DELETE RESTRICT,
    service_id        INTEGER REFERENCES service(id) ON DELETE RESTRICT,
    name_snapshot     TEXT    NOT NULL,
    category_snapshot TEXT,
    unit_price        REAL    NOT NULL CHECK (unit_price >= 0),
    quantity          INTEGER NOT NULL CHECK (quantity > 0),
    line_total        REAL    NOT NULL CHECK (line_total >= 0),
    CHECK (
      (item_type = 'product' AND product_id IS NOT NULL AND service_id IS NULL) OR
      (item_type = 'service' AND service_id IS NOT NULL AND product_id IS NULL)
    )
  )
  ''',
  'CREATE INDEX idx_sale_item_sale ON sale_item(sale_id)',
  'CREATE INDEX idx_sale_item_product ON sale_item(product_id)',
  'CREATE INDEX idx_sale_item_service ON sale_item(service_id)',

  // ─── Movimientos de inventario (cantidad firmada) ──────────────────────
  '''
  CREATE TABLE inventory_movement (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    product_id    INTEGER NOT NULL REFERENCES product(id) ON DELETE RESTRICT,
    movement_type TEXT    NOT NULL CHECK (movement_type IN ('in','out','adjustment')),
    quantity      INTEGER NOT NULL CHECK (quantity <> 0),
    reason        TEXT    NOT NULL
                          CHECK (reason IN ('initial','purchase','sale','loss','manual')),
    sale_id       INTEGER REFERENCES sale(id) ON DELETE SET NULL,
    note          TEXT,
    moved_at      TEXT    NOT NULL,
    created_at    TEXT    NOT NULL
  )
  ''',
  'CREATE INDEX idx_movement_product ON inventory_movement(product_id, moved_at)',
];

/// Scripts incrementales por versión destino. `onUpgrade` aplica, en orden,
/// `upgrades[oldVersion + 1] … upgrades[newVersion]`.
const Map<int, List<String>> upgrades = {};
