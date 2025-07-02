import 'package:flutter/material.dart';
import 'package:pizza_order/enums.dart';
import 'package:pizza_order/ui/screens/confirmation_screen.dart';
import 'package:pizza_order/ui/screens/customer_screen.dart';
import 'package:pizza_order/ui/widgets/pizza_card.dart';

class OrderScreen extends StatefulWidget {
  final Size selectedSize;
  final CrustType selectedCrust;

  const OrderScreen({
    super.key,
    required this.selectedSize,
    required this.selectedCrust,
  });

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  MeatType? _selectedMeat;
  VeggieType? _selectedVeggie;
  final Set<Topping> _selectedToppings = {};
  int _numSlices = 8;

  // Navigation method to CustomerScreen
  Future<void> _navigateToCustomerScreen(BuildContext context) async {
    final customerData = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => CustomerScreen(
          pizzaSize: widget.selectedSize,
          crustType: widget.selectedCrust,
          meatType: _selectedMeat,
          veggieType: _selectedVeggie,
          toppings: _selectedToppings,
          numSlices: _numSlices,
          initialIsDelivery: false, onSave: (Map<String, dynamic> data) { },
        ),
      ),
    );

    if (customerData != null && context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmationScreen(
            size: widget.selectedSize,
            crust: widget.selectedCrust,
            meat: _selectedMeat,
            veggie: _selectedVeggie,
            toppings: _selectedToppings,
            numSlices: _numSlices,
            isDelivery: customerData['isDelivery'],
            customerName: customerData['name'],
            customerAddress: customerData['address'],
            customerPhone: customerData['phone'],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customize Your Pizza')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pizza Preview Card
            PizzaCard(
              size: widget.selectedSize,
              crust: widget.selectedCrust,
              meat: _selectedMeat,
              veggie: _selectedVeggie,
              toppings: _selectedToppings,
              numSlices: _numSlices,
            ),

            // Meat Selection
            const SizedBox(height: 20),
            const Text('Meat:', style: TextStyle(fontSize: 18)),
            Wrap(
              spacing: 8,
              children: MeatType.values.map((meat) {
                return FilterChip(
                  label: Text(meat.toString().split('.').last),
                  selected: _selectedMeat == meat,
                  onSelected: (selected) {
                    setState(() {
                      _selectedMeat = selected ? meat : null;
                    });
                  },
                );
              }).toList(),
            ),

            // Veggie Selection
            const SizedBox(height: 20),
            const Text('Veggies:', style: TextStyle(fontSize: 18)),
            Wrap(
              spacing: 8,
              children: VeggieType.values.map((veggie) {
                return FilterChip(
                  label: Text(veggie.toString().split('.').last),
                  selected: _selectedVeggie == veggie,
                  onSelected: (selected) {
                    setState(() {
                      _selectedVeggie = selected ? veggie : null;
                    });
                  },
                );
              }).toList(),
            ),

            // Toppings Selection
            const SizedBox(height: 20),
            const Text('Additional Toppings:', style: TextStyle(fontSize: 18)),
            Wrap(
              spacing: 8,
              children: Topping.values.map((topping) {
                return FilterChip(
                  label: Text(topping.toString().split('.').last),
                  selected: _selectedToppings.contains(topping),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedToppings.add(topping);
                      } else {
                        _selectedToppings.remove(topping);
                      }
                    });
                  },
                );
              }).toList(),
            ),

            // Slice Count
            const SizedBox(height: 20),
            const Text('Number of Slices:', style: TextStyle(fontSize: 18)),
            Slider(
              value: _numSlices.toDouble(),
              min: 4,
              max: 16,
              divisions: 12,
              label: _numSlices.toString(),
              onChanged: (value) {
                setState(() {
                  _numSlices = value.toInt();
                });
              },
            ),

            // Navigation Button
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () => _navigateToCustomerScreen(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Continue to Customer Info'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}