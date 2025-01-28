import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/restaurant_detail_response.dart';
import 'dart:convert';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';
import 'package:restaurant_app/data/model/restaurant_model.dart';

class ApiServices {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";
  Future<RestaurantListResponse> getRestaurantList() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));

    if (response.statusCode == 200) {
      return RestaurantListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to Load Restaurant List");
    }
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));

    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to Load Restaurant Detail");
    }
  }
  Future<List<Restaurant>> getSearchRestaurant(String query) async {
    final response = await http.get(Uri.parse("$_baseUrl/search?q=$query"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Restaurant>.from(
        data["restaurants"].map((x) => Restaurant.fromJson(x)),
      );
    } else {
      throw Exception("Failed to Search Restaurant ");
    }
  }

  String getImageUrl(String pictureId) {
    return "$_baseUrl/images/large/$pictureId";
  }
}
