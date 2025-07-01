import 'enums.dart';
import 'exceptions.dart';

class Pizza {
  // Initialize fields when declared
  int _numSlices = 8;
  MeatType _meatChoice = MeatType.PEPPERONI;
  VeggieType _vegChoice = VeggieType.ONION;
  CrustType _crustType = CrustType.THIN;
  Set<Topping> _toppings = {Topping.CHEESE};
  Size _size = Size.MEDIUM;

  // Default constructor - now simplified
  Pizza();

  // Parameterized constructor
  Pizza.custom({
  required int numSlices,
  required MeatType meatChoice,
  required VeggieType vegChoice,
  required CrustType crustType,
  required Set<Topping> toppings,
  required Size size,
  })   : _numSlices = numSlices,
  _meatChoice = meatChoice,
  _vegChoice = vegChoice,
  _crustType = crustType,
  _toppings = toppings,
  _size = size {
  // Validate inputs
  if (_numSlices <= 0) {
  throw InvalidPizzaException('Number of slices must be positive');
  }
  if (_toppings.isEmpty) {
  throw InvalidPizzaException('At least one topping is required');
  }
  }

  // Getters and setters
  int get numSlices => _numSlices;
  set numSlices(int value) {
  if (value <= 0) throw InvalidPizzaException('Number of slices must be positive');
  _numSlices = value;
  }

  MeatType get meatChoice => _meatChoice;
  set meatChoice(MeatType value) => _meatChoice = value;

  VeggieType get vegChoice => _vegChoice;
  set vegChoice(VeggieType value) => _vegChoice = value;

  CrustType get crustType => _crustType;
  set crustType(CrustType value) => _crustType = value;

  Set<Topping> get toppings => _toppings;
  set toppings(Set<Topping> value) {
  if (value.isEmpty) throw InvalidPizzaException('At least one topping is required');
  _toppings = value;
  }

  Size get size => _size;
  set size(Size value) => _size = value;

  // Price calculation
  double calculatePrice() {
  double basePrice = 10.0;
  basePrice += 2.0; // meat choice
  basePrice += 1.0; // veggie choice
  basePrice += _toppings.length * 0.5; // toppings

  // Crust type additions
  switch (_crustType) {
  case CrustType.THIN:
  break;
  case CrustType.THICK:
  basePrice += 1.0;
  break;
  case CrustType.STUFFED:
  basePrice += 3.0;
  break;
  case CrustType.GLUTEN_FREE:
  basePrice += 2.0;
  break;
  }

  // Size multiplier
  switch (_size) {
  case Size.SMALL:
  basePrice *= 1.0;
  break;
  case Size.MEDIUM:
  basePrice *= 1.5;
  break;
  case Size.LARGE:
  basePrice *= 1.8;
  break;
  }

  return basePrice;
  }

  @override
  String toString() {
  return 'Pizza: ${_size.toString().split('.').last}, ${_crustType.toString().split('.').last} crust, '
  '${_meatChoice.toString().split('.').last} & ${_vegChoice.toString().split('.').last}, '
  'Toppings: ${_toppings.map((t) => t.toString().split('.').last).join(', ')}, '
  'Slices: $_numSlices, Price: \$${calculatePrice().toStringAsFixed(2)}';
  }

  Map<String, dynamic> toJson() {
    return {
      'numSlices': _numSlices,
      'meatChoice': _meatChoice.toString(),
      'vegChoice': _vegChoice.toString(),
      'crustType': _crustType.toString(),
      'toppings': _toppings.map((t) => t.toString()).toList(),
      'size': _size.toString(),
      'price': calculatePrice(),
    };
  }

  factory Pizza.fromJson(Map<String, dynamic> json) {
    return Pizza.custom(
      numSlices: json['numSlices'],
      meatChoice: MeatType.values.firstWhere(
            (e) => e.toString() == json['meatChoice'],
      ),
      vegChoice: VeggieType.values.firstWhere(
            (e) => e.toString() == json['vegChoice'],
      ),
      crustType: CrustType.values.firstWhere(
            (e) => e.toString() == json['crustType'],
      ),
      toppings: (json['toppings'] as List)
          .map((t) => Topping.values.firstWhere(
            (e) => e.toString() == t,
      ))
          .toSet(),
      size: Size.values.firstWhere(
            (e) => e.toString() == json['size'],
      ),
    );
  }
}
