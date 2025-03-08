import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_fav_database_provider.dart';
import 'package:restaurant_app/screen/favorite/restaurant_fav_card_widget.dart';
import 'package:restaurant_app/static/navigation_route.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (mounted) {
        context.read<RestaurantFavDatabaseProvider>().loadAllFavoriteValue();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Favorite Screen"),
        ),
        body: Consumer<RestaurantFavDatabaseProvider>(
            builder: (context, value, child) {
          if (value.restaurantList == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (value.restaurantList!.isEmpty) {
            return const Center(
              child: Text("No Favorite Restaurant Added Yet !"),
            );
          }
          final restaurantList = value.restaurantList!;
          return ListView.builder(
            itemCount: restaurantList.length,
            itemBuilder: (context, index) {
              final restaurant = restaurantList[index];
              return RestaurantFavCard(
                restaurant: restaurant,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    NavigationRoute.detailRoute.name,
                    arguments: restaurant.id,
                  );
                },
              );
            },
          );
        }));
  }
}
