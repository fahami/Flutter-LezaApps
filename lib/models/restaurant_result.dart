import 'restaurants.dart';

class RestaurantResult {
  bool error;
  int founded;
  List<Restaurants> restaurants;

  RestaurantResult(
      {required this.error, required this.founded, required this.restaurants});

  factory RestaurantResult.fromJson(Map<String, dynamic> json) =>
      RestaurantResult(
        error: json['error'] as bool,
        founded: json['founded'] as int,
        restaurants: (json['restaurants'] as List<dynamic>)
            .map((e) => Restaurants.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'error': error,
        'founded': founded,
        'restaurants': restaurants.map((e) => e.toJson()).toList(),
      };
}
