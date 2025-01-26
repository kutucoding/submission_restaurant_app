import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/screen/detail/body_detail_screen.dart';
import 'package:restaurant_app/static/restaurant_detail_result_state.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';

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
        ),
        body: Consumer<RestaurantDetailProvider>(
            builder: (context, value, child) {
          return switch (value.resultState) {
            RestaurantListLoadingState() => const Center(
                child: CircularProgressIndicator(),
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
