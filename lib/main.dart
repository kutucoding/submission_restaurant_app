import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/src/data/api/api_services.dart';
import 'package:restaurant_app/src/data/local/local_database.dart';
import 'package:restaurant_app/src/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/src/provider/home/image_slider_provider.dart';
import 'package:restaurant_app/src/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/src/provider/home/restaurant_search_provider.dart';
import 'package:restaurant_app/src/provider/local/local_database_provider.dart';
import 'package:restaurant_app/src/provider/main/index_nav_provider.dart';
import 'package:restaurant_app/src/provider/notification/local_notification_provider.dart';
import 'package:restaurant_app/src/provider/setting/theme_provider.dart';
import 'package:restaurant_app/src/screen/detail/detail_screen.dart';
import 'package:restaurant_app/src/screen/main/main_screen.dart';
import 'package:restaurant_app/config/static/navigation_route.dart';
import 'package:restaurant_app/src/services/local_notification_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: [
    Provider(
      create: (context) => LocalNotificationService()
        ..init()
        ..configureLocalTimeZone(),
    ),
    ChangeNotifierProvider(
      create: (context) => LocalNotificationProvider(
        context.read<LocalNotificationService>(),
      )..requestPermission(),
    ),
    Provider(
      create: (context) => LocalDatabase(),
    ),
    ChangeNotifierProvider(
      create: (context) => LocalDatabaseProvider(
        context.read<LocalDatabase>(),
      ),
    ),
    Provider(
      create: (context) => ApiServices(),
    ),
    ChangeNotifierProvider(
      create: (context) => IndexNavProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
    ),
    ChangeNotifierProvider(
        create: (context) => RestaurantListProvider(
              context.read<ApiServices>(),
            )),
    ChangeNotifierProvider(
      create: (context) => ImageSliderProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => RestaurantDetailProvider(
        context.read<ApiServices>(),
      ),
    ),
    ChangeNotifierProvider(
      create: (context) => RestaurantSearchProvider(
        context.read<ApiServices>(),
      ),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();
    _listener = AppLifecycleListener(
      onDetach: () => debugPrint('app-detached'),
      onInactive: () => debugPrint('app-inactive'),
      onPause: () => debugPrint('app-paused'),
      onResume: () => debugPrint('app-resumed'),
      onRestart: () => debugPrint('app-restarted'),
      onShow: () => debugPrint("app-showed"),
      onHide: () => debugPrint("app-hide"),
    );
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      darkTheme: Provider.of<ThemeProvider>(context).themeData,
      initialRoute: NavigationRoute.mainRoute.name,
      routes: {
        NavigationRoute.mainRoute.name: (context) => const MainScreen(),
        NavigationRoute.detailRoute.name: (context) => DetailScreen(
              restaurantId:
                  ModalRoute.of(context)?.settings.arguments as String,
            ),
      },
    );
  }
}
