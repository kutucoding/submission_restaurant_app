import 'package:restaurant_app/src/services/model/restaurant_model.dart';

class RestaurantSearchResponse {
  final bool error;
  final int founded;
  final List<Restaurant> restaurants;

  factory RestaurantSearchResponse.fromJson(Map<String, dynamic>json) {
    return RestaurantSearchResponse(
      error: json["error"], 
      founded: json["founded"], 
      restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x)))
      );
  } 

  RestaurantSearchResponse({
    required this.error,
    required this.founded,
    required this.restaurants,
  });
}