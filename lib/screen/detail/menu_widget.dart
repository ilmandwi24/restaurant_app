import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class MenuWidget extends StatelessWidget {
  final String title;
  final String imageCover;
  final List menu;

  const MenuWidget({
    super.key,
    required this.title,
    required this.menu,
    required this.imageCover
  });

  @override
  Widget build(BuildContext context) {
    print("hello");
    print(menu);
    // print(menu);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0
              ),
              
              )
          ],
        ),
        const SizedBox.square(dimension: 8),
        ListView.builder(
            shrinkWrap: true, // Make ListView take only as much space as it needs
            physics: const NeverScrollableScrollPhysics(), // Disable internal scrolling for the ListView
            itemCount: menu.length,
            itemBuilder: (context, index) {

              final menuDetail = menu[index];
              // print(menuDetail);
              // return Text(tourism.name);
              // return const Center(
              //   child:Text("hello")
              // );
              // return const ListTile(
              //           title: Text("ada"), // Display each item from the list
              //         );
              // return ListMenu(
              //   imageCover: imageCover,
              //   menuDetail: menuDetail,
              // );
              return Column(
                children: [
                  ListMenu(
                    imageCover: imageCover,
                    menuDetail: menuDetail,
                  ),
                  const SizedBox.square(dimension: 8.0,)
                ],
              );
            },
        ),
        // ListMenu(
        //         imageCover: imageCover,
        //         menuDetail: {},
        //       ),
       
             
      ],
    );
  }
}

class ListMenu extends StatelessWidget {
  const ListMenu({
    super.key,
    required this.imageCover,
    required this.menuDetail,
  });

  final String imageCover;
  final Category menuDetail;

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
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      "Rp. 25000",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          color: Color(0xFF9FA3A6),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 0,
                      )
                    ),
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