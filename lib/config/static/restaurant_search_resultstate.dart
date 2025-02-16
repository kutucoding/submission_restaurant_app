import 'package:restaurant_app/src/services/model/restaurant_model.dart';

sealed class RestaurantSearchResultstate {

}

class RestaurantSearchNoneState extends RestaurantSearchResultstate {}

class RestaurantSearchLoadingState extends RestaurantSearchResultstate {}

class RestaurantSearchLoadedState extends RestaurantSearchResultstate {
  final List<Restaurant> restaurants;

  RestaurantSearchLoadedState(this.restaurants);
}

class RestaurantSearchErrorState extends RestaurantSearchResultstate {
  final String message;
  
  RestaurantSearchErrorState(this.message);
}