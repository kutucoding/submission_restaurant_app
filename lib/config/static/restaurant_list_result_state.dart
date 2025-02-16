import 'package:restaurant_app/src/services/model/restaurant_model.dart';

sealed class RestaurantListResultState{

}

class RestaurantListNoneState extends RestaurantListResultState{}

class RestaurantListLoadingState extends RestaurantListResultState{}

class RestaurantListErrorState extends RestaurantListResultState {
  final String error;

  RestaurantListErrorState(this.error);
}

class RestaurantListLoadedState extends RestaurantListResultState{
  final List<Restaurant> data;

  RestaurantListLoadedState(this.data);
}