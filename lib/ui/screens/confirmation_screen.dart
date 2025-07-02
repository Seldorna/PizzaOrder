import 'package:flutter/material.dart';
import 'package:pizza_order/enums.dart';
import 'package:pizza_order/ui/widgets/order_summary.dart';

class ConfirmationScreen extends StatelessWidget {
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

  const ConfirmationScreen({
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
    return Scaffold(
      appBar: AppBar(title: const Text('Order Confirmation')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Thank you for your order!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            OrderSummary(
              size: size,
              crust: crust,
              meat: meat,
              veggie: veggie,
              toppings: toppings,
              numSlices: numSlices,
              isDelivery: isDelivery,
              customerName: customerName,
              customerAddress: customerAddress,
              customerPhone: customerPhone,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Here you would save the order to the backend
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Send'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Here you would save the order to the backend
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}