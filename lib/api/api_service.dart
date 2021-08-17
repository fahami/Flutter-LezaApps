import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:resto/models/restaurant_details.dart';
import 'package:resto/models/restaurant_lists.dart';

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev';
  static final String baseSmallImage = '$_baseUrl/images/small/';
  static final String baseMediumImage = '$_baseUrl/images/medium/';
  static final String baseLargeImage = '$_baseUrl/images/large/';

  Future<RestaurantLists> fetchList() async {
    final response = await http.get(Uri.parse('$_baseUrl/list'));
    print(response.body);
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

  Future<RestaurantLists> fetchSearch(String query) async {
    final response = await http.get(Uri.parse('$_baseUrl/search?q=$query'));
    return response.statusCode == 200
        ? RestaurantLists.fromJson(jsonDecode(response.body))
        : throw Exception('Failed to load search of restaurant');
  }
}
