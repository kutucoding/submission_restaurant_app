import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/screen/home/restaurant_card.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';

import '../../style/components/image_slider.dart';


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
                ImageSlider(currentSlide: currentSlider, onChange: (value) {
                  setState(() {
                    currentSlider = value;
                  });
                }),
                const SizedBox(
                  height: 10,
                ),
                //card
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Consumer<RestaurantListProvider>(
                builder: (context, value, child) {
              return switch (value.resultState) {
                RestaurantListLoadingState() => const Center(
                    child: CircularProgressIndicator(),
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
          ))
        ],
      ),
    );
  }
}
