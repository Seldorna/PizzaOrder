import 'package:flutter/material.dart';
import 'package:pizza_order/enums.dart';

class OrderSummary extends StatelessWidget {
  final Size size;
  final CrustType crust;
  final MeatType? meat;
  final VeggieType? veggie;
  final Set<Topping> toppings;
  final int numSlices;
  final bool isDelivery;
  final String customerName;
  final String customerAddress;
  final String customerPhone;

  const OrderSummary({
    super.key,
    required this.size,
    required this.crust,
    required this.meat,
    required this.veggie,
    required this.toppings,
    required this.numSlices,
    required this.isDelivery,
    required this.customerName,
    required this.customerAddress,
    required this.customerPhone,
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
              'Order Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Text('Customer: $customerName'),
            Text('Phone: $customerPhone'),
            if (isDelivery) Text('Address: $customerAddress'),
            Text('Order Type: ${isDelivery ? 'Delivery' : 'Pickup'}'),
            const SizedBox(height: 20),
            const Text(
              'Pizza Details',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('• Size: ${size.toString().split('.').last}'),
            Text('• Crust: ${crust.toString().split('.').last}'),
            if (meat != null) Text('• Meat: ${meat.toString().split('.').last}'),
            if (veggie != null) Text('• Veggie: ${veggie.toString().split('.').last}'),
            Text('• Toppings: ${toppings.isNotEmpty
                ? toppings.map((t) => t.toString().split('.').last).join(', ')
                : 'None'}'),
            Text('• Slices: $numSlices'),
            const SizedBox(height: 20),
            const Text(
              'Estimated Price: \$12.99', // You would calculate this from your backend
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}