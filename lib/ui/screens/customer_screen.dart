import 'package:flutter/material.dart';

class CustomerScreen extends StatefulWidget {
  final bool initialIsDelivery;
  final String? initialName;
  final String? initialPhone;
  final String? initialAddress;

  const CustomerScreen({
    super.key,
    required this.initialIsDelivery,
    this.initialName,
    this.initialPhone,
    this.initialAddress,
  });

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  late bool _isDelivery;
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isDelivery = widget.initialIsDelivery;
    _nameController.text = widget.initialName ?? '';
    _addressController.text = widget.initialAddress ?? '';
    _phoneController.text = widget.initialPhone ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customer Information')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Delivery Address'),
              maxLines: 2,
            ),

            // Delivery/Pickup
            const SizedBox(height: 20),
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
                  },
                ),
                const Text('Pickup'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> getCustomerData() {
    return {
      'isDelivery': _isDelivery,
      'name': _nameController.text,
      'phone': _phoneController.text,
      'address': _addressController.text,
    };
  }

  bool validateInputs() {
    if (_nameController.text.isEmpty || _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return false;
    }
    if (_isDelivery && _addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a delivery address')),
      );
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}