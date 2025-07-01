import 'package:pizza_order/enums.dart';
import 'package:pizza_order/pizza.dart';

void main() {
  // Test Pizza Creation
  final testPizza = Pizza.custom(
    numSlices: 8,
    meatChoice: MeatType.pepperoni,
    vegChoice: VeggieType.mushrooms,
    crustType: CrustType.thin,
    toppings: {Topping.cheese, Topping.olives},
    size: Size.large,
  );

  print('--- Pizza Test ---');
  print('Slices: ${testPizza.numSlices}');
  print('Meat: ${testPizza.meatChoice}');
  print('Veggie: ${testPizza.vegChoice}');
  print('Toppings: ${testPizza.toppings}');

  // Test JSON Serialization
  final pizzaJson = testPizza.toJson();
  print('\n--- Pizza JSON ---');
  print(pizzaJson);

  final pizzaFromJson = Pizza.fromJson(pizzaJson);
  print('\n--- Pizza from JSON ---');
  print('Slices: ${pizzaFromJson.numSlices}');
  print('Meat: ${pizzaFromJson.meatChoice}');
}

// Add to pizza_tester.dart
void testOrderSerialization() {
  final customer = Customer(
    name: "John Doe",
    address: "123 Pizza St",
    phoneNumber: "555-1234",
  );

  final order = Order(
    customer: customer,
    pizzas: [testPizza], // From previous test
    orderType: OrderType.delivery,
  );

  print('\n--- Order JSON ---');
  print(order.toJson());

  final orderFromJson = Order.fromJson(order.toJson());
  print('\n--- Order from JSON ---');
  print(orderFromJson);
}
