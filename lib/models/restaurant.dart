import 'package:resto/api/api_service.dart';

import 'categories.dart';
import 'customer_reviews.dart';
import 'menus.dart';

class Restaurant {
  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  List<Categories> categories;
  Menus menus;
  double rating;
  List<CustomerReviews> customerReviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        city: json['city'] as String,
        address: json['address'] as String,
        pictureId: json['pictureId'] as String,
        categories: (json['categories'] as List<dynamic>)
            .map((e) => Categories.fromJson(e as Map<String, dynamic>))
            .toList(),
        menus: Menus.fromJson(json['menus'] as Map<String, dynamic>),
        rating: json['rating'] == null ? 0.0 : json['rating'].toDouble(),
        customerReviews: (json['customerReviews'] as List<dynamic>)
            .map((e) => CustomerReviews.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'city': city,
        'address': address,
        'pictureId': pictureId,
        'categories': categories.map((e) => e.toJson()).toList(),
        'menus': menus.toJson(),
        'rating': rating,
        'customerReviews': customerReviews.map((e) => e.toJson()).toList(),
      };
  String pictureUrl() => ApiService.baseMediumImage + this.pictureId;
}
