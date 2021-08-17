import 'drinks.dart';
import 'foods.dart';

class Menus {
  List<Foods> foods;
  List<Drinks> drinks;

  Menus({required this.foods, required this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: (json['foods'] as List<dynamic>)
            .map((e) => Foods.fromJson(e as Map<String, dynamic>))
            .toList(),
        drinks: (json['drinks'] as List<dynamic>)
            .map((e) => Drinks.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'foods': foods.map((e) => e.toJson()).toList(),
        'drinks': drinks.map((e) => e.toJson()).toList(),
      };
}
