import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_sql.dart';
import 'package:restaurant_app/services/sqlite_service.dart';

class RestaurantFavDatabaseProvider extends ChangeNotifier {
  final SqliteService _service;

  RestaurantFavDatabaseProvider(this._service);

  String _message = "";
  String get message => _message;

  final bool _isFavorited = false;
  bool get isFavorited => _isFavorited;
  

  List<RestaurantSql>? _restaurantList;
  List<RestaurantSql>? get restaurantList => _restaurantList;

  RestaurantSql? _restaurantSql;
  RestaurantSql? get restaurant => _restaurantSql;

  // menambahkan fungsi untuk menyimpan data profil
  Future<void> saveFavoriteValue(RestaurantSql value) async {
    try {
      final result = await _service.insertItem(value);

      final isError = result == 0;
      if (isError) {
        _message = "Failed to save your data";
        notifyListeners();
      } else {
        _message = "Your data is saved";
        notifyListeners();
      }
    } catch (e) {
      _message = "Failed to save your data";
      notifyListeners();
    }
  }

  // menambahkan fungsi untuk memuat keseluruhan data profile
  Future<void> loadAllFavoriteValue() async {
    try {
      _restaurantList = await _service.getAllItems();
      _message = "All of your data is loaded";
      notifyListeners();
    } catch (e) {
      _message = "Failed to load your all data";
      notifyListeners();
    }
  }


  Future<bool> checkIfFavorite(String id) async {
    final restaurantList = await _service.getItemById(id);

    return restaurantList.isNotEmpty;
  }
  

  // menambahkan fungsi untuk menghapus data profile berdasarkan nilai id-nya
  Future<void> removeFavoriteValueById(String id) async {
    try {
      await _service.removeItem(id);

      _message = "Your data is removed";
      notifyListeners();
    } catch (e) {
      _message = "Failed to remove your data";
      notifyListeners();
    }
  }

  Future<void> removeAllItem() async {
    
     try {
      await _service.removeAllItem();

      _message = "Your data is removed";
      notifyListeners();
    } catch (e) {
      _message = "Failed to remove your data";
      notifyListeners();
    }
  }
}
