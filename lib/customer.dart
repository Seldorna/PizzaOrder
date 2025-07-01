class Customer {
  final String name;
  final String address;
  final String phoneNumber;

  Customer({
    required this.name,
    required this.address,
    required this.phoneNumber,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      name: json['name'] ?? 'Unknown',
      address: json['address'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'address': address, 'phoneNumber': phoneNumber};
  }

  @override
  String toString() => '$name ($phoneNumber)';
}
