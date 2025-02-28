import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/screen/detail/detail_screen.dart';
import 'package:restaurant_app/screen/home/home_screen.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    MultiProvider(
     providers: [
       Provider(
         create: (context) => ApiServices(),
       ),
       ChangeNotifierProvider(
         create: (context) => RestaurantListProvider(
           context.read<ApiServices>(),
         ),
       ),
       ChangeNotifierProvider(
         create: (context) => RestaurantDetailProvider(
           context.read<ApiServices>(),
         ),
       ),
     ],
     child: const MyApp(),
   )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tourism App',

      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow).copyWith(
          surface: Colors.white // Override the onBackground color
        ),

        useMaterial3: true, 
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      initialRoute: NavigationRoute.mainRoute.name,
      routes: {
        NavigationRoute.mainRoute.name: (context) => const HomeScreen(),
        NavigationRoute.detailRoute.name: (context) => DetailScreen(
              restaurantId: ModalRoute.of(context)?.settings.arguments != null
                  ? ModalRoute.of(context)!.settings.arguments as String
                  : 's1knt6za9kkfw1e867',
            ),
      },
    );
  }
}