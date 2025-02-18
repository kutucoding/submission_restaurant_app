import 'package:flutter/material.dart';
import 'package:restaurant_app/src/data/api/api_services.dart';
import 'package:restaurant_app/config/static/restaurant_search_resultstate.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantSearchProvider(this._apiServices);

  RestaurantSearchResultstate _resultstate = RestaurantSearchNoneState();

  RestaurantSearchResultstate get resultState => _resultstate;

  Future<void> fetchRestaurantSearch(String query) async {
    if (query.isEmpty) {
      _resultstate = RestaurantSearchNoneState();
      notifyListeners();
      return;
    }

    try {
      _resultstate = RestaurantSearchLoadingState();
      notifyListeners();

      final resultState = await _apiServices.getSearchRestaurant(query);

      if (resultState.isEmpty) {
        _resultstate = RestaurantSearchErrorState("No restaurant Found");
      } else {
        _resultstate = RestaurantSearchLoadedState(resultState);
      }
      notifyListeners();
    } catch (err) {
      String errorMessage;

      if(err.toString().contains('SocketException')) {
        errorMessage = "Gagal menampilkan Restaurant. Periksa koneksi internet anda.";
      } else {
        errorMessage = "Terjadi kesalahan. silahkan coba lagi.";
      }
      _resultstate = RestaurantSearchErrorState(errorMessage);
      notifyListeners();
    }
  }
}
