import 'restaurant.dart';

class RestaurantDetails {
  bool? error;
  String? message;
  Restaurant? restaurant;

  RestaurantDetails({this.error, this.message, this.restaurant});

  factory RestaurantDetails.fromJson(Map<String, dynamic> json) =>
      RestaurantDetails(
        error: json['error'] as bool?,
        message: json['message'] as String?,
        restaurant: json['restaurant'] == null
            ? null
            : Restaurant.fromJson(json['restaurant'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'error': error,
        'message': message,
        'restaurant': restaurant?.toJson(),
      };
}
