
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/src/provider/favorite/favorite_icon_provider.dart';
import 'package:restaurant_app/src/provider/local/local_database_provider.dart';

import '../../data/model/restaurant_model.dart';

class FavoriteIconWidget extends StatefulWidget {
  final Restaurant restaurant;
  const FavoriteIconWidget({super.key, required this.restaurant});

  @override
  State<FavoriteIconWidget> createState() => _FavoriteIconWidgetState();
}

class _FavoriteIconWidgetState extends State<FavoriteIconWidget> {
 
 @override
  void initState() {
    final favoriteIconProvider = context.read<FavoriteIconProvider>();
    final localDatabaseProvider = context.read<LocalDatabaseProvider>();
    

    Future.microtask(() async {
      await localDatabaseProvider.loadRestaurantById(widget.restaurant.id);
      final value = localDatabaseProvider.restaurant == null ? false : localDatabaseProvider.restaurant!.id == widget.restaurant.id;

      favoriteIconProvider.isFavorited = value;
    });
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final localDatabaseProvider = context.read<LocalDatabaseProvider>();
        final favoriteIconProvider = context.read<FavoriteIconProvider>();
        final isFavorited = favoriteIconProvider.isFavorited;

        if (!isFavorited) {
          await localDatabaseProvider.saveRestaurant(widget.restaurant);
        } else {
          await localDatabaseProvider.removeRestaurantById(widget.restaurant.id);
        }
        favoriteIconProvider.isFavorited =!isFavorited;
        localDatabaseProvider.loadAllRestaurant();
      },
      icon: Icon(context.watch<FavoriteIconProvider>().isFavorited
      ? Icons.favorite
      : Icons.favorite_border),
    );
  }
}