import 'restaurants.dart';

class RestaurantLists {
  bool error;
  String message;
  int count;
  List<Restaurants> restaurants;

  RestaurantLists(
      {required this.error,
      required this.message,
      required this.count,
      required this.restaurants});

  factory RestaurantLists.fromJson(Map<String, dynamic> json) =>
      RestaurantLists(
        error: json['error'] as bool,
        message: json['message'] as String,
        count: json['count'] as int,
        restaurants: (json['restaurants'] as List<dynamic>)
            .map((e) => Restaurants.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'error': error,
        'message': message,
        'count': count,
        'restaurants': restaurants.map((e) => e.toJson()).toList(),
      };
}
