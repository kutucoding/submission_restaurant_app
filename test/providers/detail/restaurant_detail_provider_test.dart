import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/src/data/api/api_services.dart';
import 'package:restaurant_app/src/data/model/restaurant_detail_response.dart';
import 'package:restaurant_app/src/data/model/restaurant_model.dart';
import 'package:restaurant_app/src/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/config/static/restaurant_detail_result_state.dart';

class MockApiServices extends Mock implements ApiServices {}

class MockRestaurantDetailResponse extends Mock
    implements RestaurantDetailResponse {}

class MockRestaurant extends Mock implements Restaurant {}

void main() {
  group('RestaurantDetailProvider Tests', () {
    late MockApiServices mockApiServices;
    late RestaurantDetailProvider provider;
    const String testId = 'test_id';
    late MockRestaurantDetailResponse mockResponse;
    late MockRestaurant mockRestaurant;

    setUp(() {
      mockApiServices = MockApiServices();
      provider = RestaurantDetailProvider(mockApiServices);
      mockResponse = MockRestaurantDetailResponse();
      mockRestaurant = MockRestaurant();
    });

    test('Initial state should be RestaurantDetailNoneState', () {
      expect(provider.resultState, isA<RestaurantDetailNoneState>());
    });

    test(
        'Should return RestaurantDetailLoadedState when API call is successful',
        () async {
      when(() => mockApiServices.getRestaurantDetail(testId))
          .thenAnswer((_) async => mockResponse);
      when(() => mockResponse.error).thenReturn(false);
      when(() => mockResponse.restaurant).thenReturn(mockRestaurant);

      await provider.fetchRestauranDetail(testId);

      expect(provider.resultState, isA<RestaurantDetailLoadedState>());
      expect((provider.resultState as RestaurantDetailLoadedState).data,
          mockRestaurant);
    });

    test(
        'Should return RestaurantDetailErrorState when API call fails with error message',
        () async {
      const errorMessage = 'Restaurant not found';
      when(() => mockApiServices.getRestaurantDetail(testId))
          .thenAnswer((_) async => mockResponse);
      when(() => mockResponse.error).thenReturn(true);
      when(() => mockResponse.message).thenReturn(errorMessage);

      await provider.fetchRestauranDetail(testId);

      expect(provider.resultState, isA<RestaurantDetailErrorState>());
      expect((provider.resultState as RestaurantDetailErrorState).error,
          errorMessage);
    });

    test(
        'Should return RestaurantDetailErrorState when API call throws exception',
        () async {
      const errorMessage = 'Network error';
      when(() => mockApiServices.getRestaurantDetail(testId))
          .thenThrow(Exception(errorMessage));

      await provider.fetchRestauranDetail(testId);

      expect(provider.resultState, isA<RestaurantDetailErrorState>());
      expect((provider.resultState as RestaurantDetailErrorState).error,
          'Exception: $errorMessage');
    });
  });
}
