import 'items.dart';

class Menus {
  List<Items> foods;
  List<Items> drinks;

  Menus({required this.foods, required this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: (json['foods'] as List<dynamic>)
            .map((e) => Items.fromJson(e as Map<String, dynamic>))
            .toList(),
        drinks: (json['drinks'] as List<dynamic>)
            .map((e) => Items.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'foods': foods.map((e) => e.toJson()).toList(),
        'drinks': drinks.map((e) => e.toJson()).toList(),
      };
}
