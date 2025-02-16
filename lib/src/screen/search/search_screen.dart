import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/src/provider/home/restaurant_search_provider.dart';
import 'package:restaurant_app/src/screen/search/search_card.dart';
import 'package:restaurant_app/config/static/navigation_route.dart';
import 'package:restaurant_app/config/static/restaurant_search_resultstate.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Restaurants"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (query) {
                context.read<RestaurantSearchProvider>().fetchRestaurantSearch(query);
              },
              decoration: InputDecoration(
                labelText: "Search",
                hintText: "Type restaurant name",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer<RestaurantSearchProvider>(
              builder: (context, provider, child) {
                final state = provider.resultState;

                return switch (state) {
                  RestaurantSearchNoneState() => const Center(
                      child: Text("Type to search restaurants."),
                    ),
                  RestaurantSearchLoadingState() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  RestaurantSearchLoadedState(restaurants: var restaurants) =>
                      ListView.builder(
                        itemCount: restaurants.length,
                        itemBuilder: (context, index) {
                          final restaurant = restaurants[index];
                          return SearchCard(
                            onTap: () {
                              Navigator.pushNamed(context, 
                              NavigationRoute.detailRoute.name,
                              arguments: restaurant.id);
                            }, 
                            restaurant: restaurant);
                        },
                      ),
                  RestaurantSearchErrorState(message: var message) =>
                      Center(child: Text(message)),
                  // ignore: unreachable_switch_case
                  _ => const SizedBox.shrink(),
                };
              },
            ),
          ),
        ],
      ),
    );
  }
}
