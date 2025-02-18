import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/src/data/api/api_services.dart';
import 'package:restaurant_app/src/data/model/restaurant_list_response.dart';
import 'package:restaurant_app/src/data/model/restaurant_model.dart';
import 'package:restaurant_app/src/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/config/static/restaurant_list_result_state.dart';

class MockApiServices extends Mock implements ApiServices {}

class MockRestaurantListResponse extends Mock
    implements RestaurantListResponse {}

class MockRestaurant extends Mock implements Restaurant {}

void main() {
  group('RestaurantListProvider Tests', () {
    late MockApiServices mockApiServices;
    late RestaurantListProvider provider;
    late MockRestaurantListResponse mockResponse;
    late List<Restaurant> mockRestaurants;

    setUp(() {
      mockApiServices = MockApiServices();
      provider = RestaurantListProvider(mockApiServices);
      mockResponse = MockRestaurantListResponse();
      mockRestaurants = [MockRestaurant(), MockRestaurant()];
    });

    test('Initial state should be RestaurantListNoneState', () {
      expect(provider.resultState, isA<RestaurantListNoneState>());
    });

    test('Should return RestaurantListLoadedState when API call is successful',
        () async {
      when(() => mockApiServices.getRestaurantList())
          .thenAnswer((_) async => mockResponse);
      when(() => mockResponse.error).thenReturn(false);
      when(() => mockResponse.restaurants).thenReturn(mockRestaurants);

      await provider.fetchRestauranList();

      expect(provider.resultState, isA<RestaurantListLoadedState>());
      expect((provider.resultState as RestaurantListLoadedState).data,
          mockRestaurants);
    });

    test(
        'Should return RestaurantListErrorState when API call fails with error message',
        () async {
      const errorMessage = 'Failed to load restaurant list';
      when(() => mockApiServices.getRestaurantList())
          .thenAnswer((_) async => mockResponse);
      when(() => mockResponse.error).thenReturn(true);
      when(() => mockResponse.message).thenReturn(errorMessage);

      await provider.fetchRestauranList();

      expect(provider.resultState, isA<RestaurantListErrorState>());
      expect((provider.resultState as RestaurantListErrorState).error,
          errorMessage);
    });

    test(
        'Should return RestaurantListErrorState when API call throws exception',
        () async {
      const errorMessage = 'Network error';
      when(() => mockApiServices.getRestaurantList())
          .thenThrow(Exception(errorMessage));

      await provider.fetchRestauranList();

      expect(provider.resultState, isA<RestaurantListErrorState>());
      expect((provider.resultState as RestaurantListErrorState).error,
          'Exception: $errorMessage');
    });
  });
}
