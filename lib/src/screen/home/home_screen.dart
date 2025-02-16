import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/src/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/src/screen/home/restaurant_card.dart';
import 'package:restaurant_app/config/static/navigation_route.dart';
import 'package:restaurant_app/config/static/restaurant_detail_result_state.dart';
import 'package:restaurant_app/config/static/restaurant_list_result_state.dart';

import '../../../config/style/components/image_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentSlider = 0;
  @override
  void initState() {
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      context.read<RestaurantListProvider>().fetchRestauranList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 40, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 10),
                const ImageSlider(),
                const SizedBox(
                  height: 10,
                ),
                //card
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, top: 5, right: 20, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Our Restaurant :",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<RestaurantListProvider>(
                builder: (context, value, child) {
              return switch (value.resultState) {
                RestaurantDetailNoneState() => const SizedBox(),
                RestaurantListLoadingState() => const Center(
                    child: CircularProgressIndicator(color: Colors.blue),
                  ),
                RestaurantListLoadedState(data: var restaurantList) =>
                  ListView.builder(
                    itemCount: restaurantList.length,
                    itemBuilder: (context, index) {
                      final restaurant = restaurantList[index];

                      return RestaurantCard(
                          restaurant: restaurant,
                          onTap: () {
                            Navigator.pushNamed(
                                context, NavigationRoute.detailRoute.name,
                                arguments: restaurant.id);
                          });
                    },
                  ),
                RestaurantListErrorState(error: var message) => Center(
                    child: Text(message),
                  ),
                _ => const SizedBox()
              };
            }),
          ),
        ],
      ),
    );
  }
}
