import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_detail_response.dart';
import 'package:restaurant_app/screen/detail/body_card_detail.dart';

class DetailScreen extends StatefulWidget {
  final String restaurantId;
  // String restaurantId;
  const DetailScreen({
    super.key,
    required this.restaurantId,  
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final Completer<Restaurant> _completerRestaurant = Completer<Restaurant>();
  late Future<RestaurantDetailResponse> _futureRestaurantDetail;

  @override
  void initState() {
    super.initState();
  
    _futureRestaurantDetail = ApiServices().getRestaurantDetail(widget.restaurantId);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant Detail"),
        // actions: [
        //   ChangeNotifierProvider(
        //     create: (context) => BookmarkIconProvider(),
        //     // todo-04-detail-11: change this widget using FutureBuilder
        //     child: FutureBuilder(
        //         future: _completerTourism.future,
        //         builder: (context, snapshot) {
        //           return switch (snapshot.connectionState) {
        //             ConnectionState.done =>
        //               BookmarkIconWidget(tourism: snapshot.data!),
        //             _ => const SizedBox(),
        //           };
        //         }),
        //   ),
        // ],
      ),
      // todo-04-detail-08: to make it easy, create a new widget below
      // todo-04-detail-09: create a FutureBuilder
      body: FutureBuilder(
        future: _futureRestaurantDetail,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              // todo-04-detail-10: define a widget base on error or has data
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              final restaurantData = snapshot.data!.restaurant;
              _completerRestaurant.complete(restaurantData);
              return BodyCardDetail(restaurant: restaurantData);
              // return Text(restaurantData.address ?? "null");
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}

