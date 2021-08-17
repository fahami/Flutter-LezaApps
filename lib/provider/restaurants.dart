import 'package:flutter/material.dart';
import 'package:resto/api/api_service.dart';
import 'package:resto/constant/enum.dart' show ResultState;
import 'package:resto/models/restaurant_lists.dart';

class RestaurantProvider extends ChangeNotifier {
  late ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    fetchRestaurant();
  }

  late ResultState _state;
  ResultState get state => _state;

  String _query = '';
  String get query => _query;

  String _message = '';
  String get message => _message;

  late RestaurantLists _restaurants;
  RestaurantLists get result => _restaurants;

  Future<dynamic> fetchRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final results = await apiService.fetchList();
      if (results.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'No data found from API';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurants = results;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error on $e';
    }
  }
}
