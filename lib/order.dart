import 'customer.dart';
import 'pizza.dart';
import 'enums.dart';

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
  }) : orderId = orderId ?? _generateOrderId(),
       orderDate = orderDate ?? DateTime.now(),
       discount = pizzas.length > 1 ? 0.05 : 0.0;

  static String _generateOrderId() =>
      'ORD${DateTime.now().millisecondsSinceEpoch}';

  double get totalPrice {
    return pizzas.fold(0.0, (sum, pizza) => sum + pizza.calculatePrice()) *
        (1 - discount);
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      customer: Customer.fromJson(json['customer']),
      pizzas: (json['pizzas'] as List)
          .map((pizzaJson) => Pizza.fromJson(pizzaJson))
          .toList(),
      orderType: OrderType.values.firstWhere(
        (e) => e.toString() == json['orderType'],
        orElse: () => OrderType.delivery,
      ),
      orderId: json['orderId'],
      orderDate: DateTime.parse(json['orderDate']),
    );
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

  @override
  String toString() {
    return 'Order #$orderId (${orderDate.toLocal()})\n'
        'Customer: ${customer.name}\n'
        'Pizzas: ${pizzas.length}\n'
        'Total: \$${totalPrice.toStringAsFixed(2)}';
  }
}
