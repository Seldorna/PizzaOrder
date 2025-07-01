/// Customer class representing customer information
/// Author: [Your Name]
/// Registration: [Your Registration Number]

class Customer {
  String _name;
  String _address;
  String _phoneNumber;

  Customer(this._name, this._address, this._phoneNumber);

  // Getters and setters
  String get name => _name;
  set name(String value) => _name = value;

  String get address => _address;
  set address(String value) => _address = value;

  String get phoneNumber => _phoneNumber;
  set phoneNumber(String value) => _phoneNumber = value;

  @override
  String toString() {
    return 'Customer: $_name, $_address, $_phoneNumber';
  }

  Map<String, dynamic> toJson() {
    return {
      'name': _name,
      'address': _address,
      'phoneNumber': _phoneNumber,
    };
  }

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      json['name'],
      json['address'],
      json['phoneNumber'],
    );
  }
}