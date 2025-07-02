import 'package:pizza_order/enums.dart';

class Pizza {
  final int numSlices;
  final MeatType meatChoice;
  final VeggieType vegChoice;
  final CrustType crustType;
  final Set<Topping> toppings;
  final Size size;

  // Pricing constants
  static const double _basePrice = 8.0;
  static const Map<Size, double> _sizeMultipliers = {
    Size.small: 0.9,
    Size.medium: 1.0,
    Size.large: 1.2,
  };
  static const double _premiumCrustFee = 1.5;
  static const double _toppingPrice = 0.5;

  Pizza.custom({
    required this.numSlices,
    required this.meatChoice,
    required this.vegChoice,
    required this.crustType,
    required this.toppings,
    required this.size,
  });

  // Add price calculation method
  double calculatePrice() {
    double price = _basePrice;
    
    // Size multiplier
    price *= _sizeMultipliers[size] ?? 1.0;
    
    // Premium crust fee
    if (crustType == CrustType.thin || crustType == CrustType.stuffed) {
      price += _premiumCrustFee;
    }
    
    // Toppings
    price += toppings.length * _toppingPrice;
    
    // Meat premium
    if (meatChoice != MeatType.none) {
      price += 1.0;
    }
    
    return price;
  }
  @override
  String toString() {
    return 'Pizza(numSlices: $numSlices, meatChoice: $meatChoice, '
        'vegChoice: $vegChoice, crustType: $crustType, '
        'toppings: ${toppings.join(', ')}, size: $size, '
        'price: \$${calculatePrice().toStringAsFixed(2)})';
  }
  // Add fromJson factory
  factory Pizza.fromJson(Map<String, dynamic> json) {
    return Pizza.custom(
      numSlices: json['numSlices'] ?? 8,
      meatChoice: MeatType.values.firstWhere(
            (e) => e.toString() == json['meatChoice'],
        orElse: () => MeatType.none,
      ),
      vegChoice: VeggieType.values.firstWhere(
            (e) => e.toString() == json['vegChoice'],
        orElse: () => VeggieType.none,
      ),
      crustType: CrustType.values.firstWhere(
            (e) => e.toString() == json['crustType'],
        orElse: () => CrustType.regular,
      ),
      toppings: (json['toppings'] as List<dynamic>).map((t) =>
          Topping.values.firstWhere(
                (e) => e.toString() == t,
            orElse: () => Topping.none,
          ),
      ).toSet(),
      size: Size.values.firstWhere(
            (e) => e.toString() == json['size'],
        orElse: () => Size.medium,
      ),
    );
  }

  // Add toJson method
  Map<String, dynamic> toJson() {
    return {
      'numSlices': numSlices,
      'meatChoice': meatChoice.toString(),
      'vegChoice': vegChoice.toString(),
      'crustType': crustType.toString(),
      'toppings': toppings.map((t) => t.toString()).toList(),
      'size': size.toString(),
    };
  }
}
  