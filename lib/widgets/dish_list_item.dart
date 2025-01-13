import 'package:flutter/material.dart';
import 'package:turbbbites_flutter_app/models/dish_model.dart';

class DishListItem extends StatelessWidget {
  const DishListItem({super.key, required this.dish, required this.onSelected});

  final DishModel dish;
  final void Function(DishModel) onSelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          onSelected(dish);
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  )
                  // FadeInImage(
                  //   placeholder: MemoryImage(kTransparentImage),
                  //   fit: BoxFit.cover,
                  //   width: 100,
                  //   height: 100,
                  //   image: NetworkImage(
                  //     dish.imageURL != null
                  //         ? '${BaseApiService.baseURL}\\${dish.imageURL!}'
                  //         : "",
                  //   ),
                  // )
                  ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dish.name),
                  const SizedBox(height: 4),
                  Text(dish.price.toString()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
