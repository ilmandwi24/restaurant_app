import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/provider/local_notification_provider.dart';
import 'package:restaurant_app/provider/main/index_nav_provider.dart';
import 'package:restaurant_app/provider/reminder_provider.dart';
import 'package:restaurant_app/provider/restaurant_fav_database_provider.dart';
import 'package:restaurant_app/provider/theme_provider.dart';
import 'package:restaurant_app/screen/detail/detail_screen.dart';
import 'package:restaurant_app/screen/main/main_screen.dart';
import 'package:restaurant_app/services/local_notification_service.dart';
import 'package:restaurant_app/services/shared_preferences_service.dart';
import 'package:restaurant_app/services/sqlite_service.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/style/theme/restaurant_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(MultiProvider(
    providers: [
      Provider(
        create: (context) => LocalNotificationService()
          ..init()
          ..configureLocalTimeZone(),
      ),
      ChangeNotifierProvider(
        create: (context) => LocalNotificationProvider(
          context.read<LocalNotificationService>(),
        )..requestPermissions(),
      ),
      Provider(
        create: (context) => SharedPreferencesService(prefs),
      ),
      ChangeNotifierProvider(
          create: (context) => ReminderProvider(
              context.read<SharedPreferencesService>(),
              context.read<LocalNotificationService>())),
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(
          context.read<SharedPreferencesService>(),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => IndexNavProvider(),
      ),
      Provider(
        create: (context) => ApiServices(),
      ),
      Provider(
        create: (context) => SqliteService(),
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
      ChangeNotifierProvider(
        create: (context) => RestaurantFavDatabaseProvider(
          context.read<SqliteService>(),
        ),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      debugShowCheckedModeBanner: false, // Hilangkan banner DEBUG

      theme: RestaurantTheme.lightTheme,
      darkTheme: RestaurantTheme.darkTheme,
      themeMode: context.watch<ThemeProvider>().isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,
      initialRoute: NavigationRoute.mainRoute.name,
      routes: {
        NavigationRoute.mainRoute.name: (context) => const MainScreen(),
        NavigationRoute.detailRoute.name: (context) => DetailScreen(
              restaurantId: ModalRoute.of(context)?.settings.arguments != null
                  ? ModalRoute.of(context)!.settings.arguments as String
                  : 's1knt6za9kkfw1e867',
            ),
      },
    );
  }
}
