import 'package:flutter/material.dart';
import 'package:pizza_order/enums.dart';

class PizzaCard extends StatelessWidget {
  final Size size;
  final CrustType crust;
  final MeatType? meat;
  final VeggieType? veggie;
  final Set<Topping> toppings;
  final int numSlices;


  const PizzaCard({
    super.key,
    required this.size,
    required this.crust,
    required this.meat,
    required this.veggie,
    required this.toppings,
    required this.numSlices,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Pizza',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Size: ${size.toString().split('.').last}'),
            Text('Crust: ${crust.toString().split('.').last}'),
            if (meat != null) Text('Meat: ${meat.toString().split('.').last}'),
            if (veggie != null) Text('Veggie: ${veggie.toString().split('.').last}'),
            Text('Toppings: ${toppings.isNotEmpty
                ? toppings.map((t) => t.toString().split('.').last).join(', ')
                : 'None'}'),
            Text('Slices: $numSlices'),
          ],
        ),
      ),
    );
  }
}