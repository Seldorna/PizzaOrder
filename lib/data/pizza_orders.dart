import 'dart:convert';
import 'dart:io';
import 'package:pizza_order/order.dart';
import 'package:pizza_order/exceptions.dart';

class OrderRepository {
  static const String _fileName = 'pizza_orders.json';

  Future<void> saveOrder(Order order) async {
    try {
      final file = File(_fileName);
      List<Map<String, dynamic>> orders = [];

      // Read existing orders if file exists
      if (await file.exists()) {
        final contents = await file.readAsString();
        orders = List<Map<String, dynamic>>.from(json.decode(contents));
      }

      // Add new order
      orders.add(order.toJson());

      // Write back to file
      await file.writeAsString(json.encode(orders));
    } catch (e) {
      throw OrderSaveException('Failed to save order: ${e.toString()}');
    }
  }

  Future<List<Order>> loadOrders() async {
    try {
      final file = File(_fileName);
      if (!await file.exists()) {
        return [];
      }

      final contents = await file.readAsString();
      final List<dynamic> jsonList = json.decode(contents);

      return jsonList.map((jsonOrder) {
        return Order.fromJson(jsonOrder);
      }).toList();
    } catch (e) {
      throw OrderLoadException('Failed to load orders: ${e.toString()}');
    }
  }

  Future<void> clearOrders() async {
    try {
      final file = File(_fileName);
      if (await file.exists()) {
        await file.writeAsString('[]');
      }
    } catch (e) {
      throw OrderClearException('Failed to clear orders: ${e.toString()}');
    }
  }
}