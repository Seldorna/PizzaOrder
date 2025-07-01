import 'package:pizza_order/enums.dart';

class Pizza {
  final int numSlices;
  final MeatType meatChoice;
  final VeggieType vegChoice;
  final CrustType crustType;
  final Set<Topping> toppings;
  final Size size;

  Pizza.custom({
    required this.numSlices,
    required this.meatChoice,
    required this.vegChoice,
    required this.crustType,
    required this.toppings,
    required this.size,
  });

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