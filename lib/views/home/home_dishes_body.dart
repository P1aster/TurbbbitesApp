import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turbbbites_flutter_app/core/api/controllers/dish_category_controller.dart';
import 'package:turbbbites_flutter_app/core/api/controllers/dish_controller.dart';
import 'package:turbbbites_flutter_app/models/pagination_model.dart';
import 'package:turbbbites_flutter_app/models/dish_category_model.dart';
import 'package:turbbbites_flutter_app/models/dish_model.dart';
import 'package:turbbbites_flutter_app/widgets/dish_category_list.dart';
import 'package:turbbbites_flutter_app/widgets/dish_list.dart';

class HomeDishesBody extends StatefulWidget {
  const HomeDishesBody({super.key});

  @override
  State<HomeDishesBody> createState() => _HomeDishesBodyState();
}

class _HomeDishesBodyState extends State<HomeDishesBody> {
  DishCategoryApiController dishCategoryController =
      DishCategoryApiController.controller;
  DishApiController dishController = DishApiController.controller;

  int _selectedCategoryId = 0;


  PaginationResponseModel<DishModel>? _dishes;

  List<DishCategoryModel> _dishCategoriesData = [
    DishCategoryModel(id: 0, name: "All")
  ];

  void _fetchDishes(int? categoryId) async {
    var response = await dishController.getAllDishes(categoryId);
    setState(() {
      _dishes = response;
    });
  }

  void _fetchDishCategories() async {
    var response = await dishCategoryController.getAllCategories();
    var newCategories = [
      DishCategoryModel(id: 0, name: "All"),
      ...?response
    ];
    setState(() {
    _dishCategoriesData = newCategories;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchDishes(null);
    _fetchDishCategories();
  }

  void _setSelectedCategory(int selectedCategoryId) {
    setState(() {
      _selectedCategoryId = selectedCategoryId;
    });
    _fetchDishes(selectedCategoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Category",
          ),
          SizedBox(
            height: 20,
          ),
          DishCategoryList(
              dishCategories: _dishCategoriesData,
              selected: _selectedCategoryId,
              onSelected: _setSelectedCategory),
          SizedBox(
            height: 20,
          ),
          Text(
            "Products",
          ),
          Obx(() => dishController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : const SizedBox()),
          Obx(() => dishController.isError.value
              ? Center(
                  child: Column(
                    children: [
                      Text(dishController.error.value),
                      TextButton(
                        onPressed: () => _fetchDishes(_selectedCategoryId == 0
                            ? null
                            : _selectedCategoryId),
                        child: const Text("Retry"),
                      ),
                    ],
                  ),
                )
              : const SizedBox()),
          Obx(() => dishController.isSuccess.value && _dishes != null
              ? Flexible(
                  child: DishList(dishes: _dishes!.data, total: _dishes!.total))
              : const SizedBox()),
        ],
      ),
    );
  }
}
