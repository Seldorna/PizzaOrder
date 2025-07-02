import 'package:flutter/material.dart';
import 'package:pizza_order/ui/screens/confirmation_screen.dart';
import 'package:pizza_order/enums.dart';

class CustomerScreen extends StatefulWidget {
  final bool initialIsDelivery;
  final String? initialName;
  final String? initialPhone;
  final String? initialAddress;
  final Function(Map<String, dynamic>) onSave;

  final Size pizzaSize;
  final CrustType crustType;
  final MeatType? meatType;
  final VeggieType? veggieType;
  final Set<Topping> toppings;
  final int numSlices;

  const CustomerScreen({
    super.key,
    required this.initialIsDelivery,
    this.initialName,
    this.initialPhone,
    this.initialAddress,
    required this.onSave,
    required this.pizzaSize,
    required this.crustType,
    required this.meatType,
    required this.veggieType,
    required this.toppings,
    required this.numSlices,
  });

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  late bool _isDelivery;
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _isDelivery = widget.initialIsDelivery;
    _nameController.text = widget.initialName ?? '';
    _addressController.text = widget.initialAddress ?? '';
    _phoneController.text = widget.initialPhone ?? '';
  }

   void _navigateToConfirmationScreen() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmationScreen(
            size: widget.pizzaSize,
            crust: widget.crustType,
            meat: widget.meatType,
            veggie: widget.veggieType,
            toppings: widget.toppings,
            numSlices: widget.numSlices,
            isDelivery: _isDelivery,
            customerName: _nameController.text,
            customerAddress: _addressController.text,
            customerPhone: _phoneController.text,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Information'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveData,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  icon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  icon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Delivery Address',
                  icon: Icon(Icons.location_on),
                ),
                maxLines: 2,
                validator: (value) {
                  if (_isDelivery && (value == null || value.isEmpty)) {
                    return 'Delivery requires an address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              const Text('Order Type:', style: TextStyle(fontSize: 18)),
              Row(
                children: [
                  Radio<bool>(
                    value: true,
                    groupValue: _isDelivery,
                    onChanged: (value) {
                      setState(() {
                        _isDelivery = value!;
                      });
                      _formKey.currentState?.validate();
                    },
                  ),
                  const Text('Delivery'),
                  const SizedBox(width: 20),
                  Radio<bool>(
                    value: false,
                    groupValue: _isDelivery,
                    onChanged: (value) {
                      setState(() {
                        _isDelivery = value!;
                      });
                      _formKey.currentState?.validate();
                    },
                  ),
                  const Text('Pickup'),
                ],
              ),
              const SizedBox(height: 32),
              // Save Button at bottom
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.orange[800],
                  ),
                  onPressed: _saveData,
                  child: const Text(
                    'Save Customer Details',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveData() {
    if (_formKey.currentState!.validate()) {
      widget.onSave({
        'isDelivery': _isDelivery,
        'name': _nameController.text,
        'phone': _phoneController.text,
        'address': _addressController.text,
      });
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}