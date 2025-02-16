
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/src/provider/local/local_database_provider.dart';
import 'package:restaurant_app/src/screen/home/restaurant_card.dart';
import 'package:restaurant_app/config/static/navigation_route.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  @override
  void initState() {
    Future.microtask(() {
      context.read<LocalDatabaseProvider>().loadAllRestaurant();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant List"),
      ),
      body: Consumer<LocalDatabaseProvider>(builder: (context, value, child){
        final restaurantList = value.restaurantList ?? [];
        return switch (restaurantList.isNotEmpty) {
          true => ListView.builder(
            itemCount: restaurantList.length,
            itemBuilder: (context, index){
              final restaurant = restaurantList[index];

              return RestaurantCard(
                restaurant: restaurant, 
                onTap: () {
                  Navigator.pushNamed(context, NavigationRoute.detailRoute.name,
                  arguments: restaurant.id);
                });
            },
            ),
            _ => const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("No Favorite Restaurant")],
              ),
            )
        } ;
      }),
    );
  }
}