import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/src/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/src/provider/favorite/favorite_icon_provider.dart';
import 'package:restaurant_app/src/screen/detail/body_detail_screen.dart';
import 'package:restaurant_app/src/screen/favorite/favorite_icon_widget.dart';
import 'package:restaurant_app/config/static/restaurant_detail_result_state.dart';

class DetailScreen extends StatefulWidget {
  final String restaurantId;
  const DetailScreen({super.key, required this.restaurantId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {


  @override
  void initState() {
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      context
          .read<RestaurantDetailProvider>()
          .fetchRestauranDetail(widget.restaurantId);
        
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Detail Restaurant",
          style: Theme.of(context).textTheme.headlineSmall,),
          actions: [
            ChangeNotifierProvider(create: (context) => FavoriteIconProvider(),
            child: Consumer<RestaurantDetailProvider>(builder: (context, value, child){
              return switch (value.resultState) {
                RestaurantDetailLoadedState(data: var restaurant) =>
                FavoriteIconWidget(restaurant: restaurant),
                _ => const SizedBox(),
              };
            }),)
          ],
        ),
        body: Consumer<RestaurantDetailProvider>(
            builder: (context, value, child) {
          return switch (value.resultState) {
            RestaurantDetailNoneState() => const SizedBox(),
            RestaurantDetailLoadingState() => const Center(
                  child: CircularProgressIndicator(color: Colors.blue),
                ),
            RestaurantDetailLoadedState(data: var restaurant) =>
              BodyDetailScreen(restaurant: restaurant),
            RestaurantDetailErrorState(error: var message) => Center(
                child: Text(message),
              ),
            _ => const SizedBox()
          };
        }));
  }
}
