import 'dart:io';
import 'pizza.dart';
import 'customer.dart';
import 'order.dart';
import 'order_manager.dart';
import 'enums.dart';
import 'exceptions.dart';

/// Main class for testing the pizza ordering system
/// Author: [Your Name]
/// Registration: [Your Registration Number]
class PizzaTester {
  static Future<void> main(List<String> args) async {
    print('=== Pizza Ordering System ===');

    // Load existing orders
    await OrderManager.displaySavedOrders();

    // Get number of pizzas from command line or prompt
    int numPizzas = 1;
    if (args.isNotEmpty) {
      numPizzas = int.tryParse(args[0]) ?? 1;
    } else {
      stdout.write('Enter number of pizzas to order (default 1): ');
      final input = stdin.readLineSync();
      numPizzas = int.tryParse(input ?? '1') ?? 1;
    }

    // Get customer details
    print('\n=== Customer Information ===');
    stdout.write('Name: ');
    final name = stdin.readLineSync() ?? 'Unknown';
    stdout.write('Address: ');
    final address = stdin.readLineSync() ?? 'Unknown';
    stdout.write('Phone Number: ');
    final phoneNumber = stdin.readLineSync() ?? 'Unknown';

    final customer = Customer(name, address, phoneNumber);

    // Get order type
    OrderType orderType;
    while (true) {
      stdout.write('Order type (Delivery/Pickup): ');
      final input = stdin.readLineSync()?.toUpperCase();
      if (input == 'DELIVERY') {
        orderType = OrderType.DELIVERY;
        break;
      } else if (input == 'PICKUP') {
        orderType = OrderType.PICKUP;
        break;
      }
      print('Invalid input. Please enter "Delivery" or "Pickup".');
    }

    // Create pizzas
    final List<Pizza> pizzas = [];
    for (int i = 0; i < numPizzas; i++) {
      print('\n=== Pizza ${i + 1} Details ===');
      pizzas.add(await _createPizza());
    }

    // Create and save order
    final order = Order(customer, pizzas, orderType);
    await OrderManager.saveOrder(order);

    // Display order summary
    print('\n=== Order Summary ===');
    print(order);
    print('Order saved successfully!');
  }

  static Future<Pizza> _createPizza() async {
    while (true) {
      try {
        // Get number of slices
        stdout.write('Number of slices (default 8): ');
        final slicesInput = stdin.readLineSync();
        final numSlices = int.tryParse(slicesInput ?? '8') ?? 8;

        // Display meat options
        print('\nMeat Options:');
        for (var type in MeatType.values) {
          print('- ${type.toString().split('.').last}');
        }
        stdout.write('Select meat: ');
        final meatInput = stdin.readLineSync()?.toUpperCase();
        final meatChoice = MeatType.values.firstWhere(
              (e) => e.toString() == 'MeatType.$meatInput',
          orElse: () => throw InvalidPizzaException('Invalid meat choice'),
        );

        // Display veggie options
        print('\nVeggie Options:');
        for (var type in VeggieType.values) {
          print('- ${type.toString().split('.').last}');
        }
        stdout.write('Select veggie: ');
        final vegInput = stdin.readLineSync()?.toUpperCase();
        final vegChoice = VeggieType.values.firstWhere(
              (e) => e.toString() == 'VeggieType.$vegInput',
          orElse: () => throw InvalidPizzaException('Invalid veggie choice'),
        );

        // Display crust options
        print('\nCrust Options:');
        for (var type in CrustType.values) {
          print('- ${type.toString().split('.').last}');
        }
        stdout.write('Select crust: ');
        final crustInput = stdin.readLineSync()?.toUpperCase();
        final crustType = CrustType.values.firstWhere(
              (e) => e.toString() == 'CrustType.$crustInput',
          orElse: () => throw InvalidPizzaException('Invalid crust choice'),
        );

        // Display size options
        print('\nSize Options:');
        for (var type in Size.values) {
          print('- ${type.toString().split('.').last}');
        }
        stdout.write('Select size: ');
        final sizeInput = stdin.readLineSync()?.toUpperCase();
        final size = Size.values.firstWhere(
              (e) => e.toString() == 'Size.$sizeInput',
          orElse: () => throw InvalidPizzaException('Invalid size choice'),
        );

        // Display topping options
        print('\nTopping Options (select multiple, comma separated):');
        for (var type in Topping.values) {
          print('- ${type.toString().split('.').last}');
        }
        stdout.write('Select toppings: ');
        final toppingsInput = stdin.readLineSync()?.toUpperCase();
        final toppings = toppingsInput?.split(',')
            .map((s) => s.trim())
            .map((s) => Topping.values.firstWhere(
              (e) => e.toString() == 'Topping.$s',
          orElse: () => throw InvalidPizzaException('Invalid topping: $s'),
        ))
            .toSet() ?? {};

        return Pizza.custom(
          numSlices: numSlices,
          meatChoice: meatChoice,
          vegChoice: vegChoice,
          crustType: crustType,
          toppings: toppings,
          size: size,
        );
      } on InvalidPizzaException catch (e) {
        print('Error: ${e.message}');
        print('Please try again.\n');
      } catch (e) {
        print('Error: $e');
        print('Please try again.\n');
      }
    }
  }
}