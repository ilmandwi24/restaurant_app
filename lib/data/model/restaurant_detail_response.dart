import 'package:restaurant_app/data/model/restaurant.dart';

class RestaurantDetailResponse {
    final bool error;
    final String message;
    final Restaurant restaurant;

    RestaurantDetailResponse({
        required this.error,
        required this.message,
        required this.restaurant,
    });

    factory RestaurantDetailResponse.fromJson(Map<String, dynamic> json) => RestaurantDetailResponse(
        error: json["error"],
        message: json["message"],
        // restaurants: List<Restaurant>.from(json["restaurants"].map((x) => x)),
        restaurant: Restaurant.fromJson(json["restaurant"]),

    );

}
