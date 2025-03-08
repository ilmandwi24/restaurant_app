import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/restaurant_detail_response.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';


class MockHttpClient extends Mock implements http.Client {}

void main() {

  late ApiServices apiServices;
  late MockHttpClient mockClient;

  setUp(() {
    mockClient = MockHttpClient();
    apiServices = ApiServices(client : mockClient);
        registerFallbackValue(Uri());

  });

  group('ApiServices', () {
    test('can be instantiated', () {
      expect(apiServices, isNotNull);
    });

    

     test('getRestaurantList returns RestaurantListResponse on success', () async {
      final jsonResponse = jsonEncode({
        "error": false,
        "message": "success",
        "count": 1,
        "restaurants": [
          {
            "id": "rqdv5juczeskfw1e867",
            "name": "Melting Pot",
            "description":
                "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
            "pictureId": "14",
            "city": "Medan",
            "rating": 4.2
          }
        ]
      });
      // Mock response API
      when(() => mockClient.get(Uri.parse("https://restaurant-api.dicoding.dev/list")))
          .thenAnswer((_) async => http.Response(jsonResponse, 200));

      // Inject mockClient secara manual
      final result = await apiServices.getRestaurantList();

      

      expect(result.restaurants.isNotEmpty, true);
      expect(result,  isA<RestaurantListResponse>());
      expect(result.message, "success");
      
      expect(result.restaurants[0].name, "Melting Pot");
      

    });

     test('getRestaurantList returns  throws an exception on failure', () async {
      // Mock response API
      when(() => mockClient
              .get(Uri.parse("https://restaurant-api.dicoding.dev/list")))
          .thenThrow(Exception('Failed to load restaurant list'));

      // Inject mockClient secara manual

      expect(() => apiServices.getRestaurantList(), throwsException);
    });

    



     test('getRestaurantDetail returns RestaurantDetailResponse on success', () async {
      final jsonResponse = jsonEncode({
        "error": false,
        "message": "success",
        "restaurant": {
          "id": "rqdv5juczeskfw1e867",
          "name": "Melting Pot",
          "description":
              "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
          "city": "Medan",
          "address": "Jln. Pandeglang no 19",
          "pictureId": "14",
          "categories": [
            {"name": "Italia"},
            {"name": "Modern"}
          ],
          "menus": {
            "foods": [
              {"name": "Paket rosemary"},
              {"name": "Toastie salmon"},
              {"name": "Bebek crepes"},
              {"name": "Salad lengkeng"}
            ],
            "drinks": [
              {"name": "Es krim"},
              {"name": "Sirup"},
              {"name": "Jus apel"},
              {"name": "Jus jeruk"},
              {"name": "Coklat panas"},
              {"name": "Air"},
              {"name": "Es kopi"},
              {"name": "Jus alpukat"},
              {"name": "Jus mangga"},
              {"name": "Teh manis"},
              {"name": "Kopi espresso"},
              {"name": "Minuman soda"},
              {"name": "Jus tomat"}
            ]
          },
          "rating": 4.2,
          "customerReviews": [
            {
              "name": "Ahmad",
              "review": "Tidak rekomendasi untuk pelajar!",
              "date": "13 November 2019"
            },
            {"name": "Rahmat", "review": "ok", "date": "8 Maret 2025"}
          ]
        }
      });

      when(() => mockClient.get(Uri.parse("https://restaurant-api.dicoding.dev/detail/rqdv5juczeskfw1e867")))
          .thenAnswer((_) async => http.Response(jsonResponse, 200));

      final result = await ApiServices().getRestaurantDetail("rqdv5juczeskfw1e867");

      expect(result.message, "success");
      expect(result.restaurant.name, "Melting Pot");
      expect(result.restaurant.city, "Medan");
      expect(result, isA<RestaurantDetailResponse>());
    });

     test('getRestaurantDetail throws an exception on failure', () async {
      when(() => mockClient.get(Uri.parse("https://restaurant-api.dicoding.dev/detail/1")))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(() => apiServices.getRestaurantDetail("1"), throwsException);
    });

  


  });
}