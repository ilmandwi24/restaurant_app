import 'dart:convert';

import 'package:restaurant_app/data/model/restaurant_detail_response.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';
import 'package:http/http.dart' as http;

class ApiServices {

  final http.Client client;

  ApiServices({http.Client? client}) : client = client ?? http.Client();


  static const String _baseUrl = "https://restaurant-api.dicoding.dev";

  Future<RestaurantListResponse> getRestaurantList() async {
    final response = await client.get(Uri.parse("$_baseUrl/list"));
  
    if (response.statusCode == 200) {
      return RestaurantListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    final response = await client.get(Uri.parse("$_baseUrl/detail/$id"));

    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }

 
}
