import 'package:flutter/material.dart';
import 'package:pizza_order/enums.dart';
import 'package:pizza_order/ui/widgets/pizza_card.dart';

class ConfirmationScreen extends StatelessWidget {
  final Size size;
  final CrustType crust;
  final MeatType meat;
  final VeggieType veggie;
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
      appBar: AppBar(
        title: const Text('Order Confirmation'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pizza Preview
            Center(
              child: PizzaCard(
                size: size,
                crust: crust,
                meat: meat,
                veggie: veggie,
                toppings: toppings,
                numSlices: numSlices,
                showFullDetails: true,
              ),
            ),

            const SizedBox(height: 24),
            const Divider(thickness: 1),
            const SizedBox(height: 16),

            // Order Summary
            const Text(
              'ORDER SUMMARY',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildDetailRow('Size', size.toString().split('.').last),
            _buildDetailRow('Crust', crust.toString().split('.').last),
            _buildDetailRow('Meat', meat.toString().split('.').last),
            _buildDetailRow('Veggie', veggie.toString().split('.').last),
            _buildDetailRow(
              'Toppings', 
              toppings.isNotEmpty 
                ? toppings.map((t) => t.toString().split('.').last).join(', ')
                : 'None'
            ),
            _buildDetailRow('Slices', numSlices.toString()),

            const SizedBox(height: 24),
            const Divider(thickness: 1),
            const SizedBox(height: 16),

            // Customer Info
            const Text(
              'CUSTOMER DETAILS',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildDetailRow('Name', customerName),
            _buildDetailRow('Phone', customerPhone),
            _buildDetailRow(
              'Order Type', 
              isDelivery ? 'Delivery' : 'Pickup'
            ),
            if (isDelivery) _buildDetailRow('Address', customerAddress),

            const SizedBox(height: 32),
            
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    side: BorderSide(color: Colors.orange[800]!),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Edit Order',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    backgroundColor: Colors.orange[800],
                  ),
                  onPressed: () {
                    // TODO: Implement order submission logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Order placed successfully!')),
                    );
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: const Text(
                    'Place Order',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}