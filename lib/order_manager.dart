import 'dart:convert';
import 'dart:io';
import 'package:pizza_order/customer.dart';
import 'package:pizza_order/order.dart';
import 'package:pizza_order/pizza.dart';

class OrderManager {
  static const String _fileName = 'pizza_orders.json';

  static Future<void> saveOrder(Order order) async {
    try {
      final file = File(_fileName);
      List<Map<String, dynamic>> orders = [];

      if (await file.exists()) {
        final contents = await file.readAsString();
        orders = List<Map<String, dynamic>>.from(json.decode(contents));
      }

      orders.add(order.toJson());
      await file.writeAsString(json.encode(orders));
    } catch (e) {
      throw Exception('Error saving order: $e');
    }
  }

  static Future<List<Order>> loadOrders() async {
    try {
      final file = File(_fileName);
      if (!await file.exists()) return [];

      final contents = await file.readAsString();
      final List<dynamic> jsonList = json.decode(contents);

      return jsonList.map((jsonOrder) {
        return Order.fromJson(jsonOrder); // Relies on Order.fromJson
      }).toList();
    } catch (e) {
      throw Exception('Error loading orders: $e');
    }
  }
}