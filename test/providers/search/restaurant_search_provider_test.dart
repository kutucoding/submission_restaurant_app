import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/src/data/api/api_services.dart';
import 'package:restaurant_app/src/data/model/restaurant_model.dart';
import 'package:restaurant_app/src/provider/home/restaurant_search_provider.dart';
import 'package:restaurant_app/config/static/restaurant_search_resultstate.dart';

class MockApiServices extends Mock implements ApiServices {}

class MockRestaurant extends Mock implements Restaurant {}

void main() {
  group('RestaurantSearchProvider Tests', () {
    late MockApiServices mockApiServices;
    late RestaurantSearchProvider provider;
    late List<Restaurant> mockRestaurants;

    setUp(() {
      mockApiServices = MockApiServices();
      provider = RestaurantSearchProvider(mockApiServices);
      mockRestaurants = [MockRestaurant(), MockRestaurant()];
    });

    test('Initial state should be RestaurantSearchNoneState', () {
      expect(provider.resultState, isA<RestaurantSearchNoneState>());
    });

    test('Should return RestaurantSearchNoneState when query is empty',
        () async {
      await provider.fetchRestaurantSearch('');

      expect(provider.resultState, isA<RestaurantSearchNoneState>());
    });

    test('Should return RestaurantSearchLoadedState when search is successful',
        () async {
      when(() => mockApiServices.getSearchRestaurant(any()))
          .thenAnswer((_) async => mockRestaurants);

      await provider.fetchRestaurantSearch('pizza');

      expect(provider.resultState, isA<RestaurantSearchLoadedState>());
      expect((provider.resultState as RestaurantSearchLoadedState).restaurants,
          mockRestaurants);
    });

    test(
        'Should return RestaurantSearchErrorState when search returns no results',
        () async {
      when(() => mockApiServices.getSearchRestaurant(any()))
          .thenAnswer((_) async => []);

      await provider.fetchRestaurantSearch('unknown');

      expect(provider.resultState, isA<RestaurantSearchErrorState>());
      expect((provider.resultState as RestaurantSearchErrorState).message,
          'No restaurant Found');
    });

    test(
        'Should return RestaurantSearchErrorState when API call throws exception',
        () async {
      const errorMessage = 'Network error';
      when(() => mockApiServices.getSearchRestaurant(any()))
          .thenThrow(Exception(errorMessage));

      await provider.fetchRestaurantSearch('pizza');

      // Assert: Check the state after the search
      expect(provider.resultState, isA<RestaurantSearchErrorState>());
      expect((provider.resultState as RestaurantSearchErrorState).message,
          'Exception: $errorMessage');
    });
  });
}
