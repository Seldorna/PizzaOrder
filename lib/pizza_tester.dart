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