import 'package:flutter/material.dart';
import 'package:restaurant_app/src/data/api/api_services.dart';
import 'package:restaurant_app/config/static/restaurant_list_result_state.dart';

class RestaurantListProvider extends ChangeNotifier{
  final ApiServices _apiServices;

  RestaurantListProvider(
    this._apiServices
  );

  RestaurantListResultState _resultState = RestaurantListNoneState();

  RestaurantListResultState get resultState => _resultState;

  Future<void> fetchRestauranList() async {
    try {
      _resultState = RestaurantListLoadingState();
      notifyListeners();

      final result = await _apiServices.getRestaurantList();

      if(result.error){
        _resultState = RestaurantListErrorState(result.message);
        notifyListeners(); 
      } else {
        _resultState = RestaurantListLoadedState(result.restaurants);
        notifyListeners();
      }
    } on Exception catch (err) {
      _resultState = RestaurantListErrorState(err.toString());
      notifyListeners();
    }
  }
}