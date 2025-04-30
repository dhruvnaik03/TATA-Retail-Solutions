import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/product.dart';
import '../models/invoice.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('gstbilling.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        price REAL NOT NULL,
        gstRate REAL NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE invoices (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL,
        totalAmount REAL NOT NULL
      )
    ''');
  }

  Future<int> insertProduct(Product product) async {
    final db = await instance.database;
    return await db.insert('products', product.toMap());
  }

  Future<List<Product>> fetchProducts() async {
    final db = await instance.database;
    final result = await db.query('products');
    return result.map((map) => Product.fromMap(map)).toList();
  }

  Future<int> insertInvoice(Invoice invoice) async {
    final db = await instance.database;
    return await db.insert('invoices', invoice.toMap());
  }

  Future<List<Invoice>> fetchInvoices() async {
    final db = await instance.database;
    final result = await db.query('invoices');
    return result.map((map) => Invoice.fromMap(map)).toList();
  }
}
