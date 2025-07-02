import 'package:pizza_order/enums.dart';
import 'package:pizza_order/pizza.dart';

class PizzaTester {
  static void runAllTests() {
    _testPizzaCreation();
    _testPizzaJsonSerialization();
  }

  static void _testPizzaCreation() {
    final pizza = Pizza.custom(
      numSlices: 8,
      meatChoice: MeatType.pepperoni,
      vegChoice: VeggieType.mushrooms,
      crustType: CrustType.thin,
      toppings: {Topping.cheese, Topping.olives},
      size: Size.large,
    );
    
    print('=== Pizza Creation Test ===');
    print('Created pizza: $pizza');
  }

  static void _testPizzaJsonSerialization() {
    final pizza = Pizza.custom(
      numSlices: 6,
      meatChoice: MeatType.ham,
      vegChoice: VeggieType.onions,
      crustType: CrustType.thin,
      toppings: {Topping.cheese},
      size: Size.medium,
    );
    
    print('\n=== JSON Serialization Test ===');
    final json = pizza.toJson();
    print('JSON: $json');
    
    final deserialized = Pizza.fromJson(json);
    print('Deserialized: $deserialized');
  }
}