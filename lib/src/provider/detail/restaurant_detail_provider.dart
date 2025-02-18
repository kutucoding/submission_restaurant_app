import 'package:flutter/material.dart';
import 'package:restaurant_app/src/data/api/api_services.dart';
import 'package:restaurant_app/config/static/restaurant_detail_result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantDetailProvider(this._apiServices);

  RestaurantDetailResultState _resultState = RestaurantDetailNoneState();

  RestaurantDetailResultState get resultState => _resultState;

  Future<void> fetchRestauranDetail(String id) async {
    _resultState = RestaurantDetailLoadingState();
    notifyListeners();

    try {
      final result = await _apiServices.getRestaurantDetail(id);

      if (result.error) {
        _resultState = RestaurantDetailErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestaurantDetailLoadedState(result.restaurant);
        notifyListeners();
      }
    } on Exception catch (err) {
     String errorMessage;

     if(err.toString().contains('SocketException')) {
      errorMessage = "Gagal Menampilkan Detail Restaurant. Periksa koneksi internet anda.";
     } else {
      errorMessage = "Terjadi kesalahan. silahkan coba lagi.";
     }

     _resultState = RestaurantDetailErrorState(errorMessage);
     notifyListeners();
    }
  }
}
