import 'package:pizza_order/customer.dart';
import 'package:pizza_order/pizza.dart';
import 'package:pizza_order/enums.dart';

class Order {
  final String orderId;
  final DateTime orderDate;
  final Customer customer;
  final List<Pizza> pizzas;
  final OrderType orderType;
  final double discount;

  Order({
    required this.customer,
    required this.pizzas,
    required this.orderType,
    String? orderId,
    DateTime? orderDate,
  })  : orderId = orderId ?? _generateOrderId(),
        orderDate = orderDate ?? DateTime.now(),
        discount = pizzas.length > 1 ? 0.05 : 0.0;

  static String _generateOrderId() {
    return 'ORD${DateTime.now().millisecondsSinceEpoch}';
  }

  double get totalPrice {
    double total = pizzas.fold(0.0, (sum, pizza) => sum + pizza.calculatePrice());
    return total * (1 - discount);
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'orderDate': orderDate.toIso8601String(),
      'customer': customer.toJson(),
      'pizzas': pizzas.map((pizza) => pizza.toJson()).toList(),
      'orderType': orderType.toString(),
      'totalPrice': totalPrice,
      'discount': discount,
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      customer: Customer.fromJson(json['customer']),
      pizzas: (json['pizzas'] as List)
          .map((pizzaJson) => Pizza.fromJson(pizzaJson))
          .toList(),
      orderType: OrderType.values.firstWhere(
            (e) => e.toString() == json['orderType'],
        orElse: () => OrderType.DELIVERY, // default value if not found
      ),
      orderId: json['orderId'],
      orderDate: DateTime.parse(json['orderDate']),
    );
  }

  @override
  String toString() {
    return 'Order #$orderId (${orderDate.toLocal()})\n'
        'Customer: ${customer.name}\n'
        'Type: ${orderType.toString().split('.').last}\n'
        'Pizzas: ${pizzas.length}\n'
        'Discount: ${(discount * 100).toInt()}%\n'
        'Total: \$${totalPrice.toStringAsFixed(2)}';
  }
}