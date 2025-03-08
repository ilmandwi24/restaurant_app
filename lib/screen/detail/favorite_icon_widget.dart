import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/data/model/restaurant_sql.dart';
import 'package:restaurant_app/provider/detail/favorite_icon_provider.dart';
import 'package:restaurant_app/provider/restaurant_fav_database_provider.dart';

class FavoriteIconWidget extends StatefulWidget {
  final RestaurantDetail restaurant;
  const FavoriteIconWidget({super.key, required this.restaurant});

  @override
  State<FavoriteIconWidget> createState() => _FavoriteIconWidgetState();
}

class _FavoriteIconWidgetState extends State<FavoriteIconWidget> {
  @override
  void initState() {
    final restaurantFavListProvider =
        context.read<RestaurantFavDatabaseProvider>();
    final favoriteIconProvider = context.read<FavoriteIconProvider>();

    // final restaurant = favoriteIconProvider.restaurant;
    Future.microtask(() async {
      final favRes =
          await restaurantFavListProvider.checkIfFavorite(widget.restaurant.id);
      favoriteIconProvider.isFavorited = favRes;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final restaurantFavListProvider =
            context.read<RestaurantFavDatabaseProvider>();
        final favoriteIconProvider = context.read<FavoriteIconProvider>();
        final isFavorited = favoriteIconProvider.isFavorited;
        final restaurantSqlData = RestaurantSql(
            id: widget.restaurant.id,
            name: widget.restaurant.name,
            description: widget.restaurant.description,
            pictureId: widget.restaurant.pictureId,
            rating: widget.restaurant.rating,
            city: widget.restaurant.city);
        // print(restaurantSqlData.toJson());
        if (isFavorited) {
          restaurantFavListProvider
              .removeFavoriteValueById(restaurantSqlData.id);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Remove from favorite list'),
              duration: Duration(seconds: 1),
            ),
          );
        } else {
          restaurantFavListProvider.saveFavoriteValue(restaurantSqlData);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Added to favorite list'),
              duration: Duration(seconds: 1),
            ),
          );
        }
        favoriteIconProvider.isFavorited = !isFavorited;
        if (context.mounted) {
          await restaurantFavListProvider.loadAllFavoriteValue();
        }
      },
      icon: Icon(
        context.watch<FavoriteIconProvider>().isFavorited
            ? Icons.favorite
            : Icons.favorite_outline,
      ),
    );
  }
}
