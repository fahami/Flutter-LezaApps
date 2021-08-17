import 'package:flutter/material.dart';
import 'package:resto/api/api_service.dart';
import 'package:resto/constant/enum.dart' show ResultState;
import 'package:resto/models/restaurant_details.dart';

class DetailProvider extends ChangeNotifier {
  late ApiService apiService;
  late String id;

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  late RestaurantDetails _result;
  RestaurantDetails get result => _result;

  DetailProvider({required this.apiService, required this.id}) {
    fetchDetail(this.id);
  }
  Future<dynamic> fetchDetail(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final detail = await apiService.fetchDetail(id);
      if (detail.restaurant == null) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'No data found from API';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _result = detail;
      }
    } catch (e) {
      _state = ResultState.Error;
      print(e);
      notifyListeners();
      return _message = 'Error on $e';
    }
  }
}
