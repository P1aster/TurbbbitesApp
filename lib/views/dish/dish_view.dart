import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turbbbites_flutter_app/core/api/base_api_service.dart';
import 'package:turbbbites_flutter_app/core/controllers/cart_controller.dart';
import 'package:turbbbites_flutter_app/models/cart_model.dart';
import 'package:turbbbites_flutter_app/models/dish_model.dart';
import 'dart:math';

import 'package:turbbbites_flutter_app/widgets/quantity_input.dart';

class DishView extends StatefulWidget {
  final DishModel dish;
  const DishView({super.key, required this.dish});
  @override
  State<DishView> createState() => _DishViewState();
}

class _DishViewState extends State<DishView> {
  int _quantity = 1;
  final CartController controller = Get.find<CartController>();

  void _setQuantity(int quantity) {
    setState(() {
      _quantity = quantity;
    });
  }

  void _onSubmit() {
    controller
        .addToCart(CartElementModel(dish: widget.dish, quantity: _quantity));
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Center(
                      child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: widget.dish.imageURL != null
                        ? Image.network(
                            '${BaseApiService.baseURL}\\${widget.dish.imageURL!}',
                            width: min(width - (16.0 * 2), 500),
                            height: min(shortestSide - 16.0, 500),
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: min(width - (16.0 * 2), 500),
                            height: min(shortestSide - 16.0, 500),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                  )),
                  const SizedBox(height: 16),
                  Text(
                    widget.dish.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.dish.description,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Price: ${widget.dish.price}",
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        "Quantity: ",
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      QuantityInput(
                        maxVal: 10,
                        minVal: 1,
                        initVal: 1,
                        onChanged: _setQuantity,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total: ${(widget.dish.price * _quantity).toStringAsFixed(2)}",
                ),
                FilledButton(
                  onPressed: _onSubmit,
                  child: const Text("Add to cart"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
