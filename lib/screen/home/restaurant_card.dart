import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/restaurant_model.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final Function() onTap;
  const RestaurantCard(
      {super.key, required this.restaurant, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xffFAD8B8)),
            boxShadow: const [
              BoxShadow(
                  color: Color(0xffFAD8B8), blurRadius: 4, offset: Offset(0, 3))
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 120,
                  maxWidth: 120,
                  minHeight: 80,
                  minWidth: 80,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Hero(
                    tag: restaurant.pictureId,
                    child: Image.network(
                      ApiServices().getImageUrl(restaurant.pictureId),
                      width: double.infinity,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox.square(
                dimension: 8,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    restaurant.name,
                    style: Theme.of(context).textTheme.titleMedium,
                    selectionColor: Theme.of(context).colorScheme.surface,
                  ),
                  const SizedBox.square(
                    dimension: 6,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.pin_drop),
                      const SizedBox.square(
                        dimension: 4,
                      ),
                      Expanded(
                        child: Text(
                          restaurant.city,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox.square(
                    dimension: 6,
                  ),
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.star,
                        color: Colors.yellowAccent,
                      ),
                      Expanded(
                          child: Text(
                        restaurant.rating.toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ))
                    ],
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
