import 'package:flutter/material.dart';
import 'package:pizza_order/enums.dart';
import 'package:pizza_order/ui/screens/confirmation_screen.dart';
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
  bool _isDelivery = false;
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _validateAndNavigate() {
    if (_selectedMeat == null || _selectedVeggie == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select meat and veggie options')),
      );
      return;
    }

    if (_nameController.text.isEmpty || _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your name and phone number')),
      );
      return;
    }

    if (_isDelivery && _addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter delivery address')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmationScreen(
          size: widget.selectedSize,
          crust: widget.selectedCrust,
          meat: _selectedMeat!,
          veggie: _selectedVeggie!,
          toppings: _selectedToppings,
          numSlices: _numSlices,
          isDelivery: _isDelivery,
          customerName: _nameController.text,
          customerAddress: _addressController.text,
          customerPhone: _phoneController.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customize Your Pizza'),
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
            // Pizza Preview Card
            PizzaCard(
              size: widget.selectedSize,
              crust: widget.selectedCrust,
              meat: _selectedMeat,
              veggie: _selectedVeggie,
              toppings: _selectedToppings,
              numSlices: _numSlices,
            ),

            // ... [Keep all your existing customization widgets here] ...

            // Bottom action buttons
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Back Button
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    side: BorderSide(color: Colors.orange[800]!),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Back',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),

                // Confirm Order Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    backgroundColor: Colors.orange[800],
                  ),
                  onPressed: _validateAndNavigate,
                  child: const Text(
                    'Confirm Order',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}