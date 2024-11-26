import 'package:flutter/material.dart';
import 'package:restaurant_app/screen/detail/detail_screen.dart';
import 'package:restaurant_app/screen/home/home_screen.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tourism App',
      // theme: TourismTheme.lightTheme,
      // darkTheme: TourismTheme.darkTheme,
      // textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme),
      theme: ThemeData(
        // Apply Google Font globally through the TextTheme
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow).copyWith(
          background: Colors.white // Override the onBackground color
        ),

        useMaterial3: true, 
        // primarySwatch: Colors.blue,
      ),
      themeMode: ThemeMode.system,
      initialRoute: NavigationRoute.mainRoute.name,
      routes: {
        NavigationRoute.mainRoute.name: (context) => const HomeScreen(),
        // todo-04-detail-12: dont forget to change the variable
        NavigationRoute.detailRoute.name: (context) => DetailScreen(
              restaurantId: ModalRoute.of(context)?.settings.arguments != null
                  ? ModalRoute.of(context)!.settings.arguments as String
                  : 's1knt6za9kkfw1e867',
            ),
      },
    );
  }
}