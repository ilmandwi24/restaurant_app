import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

class ListMenu extends StatelessWidget {

   final String imageCover;
  final Category menuDetail;

  const ListMenu({
    super.key,
    required this.imageCover,
    required this.menuDetail,
  });

 
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Center horizontally
      crossAxisAlignment: CrossAxisAlignment.center, // Center vertically
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 80,
            minHeight: 40,
            maxWidth: 80,
            minWidth: 40,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24.0),
            child: Image.asset(
              imageCover,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox.square(dimension: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                menuDetail.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Row(
                children: [
                  Expanded(
                    child: Text("Rp. 25.000",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: Color(0xFF9FA3A6),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}