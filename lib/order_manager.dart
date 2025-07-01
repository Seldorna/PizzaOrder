import 'dart:io';
import 'dart:convert';
import 'order.dart';
import 'customer.dart';
import 'pizza.dart';
import 'enums.dart';

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
      // Replace print with proper error handling
      throw Exception('Error saving order: $e');
    }
  }

  static Future<List<Order>> loadOrders() async {
    try {
      final file = File(_fileName);
      if (!await file.exists()) {
        return [];
      }

      final contents = await file.readAsString();
      final List<dynamic> jsonList = json.decode(contents);

      return jsonList.map((jsonOrder) {
        // Reconstruct customer using proper constructor
        final customerJson = jsonOrder['customer'];
        final customer = Customer(
          name: customerJson['name'],
          address: customerJson['address'],
          phoneNumber: customerJson['phoneNumber'],
        );

        // Reconstruct pizzas
        final List<Pizza> pizzas = [];
        for (var pizzaJson in jsonOrder['pizzas']) {
          pizzas.add(Pizza.custom(
            numSlices: pizzaJson['numSlices'],
            meatChoice: MeatType.values.firstWhere(
                  (e) => e.toString() == pizzaJson['meatChoice'],
              orElse: () => MeatType.none,
            ),
            vegChoice: VeggieType.values.firstWhere(
                  (e) => e.toString() == pizzaJson['vegChoice'],
              orElse: () => VeggieType.none,
            ),
            crustType: CrustType.values.firstWhere(
                  (e) => e.toString() == pizzaJson['crustType'],
              orElse: () => CrustType.regular,
            ),
            toppings: (pizzaJson['toppings'] as List)
                .map((t) => Topping.values.firstWhere(
                  (e) => e.toString() == t,
              orElse: () => Topping.none,
            ))
                .toSet(),
            size: Size.values.firstWhere(
                  (e) => e.toString() == pizzaJson['size'],
              orElse: () => Size.medium,
            ),
          ));
        }

        // Reconstruct order using named parameters
        return Order(
          customer: customer,
          pizzas: pizzas,
          orderType: OrderType.values.firstWhere(
                (e) => e.toString() == jsonOrder['orderType'],
            orElse: () => OrderType.DELIVERY,
          ),
        );
      }).toList();
    } catch (e) {
      throw Exception('Error loading orders: $e');
    }
  }

  static Future<void> displaySavedOrders() async {
    final orders = await loadOrders();
    if (orders.isEmpty) {
      return;
    }
    // In a real app, you would return these orders to the UI layer
    // instead of printing them
  }
}