import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:resto/models/restaurant_details.dart';
import 'package:resto/models/restaurant_lists.dart';
import 'package:resto/models/restaurant_result.dart';
import 'package:resto/models/write_review.dart';

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev';
  static final String image = '$_baseUrl/images/medium/';

  Future<RestaurantLists> fetchList() async {
    final response = await http.get(Uri.parse('$_baseUrl/list'));
    return response.statusCode == 200
        ? RestaurantLists.fromJson(jsonDecode(response.body))
        : throw Exception('Failed to load list of restaurant');
  }

  Future<RestaurantDetails> fetchDetail(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/detail/$id'));
    return response.statusCode == 200
        ? RestaurantDetails.fromJson(jsonDecode(response.body))
        : throw Exception('Failed to load details of restaurant');
  }

  Future<RestaurantResult> fetchSearch(String query) async {
    final response = await http.get(Uri.parse('$_baseUrl/search?q=$query'));
    return response.statusCode == 200
        ? RestaurantResult.fromJson(jsonDecode(response.body))
        : throw Exception('Failed to load search of restaurant');
  }

  Future<WriteReview> writeReview(String review, String name, String id) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/review'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'X-Auth-Token': '12345'
      },
      body: {"id": id, "name": name, "review": review},
    );
    return response.statusCode == 200
        ? WriteReview.fromJson(jsonDecode(response.body))
        : throw Exception('Failed to write review');
  }
}
