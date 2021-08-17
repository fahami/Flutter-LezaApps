import 'package:flutter/material.dart';
import 'package:resto/api/api_service.dart';
import 'package:resto/constant/enum.dart' show ResultState;
import 'package:resto/models/restaurant_result.dart';

class SearchProvider extends ChangeNotifier {
  late ApiService apiService;

  SearchProvider({required this.apiService, required query}) {
    fetchSearch(query);
  }
  late String query;
  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  late RestaurantResult _searches;
  RestaurantResult get searches => _searches;

  Future<dynamic> fetchSearch(String query) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final search = await apiService.fetchSearch(query);
      if (search.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'No data found from API';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _searches = search;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error on $e';
    }
  }
}
