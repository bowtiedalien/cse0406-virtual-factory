import 'package:path/path.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:virtual_factory/model/customer.dart';
import 'package:virtual_factory/model/order.dart';
import 'package:virtual_factory/model/order_item.dart';
import 'package:virtual_factory/model/product.dart';
import 'package:virtual_factory/model/user.dart';

class VirtualFactory {
  static final VirtualFactory instance = VirtualFactory._init();

  static Database? _database;

  VirtualFactory._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('virtualFactory.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final intType = 'INTEGER NOT NULL';
    final statusType =
        'TEXT NOT NULL DEFAULT \'${enumOrderStatus.unconfirmed.toString()}\'';

    // Customers table
    await db.execute('''
    CREATE TABLE $tableCustomers(
      ${CustomerFields.id} $idType,
      ${CustomerFields.name} $textType,
      ${CustomerFields.password} $textType
    )
    ''');

    // Users table
    await db.execute('''
    CREATE TABLE $tableUsers(
      ${UserFields.id} $idType,
      ${UserFields.name} $textType,
      ${UserFields.password} $textType
    )
    ''');

    // Orders table
    await db.execute('''
    CREATE TABLE $tableOrders(
      ${OrderFields.id} $idType,
      ${OrderFields.customerId} $intType,
      ${OrderFields.orderDate} $textType,
      ${OrderFields.deadline} $textType,
      ${OrderFields.status} $statusType
    )
    ''');

    // Order Items table
    await db.execute('''
    CREATE TABLE $tableOrderItems(
      ${OrderItemFields.id} $idType,
      ${OrderItemFields.orderId} $intType,
      ${OrderItemFields.productId} $intType,
      ${OrderItemFields.amount} $intType
    )
    ''');

    // Products table
    await db.execute('''
    CREATE TABLE $tableProducts(
      ${ProductFields.id} $idType,
      ${ProductFields.name} $textType,
      ${ProductFields.productType} $textType,
      ${ProductFields.isSalable} $boolType
    )
    ''');
  }

  Future<Customer> createCustomer(Customer customer) async {
    final db = await instance.database;

    final id = await db.insert(tableCustomers, customer.toJson());

    return customer.copy(id: id);
  }

  Future<Customer> getCustomer(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableCustomers,
      columns: CustomerFields.values,
      where: '${CustomerFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Customer.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<User> addUser(User user) async {
    final db = await instance.database;

    final id = await db.insert(tableUsers, user.toJson());

    return user.copy(id: id);
  }

  Future<User> getUser(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableUsers,
      columns: UserFields.values,
      where: '${UserFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<Order> createOrder(Order order) async {
    final db = await instance.database;

    final id = await db.insert(tableOrders, order.toJson());

    return order.copy(id: id);
  }

  Future<Order> getOrder(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableOrders,
      columns: OrderFields.values,
      where: '${OrderFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Order.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Order>> getUnconfirmedOrders() async {
    final db = await instance.database;

    final orderBy = '${OrderFields.orderDate} ASC';
    var result = List.empty();
    try {
      result = await db.query(tableOrders,
          orderBy: orderBy,
          where: '${OrderFields.status} = ?',
          whereArgs: [enumOrderStatus.unconfirmed.toString()]);
      return result.map((json) => Order.fromJson(json)).toList();
    } catch (err) {
      print('Error in comfirmed getter: ' + err.toString());
      result = List<Order>.empty();
      return result.map((json) => Order.fromJson(json)).toList();
    }
  }

  Future<List<Order>> getConfirmedOrders() async {
    final db = await instance.database;

    final orderBy = '${OrderFields.orderDate} ASC';

    var result = List.empty();
    try {
      result = await db.query(tableOrders,
          orderBy: orderBy,
          where: '${OrderFields.status} = ? OR ${OrderFields.status} = ?',
          whereArgs: [
            enumOrderStatus.scheduled.toString(),
            enumOrderStatus.delivered.toString()
          ]);

      return result.map((json) => Order.fromJson(json)).toList();
    } catch (err) {
      print('Error in uncomfirmed getter: ' + err.toString());
      result = List<Order>.empty();
      return result.map((json) => Order.fromJson(json)).toList();
    }
  }

  Future<List<Order>> getAllOrders() async {
    final db = await instance.database;

    final orderBy = '${OrderFields.orderDate} ASC';
    final result = await db.query(tableOrders, orderBy: orderBy);

    return result.map((json) => Order.fromJson(json)).toList();
  }

  Future<int> updateOrderStatus(Order order) async {
    final db = await instance.database;
    return db.update(
      tableOrders,
      order.toJson(),
      where: '${OrderFields.id} = ?',
      whereArgs: [order.id],
    );
  }

  Future<OrderItem> createOrderItem(OrderItem orderItem) async {
    final db = await instance.database;

    final id = await db.insert(tableOrderItems, orderItem.toJson());

    return orderItem.copy(id: id);
  }

  Future<OrderItem> getOrderItem(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableOrderItems,
      columns: OrderItemFields.values,
      where: '${OrderItemFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return OrderItem.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<int> deleteOrder(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableOrders,
      where: '${OrderFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
