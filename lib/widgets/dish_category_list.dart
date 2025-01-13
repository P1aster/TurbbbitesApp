import 'package:flutter/material.dart';
import 'package:turbbbites_flutter_app/models/dish_category_model.dart';

class DishCategoryList extends StatelessWidget {
  const DishCategoryList({super.key, required this.selected, required this.dishCategories, required this.onSelected});

  final int selected;
  final List<DishCategoryModel> dishCategories;
  final void Function(int) onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      spacing: 10,
      children: [
        for (final dishCategory in dishCategories)
          ChoiceChip(
            label: Text(dishCategory.name),
            selected: selected == dishCategory.id,
            onSelected: (selected) {
              onSelected(dishCategory.id);
            },
          ),
      ],
    );
  }
}
