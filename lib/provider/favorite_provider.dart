import 'package:flutter/material.dart';
import 'package:resto/constant/enum.dart';
import 'package:resto/models/restaurant.dart';
import 'package:resto/utils/database_helper.dart';

class FavoriteProvider extends ChangeNotifier {
  FavoriteProvider({required this.databaseHelper}) {
    DatabaseHelper();
    getAllFavorites();
  }
  List<Restaurant> _restaurantsList = [];
  List<Restaurant> get results => _restaurantsList;

  final DatabaseHelper databaseHelper;

  ResultState _state = ResultState.Loading;
  ResultState get state => _state;

  late bool _isFavorite;
  bool get isFavorite => _isFavorite;

  String _message = '';
  String get message => _message;

  void addFavorite(Restaurant restaurants) async {
    try {
      databaseHelper.saveFavorite(Restaurant(
          id: restaurants.id,
          name: restaurants.name,
          description: restaurants.description,
          city: restaurants.city,
          pictureId: restaurants.pictureId,
          rating: restaurants.rating));
      getAllFavorites();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Gagal menyimpan restoran favorit';
      notifyListeners();
    }
  }

  void getAllFavorites() async {
    final favorites = await databaseHelper.getFavorite();
    if (favorites.length <= 0) {
      _state = ResultState.NoData;
      _message = 'Kamu belum menyimpan satupun restoran favorit';
    } else {
      _state = ResultState.HasData;
      _restaurantsList = favorites;
    }
    notifyListeners();
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.deleteFavorite(id);
      _message = 'Data telah dihapus';
      getAllFavorites();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Gagal untuk menghapus restoran';
      notifyListeners();
    }
  }

  Future<bool?> checkFavorite(String id) async {
    final favorite = await databaseHelper.isFavorite(id);
    return favorite;
  }
}
