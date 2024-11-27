import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/screen/detail/list_menu_widget.dart';

class MenuWidget extends StatelessWidget {
  final String title;
  final String imageCover;
  final List menu;

  const MenuWidget(
      {super.key,
      required this.title,
      required this.menu,
      required this.imageCover});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            )
          ],
        ),
        const SizedBox.square(dimension: 8),
        ListView.builder(
          shrinkWrap: true, // Make ListView take only as much space as it needs
          physics:
              const NeverScrollableScrollPhysics(), // Disable internal scrolling for the ListView
          itemCount: menu.length,
          itemBuilder: (context, index) {
            final menuDetail = menu[index];

            return Column(
              children: [
                ListMenu(
                  imageCover: imageCover,
                  menuDetail: menuDetail,
                ),
                const SizedBox.square(
                  dimension: 16.0,
                )
              ],
            );
          },
        ),
      ],
    );
  }
}


