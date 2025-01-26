import 'package:restaurant_app/data/model/restaurant_model.dart';

sealed class RestaurantDetailResultState{

}

class RestaurantDetailNoneState extends RestaurantDetailResultState{}

class RestaurantDetailLoadingState extends RestaurantDetailResultState{}

class RestaurantDetailErrorState extends RestaurantDetailResultState {
  final String error;

  RestaurantDetailErrorState(this.error);
}

class RestaurantDetailLoadedState extends RestaurantDetailResultState{
  final Restaurant data;

  RestaurantDetailLoadedState(this.data);
}