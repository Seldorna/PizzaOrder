import 'package:flutter/material.dart';
import 'package:pizza_order/enums.dart';
import 'package:pizza_order/ui/screens/order_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  Size _selectedSize = Size.MEDIUM;
  CrustType _selectedCrust = CrustType.THIN;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Build Your Pizza')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Size Selection
              const Text('Size:', style: TextStyle(fontSize: 20)),
              DropdownButton<Size>(
                value: _selectedSize,
                items: Size.values.map((size) {
                  return DropdownMenuItem<Size>(
                    value: size,
                    child: Text(size.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (Size? newValue) {
                  setState(() {
                    _selectedSize = newValue!;
                  });
                },
              ),

              // Crust Selection
              const SizedBox(height: 20),
              const Text('Crust Type:', style: TextStyle(fontSize: 20)),
              DropdownButton<CrustType>(
                value: _selectedCrust,
                items: CrustType.values.map((crust) {
                  return DropdownMenuItem<CrustType>(
                    value: crust,
                    child: Text(crust.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (CrustType? newValue) {
                  setState(() {
                    _selectedCrust = newValue!;
                  });
                },
              ),

              // Continue Button
              const SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderScreen(
                          selectedSize: _selectedSize,
                          selectedCrust: _selectedCrust,
                        ),
                      ),
                    );
                  },
                  child: const Text('Continue to Toppings'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}