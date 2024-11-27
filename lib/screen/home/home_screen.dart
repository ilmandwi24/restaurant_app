import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';
import 'package:restaurant_app/provider/restaurant_list_provider.dart';
import 'package:restaurant_app/screen/home/restaurant_card_widget.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    
    Future.microtask(() {
     context.read<RestaurantListProvider>().fetchRestaurantList();
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tourism List"),
        
      ),
      // todo-03-home-04: comment the ListView widget first, we take it later
      // todo-03-home-05: create a FutureBuilder
      // body: FutureBuilder(
      //   future: _futureRestaurantListResponse,
      //   builder: (context, snapshot) {
      //     // todo-03-home-06: define a widget based on state
      //     switch (snapshot.connectionState) {
      //       case ConnectionState.waiting:
      //         return const Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       case ConnectionState.done:
      //         // todo-03-home-07: define a widget base on error or has data
      //         if (snapshot.hasError) {
      //           return Center(
      //             child: Text(snapshot.error.toString()),
      //           );
      //         }

      //         final listOfRestaurant = snapshot.data!.restaurants;
      //         // print(listOfRestaurant);
      //         // return const Text("hello");
      //         return ListView.builder(
      //           itemCount: listOfRestaurant.length,
      //           itemBuilder: (context, index) {
      //             final restaurant = listOfRestaurant[index];
      //             // return Text(tourism.name);

      //             return RestaurantCard(
      //               restaurant: restaurant,
      //               onTap: () {
      //                 Navigator.pushNamed(
      //                   context,
      //                   NavigationRoute.detailRoute.name,
      //                   // todo-04-detail-13: dont forget to change the value too
      //                   arguments: restaurant.id,
      //                 );
      //               },
      //             );
      //           },
      //         );
      //       default:
      //         return const SizedBox();
      //     }
      //   },
      // ),
      body: Consumer<RestaurantListProvider>(
        builder: (context, value, child) {
          // todo-03-home-06: define a widget based on state
          return switch (value.resultState) {
            RestaurantListLoadingState() => const Center(
               child: CircularProgressIndicator(),
             ),
            RestaurantListLoadedState(data: var restaurantList) => ListView.builder(
              itemCount: restaurantList.length,
              itemBuilder: (context, index) {
                final restaurant = restaurantList[index];
                // return Text(tourism.name);

                return RestaurantCard(
                  restaurant: restaurant,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      NavigationRoute.detailRoute.name,
                      // todo-04-detail-13: dont forget to change the value too
                      arguments: restaurant.id,
                    );
                  },
                );
              },
            ),
            RestaurantListErrorState(error: var message) => Center(
               child: Text(message),
             ),
             _ => const SizedBox(),
            
          };
        },
      ),
    );
  }
}