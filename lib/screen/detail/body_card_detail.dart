import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/screen/detail/menu_widget.dart';

class BodyCardDetail extends StatelessWidget {
  final Restaurant restaurant;
  
  const BodyCardDetail({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    // print(restaurant.menus);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(
              'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
              fit: BoxFit.cover,
            ),
            const SizedBox.square(dimension: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.name,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.pin_drop),
                          const SizedBox.square(dimension: 4),
                          Expanded(
                            child: Text(
                              restaurant.address == "" ? restaurant.city :'${restaurant.address}, ${restaurant.city}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.pink,
                    ),
                    const SizedBox.square(dimension: 4),
                    Text(
                      restaurant.rating.toString(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  ],
                ),
              ],
            ),
            const SizedBox.square(dimension: 16),
            Text(
              restaurant.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox.square(dimension: 16),
            MenuWidget(
              title: "Menu Makanan", 
              imageCover: 'assets/images/menu_makanan.png',
              menu: restaurant.menus?.foods ?? []),
            const SizedBox.square(dimension: 8),
            MenuWidget(
              title: "Menu Minuman", 
              imageCover: 'assets/images/menu_minuman.png',
              menu: restaurant.menus?.drinks ?? []),
          ],
        ),
      ),
    );
  }
}