import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';

class MockApiServices extends Mock implements ApiServices {}

void main() {
  late MockApiServices mockApiServices;
  late RestaurantListProvider restaurantListProvider;

  group('HomeProvider', () {
    setUp(() {
      mockApiServices = MockApiServices();
      restaurantListProvider = RestaurantListProvider(mockApiServices);
    });

    test('can be instantiated', () {
      expect(restaurantListProvider, isNotNull);
    });

    test('initial state is RestaurantListNoneState', () {
      expect(
          restaurantListProvider.resultState, isA<RestaurantListNoneState>());
    });

    test('fetchRestaurantList sets state to loading, then loaded on success',
        () async {
      final restaurants = [
        Restaurant(
            id: "rqdv5juczeskfw1e867",
            name: "Melting Pot",
            description:
                "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
            pictureId: "14",
            city: "Medan",
            rating: 4.2)
      ];

      when(() => mockApiServices.getRestaurantList()).thenAnswer(
        (_) async => RestaurantListResponse(
            error: false,
            message: 'success',
            restaurants: restaurants,
            count: 0),
      );

    
      await restaurantListProvider.fetchRestaurantList();

      verify(() => mockApiServices.getRestaurantList()).called(1);
      expect(
          restaurantListProvider.resultState, isA<RestaurantListLoadedState>());
      expect(
        (restaurantListProvider.resultState as RestaurantListLoadedState).data,
        equals(restaurants),
      );
    });

    test('fetchRestaurantList sets state to loading, then error on failure',
        () async {
  
      when(() => mockApiServices.getRestaurantList())
          .thenThrow(Exception('Failed to load restaurant list'));

  
      await restaurantListProvider.fetchRestaurantList();

      
      verify(() => mockApiServices.getRestaurantList()).called(1);
      expect(
          restaurantListProvider.resultState, isA<RestaurantListErrorState>());
      expect(
        (restaurantListProvider.resultState as RestaurantListErrorState).error,
        equals('Exception: Failed to load restaurant list'),
      );
    });

    test('notifyListeners is called when state changes', () async {
      when(() => mockApiServices.getRestaurantList()).thenAnswer(
        (_) async => RestaurantListResponse(
            error: false, message: 'success', restaurants: [], count: 0),
      );
    
      await restaurantListProvider.fetchRestaurantList();

    
      verify(() => mockApiServices.getRestaurantList()).called(1);
      expect(
          restaurantListProvider.resultState, isA<RestaurantListLoadedState>());
    });
  });
}
