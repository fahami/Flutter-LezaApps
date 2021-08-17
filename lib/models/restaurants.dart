import 'package:resto/api/api_service.dart';

class Restaurants {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  Restaurants({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory Restaurants.fromJson(Map<String, dynamic> json) => Restaurants(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        pictureId: json['pictureId'] as String,
        city: json['city'] as String,
        rating: json['rating'] == null ? 0.0 : json['rating'].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'pictureId': pictureId,
        'city': city,
        'rating': rating,
      };
  String pictureUrl() => ApiService.baseMediumImage + this.pictureId;
}
